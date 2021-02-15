--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[Dbo].[CategoriasProductosState]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE Dbo.CategoriasProductosState
GO
CREATE PROCEDURE [dbo].[CategoriasProductosState]
@id BIGINT,
@id_user INT

AS
/***************************************
*Nombre:		[dbo].[CategoriasProductosState]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		29/10/19
*Desarrollador: (JTHERAN)
***************************************/
Declare @ds_error Varchar(Max)

Begin Try

	/* Actualización del campo estado en la tabla CategoriaProductos*/

	UPDATE dbo.CategoriasProductos
	SET estado = CASE estado WHEN 0 THEN 1 ELSE 0 END,
	id_user = @id_user, 
	updated = GETDATE() 
	WHERE id = @id;

	SELECT @id;


End Try
Begin Catch
	    Select @ds_error = ERROR_MESSAGE()
	    RaisError(@ds_error,16,1)
	    Return
End Catch
