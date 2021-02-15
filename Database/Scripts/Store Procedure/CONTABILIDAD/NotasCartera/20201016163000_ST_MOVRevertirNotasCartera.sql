--liquibase formatted sql
--changeset ,jteheran:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[ST_MOVRevertirNotasCartera]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [CNT].[ST_MOVRevertirNotasCartera]
GO

CREATE PROCEDURE [CNT].[ST_MOVRevertirNotasCartera]
@id BIGINT = 0,
@id_user INT

--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[CNT].[ST_MOVRevertirNotasCartera]
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		16/10/2020
*Desarrollador:  Jeteme
*Descripcion:	Se realizan EL PROCESO DE Revertir los Notas de cartera
***************************************/
DECLARE @tabla TABLE(id int identity(1,1), id_cuota int);
Declare @id_return INT, @Contabilizar BIT,@id_orden INT=NULL,@fechadoc VARCHAR(10),@anomes VARCHAR(6),@saldoanteriorcli NUMERIC(18,2),@movdebitocli NUMERIC(18,2),@movcreditocli NUMERIC(18,2),@saldoactualcli NUMERIC(18,2),@saldoanteriorpro NUMERIC(18,2),@movdebitopro NUMERIC(18,2),@movcreditopro NUMERIC(18,2),@saldoactualpro NUMERIC(18,2);
Declare @rows int = 0,@count INT=1, @tipoterce VARCHAR(50),@Mensaje varchar(max),@id_saldoant BIGINT,@id_saldoact BIGINT,@id_ctaact BIGINT,@id_ctaant BIGINT,@coderror INT;

