--liquibase formatted sql
--changeset ,CZULBARAN:4 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_MovEntradasItemList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_MovEntradasItemList]
GO

CREATE PROCEDURE [dbo].[ST_MovEntradasItemList]
	@page INT = 1,
	@numpage INT = 10,
	@countpage INT = 0 OUTPUT,
	@filter VARCHAR(50) = NULL,
	@id_entrada BIGINT,
	@op CHAR(1)
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[dbo].[ST_MovEntradasItemTempList]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		26/11/19
*Desarrollador: (Jeteme)
***************************************/
DECLARE @error VARCHAR(MAX), @starpage INT = 1, @endpage INT = 1;
DECLARE @temp TABLE(id_record INT IDENTITY(1,1) ,id_pk INT,id_entrada BIGINT ,id_articulo BIGINT,codigo VARCHAR(50),presentacion VARCHAR(25),serie BIT,lote BIT, id_lote VARCHAR(50),
					nombre VARCHAR(50),cantidad numeric(18,2),costo numeric(18,4),iva numeric(18,4),inc NUMERIC(18,4),descuento numeric(18,4),costototal numeric(18,4), 
					vencimiento varchar(10), pordescuento decimal(5,2), id_iva bigint, id_inc bigint, selected bit, cantidaddev numeric(18,2),id_bodega BIGINT,bodega Varchar(255),id_bodegadest BIGINT,bodegadest VARCHAR(255),config bit)
