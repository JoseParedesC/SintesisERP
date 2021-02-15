--liquibase formatted sql
--changeset ,jteheran:3 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[ST_MOVRevertirComprobantesEgresos]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [CNT].[ST_MOVRevertirComprobantesEgresos]
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
		    		   UPDATE [CNT].[TRANSACCIONES] SET ESTADO=Dbo.ST_FnGetIdList('REVER') WHERE nrodocumento=@id and tipodocumento='CE' and anomes=@anomes
	   				   EXEC CNT.ST_MOVSaldos  @opcion='R',@id=@id,@id_user=@id_user,@nombreView='CNT.VW_TRANSACIONES_COMPROBANTESEGRESO', @tipodocumento = 'CE',@anomes=@anomes

		
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


