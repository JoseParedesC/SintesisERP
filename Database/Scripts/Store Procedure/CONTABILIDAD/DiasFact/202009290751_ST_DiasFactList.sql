--liquibase formatted sql
--changeset ,jtous:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_DiasFactList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[ST_DiasFactList]
GO
CREATE PROCEDURE [dbo].[ST_DiasFactList]
@id BIGINT,
@id_user INT
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[Dbo].[ST_DiasFactState]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		09/04/17
*Desarrollador: (JTOUS)
***************************************/
Declare @ds_error Varchar(Max)
BEGIN TRANSACTION
BEGIN TRY 
	
	UPDATE dbo.DiasFac
	SET estado = CASE estado WHEN 0 THEN 1 ELSE 0 END,
	id_user = @id_user, 
	updated = GETDATE() 
	WHERE id = @id;

	SELECT @id;
	
COMMIT TRANSACTION;
END TRY
BEGIN CATCH
		ROLLBACK TRANSACTION;
	    SELECT @ds_error = ERROR_MESSAGE()
	    RAISERROR(@ds_error,16,1)
	    RETURN
END CATCH
