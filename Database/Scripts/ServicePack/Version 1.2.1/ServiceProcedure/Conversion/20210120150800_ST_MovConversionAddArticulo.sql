--liquibase formatted sql
--changeset ,CZULBARAN:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_MovConversionAddArticulo]') and OBJECTPROPERTY(id, N'IsProcedure') = 1) 
DROP PROCEDURE dbo.ST_MovConversionAddArticulo
GO
CREATE PROCEDURE [dbo].[ST_MovConversionAddArticulo]
	@id_entrada		[int],
    @id_articulo	[INT],
    @id_bodega		[INT],
    @cantidad		[NUMERIC] (18,2),
    @id_user		[INT],
	@serie          BIT,
	@lote           BIT,
	@factura		VARCHAR(255)
AS
/***************************************
*Nombre:		[Dbo].[ST_MovConversionAddArticulo]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		25/01/2020
*Desarrollador: (CZULBARAN)
***************************************/
DECLARE @error VARCHAR(MAX), @id int, @costo NUMERIC(18,4) = 0, @search BIT
BEGIN TRY
BEGIN TRAN

	SET @search = ISNULL((SELECT TOP 1 P.serie FROM DBO.Productos P INNER JOIN dbo.Productos_Formulados F on F.id_item = P.id  WHERE F.id_producto= @id_articulo AND P.serie =1),0)
	SET @costo = ISNULL(DBO.ST_FnCostoArticuloFormulado(@id_articulo, @id_bodega),0);
	IF EXISTS (SELECT 1 FROM DBO.MOVEntradasItemsTemp WHERE id_entrada = @id_entrada AND id_articulo = @id_articulo AND id_bodega != @id_bodega)
		RAISERROR ('No puede colocar una bodega distinta al articulo ya ingresado', 16, 0) 
	
	INSERT INTO [dbo].[MOVEntradasItemsTemp] (id_entrada, id_articulo, id_bodega, cantidad, costo, precio, iva, descuento, costototal, flete, id_user,/* */serie,descuentound,pordescuento,inventarial,lote)
	SELECT @id_entrada, P.id, @id_bodega, @cantidad, @costo, 0, 0, 0, @cantidad * @costo, 0, @id_user, P.serie, 0, 0,1, 0 FROM Productos P WHERE id = @id_articulo;
	SET @id = SCOPE_IDENTITY();
	INSERT INTO [dbo].[MOVFacturaItemsTemp] (id_factura, id_articulo, id_bodega, serie, lote ,cantidad, precio, descuentound, pordescuento, descuento, id_iva, poriva, iva,  
					id_inc, porinc, inc, total, id_user,costo,  preciodes, formulado, inventarial, id_itemfac)
	
	SELECT @factura, PF.id_item, @id_bodega, PP.serie, 0, @cantidad * PF.cantidad, A.precio, A.descuentound, 0, A.descuento, A.id_iva, A.poriva, A.iva,
	A.id_inc, A.porinc, A.inc, A.total, @id_user, 0, A.preciodes, A.formulado, 1, P.id	
	FROM DBO.Productos_Formulados PF INNER JOIN DBO.Productos P ON PF.id_producto = P.id	
									 CROSS APPLY Dbo.ST_FnPrecioArticulo (PF.id_item, 0, @cantidad, 0) A 
									 INNER JOIN DBO.Productos PP ON PF.id_item = PP.id
	WHERE P.id = @id_articulo;
	SELECT  R.total Ttotal FROM Dbo.ST_FnCalRetenciones(0, @id_entrada, 0, 'EN',@id_entrada,0,0,0,0) R

COMMIT TRAN;
END TRY
BEGIN CATCH
		ROLLBACK TRAN;
	    --Getting the error description
	    SELECT @error   =  ERROR_PROCEDURE() + 
					';  ' + convert(varchar,ERROR_LINE()) + 
					'; ' + ERROR_MESSAGE()
	    -- save the error in a Log file
	    RAISERROR(@error,16,1);
	    RETURN  
END CATCH