BEGIN TRY
		
		SET @numpage = ISNULL(@numpage,10);

		SET @starpage = (@page * @numpage) - @numpage +1;
		SET @endpage = @numpage * @page;
		IF(@op = 'T')
		BEGIN		
			INSERT INTO @temp(id_pk, id_entrada, id_articulo, codigo, presentacion, serie, lote, id_lote, nombre, cantidad, 
			costo, iva, inc, descuento, costototal, vencimiento, id_inc, id_iva, pordescuento, selected, cantidaddev,id_bodega,bodega,id_bodegadest,bodegadest, config)
			SELECT  
					i.id,
					i.id_entrada,
					i.id_articulo,
					p.codigo,
					p.presentacion,
					i.serie,
					 i.lote lote,
					CASE WHEN i.id_lote = 'sintesis' THEN '' ELSE i.id_lote END id_lote,
					p.nombre,
					i.cantidad,
					i.costo, 
					i.iva,
					i.inc, 
					i.descuento, 
					i.costototal, 
					CASE WHEN CONVERT(VARCHAR(10), i.vencimientolote, 120) = '1900-01-01' THEN '' ELSE CONVERT(VARCHAR(10), i.vencimientolote, 120) END vencimiento,
					i.id_inc,
					i.id_iva,
					i.pordescuento,
					i.selected,
					i.cantidaddev,
					i.id_bodega,
					b.nombre,
					i.id_bodegadest,
					b2.nombre,
					/*czulbaran agrega este campo para verificar si el producto tiene productos hijos con series*/
					ISNULL((SELECT TOP 1 P.serie FROM DBO.Productos P INNER JOIN dbo.Productos_Formulados F on F.id_item = P.id  WHERE F.id_producto= i.id_articulo AND P.serie = 1),0) config																																				
			FROM dbo.MOVEntradasItemsTemp i 
			INNER JOIN dbo.productos p on i.id_articulo = p.id
			LEFT JOIN dbo.Bodegas b on i.id_bodega=b.id 
			LEFT JOIN dbo.Bodegas b2 ON i.id_bodegadest=b2.id
			WHERE ((isnull(@filter,'')='' or p.nombre like '%' + @filter + '%')) AND i.id_entrada = @id_entrada		
			ORDER BY i.id ASC;

			SET @countpage = @@rowcount;		
		
			SELECT Tm.id_record, tm.id_pk as id, tm.id_entrada, tm.id_articulo, tm.codigo +' ('+tm.presentacion+')' codigo, tm.nombre nombre, tm.presentacion, 
			tm.serie, tm.lote, CASE WHEN tm.id_lote = '' THEN '-' ELSE tm.id_lote END id_lote, tm.cantidad, tm.costo, tm.iva, tm.inc, tm.descuento, tm.costototal, tm.vencimiento, ISNULL(id_inc, '') id_inc, ISNULL(id_iva, '') id_iva, pordescuento, selected, cantidaddev,tm.id_bodega,tm.bodega,tm.id_bodegadest,tm.bodegadest, config
			FROM @temp Tm WHERE id_record between @starpage AND @endpage
			ORDER BY tm.id_pk ASC;

		END
		ELSE IF(@op = 'E')
		BEGIN
			INSERT INTO @temp(id_pk, id_entrada, id_articulo, codigo, presentacion, serie, lote, id_lote, nombre, cantidad, costo, iva, inc, descuento, costototal, vencimiento)
			SELECT  i.id, 
					i.id_entrada,
					i.id_articulo,
					codigo,
					presentacion,
					i.serie,
					CASE WHEN i.lote != '' THEN 1 ELSE 0 END lote,
					CASE WHEN i.lote = 'sintesis' THEN '' ELSE i.lote END id_lote,
					nombre,
					i.cantidad,
					i.costo, 
					i.iva,
					i.inc,
					i.descuento, 
					i.costototal, 
					CASE WHEN i.lote = 'sintesis' THEN '' ELSE vencimientoLote END vencimientoLote 
			FROM dbo.VW_MOVEntradasItems  i				 
			WHERE	((isnull(@filter,'')='' or nombre like '%' + @filter + '%')) and i.id_entrada = @id_entrada				
			ORDER BY i.id ASC;

			SET @countpage = @@rowcount;		
		
			SELECT Tm.id_record,tm.id_pk as id ,tm.id_entrada, tm.id_articulo,tm.codigo+' ('+tm.presentacion+')' codigo ,tm.nombre nombre,tm.presentacion,tm.cantidad,tm.costo ,tm.iva,tm.inc, tm.descuento, tm.costototal, tm.serie, CASE WHEN tm.vencimiento = '1900-01-01' THEN '' ELSE tm.vencimiento END vencimiento, tm.lote, tm.id_lote
			FROM @temp Tm					
			WHERE id_record between @starpage AND @endpage
			ORDER BY tm.id_pk ASC;

		END
		ELSE IF(@op = 'C')
		BEGIN
			INSERT INTO @temp(id_pk, id_entrada, id_articulo, codigo, presentacion, serie, lote, nombre, cantidad, costo, iva, inc, descuento, costototal, vencimiento)
			SELECT  i.id, 
					i.id_orden,
					i.id_producto,
					p.codigo,
					p.presentacion,
					'' serie,
					'' lote,
					p.nombre,
					i.cantidad,
					i.costo, 
					0 iva,
					0 inc,
					0 escuento, 
					i.costototal, 
					'' vencimientoLote 
			FROM dbo.VW_MOVOrdenComprasItem  i LEFT JOIN
				 dbo.productos p on i.id_producto = p.id 
			WHERE	((isnull(@filter,'')='' or p.nombre like '%' + @filter + '%')) and i.id_orden = @id_entrada				
			ORDER BY i.id ASC;

			SET @countpage = @@rowcount;		
		
			SELECT Tm.id_record,tm.id_pk as id ,tm.id_entrada, tm.id_articulo, tm.codigo+' ('+tm.presentacion+')' codigo , tm.nombre nombre, tm.presentacion, tm.cantidad, tm.costo, tm.costototal
			FROM @temp Tm					
			WHERE id_record between @starpage AND @endpage
			ORDER BY tm.id_pk ASC;

		END
		ELSE IF(@op = 'D')
		BEGIN
			INSERT INTO @temp(id_pk, id_entrada, id_articulo, codigo, presentacion, serie, lote, id_lote, nombre, cantidad, costo, iva, inc, descuento, costototal, vencimiento, cantidaddev)
			SELECT  i.id, 
					i.id_devolucion,
					i.id_articulo,
					i.codigo,
					i.presentacion,
					i.serie,
					CASE WHEN i.lote != '' THEN 1 ELSE 0 END lote,
					i.lote id_lote,
					i.nombre,
					i.cantidad,
					i.costo, 
					i.iva,
					i.inc,
					i.descuento, 
					i.costototal,
					vencimientoLote,
					i.cantidad
			FROM [dbo].[VW_MOVDevEntradaItems] i
			WHERE id_devolucion = @id_entrada
			AND	((isnull(@filter,'')='' or i.nombre like '%' + @filter + '%'))
			ORDER BY i.id ASC;

			SET @countpage = @@rowcount;		
		
			SELECT Tm.id_record, tm.id_pk as id, tm.id_entrada, tm.id_articulo, tm.codigo + ' ('+tm.presentacion + ')' codigo, tm.nombre nombre, tm.presentacion,
			tm.cantidad, tm.costo, tm.iva, tm.inc, tm.descuento, tm.costototal, tm.serie, CASE WHEN tm.vencimiento = '1900-01-01' THEN '' ELSE tm.vencimiento END vencimiento, 
			tm.lote, tm.id_lote, tm.cantidaddev
			FROM @temp Tm					
			WHERE id_record between @starpage AND @endpage
			ORDER BY tm.id_pk ASC;

		END ELSE IF(@op = 'A')
		BEGIN
			INSERT INTO @temp(id_pk, id_entrada, id_articulo, codigo, presentacion, serie, lote, id_lote, nombre, cantidad, costo, costototal, cantidaddev,id_bodega,bodega)
			SELECT  i.id, 
					i.id_ajuste,
					i.id_articulo,
					i.codigo,
					i.presentacion,
					i.serie,
					CASE WHEN i.lote != '' THEN 1 ELSE 0 END lote,
					i.lote id_lote,
					i.nombre,
					i.cantidad,
					i.costo, 
					i.costototal,
					i.cantidad,
					i.id_bodega,
					b.nombre
			FROM [dbo].[VW_MOVAjustesItems] i
			LEFT JOIN dbo.Bodegas b on i.id_bodega=b.id 
			WHERE id_ajuste = @id_entrada
			AND	((isnull(@filter,'')='' or i.nombre like '%' + @filter + '%'))
			ORDER BY i.id ASC;

			SET @countpage = @@rowcount;		
		
			SELECT Tm.id_record, tm.id_pk as id, tm.id_entrada, tm.id_articulo, tm.codigo + ' ('+tm.presentacion + ')' codigo, tm.nombre nombre, tm.presentacion,
			tm.cantidad, tm.costo, tm.iva, tm.inc, tm.descuento, tm.costototal, tm.serie, CASE WHEN tm.vencimiento = '1900-01-01' THEN '' ELSE tm.vencimiento END vencimiento, 
			tm.lote, tm.id_lote, tm.cantidaddev,tm.id_bodega,tm.bodega
			FROM @temp Tm					
			WHERE id_record between @starpage AND @endpage
			ORDER BY tm.id_pk ASC;

		END ELSE IF(@op = 'L')--´L´ representa a Traslado
		BEGIN
			INSERT INTO @temp(id_pk, id_entrada, id_articulo, codigo, presentacion, serie, lote, id_lote, nombre, cantidad, costo, costototal, cantidaddev,id_bodega,bodega,id_bodegadest,bodegadest)
			SELECT  i.id, 
					i.id_traslado,
					i.id_articulo,
					i.codigo,
					i.presentacion,
					i.serie,
					CASE WHEN i.lote != '' THEN 1 ELSE 0 END lote,
					i.lote id_lote,
					i.nombre,
					i.cantidad,
					i.costo, 
					i.costototal,
					i.cantidad,
					i.id_bodega,
					b.nombre,
					i.id_bodegades,
					i.bodegades
			FROM [dbo].[VW_MOVTrasladosItems] i
			LEFT JOIN dbo.Bodegas b on i.id_bodega=b.id 
			WHERE id_traslado = @id_entrada
			AND	((isnull(@filter,'')='' or i.nombre like '%' + @filter + '%'))
			ORDER BY i.id ASC;

			SET @countpage = @@rowcount;		
		
			SELECT Tm.id_record, tm.id_pk as id, tm.id_entrada, tm.id_articulo, tm.codigo + ' ('+tm.presentacion + ')' codigo, tm.nombre nombre, tm.presentacion,
			tm.cantidad, tm.costo, tm.iva, tm.inc, tm.descuento, tm.costototal, tm.serie, CASE WHEN tm.vencimiento = '1900-01-01' THEN '' ELSE tm.vencimiento END vencimiento, 
			tm.lote, tm.id_lote, tm.cantidaddev,tm.id_bodega,tm.bodega,tm.id_bodegadest,tm.bodegadest
			FROM @temp Tm					
			WHERE id_record between @starpage AND @endpage
			ORDER BY tm.id_pk ASC;

		END
		ELSE IF (@op ='Z')
		BEGIN
			IF EXISTS (SELECT 1 FROM MOVConversiones WHERE id = @id_entrada)
			BEGIN
			SET @numpage = ISNULL(@numpage,10);

			SET @starpage = (@page * @numpage) - @numpage +1;
			SET @endpage = @numpage * @page;
			
			SELECT 
		     id, codigo, nombre, bodega, cantidad, costo, costototal, serie, config
			FROM 
			Dbo.VW_MOVConversionesItems M
			WHERE 
			id_conversion = @id_entrada;

			SET @countpage = @@rowcount;
			END
				ELSE
		
				INSERT INTO @temp(id_pk, id_entrada, id_articulo, codigo, presentacion, serie, lote, id_lote, nombre, cantidad, costo, iva, inc, descuento, costototal, vencimiento)
					SELECT  i.id, 
					i.id_entrada,
					i.id_articulo,
					codigo,
					presentacion,
					i.serie,
					CASE WHEN i.lote != '' THEN 1 ELSE 0 END lote,
					i.lote id_lote,
					nombre,
					i.cantidad,
					i.costo, 
					i.iva,
					i.inc,
					i.descuento, 
					i.costototal, 
					vencimientoLote 
			FROM dbo.VW_MOVEntradasItems  i				 
			WHERE	((isnull(@filter,'')='' or nombre like '%' + @filter + '%')) and i.id_entrada = @id_entrada				
			ORDER BY i.id ASC;

			SET @countpage = @@rowcount;		
		
			SELECT Tm.id_record,tm.id_pk as id ,tm.id_entrada, tm.id_articulo,tm.codigo+' ('+tm.presentacion+')' codigo ,tm.nombre nombre,tm.presentacion,tm.cantidad,tm.costo ,tm.iva,tm.inc, tm.descuento, tm.costototal, tm.serie, CASE WHEN tm.vencimiento = '1900-01-01' THEN '' ELSE tm.vencimiento END vencimiento, tm.lote, tm.id_lote
			FROM @temp Tm					
			WHERE id_record between @starpage AND @endpage
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


