--liquibase formatted sql
--changeset ,jteheran:3 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[ST_MOVContabilizarComprobantesContable]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [CNT].[ST_MOVContabilizarComprobantesContable]
GO
CREATE PROCEDURE [CNT].[ST_MOVContabilizarComprobantesContable]
@id BIGINT = 0, 
@fecha  SMALLDATETIME,
@id_tipodoc BIGINT,
@detalle VARCHAR(MAX),
@id_comprobantetemp BIGINT,
@id_user INT


--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[CNT].[ST_MOVContabilizarComprobantesContable]
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		21/10/2020
*Desarrollador:  JESID TEHERAN MEZA
*Descripcion:	Se realizan EL PROCESO DE REALIZACION DE COMPROBANTE CONTABLE
***************************************/
Declare @id_return INT, @Contabilizar BIT, @idestado INT,@anomes VARCHAR(6),@fechadoc VARCHAR(10),@rows int, @count int = 1,@id_cuenta BIGINT,@valor NUMERIC(18,2),@id_tercero BIGINT,@id_saldo BIGINT,@factura varchar(50),@fechavencimiento smalldatetime,@id_saldocuota bigint,@Ccliente bit=0,@Cproveedor bit=0;
Declare @tabla TABLE (tm_id BIgint identity(1,1),id_item BIGINT,id_comprobante Bigint,id_tercero BIGINT,id_cuenta bigint,valor numeric(18,2),factura varchar(50),id_saldocuota bigint)
BEGIN TRANSACTION
BEGIN TRY

			SET @anomes = CONVERT(VARCHAR(6), @fecha, 112);
			SET @fechadoc = CONVERT(VARCHAR(10), @fecha, 120);
			
			EXECUTE [Dbo].ST_ValidarPeriodo
							@fecha			= @fechadoc,
							@anomes			= @anomes,
							@mod			= 'C'


		SET @idestado = Dbo.ST_FnGetIdList('PROCE');
			
					INSERT INTO [CNT].[MOVComprobantesContables] (fecha, detalle,id_documento,estado,id_usercreated,id_userupdated)
					SELECT @fecha,@detalle,@id_tipodoc,@idestado,@id_user,@id_user
					
					
					SET @id_return = SCOPE_IDENTITY();
					
					

					IF ISNULL(@id_return, 0) <> 0
					BEGIN
						INSERT INTO [CNT].[MOVComprobantesContablesItems] (id_comprobante,id_centrocosto, id_concepto,id_cuenta,id_tercero,detalle,valor,factura,id_saldocuota,fechavencimiento, id_usercreated)						
						SELECT @id_return,id_centrocosto ,id_concepto,id_cuenta ,id_tercero,detalle,valor,factura,id_saldocuota,fechavencimiento,@id_user
						FROM [cnt].[MOVComprobantesItemsTemp] WHERE id_comprobante = @id_comprobantetemp;
											 
						 Set @rows = @@ROWCOUNT;
						 
						 EXEC CNT.ST_MOVTransacciones @id=@id_return,@id_user=@id_user,@nombreView='CNT.VW_TRANSACIONES_COMPROBANTESCONTABLE'
						 					
						 EXEC CNT.ST_MOVSaldos  @opcion='I',@id=@id_return,@id_user=@id_user,@nombreView='CNT.VW_TRANSACIONES_COMPROBANTESCONTABLE' --SE CAMBIO ESTA LINEA 
					
						 Delete [CNT].[MOVComprobantesItemsTemp] WHERE id_comprobante = @id_comprobantetemp;
						 Delete [CNT].[MOVComprobantesContablesTemp] Where id = @id_comprobantetemp;
						
			

						SELECT @id_return id, 'PROCESADO' estado
						
					
					END
					ELSE
					BEGIN
						RAISERROR('Error al Guardar Comprobante, No se pudo guardar la cabecera del Comprobante.', 16,0);
					END
									
			
		
			
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH	
		ROLLBACK TRANSACTION;
		Declare @Mensaje varchar(max) = 'Error: '+ERROR_MESSAGE();
		RAISERROR(@Mensaje,16,0);	
	END CATCH


GO