BEGIN TRANSACTION
BEGIN TRY


		SELECT  @fechadoc=CONVERT(VARCHAR(10), fecha, 120),@anomes=CONVERT(VARCHAR(10), fecha, 112) FROM CNT.MOVNotasCartera WHERE id=@id

		EXECUTE [Dbo].ST_ValidarPeriodo
				@fecha			= @fechadoc,
				@anomes			= @anomes,
				@mod			= 'C'
		
		IF NOT EXISTS (SELECT 1 FROM Cnt.MOVNotasCartera WHERE id = @id AND (estado = Dbo.ST_FnGetIdList('REVER') OR estado =  Dbo.ST_FnGetIdList('REVON')))
		BEGIN
			 

			INSERT INTO [CNT].[MOVNotasCartera] (id_tipodoc,id_centrocosto,fecha,id_tercero,id_saldo,id_saldoact,id_ctaant,id_ctaact,vencimientoact,detalle,estado,id_reversion,id_usercreated)
			SELECT id_tipodoc,id_centrocosto,GETDATE(),id_tercero, id_saldo,id_saldoact,id_ctaant,id_ctaact,vencimientoact,detalle,Dbo.ST_FnGetIdList('REVON'),  @id, @id_user
			FROM [CNT].MOVNotasCartera WHERE id = @id;

			SET @id_return = SCOPE_IDENTITY();
		
			IF ISNULL(@id_return, 0) <> 0
			BEGIN

				UPDATE [CNT].MOVNotasCartera SET id_reversion = @id_return, estado = Dbo.ST_FnGetIdList('REVER') Where id = @id;

				--Alimento las variables necesarias para hacer comparaciones
				SELECT @tipoterce     = tipotercero,
					   @id_saldoant   = id_saldo,
					   @id_saldoact   = id_saldoact,
					   @saldoactualcli   = N.saldoactual,
					   @saldoanteriorpro = SP.saldoanterior,
					   @movdebitopro     = SP.movDebito,
					   @movcreditopro    = SP.movCredito,
					   @saldoactualpro   = SP.saldoActual 
					   FROM CNT.VW_MOVNotascartera N LEFT JOIN CNT.SaldoCliente S ON N.id_saldoact=S.id 
					   LEFT JOIN CNT.SaldoProveedor SP ON N.id_saldoact=SP.id 
					   WHERE N.id=@id /*AND (S.anomes = @anomes OR SP.anomes = @anomes)*/
	
				
				IF(@tipoterce='CLIENTE')
				BEGIN
					IF(@id_saldoact is not null)-- Valido si el campo de id_saldo actual no es nulo, lo que quiere decir que se genero un nuevo registro o se actualizo uno existente
						BEGIN
							--Actualizo el registro de saldo que se genero con esta notacredito descontando el valor del movimiento debito y el sacto actual con el saldo que se le sumo a la hora de realizar dicha nota	
							UPDATE CNT.SaldoCliente  SET movDebito=movDebito-@saldoactualcli,
														saldoactual=Saldoactual-@saldoactualcli,
														changed=0,
														id_nota=@id_return 
							WHERE id=@id_saldoact
							--Actualizo el registro de saldo que se remplazo  descontando en el movimiento credito el valor del saldo y sumandole al saldoatual el valor del saldo realizado en ese registro
							UPDATE CNT.SaldoCliente SET movCredito=movCredito-@saldoactualcli,
														saldoActual=saldoActual+@saldoactualcli,
														changed=0,
														id_nota = NULL
							WHERE id=@id_saldoant

						END ELSE -- Si es nulo quiere decir que no se genero ni se modifico ningun registro adicional por lo tanto se le debe descontar a los movimientos debitos y credito el saldo que se le habia sumado con esta nota
						BEGIN
							UPDATE CNT.SaldoCliente SET movCredito=movCredito-@saldoactualcli,
														movDebito=movDebito-@saldoactualcli,
														changed=0,
														id_nota = NULL
							WHERE id=@id_saldoant
						END
						
						--Se actualiza los registros generados al momento de realizar la nota modificando la nota credito
							UPDATE C SET C.movdebito= C.movdebito-(select valor from cnt.Transacciones where tipodocumento='NC' and nrodocumento=@id and RTRIM(LTRIM(substring(descripcion,LEN(descripcion)-1,5)))=C.cuota and valor>0),
										 C.saldoActual=C.saldoanterior+(C.movdebito-(select valor from cnt.Transacciones where tipodocumento='NC' and nrodocumento=@id and RTRIM(LTRIM(substring(descripcion,LEN(descripcion)-1,5)))=C.cuota and valor>0))-C.movcredito,
										 C.id_nota=@id_return,
										 C.cancelada=1,
										 C.changed=0
							FROM CNT.SaldoCliente_Cuotas C JOIN CNT.SaldoCliente S ON S.id_cliente=C.id_cliente AND S.id_cuenta=C.id_cuenta and S.anomes=C.anomes and S.nrofactura=C.nrofactura and C.id_nota is null
							WHERE S.id=IIF(@id_saldoact is NULL,@id_saldoant,@id_saldoact)
						
						

							UPDATE C SET C.movCredito= C.movcredito-(select valor*-1 from cnt.Transacciones where tipodocumento='NC' and nrodocumento=@id and RTRIM(LTRIM(substring(descripcion,LEN(descripcion)-1,5)))=C.cuota and valor<0),
										 C.saldoActual=C.saldoanterior+C.movdebito-(C.movcredito-(select valor*-1 from cnt.Transacciones where tipodocumento='NC' and nrodocumento=@id and RTRIM(LTRIM(substring(descripcion,LEN(descripcion)-1,5)))=C.cuota and valor<0)),
										 C.id_nota=NULL,
										 C.cancelada=0,
										 C.changed=0
							FROM CNT.SaldoCliente_Cuotas C JOIN CNT.SaldoCliente S ON S.id_cliente=C.id_cliente AND S.id_cuenta=C.id_cuenta and S.anomes=C.anomes and S.nrofactura=C.nrofactura and C.id_nota=@id
							WHERE S.id=@id_saldoant
					
				END	ELSE
					BEGIN
					--Actualizo el saldo anterior
					UPDATE CNT.SaldoProveedor SET saldoanterior  = @saldoanteriorpro,
												movDebito      = @movdebitopro,
												movCredito	   = @movcreditopro,
												saldoActual	   = @saldoactualpro,
												id_nota		   = NULL
					WHERE id = @id_saldoant and anomes = @anomes

					--Se elimina el saldo que se genero con esta nota cartera
					DELETE FROM CNT.SaldoProveedor WHERE id = @id_saldoact and anomes=@anomes	
					END


				UPDATE [CNT].[TRANSACCIONES] SET ESTADO=Dbo.ST_FnGetIdList('REVER') WHERE nrodocumento=@id and tipodocumento='RC' and anomes=@anomes
	   		    EXEC [CNT].[ST_MOVSaldoCuenta] @opcion = 'R', @id = @id, @id_user = @id_user, @nombreView = 'CNT.VW_TRANSACIONES_RECIBOCAJA', @tipodocumento = 'RC', @anomes=@anomes

				 EXEC [CNT].[ST_MOVRecalculoSaldo] @saldo='CLIENTE',@anomes=@anomes;
				SELECT @id_return id, 'REVERSION' estado, @id idrev
				END
				ELSE
				BEGIN
					SET @Mensaje = 'No se genero el documento de reversi�n';
					RAISERROR(@Mensaje,16,0);
				END
			END
			ELSE
				RAISERROR('Esta nota de cartera ya ha sido revertido, verifique...',16,0);
			COMMIT TRANSACTION;
			END TRY
			BEGIN CATCH	
				ROLLBACK TRANSACTION;
				--DELETE PV.TempArticulos_SpId WHERE SpId =  @@SpId;
				SET @coderror=ERROR_NUMBER();
				SET @Mensaje = 'Error: '+ERROR_MESSAGE();
				IF(@coderror=547)
					RAISERROR('Este documento tiene movimiento referenciado, No es posible Revertir!',16,1)
				ELSE
				RAISERROR(@Mensaje,16,0);	
			END CATCH
GO


