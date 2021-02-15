--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[Dbo].[CajasDelete]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE Dbo.CajasDelete
GO
CREATE PROCEDURE dbo.CajasDelete
@id BIGINT,
@id_user INT

AS
/***************************************
*Nombre:		[dbo].[CajasDelete]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		19/12/19
*Desarrollador: (JETEHERAN)
***************************************/
Declare @ds_error Varchar(Max)
BEGIN TRANSACTION
BEGIN TRY 

		DELETE dbo.Cajas WHERE id = @id;

		SELECT @id;
COMMIT TRANSACTION;
END TRY
BEGIN CATCH
		ROLLBACK TRANSACTION;
	    SELECT @ds_error = ERROR_MESSAGE()
	    RAISERROR(@ds_error,16,1);
END CATCH
GO
