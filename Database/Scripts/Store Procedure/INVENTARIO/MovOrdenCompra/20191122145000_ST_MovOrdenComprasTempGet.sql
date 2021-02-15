--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_MovOrdenComprasTempGet]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_MovOrdenComprasTempGet]
GO
CREATE PROCEDURE dbo.ST_MovOrdenComprasTempGet 
	@id [int]
 
AS
BEGIN
/***************************************
*Nombre:		[dbo].[ST_MovOrdenComprasTempGet]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		22/11/19
*Desarrollador: (Jeteme)
***************************************/
	------------------------------------------------------------------------------
	-- Declaring variables Page_Nav
	------------------------------------------------------------------------------
	Declare @ds_error varchar(max), @id_entra int
	
	Begin Try
		SET @id_entra = (SELECT Top 1  id  FROM Dbo.MovOrdenComprasTemp T Where T.id = @id);
		
		Select 
			id, 
			fechadocumen,
			estado,
			id_proveedor,
			proveedor,
			bodega,
			nombrebodega
		From 
			Dbo.VW_MOVOrdenComprasTemp M
		Where 
			id = @id;

		Select 
			id,	codigo, presentacion, nombre, bodega, cantidad
		From 
			Dbo.VW_MOVOrdenComprasItemTemp M
		Where 
			id_ordencompra = @id_entra;
		
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
