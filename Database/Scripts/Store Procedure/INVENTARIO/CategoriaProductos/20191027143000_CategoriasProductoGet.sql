--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[Dbo].[CategoriasProductosGet]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE Dbo.CategoriasProductosGet
GO
CREATE PROCEDURE [dbo].[CategoriasProductosGet]
	@id [int] = null,
	@id_user [int]
--WITH ENCRYPTION
AS
BEGIN
/***************************************
*Nombre:		[dbo].[CategoriasProductosGet]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		29/10/19
*Desarrollador: (JTHERAN)
***************************************/
	------------------------------------------------------------------------------
	-- Declaring variables Page_Nav
	------------------------------------------------------------------------------
	Declare @ds_error varchar(max)
	
	Begin Try
	Select A.id, A.nombre
		From  dbo.CategoriasProductos A
		Where A.id = @id;
		
	End Try
    Begin Catch
	--Getting the error description
	Set @ds_error   =  ERROR_PROCEDURE() + 
					';  ' + convert(varchar,ERROR_LINE()) + 
					'; ' + ERROR_MESSAGE()
	-- save the error in a Log file
	RaisError(@ds_error,16,1)
	return
	End Catch
END

GO


