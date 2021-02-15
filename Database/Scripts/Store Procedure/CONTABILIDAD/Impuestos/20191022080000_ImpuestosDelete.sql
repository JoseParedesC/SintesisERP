--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[ImpuestosDelete]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE CNT.ImpuestosDelete
GO

CREATE PROCEDURE [CNT].[ImpuestosDelete]
@id BIGINT,
@id_user INT
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[CNT].[ImpuestosDelete]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		22/10/19
*Desarrollador: (jeteme)
***************************************/
Declare @ds_error Varchar(Max),@coderror int
BEGIN TRANSACTION
BEGIN TRY 
		
		DELETE CNT.Impuestos WHERE id = @id;

		SELECT @id;
COMMIT TRANSACTION;
END TRY
BEGIN CATCH
		ROLLBACK TRANSACTION;
	    SELECT @ds_error = ERROR_MESSAGE(),@coderror=ERROR_NUMBER()

		IF(@coderror=547)
		RAISERROR('Este impuesto tiene movimiento referenciado, NO es posible Eliminarlo!',16,1)
	    ELSE
	    RAISERROR(@ds_error,16,1)
	    RETURN
END CATCH


GO


