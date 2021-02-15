--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_CNTResolucionesUpdate]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_CNTResolucionesUpdate]
GO

CREATE PROCEDURE [dbo].[ST_CNTResolucionesUpdate]
@id BIGINT = null,
@id_centrocosto bigint, 
@leyenda VARCHAR(MAX), 
@id_user int

AS

/***************************************
*Nombre:		[Dbo].[ST_CNTResolucionesUpdate]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		09/04/17
*Desarrollador: (JTOUS)
***************************************/

BEGIN TRANSACTION
BEGIN TRY
	
	DECLARE @id_return INT, @error VARCHAR(MAX), @estado BIT = 1;
	IF EXISTS (SELECT 1 FROM [DocumentosTecnicaKey] WHERE id_ccosto = @id_centrocosto AND estado != 0)
		SET	@estado = 0

	UPDATE Dbo.[DocumentosTecnicaKey]
	SET 
		leyenda		= @leyenda, 			
		id_ccosto	= @id_centrocosto, 
		estado		= CASE WHEN @estado = 0 THEN 0 ELSE estado END,
		updated		= GETDATE()
	WHERE id = @id;
			
	SET @id_return = @id	

	COMMIT TRANSACTION;
END TRY
BEGIN CATCH	
	ROLLBACK TRANSACTION;
	SET @error = 'Error: '+ERROR_MESSAGE();
	RAISERROR(@error,16,0);	
END CATCH

SELECT @id_return;

GO


