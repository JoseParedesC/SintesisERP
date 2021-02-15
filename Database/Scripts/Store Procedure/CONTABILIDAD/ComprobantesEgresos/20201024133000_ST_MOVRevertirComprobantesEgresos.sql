--liquibase formatted sql
--changeset ,jteheran:3 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[ST_MOVRevertirComprobantesEgresos]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [CNT].[ST_MOVRevertirComprobantesEgresos]
GO


CREATE PROCEDURE [CNT].[ST_MOVRevertirComprobantesEgresos]
@id BIGINT = 0,
@id_user INT

--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[CNT].[ST_MOVRevertirComprobantesEgresos]
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		07/01/2020
*Desarrollador:  Jeteme
*Descripcion:	Se realizan EL PROCESO DE Revertir los pagos
***************************************/
Declare @tablePago TABLE(id_record INT IDENTITY(1,1) ,id_pk INT );
Declare @id_return INT, @Contabilizar BIT,@id_orden INT=NULL,@anomes VARCHAR(6),@fechadoc VARCHAR(10),@Valor NUMERIC(18,2),@identrada BIGINT,@numfactura VARCHAR(50);
Declare @rows int = 0, @valortotal int = 0, @id_pago int,@Mensaje varchar(max);

BEGIN TRANSACTION
BEGIN TRY
		
		
		SELECT  @fechadoc=CONVERT(VARCHAR(10), fecha, 120),@anomes=CONVERT(VARCHAR(10), fecha, 112) FROM CNT.[MOVComprobantesEgresos] WHERE id=@id
		
		EXECUTE [Dbo].ST_ValidarPeriodo
				@fecha			= @fechadoc,
				@anomes			= @anomes,
				@mod			= 'C'

	

		
		IF NOT EXISTS (SELECT 1 FROM [CNT].[MOVComprobantesEgresos] WHERE id = @id AND (estado = Dbo.ST_FnGetIdList('REVER') OR estado =  Dbo.ST_FnGetIdList('REVON')))
		BEGIN
			 

			INSERT INTO [CNT].[MOVComprobantesEgresos] (id_tipodoc,id_centrocosto,fecha,id_proveedor,valorpagado,valorconcepto,cambio,detalle ,id_ctaant,valoranticipo,estado,id_reversion,id_usercreated,id_userupdated)
			SELECT id_tipodoc,id_centrocosto,fecha,id_proveedor, valorpagado,valorconcepto,cambio,detalle,id_ctaant,valoranticipo ,Dbo.ST_FnGetIdList('REVON'),  @id, @id_user,@id_user
			FROM [CNT].[MOVComprobantesEgresos] WHERE id = @id;

			SET @id_return = SCOPE_IDENTITY();
		
			IF ISNULL(@id_return, 0) <> 0
			BEGIN

					UPDATE [CNT].[MOVComprobantesEgresos] SET id_reversion = @id_return, estado = Dbo.ST_FnGetIdList('REVER') Where id = @id;
		
					INSERT INTO @tablePago(id_pk) SELECT id FROM [CNT].[MOVComprobantesEgresosItems] WHERE id_comprobante=@id

					DECLARE @countPago INT = (SELECT COUNT(*) FROM @tablePago)
					SET @valortotal=0
						WHILE @countPago > 0
						BEGIN
				
							SELECT TOP 1 @identrada =  S.id_documento,@Valor=p.valor,@numfactura=p.nrofactura FROM @tablePago t INNER JOIN cnt.MOVComprobantesEgresosItems p ON t.id_pk=p.id INNER JOIN CNT.SaldoProveedor S ON p.id_documento=S.id ORDER BY id_record
							--DECLARE @identrada VARCHAR(max) = (SELECT TOP(1) p.id_entrada FROM @tablePago t INNER JOIN [CNT].[MOVComprobantesEgresosItems] p ON t.id_pk=p.id ORDER BY id_record)
							--DECLARE @Valor numeric(18,2) = (SELECT TOP(1) p.valor FROM @tablePago t INNER JOIN [CNT].[MOVComprobantesEgresosItems] p ON t.id_pk=p.id ORDER BY id_record)
							DECLARE @ide INT = (SELECT TOP(1) id_record FROM @tablePago ORDER BY id_record)
							DECLARE @id_proveedor BIGINT= (SELECT TOP(1)pr.id_proveedor FROM @tablePago t INNER JOIN [CNT].[MOVComprobantesEgresosItems] p ON t.id_pk=p.id INNER JOIN [CNT].[MOVComprobantesEgresos] pr ON p.id_comprobante=pr.id ORDER BY id_record )
 
							EXEC CNT.[ST_MOVSaldoProveedor] @Opcion='R',@id=@identrada,@id_proveedor=@id_proveedor,@tipo='',@pago=@Valor,@id_Pagoprov=@id,@id_user=@id_user,@anomes=@anomes;
	
							DELETE @tablePago WHERE id_record=@ide
 
							SET @countPago = (SELECT COUNT(*) FROM @tablePago)

 
						END
						UPDATE [CNT].[TRANSACCIONES] SET ESTADO=Dbo.ST_FnGetIdList('REVER') WHERE nrodocumento=@id and tipodocumento='CE' and anomes=@anomes

	   					EXEC [CNT].[ST_MOVSaldoCuenta] @opcion = 'R', @id = @id, @id_user = @id_user, @nombreView = 'CNT.VW_TRANSACIONES_COMPROBANTESEGRESO', @tipodocumento = 'CE',@anomes=@anomes
	   					EXEC [CNT].[ST_MOVSaldoTerceronew] @opcion = 'R', @id = @id, @id_user = @id_user, @nombreView = 'CNT.VW_TRANSACIONES_COMPROBANTESEGRESO', @tipodocumento = 'CE',@anomes=@anomes
						--Recalculo de tabla SaldoProveedor
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
			RAISERROR('Este Pago ya ha sido revertido, verifique...',16,0);
		COMMIT TRANSACTION;
			END TRY
			BEGIN CATCH	
				ROLLBACK TRANSACTION;
				--DELETE PV.TempArticulos_SpId WHERE SpId =  @@SpId;
				SET @Mensaje = 'Error: '+ERROR_MESSAGE();
				RAISERROR(@Mensaje,16,0);	
			END CATCH


GO


