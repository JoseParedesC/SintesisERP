--liquibase formatted sql
--changeset ,jtous:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[ST_MOVNotasCarteraSave]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [CNT].[ST_MOVNotasCarteraSave]   
GO



CREATE PROCEDURE [CNT].[ST_MOVNotasCarteraSave]
@id BIGINT = null,
@id_tipodoc BIGINT,
@id_centrocostos BIGINT,
@fecha smalldatetime,
@tipo_tercero VARCHAR(2),
@id_tercero BIGINT,
@id_saldo BIGINT,
@id_ctaant BIGINT,
@id_ctaact BIGINT=NULL,
@detalle VARCHAR(MAX),
@vencimientoact VARCHAR(10) =NULL,
@saldoActual NUMERIC(18,2)=NULL,
@tipoVenci INT=NULL,
@Dias INT=NULL,
@Numcuota INT=NULL,
@cuota INT=NULL, 
@ChangeCuote BIT,
@id_user BIGINT
--WITH ENCRYPTION
AS

/***************************************
*Nombre:		[CNT].[ST_MOVNotasCarteraSave]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		16/10/20
*Desarrollador: (Jeteme)

SP para insertar UNA NOTA DE CARTERA
--JTOUS: Se agrego la columna en el insertar de notas cartera el tipo tercero
***************************************/

