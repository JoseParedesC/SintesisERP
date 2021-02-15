--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[VendedoresDelete]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[VendedoresDelete]
GO

CREATE PROCEDURE [dbo].[VendedoresDelete]
@id BIGINT,
@id_user INT
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[dbo].[VendedoresDelete]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		15/11/19
*Desarrollador: (Jeteme)
***************************************/
Declare @ds_error Varchar(Max),@coderror int
BEGIN TRANSACTION
BEGIN TRY 

		DELETE dbo.Vendedores WHERE id = @id;

		SELECT @id;
COMMIT TRANSACTION;
END TRY
BEGIN CATCH
		ROLLBACK TRANSACTION;
	    SELECT @ds_error = ERROR_MESSAGE(),@coderror=ERROR_NUMBER()

		IF(@coderror=547)
		RAISERROR('Este vendedor tiene movimientos referenciados, No es posible Eliminarlo!',16,1)
	    ELSE
	    RAISERROR(@ds_error,16,1)
	    RETURN
END CATCH


GO


