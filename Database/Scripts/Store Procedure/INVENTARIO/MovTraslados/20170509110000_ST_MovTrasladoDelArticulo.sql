--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_MovTrasladoDelArticulo]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_MovTrasladoDelArticulo]
GO

CREATE PROCEDURE DBO.ST_MovTrasladoDelArticulo
    @id_articulo [INT],
	@idtoken [VARCHAR](255)
 
AS
/***************************************
*Nombre:		[Dbo].[ST_MovTrasladoDelArticulo]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		09/05/2017
*Desarrollador: (JTOUS)
***************************************/
DECLARE @error VARCHAR(MAX);
BEGIN TRY
BEGIN TRAN

	DELETE [dbo].[MOVDocumentItemTemp] 
	Where id = @id_articulo 
	  And idToken = @idtoken 
	  And tipodoc = 'T';
	  
	SELECT ISNULL(SUM(costo * cantidad), 0) Ttotal 
	FROM [dbo].[MOVDocumentItemTemp] 
	Where idToken = @idtoken 
	  And tipodoc = 'T';

COMMIT TRAN;
END TRY
BEGIN CATCH
		ROLLBACK TRAN;
	    --Getting the error description
	    SELECT @error   =  ERROR_PROCEDURE() + 
					';  ' + convert(varchar,ERROR_LINE()) + 
					'; ' + ERROR_MESSAGE()
	    -- save the error in a Log file
	    RAISERROR(@error,16,1);
	    RETURN  
END CATCH
GO
