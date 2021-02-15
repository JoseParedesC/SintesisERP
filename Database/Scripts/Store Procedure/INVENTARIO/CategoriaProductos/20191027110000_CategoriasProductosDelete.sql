--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[Dbo].[CategoriasProductosDelete]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE Dbo.CategoriasProductosDelete
GO

CREATE PROCEDURE [dbo].[CategoriasProductosDelete]
@id BIGINT,
@id_user INT
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[dbo].[CategoriasProductosDelete]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		29/10/19
*Desarrollador: (JTHERAN)
***************************************/
Declare @ds_error Varchar(Max)
BEGIN TRANSACTION
BEGIN TRY 

		DELETE dbo.categoriasproductos WHERE id = @id;

		SELECT @id;
COMMIT TRANSACTION;
END TRY
BEGIN CATCH
		ROLLBACK TRANSACTION;
	    SELECT @ds_error = ERROR_MESSAGE()
		IF(@ds_error like '%"FK_Articulos_TipoArticulos".%')
		RAISERROR('Categoria se ha utilizado en un producto',16,1)
		ELSE
	    RAISERROR(@ds_error,16,1)
	    RETURN
END CATCH
