--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[ST_MOVRevertirComprobanteContable]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [CNT].[ST_MOVRevertirComprobanteContable]
GO


CREATE PROCEDURE [CNT].[ST_MOVRevertirComprobanteContable]
@id BIGINT = 0,
@id_user INT

--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[CNT].[ST_MOVRevertirComprobanteContable]
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		07/01/2020
*Desarrollador:  Jeteme
*Descripcion:	Se realizan EL PROCESO DE Revertir los pagos
***************************************/
Declare @tablePago TABLE(id_record INT IDENTITY(1,1) ,id_pk INT );
Declare @id_return INT, @Contabilizar BIT,@id_orden INT=NULL,@fechadoc VARCHAR(10),@anomes VARCHAR(6),@valor NUMERIC(18,2),@id_cuenta BIGINT,@id_tercero BIGINT,@factura varchar(50),@id_saldocuota bigint,@Ccliente bit=0,@Cproveedor bit=0;
Declare @rows int = 0, @valortotal int = 0, @id_pago int,@Mensaje varchar(max),@count int=1;
Declare @tabla TABLE (tm_id BIgint identity(1,1),id_item BIGINT,id_comprobante Bigint,id_tercero BIGINT,id_cuenta bigint,valor numeric(18,2),factura varchar(50),id_saldocuota bigint)


BEGIN TRANSACTION
BEGIN TRY
		
	   SELECT  @fechadoc=CONVERT(VARCHAR(10), fecha, 120),@anomes=CONVERT(VARCHAR(10), fecha, 112) FROM CNT.MOVComprobantesContables WHERE id=@id
	

		EXECUTE [Dbo].ST_ValidarPeriodo
				@fecha			= @fechadoc,
				@anomes			= @anomes,
				@mod			= 'C'

		IF NOT EXISTS (SELECT 1 FROM Cnt.MOVComprobantesContables WHERE id = @id AND (estado = Dbo.ST_FnGetIdList('REVER') OR estado =  Dbo.ST_FnGetIdList('REVON')))
		BEGIN
			 
			INSERT INTO [CNT].[MOVComprobantesContables] (fecha,id_documento,detalle, estado,id_reversion,id_usercreated,id_userupdated)
			SELECT fecha,id_documento, detalle,  Dbo.ST_FnGetIdList('REVON'),  @id, @id_user,@id_user
			FROM [CNT].[MOVComprobantesContables] WHERE id = @id;

			SET @id_return = SCOPE_IDENTITY();
		
			IF ISNULL(@id_return, 0) <> 0
			BEGIN

			 Insert into @tabla (id_item,id_comprobante,id_cuenta,id_tercero,valor,factura,id_saldocuota)
			 Select I.id,C.id,I.id_cuenta,I.id_tercero,I.valor,factura,id_saldocuota  from [CNT].[MOVComprobantesContables] C INNER JOIN [CNT].[MOVComprobantesContablesItems] I ON C.id=I.id_comprobante WHERE C.id=@id


			 Set @rows = @@ROWCOUNT;
						 
						WHILE(@rows >= @count)
						BEGIN 
							SELECT @id_tercero=id_tercero,@id_cuenta=id_cuenta,@valor=valor,@id_saldocuota=id_saldocuota,@factura=factura FROM @tabla where tm_id=@count
							 IF((SELECT categoria FROM CNTCuentas WHERE id=@id_cuenta )=dbo.ST_FnGetIdList('CPROVE'))
											BEGIN
											SET @Cproveedor=1;
											--Actualizo saldocliente con los valores asignados
												UPDATE CNT.SaldoProveedor SET movdebito   = movdebito  - IIF(@valor>0,@valor,0),
												movCredito  = movCredito - IIF(@valor>0,0,@valor*-1),
												saldoActual = saldoAnterior + (movdebito  - IIF(@valor>0,@valor,0))- movCredito - IIF(@valor>0,0,@valor*-1),
												changed=0
												WHERE id=@id_saldocuota
											END
							SET @count += 1;
						END
						
			UPDATE [CNT].[MOVComprobantesContables] SET id_reversion = @id_return, estado = Dbo.ST_FnGetIdList('REVER') Where id = @id;
			/*Buscar la manera de revertir en transacciones*/
			UPDATE [CNT].[TRANSACCIONES] SET ESTADO=Dbo.ST_FnGetIdList('REVER') WHERE nrodocumento=@id and tipodocumento='CC' and anomes=@anomes
			--Actualizacion de tablas saldos
			
			EXEC CNT.ST_MOVSaldos  @opcion='R',@id=@id,@id_user=@id_user,@nombreView='CNT.VW_TRANSACIONES_COMPROBANTESCONTABLE', @tipodocumento = 'CC',@anomes=@anomes
		
			
			IF(@Ccliente=1)
				EXEC [CNT].[ST_MOVRecalculoSaldo] @saldo='CLIENTE',@anomes=@anomes;	
			IF(@Cproveedor=1)
				EXEC [CNT].[ST_MOVRecalculoSaldo] @saldo='PROVEEDOR',@anomes=@anomes;

				SELECT @id_return id, 'REVERSION' estado, @id idrev
					END
					ELSE
					BEGIN
						SET @Mensaje = 'No se genero el documento de reversi�n';
						RAISERROR(@Mensaje,16,0);
					END
				END
				ELSE
					RAISERROR('Este Comprobante ya ha sido revertido, verifique...',16,0);
				COMMIT TRANSACTION;
			END TRY
			BEGIN CATCH	
				ROLLBACK TRANSACTION;
				--DELETE PV.TempArticulos_SpId WHERE SpId =  @@SpId;
				SET @Mensaje = 'Error: '+ERROR_MESSAGE();
				RAISERROR(@Mensaje,16,0);	
			END CATCH

