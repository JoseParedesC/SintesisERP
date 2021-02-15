--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_MovFacturaItemList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_MovFacturaItemList]
GO
CREATE PROCEDURE [dbo].[ST_MovFacturaItemList]
	@page INT = 1,
	@numpage INT = 10,
	@countpage INT = 0 OUTPUT,
	@filter VARCHAR(50) = NULL,
	@id_factura VARCHAR(255),
	@id_fac BIGINT = null,
	@op CHAR(1)
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[dbo].[ST_MovFacturaItemList]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		26/11/19
*Desarrollador: (Jeteme)
***************************************/
DECLARE @error VARCHAR(MAX), @starpage INT = 1, @endpage INT = 1;
DECLARE @temp TABLE(id_record INT IDENTITY(1,1) ,id_pk INT, id_factura VARCHAR(255) ,id_articulo BIGINT,codigo VARCHAR(50),presentacion VARCHAR(25),serie bit,lote BIT, id_lote VARCHAR(50),
					nombre VARCHAR(50),cantidad numeric(18,2), precio numeric(18,4),iva numeric(18,4),inc NUMERIC(18,4),descuento numeric(18,4),total numeric(18,4), 
					vencimiento varchar(10), pordescuento decimal(5,2), id_iva bigint, id_inc bigint, selected bit, cantidaddev numeric(18,2), bodega varchar(50))