BEGIN TRANSACTION
BEGIN TRY

	DECLARE  @id_return INT,@numeropagos INT, @error VARCHAR(MAX),@anomes VARCHAR(6),@fechadoc VARCHAR(10),@id_saldonew BIGINT,@nrofactura varchar(50),@CsaldoActual NUMERIC(18,2);
	DECLARE @miCTE TABLE(id BIGINT,cuota INT,vencimiento VARCHAR(10))
	DECLARE @numfactura VARCHAR(50),@id_documento BIGINT;
	Declare @id_saldocuota bigint;
	SET @anomes   = CONVERT(VARCHAR(6), @fecha, 112);
	SET @fechadoc = CONVERT(VARCHAR(10), @fecha, 120);
	SET @id_ctaact= (IIF(@id_ctaact=0,NULL,@id_ctaact))
	

			EXECUTE [Dbo].ST_ValidarPeriodo
					@fecha			= @fechadoc,
					@anomes			= @anomes,
					@mod			= 'C'
	
	IF(Isnull(@id,0) = 0)
	BEGIN		
	
		INSERT INTO [CNT].[MOVNotasCartera]([id_tipodoc],[id_centrocosto],[fecha],[id_tercero], [id_saldo], [id_ctaant], [id_ctaact],[vencimientoact] ,[id_tipoven],[dia],[saldoactual],[nrocuotas],[detalle],[estado],[id_usercreated], tipoter)
		VALUES (@id_tipodoc,@id_centrocostos,@fecha,@id_tercero, @id_saldo,@id_ctaant,@id_ctaact,@vencimientoact,@tipoVenci,@Dias,@saldoActual,@Numcuota,@detalle,Dbo.ST_FnGetIdList('PROCE'),@id_user, @tipo_tercero);
	
		SET @id = SCOPE_IDENTITY();
	END

	IF(@tipo_tercero='CL')
	BEGIN
			SELECT @numfactura=nrofactura,@id_documento=id_documento FROM CNT.SaldoCliente WHERE id=@id_saldo
		
			IF(@id_ctaact is not null)
			BEGIN
				
				IF NOT EXISTS (SELECT 1 FROM Cnt.SaldoCliente WHERE id_cliente = @id_tercero AND id_cuenta=@id_ctaact AND nrofactura=@numfactura and anomes=@anomes)
				BEGIN 
					INSERT INTO CNT.SaldoCliente (anomes,id_cliente,id_documento,nrofactura,id_cuenta,fechaactual,fechavencimiento,saldoanterior,movDebito,movCredito,saldoActual,id_user)
					SELECT @anomes,id_cliente,id_documento,nrofactura,IIF(@id_ctaact IS NULL,@id_ctaant,@id_ctaact),fechaactual,fechavencimiento,saldoanterior,movDebito,movCredito,saldoActual,@id_user FROM CNT.SaldoCliente WHERE id=@id_saldo and anomes=@anomes and id_cuenta=@id_ctaant
					SET @id_saldonew = SCOPE_IDENTITY();
				END ELSE
				BEGIN
					
					SELECT @id_saldonew=S.id,@CsaldoActual=T.saldoActual  FROM CNT.SaldoCliente S CROSS APPLY (SELECT id,saldoActual FROM CNT.SaldoCliente WHERE id=@id_saldo) T  where id_cliente = @id_tercero AND id_cuenta=@id_ctaact AND nrofactura=@numfactura and anomes=@anomes
					UPDATE  S  SET S.movDebito=movDebito+@CsaldoActual,
								   S.SaldoActual=S.saldoActual+@CsaldoActual,
								   s.id_nota=NULL
					 FROM CNT.SaldoCliente S WHERE id=@id_saldonew
				END
				
			
					IF(@vencimientoact IS NULL)
					BEGIN
						INSERT INTO CNT.SaldoCliente_Cuotas(anomes,id_cliente,id_cuenta,nrofactura,cuota,saldoAnterior,movdebito,movCredito,saldoActual,vencimiento_cuota,fechapagointeres,cancelada,id_devolucion,id_user)
						SELECT @anomes,S.id_cliente,@id_ctaact,S.nrofactura,S.cuota,s.saldoAnterior,S.movdebito,0,S.saldoActual,s.vencimiento_cuota,s.vencimiento_cuota,S.cancelada,S.id_devolucion,@id_user 
						FROM [CNT].SaldoCliente_Cuotas S 
						WHERE  id_cliente=@id_tercero AND id_cuenta=@id_ctaant AND nrofactura=@numfactura AND anomes=@anomes AND id_devolucion is null AND cancelada=0 and id_nota is null ORDER BY S.cuota ASC
				
						--Asigno el id de la nota los registros que se remplazaran
						UPDATE CNT.SaldoCliente_Cuotas set cancelada=1,id_nota=@id where id_cliente=@id_tercero and id_cuenta=@id_ctaant and nrofactura=@numfactura and anomes=@anomes and id_devolucion is NULL And cancelada=0 and id_nota is null	
					END ELSE
					BEGIN
						SET @id_saldocuota =(Select top 1 id from cnt.SaldoCliente_Cuotas WHERE  id_cliente=@id_tercero AND id_cuenta=@id_ctaant AND nrofactura=@numfactura AND anomes=@anomes AND id_devolucion is null AND cancelada=0 ORDER BY id desc)
							IF(@ChangeCuote=0)
								INSERT INTO CNT.SaldoCliente_Cuotas(anomes,id_cliente,id_cuenta,nrofactura,cuota,saldoAnterior,movdebito,movCredito,saldoActual,vencimiento_cuota,fechapagointeres,cancelada,id_devolucion,id_user)
								SELECT @anomes,S.id_cliente,IIF(@id_ctaact IS NULL,S.id_cuenta,@id_ctaact),S.nrofactura,S.cuota,S.saldoAnterior,S.movdebito,0,S.saldoActual,C.vencimiento,C.vencimiento,S.cancelada,S.id_devolucion,@id_user 
								FROM [CNT].[ST_FnNotasCarteraRecCuotas](@cuota, @saldoActual, @Numcuota, @tipoVenci, @vencimientoact, @Dias) C INNER JOIN CNT.SaldoCliente_Cuotas S ON S.cuota=C.cuotanro
								WHERE  id_cliente=@id_tercero AND id_cuenta=@id_ctaant AND nrofactura=@numfactura AND anomes=@anomes AND id_devolucion is null AND cancelada=0 ORDER BY S.cuota ASC
							ELSE
							BEGIN
								INSERT INTO CNT.SaldoCliente_Cuotas(anomes,id_cliente,id_cuenta,nrofactura,cuota,saldoAnterior,movdebito,movCredito,saldoActual,vencimiento_cuota,fechapagointeres,cancelada,id_devolucion,id_user)
								SELECT @anomes,@id_tercero,IIF(@id_ctaact IS NULL,@id_ctaant,@id_ctaact),@numfactura,c.cuotanro,0,C.valorcuota,0,C.valorcuota,C.vencimiento,C.vencimiento,0,NULL,@id_user 
								FROM [CNT].[ST_FnNotasCarteraRecCuotas](@cuota, @saldoActual, @Numcuota, @tipoVenci, @vencimientoact, @Dias) C 
						
							END
					
							UPDATE CNT.SaldoCliente_Cuotas set cancelada=1,id_nota=@id where id_cliente=@id_tercero and id_cuenta=@id_ctaant and nrofactura=@numfactura and anomes=@anomes and id_devolucion is NULL And cancelada=0 and id_nota is null and id<=@id_saldocuota	
							
						END
					UPDATE CNT.MOVNotasCartera SET id_saldoact=@id_saldonew WHERE id=@id
						
		END ELSE
			BEGIN
				IF(@vencimientoact is not null)
				BEGIN
					set @id_saldocuota =(Select top 1 id from cnt.SaldoCliente_Cuotas WHERE  id_cliente=@id_tercero AND id_cuenta=@id_ctaant AND nrofactura=@numfactura AND anomes=@anomes AND id_devolucion is null AND cancelada=0 ORDER BY id desc)
						IF(@ChangeCuote=0)
							INSERT INTO CNT.SaldoCliente_Cuotas(anomes,id_cliente,id_cuenta,nrofactura,cuota,saldoAnterior,movdebito,movCredito,saldoActual,vencimiento_cuota,fechapagointeres,cancelada,id_devolucion,id_user)
							SELECT @anomes,S.id_cliente,S.id_cuenta,S.nrofactura,S.cuota,S.saldoAnterior,S.movdebito,0,S.saldoActual,C.vencimiento,C.vencimiento,S.cancelada,S.id_devolucion,@id_user 
							FROM [CNT].[ST_FnNotasCarteraRecCuotas](@cuota, @saldoActual, @Numcuota, @tipoVenci, @vencimientoact, @Dias) C INNER JOIN CNT.SaldoCliente_Cuotas S ON S.cuota=C.cuotanro
							WHERE  id_cliente=@id_tercero AND id_cuenta=@id_ctaant AND nrofactura=@numfactura AND anomes=@anomes AND id_devolucion is null AND cancelada=0 ORDER BY S.cuota ASC
						ELSE
							BEGIN
								INSERT INTO CNT.SaldoCliente_Cuotas(anomes,id_cliente,id_cuenta,nrofactura,cuota,saldoAnterior,movdebito,movCredito,saldoActual,vencimiento_cuota,fechapagointeres,cancelada,id_devolucion,id_user)
								SELECT @anomes,@id_tercero,@id_ctaant,@numfactura,c.cuotanro,0,C.valorcuota,0,C.valorcuota,C.vencimiento,C.vencimiento,0,NULL,@id_user 
								FROM [CNT].[ST_FnNotasCarteraRecCuotas](@cuota, @saldoActual, @Numcuota, @tipoVenci, @vencimientoact, @Dias) C 
							END
					UPDATE CNT.SaldoCliente_Cuotas set cancelada=1,id_nota=@id where id_cliente=@id_tercero and id_cuenta=@id_ctaant and nrofactura=@numfactura and anomes=@anomes and id_devolucion is NULL And cancelada=0 and id_nota is null and id<=@id_saldocuota	
				END
			
	END
	
		/*Se alimenta la tabla transacciones y saldo de cuentas para cuando es clientes*/
		EXEC CNT.ST_MOVTransacciones @id=@id,@id_user=@id_user,@nombreView='CNT.VW_TRANSACIONES_NOTASCARTERA'
		EXEC CNT.ST_MOVSaldoCuenta @opcion='I',@id=@id,@id_user=@id_user,@nombreView='CNT.VW_TRANSACIONES_NOTASCARTERA'
		--Se Actualizan las tablas de saldos clientes y saldo cliente cuotas
		UPDATE CNT.SaldoCliente_Cuotas set movCredito=(saldoAnterior+movdebito),saldoActual=0 where id_cliente=@id_tercero and id_cuenta=@id_ctaant and nrofactura=@numfactura and anomes=@anomes and id_devolucion is NULL  and id_nota =@id 

		
		if(@id_ctaact is not null )
			BEGIN
			UPDATE CNT.SaldoCliente
			SET movCredito=movDebito+saldoanterior,
				saldoActual=0,
				id_nota=@id
			WHERE id=@id_saldo and anomes=@anomes and id_cuenta=@id_ctaant

		
			END
		IF(@vencimientoact is not null and @id_ctaact is null)
		BEGIN
			UPDATE CNT.SaldoCliente
			SET	Movdebito= movDebito+saldoActual,
				movCredito=movCredito+saldoActual
			WHERE id=@id_saldo 
		END
		 EXEC [CNT].[ST_MOVRecalculoSaldo] @saldo='CLIENTE',@anomes=@anomes;
	END ELSE
		BEGIN 
			IF(@tipo_tercero='PR')
			BEGIN


				INSERT INTO CNT.SaldoProveedor (anomes,id_proveedor,id_documento,nrofactura,id_cuenta,fechaactual,fechavencimiento,saldoanterior,movDebito,movCredito,saldoActual,id_saldonota,id_user)
				SELECT @anomes,id_proveedor,id_documento,nrofactura,IIF(@id_ctaact IS NULL,@id_ctaant,@id_ctaact),fechaactual,IIF(@vencimientoact is null,fechavencimiento,@vencimientoact),saldoanterior,movDebito,movCredito,saldoActual,id,@id_user FROM CNT.SaldoProveedor WHERE id=@id_saldo and anomes=@anomes and id_cuenta=@id_ctaant
	
				SET @id_saldonew = SCOPE_IDENTITY();

				UPDATE CNT.SaldoProveedor
				SET movDebito=movCredito,
					saldoActual=saldoanterior+0,
					before=changed,
					changed=0,
					id_nota=@id
				WHERE id=@id_saldo and anomes=@anomes and id_cuenta=@id_ctaant
				/*Se alimenta la tabla transacciones y saldo de cuentas para cuando es Proveedor*/
				UPDATE CNT.MOVNotasCartera SET id_saldoact=@id_saldonew WHERE id=@id
				EXEC CNT.ST_MOVTransacciones @id=@id,@id_user=@id_user,@nombreView='CNT.VW_TRANSACIONES_NOTASCARTERA'
				EXEC CNT.ST_MOVSaldoCuenta @opcion='I',@id=@id,@id_user=@id_user,@nombreView='CNT.VW_TRANSACIONES_NOTASCARTERA'
			END
		
		END
		 


		 SELECT @id id_nota
COMMIT TRANSACTION;
END TRY
BEGIN CATCH
	SET @error = 'Error: '+ERROR_MESSAGE();
	RAISERROR(@error,16,0);		
	ROLLBACK TRANSACTION;
END CATCH

SELECT @id_return;







GO


