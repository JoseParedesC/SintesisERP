--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[Dbo].[FormasPagosDelete]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE Dbo.FormasPagosDelete
GO

CREATE PROCEDURE dbo.FormasPagosDelete
@id BIGINT,
@id_user INT
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[dbo].[FormaPagoDelete]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		27/11/19
*Desarrollador: (JETEHERAN)
***************************************/
Declare @ds_error Varchar(Max)
BEGIN TRANSACTION
BEGIN TRY 

		DELETE dbo.FormaPagos WHERE id = @id;

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
