--liquibase formatted sql
--changeset ,jteheran:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[Dbo].[ST_CNTCategoriaFiscalServicioSave]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [Dbo].[ST_CNTCategoriaFiscalServicioSave]
GO



CREATE PROCEDURE [dbo].[ST_CNTCategoriaFiscalServicioSave]
@id BIGINT = null,
@id_servicio BIGINT,
@id_retefuente BIGINT = null,
@id_reteiva  BIGINT = null,
@id_reteica BIGINT = null,
@fuentebase  decimal(18,2),
@ivabase  decimal(18,2),
@icabase  decimal(18,2),
@id_user int

--WITH ENCRYPTION
AS

/***************************************
*Nombre:		[dbo].[ST_CNTCategoriaFiscalSave]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		02/04/17
*Desarrollador: (JTOUS)
***************************************/

BEGIN TRANSACTION
BEGIN TRY
	
	DECLARE @id_return INT, @error VARCHAR(MAX);

	IF(Isnull(@id,0) = 0)
	BEGIN
		IF EXISTS (SELECT 1 FROM Dbo.CNTCategoriaFiscalServicios A WHERE A.id_servicio = @id_servicio AND id != ISNULL(@id,0))
		BEGIN
			RAISERROR('Ya existe Categor�a con este Servicio...', 16,0);
		END
		ELSE
		BEGIN
			
				INSERT INTO Dbo.CNTCategoriaFiscalServicios (id_servicio, id_retefuente, id_reteica, id_reteiva, valorfuente, valorica, valoriva,  id_user)
				VALUES(@id_servicio, @id_retefuente, @id_reteica, @id_reteiva, @fuentebase, @icabase, @ivabase, @id_user)
			
				
			SET @id_return = SCOPE_IDENTITY();	
		END
	END
	ELSE
	BEGIN
	
			UPDATE Dbo.CNTCategoriaFiscalServicios SET  id_retefuente = @id_retefuente, id_reteica = @id_reteica, id_reteiva = @id_reteiva, valorfuente = @fuentebase, 
				valorica = @icabase, valoriva = @ivabase
			WHERE id = @id;
	
		
		SET @id_return = @id;	
	END
	

COMMIT TRANSACTION;
END TRY
BEGIN CATCH
	SET @error = 'Error: '+ERROR_MESSAGE();
	RAISERROR(@error,16,0);		
	ROLLBACK TRANSACTION;
END CATCH

SELECT @id_return;
GO


