--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_TurnosDelete]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_TurnosDelete]
GO
CREATE PROCEDURE dbo.ST_TurnosDelete
@id BIGINT,
@id_user INT
WITH ENCRYPTION
AS
/***************************************
*Nombre:		[dbo].[ST_TurnosDelete]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci?n:		27/03/17
*Desarrollador: (JTOUS)
***************************************/
Declare @ds_error Varchar(Max)
BEGIN TRANSACTION
BEGIN TRY 

		DELETE dbo.Turnos WHERE id = @id;

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
