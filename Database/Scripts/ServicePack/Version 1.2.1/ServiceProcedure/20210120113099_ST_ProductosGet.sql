--liquibase formatted sql
--changeset ,CZULBARAN:3 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ProductosGet]') and OBJECTPROPERTY(id, N'IsProcedure') = 1) 
DROP PROCEDURE dbo.ProductosGet 
GO
CREATE PROCEDURE [dbo].[ProductosGet] 
	@id [int] = null,
	@id_user [int]
---WITH ENCRYPTION
AS
/***************************************
*Nombre:		[dbo].[ProductosGet]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		16/11/19
*Desarrollador: (JETEHERAN)
***************************************/
BEGIN
	------------------------------------------------------------------------------
	-- Declaring variables Page_Nav
	------------------------------------------------------------------------------
	
	Declare @ds_error varchar(max)
	
	Begin Try
		Select id, codigo,codigobarra, presentacion,categoria, tipo nombrecategoria,nombre, modelo, color,marca,marcacompl,impuesto, id_iva,nomImpuestoIva,id_inc,nomImpuestoInc ,estado, precio,porcendescto,  
		Tipo, stock, ivaincluido, serie, formulado, lote,urlimg, facturable,inventario,tipoproducto,nombreTipoProducto,id_ctacontable,Cuentacontable,id_tipodocu,codigoTipodocu,nombretipodocumento,id_naturaleza,Naturaleza,esDescuento
		From  [dbo].[VW_Productos]
		Where id = @id;

		
		select F.id_item id, A.codigo + ' - ' + A.presentacion + '  -  ' + A.nombre codigo, F.cantidad, F.id_producto id_padre
		from [dbo].[VW_Productos] A
		INNER JOIN [dbo].[Productos_Formulados] F ON A.id = F.id_item
		WHERE F.id_producto =	@id;
		
	
		
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