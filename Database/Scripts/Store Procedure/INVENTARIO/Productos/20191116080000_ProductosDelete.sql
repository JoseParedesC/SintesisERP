--liquibase formatted sql
--changeset ,jtous:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ProductosDelete]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.[ProductosDelete]
GO

CREATE PROCEDURE [dbo].[ProductosDelete]
@id BIGINT,
@id_user INT
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[dbo].[ProductosDelete]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		16/11/19
*Desarrollador: (JETEHERAN)
***************************************/
Declare @ds_error Varchar(Max),@coderror int
BEGIN TRANSACTION
BEGIN TRY 
		IF EXISTS (SELECT TOp 1 1 FROM Productos WHERE codigo = 'INTCOR' AND id = @id)
			RAISERROR('No se puede eliminar el producto de causación', 16, 0);
		
		DELETE DBO.ArticulosFormula WHERE id_articuloformu = @id;
		DELETE dbo.Productos WHERE id = @id;

COMMIT TRANSACTION;
END TRY
BEGIN CATCH
		ROLLBACK TRANSACTION;
	    SELECT @ds_error = ERROR_MESSAGE(),@coderror=ERROR_NUMBER()

		IF(@coderror=547)
			RAISERROR('Este Producto tiene movimiento referenciado, NO es posible Eliminarlo!',16,1)
	    ELSE
			RAISERROR(@ds_error,16,1)

	    RETURN
END CATCH

GO


