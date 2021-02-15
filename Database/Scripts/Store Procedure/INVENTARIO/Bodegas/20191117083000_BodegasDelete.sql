--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[Dbo].[BodegasDelete]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE Dbo.BodegasDelete
GO
CREATE PROCEDURE dbo.BodegasDelete
@id BIGINT,
@id_user INT
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[dbo].[BodegasDelete]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci?n:		17/11/19
*Desarrollador: (JETEHERAN)
***************************************/
Declare @ds_error Varchar(Max)
BEGIN TRANSACTION
BEGIN TRY 

		DELETE Dbo.Bodegas WHERE id = @id;

		SELECT @id;
COMMIT TRANSACTION;
END TRY
BEGIN CATCH
		ROLLBACK TRANSACTION;
	    SELECT @ds_error = ERROR_MESSAGE()
	    RAISERROR(@ds_error,16,1)
	    RETURN
END CATCH
GO
