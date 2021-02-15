--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_FnCantidadArtMov]') and OBJECTPROPERTY(id, N'IsScalarFunction') = 1)
DROP FUNCTION [dbo].[ST_FnCantidadArtMov]
GO

CREATE Function  [dbo].[ST_FnCantidadArtMov] (@id_articulo INT, @id_factura INT, @op VARCHAR(2))
RETURNS NUMERIC (18,2)
--With Encryption 
As
BEGIN
	DECLARE @cantidad NUMERIC(18,2) = 0

	
	IF(@op = 'FA')
	BEGIN	
			SET @cantidad = ISNULL((SELECT SUM(cantidad) FROM DBO.VW_MOVFacturaItems
							WHERE id_factura = @id_factura AND id = @id_articulo), 0) ;		
			SET @cantidad -= ISNULL((SELECT SUM(cantidad) FROM DBO.VW_MOVDevFacturaItems 
							where id_itemfac = @id_articulo AND id_factura = @id_factura), 0)
	
	END
	IF(@op = 'EN')
	BEGIN
		SET @cantidad = ISNULL((SELECT SUM(cantidad) FROM DBO.VW_MOVEntradasItems
						WHERE id = @id_articulo AND id_entrada = @id_factura), 0);
		SET @cantidad = @cantidad - ISNULL((SELECT SUM(cantidad) FROM DBO.VW_MOVDevEntradaItems 
						WHERE id_itementra = @id_articulo AND id_entrada = @id_factura AND estado = Dbo.ST_FnGetIdList('PROCE')), 0);		
	END
	/*ELSE IF(@oper = 'S')
	BEGIN
		SET @cantidad = (SELECT SUM(cantidad) FROM DBO.VW_MOVEntradasItems
						WHERE id_entrada = @id_factura AND id_articulo = @id_articulo AND id_bodega = @id_bodega and serie=@filtro);
		SET @cantidad -=  ISNULL((SELECT SUM(cantidad) FROM DBO.VW_MOVDevEntradaItems 
						WHERE id_entrada = @id_factura AND id_articulo = @id_articulo AND id_bodega = @id_bodega  AND serie=@filtro AND estado = 12), 0);		
	END
	ELSE IF(@oper='L')
	BEGIN 
	    SET @cantidad = (SELECT SUM(cantidad) FROM DBO.VW_MOVEntradasItems
						WHERE id_entrada = @id_factura AND id_articulo = @id_articulo AND id_bodega = @id_bodega and id_lote=@filtro);
		SET @cantidad -=  ISNULL((SELECT SUM(cantidad) FROM DBO.VW_MOVDevEntradaItems 
						WHERE id_entrada = @id_factura AND id_articulo = @id_articulo AND id_bodega = @id_bodega AND id_lote=@filtro AND estado = 12), 0);		
	END
	ELSE IF(@oper = 'M')
	BEGIN
	SET @cantidad = (SELECT SUM(cantidad) FROM DBO.VW_MOVEntradasItems
						WHERE id_entrada = @id_factura AND id_articulo = @id_articulo AND id_bodega = @id_bodega and serie=@filtro);
		SET @cantidad -=  ISNULL((SELECT SUM(cantidad) FROM DBO.VW_MOVDevEntradaItems 
						WHERE id_entrada = @id_factura AND id_articulo = @id_articulo AND id_bodega = @id_bodega AND serie=@filtro AND estado = 12), 0);		
	END*/
	--END
		
	RETURN ISNULL(@cantidad, 0)
End
GO



