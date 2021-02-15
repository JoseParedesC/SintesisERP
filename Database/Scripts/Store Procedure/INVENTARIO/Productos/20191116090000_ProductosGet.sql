--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ProductosGet]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.[ProductosGet]
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
*creación:		16/11/19
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

		Select F.id_articulo id, F.cantidad, A.codigo, A.presentacion, F.serie, F.id_lote,L.lote
		From  [dbo].[ArticulosFormula] F
		INNER JOIN [dbo].[VW_Productos] A ON A.id = F.id_articulo
		INNER JOIN [dbo].[LotesProducto] L ON F.id_lote=L.id
		Where F.id_articuloformu = @id;
		
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


