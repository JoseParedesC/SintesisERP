--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_CNTCategoriaFiscalDelete]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_CNTCategoriaFiscalDelete]
GO
CREATE PROCEDURE [dbo].[ST_CNTCategoriaFiscalDelete]
@id BIGINT,
@id_user INT
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[dbo].[ST_CNTCategoriaFiscalDelete]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		02/04/17
*Desarrollador: (JTOUS)
***************************************/
Declare @ds_error Varchar(Max),@coderror int;
BEGIN TRANSACTION
BEGIN TRY 

		DELETE Dbo.CNTCategoriaFiscal WHERE id = @id;

		SELECT @id;
COMMIT TRANSACTION;
END TRY
BEGIN CATCH
		ROLLBACK TRANSACTION;
	    SELECT @ds_error = ERROR_MESSAGE(), @coderror=ERROR_NUMBER()

		IF(@coderror=547)
		RAISERROR('No se puede eliminar, ya que tiene movimientos.',16,1)
	    ELSE
	    RAISERROR(@ds_error,16,1)
	    RETURN
END CATCH