BEGIN TRY
		
		SET @numpage = ISNULL(@numpage,10);

		SET @starpage = (@page * @numpage) - @numpage +1;
		SET @endpage = @numpage * @page;
		IF(@op = 'T')
		BEGIN		
			INSERT INTO @temp(id_pk, id_factura, id_articulo, codigo, presentacion, serie, lote, nombre, cantidad, 
			precio, iva, inc, descuento, total, id_inc, id_iva, pordescuento, selected, cantidaddev, bodega)
			SELECT  
					i.id,
					i.id_factura,
					i.id_articulo,
					p.codigo,
					p.presentacion,
					i.serie,
					i.lote,
					p.nombre,
					i.cantidad,
					i.precio, 
					i.iva,
					i.inc, 
					i.descuentound, 
					i.total, 					
					i.id_inc,
					i.id_iva,
					i.pordescuento,
					i.selected,
					i.cantidaddev,
					B.nombre bodega
			FROM dbo.MOVFacturaItemsTemp i 
			INNER JOIN dbo.productos p on i.id_articulo = p.id
			LEFT JOIN VW_Bodegas B ON i.id_bodega = B.id
			WHERE ((isnull(@filter,'')='' or p.nombre like '%' + @filter + '%')) AND i.id_factura = @id_factura		
			ORDER BY i.id ASC;

			SET @countpage = @@rowcount;		
		
			SELECT Tm.id_record, tm.id_pk as id, tm.id_articulo, tm.codigo +' ('+tm.presentacion+')' codigo, tm.nombre nombre, tm.presentacion, 
			tm.serie, tm.lote, tm.cantidad, tm.precio, tm.iva, tm.inc, tm.descuento, tm.total, ISNULL(id_inc, '') id_inc, ISNULL(id_iva, '') id_iva, pordescuento, selected, cantidaddev, isnull(bodega, '') bodega
			FROM @temp Tm WHERE id_record between @starpage AND @endpage
			ORDER BY tm.id_pk ASC;

		END
		ELSE IF(@op = 'F')
		BEGIN
			INSERT INTO @temp(id_pk, id_factura, id_articulo, codigo, presentacion, serie, lote, nombre, cantidad, 
			precio, iva, inc, descuento, total, id_inc, id_iva, pordescuento, selected, cantidaddev, bodega)
			SELECT  
					i.id,
					i.id_factura,
					i.id_producto,
					p.codigo,
					p.presentacion,
					i.serie,
					i.lote,
					p.nombre,
					i.cantidad,
					i.precio, 
					i.iva,
					i.inc, 
					i.descuentound, 
					i.total, 					
					0 id_inc,
					0 id_iva,
					i.pordescuento,
					0 selected,
					0 cantidaddev,
					B.nombre bodega
			FROM dbo.MOVFacturaItems i 
			INNER JOIN dbo.productos p on i.id_producto = p.id
			LEFT JOIN VW_Bodegas B ON i.id_bodega = B.id			
			WHERE ((isnull(@filter,'')='' or p.nombre like '%' + @filter + '%')) AND i.id_factura = @id_fac
			ORDER BY i.id ASC;
			
			SET @countpage = @@rowcount;		
		
			SELECT Tm.id_record, tm.id_pk as id, tm.id_articulo, tm.codigo +' ('+tm.presentacion+')' codigo, tm.nombre nombre, tm.presentacion, 
			tm.serie, tm.lote, tm.cantidad, tm.precio, tm.iva, tm.inc, tm.descuento, tm.total, ISNULL(id_inc, '') id_inc, ISNULL(id_iva, '') id_iva, pordescuento, selected, cantidaddev, isnull(bodega, '') bodega
			FROM @temp Tm WHERE id_record between @starpage AND @endpage
			ORDER BY tm.id_pk ASC;

		END
		ELSE IF(@op = 'C')--cotizaciones
		BEGIN
			INSERT INTO @temp(id_pk, id_factura, id_articulo, codigo, presentacion,  nombre, cantidad, 
			precio, iva, descuento, total, id_inc, id_iva,  selected, cantidaddev, bodega, inc)
			SELECT  
					i.id,
					i.id_Cotizacion,
					i.id_articulo ,
					p.codigo,
					p.presentacion,
					p.nombre,
					i.cantidad,
					i.precio, 
					i.iva,
					0 descuento,
					i.total, 					
					0 id_inc,
					0 id_iva,
					0 selected,
					0 cantidaddev,
					B.nombre bodega,
					I.inc
			FROM dbo.MOVCotizacionItems i 
			INNER JOIN dbo.productos p on i.id_articulo = p.id
			LEFT JOIN VW_Bodegas B ON i.id_bodega = B.id			
			WHERE ((isnull(@filter,'')='' or p.nombre like '%' + @filter + '%')) AND i.id_Cotizacion = @id_fac
			ORDER BY i.id ASC;
			
			SET @countpage = @@rowcount;		
		
			SELECT Tm.id_record, tm.id_pk as id, tm.id_articulo, tm.codigo +' ('+tm.presentacion+')' codigo, tm.nombre nombre, tm.presentacion, 
			tm.serie, tm.lote, tm.cantidad, tm.precio, tm.iva, tm.inc, tm.descuento, tm.total, ISNULL(id_inc, '') id_inc, ISNULL(id_iva, '') id_iva, pordescuento, selected, cantidaddev, isnull(bodega, '') bodega
			FROM @temp Tm WHERE id_record between @starpage AND @endpage
			ORDER BY tm.id_pk ASC;

		END
		ELSE IF(@op = 'D')
		BEGIN
			INSERT INTO @temp(id_pk, id_factura, id_articulo, codigo, presentacion, serie, lote, nombre, cantidad, 
			precio, iva, inc, descuento, total, id_inc, id_iva, pordescuento, selected, cantidaddev, bodega)
			SELECT  i.id, 
					i.id_devolucion,
					i.id_articulo,
					i.codigo,
					i.presentacion,
					i.serie,
					CASE WHEN i.lote != '' THEN 1 ELSE 0 END lote,
					i.nombre,
					i.cantidad,
					i.precio, 
					i.iva,
					i.inc,
					i.descuento, 
					I.total,
					I.inc,
					0,
					0,
					0,					
					i.cantidad,
					bodega
			FROM [dbo].[VW_MOVDevFacturaItems] i
			WHERE id_devolucion = @id_fac
			AND	((isnull(@filter,'')='' or i.nombre like '%' + @filter + '%'))
			ORDER BY i.id ASC;

			SET @countpage = @@rowcount;		
		
			SELECT Tm.id_record, tm.id_pk as id, tm.id_articulo, tm.codigo +' ('+tm.presentacion+')' codigo, tm.nombre nombre, tm.presentacion, 
			tm.serie, tm.lote, tm.cantidad, tm.precio, tm.iva, tm.inc, tm.descuento, tm.total, ISNULL(id_inc, '') id_inc, ISNULL(id_iva, '') id_iva, pordescuento, selected, cantidaddev, isnull(bodega, '') bodega
			FROM @temp Tm WHERE id_record between @starpage AND @endpage
			ORDER BY tm.id_pk ASC;

		END
		
				
END TRY
BEGIN CATCH

	    --Getting the error description
	    Select @error   =  ERROR_PROCEDURE() + 
					';  ' + convert(varchar,ERROR_LINE()) + 
					'; ' + ERROR_MESSAGE()
	    -- save the error in a Log file
	    RaisError(@error,16,1)
	    Return  
End Catch

GO


