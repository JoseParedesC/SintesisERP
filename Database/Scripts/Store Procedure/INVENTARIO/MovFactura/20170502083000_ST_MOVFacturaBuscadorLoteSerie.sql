--liquibase formatted sql
--changeset ,CZULBARAN:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_MOVFacturaBuscadorLoteSerie]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_MOVFacturaBuscadorLoteSerie]
GO


CREATE PROCEDURE [dbo].[ST_MOVFacturaBuscadorLoteSerie]
	@id_articulo BIGINT = 0,
	@id_bodega	BIGINT	= 0,
	@opcion		[CHAR] (2),
	@op			[CHAR] (1) ='',
	@id_factura VARCHAR(255) = '',
	@proceso    [CHAR] (1) = 'F'
--WITH ENCRYPTION
AS
BEGIN
/***************************************
*Nombre:		[Dbo].[FacturaBuscadorLoteSerie]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		17/05/02
*Desarrollador: (JTOUS)
***************************************/
	
Declare @ds_error varchar(max)
	
Begin Try
	IF(@opcion = 'SF')
	BEGIN 
		IF(@op = 'T')
		BEGIN
			;WITH CTE(id_articulo, id_bodega, serie, selected) AS
			(
				SELECT T.id_articulo, T.id_bodega, S.serie, 0 selected
				FROM MovFacturaSeriesTemp S 
				INNER JOIN MOVFacturaItemsTemp T ON T.id = S.id_itemstemp
				WHERE T.id_factura = @id_factura AND T.id_articulo = @id_articulo AND T.id_bodega = @id_bodega
			)
			SELECT S.serie, ISNULL(C.selected, 0) selected
			FROM ExistenciaLoteSerie S 
			INNER JOIN Existencia E ON E.id = S.id_existencia
			LEFT JOIN CTE C ON S.serie = C.serie AND E.id_articulo = C.id_articulo AND E.id_bodega = C.id_bodega 
			WHERE S.existencia > 0 AND C.serie IS NULL AND S.serie != '' AND E.id_bodega = @id_bodega and E.id_articulo=@id_articulo;
		END
		ELSE IF(@op = 'P')
		BEGIN
			DECLARE @id_articulotemp BIGINT, @id_bodegatemp BIGINT;
			SELECT @id_articulotemp = id_articulo, @id_bodegatemp = id_bodega 
			FROM MOVFacturaItemsTemp WHERE id = @id_articulo;

			;WITH CTE(id_articulo, id_bodega, serie, selected) AS
			(
				SELECT T.id_articulo, T.id_bodega, S.serie,1 selected 
				FROM [MovFacturaSeriesTemp] S 
				INNER JOIN MOVFacturaItemsTemp T ON S.id_itemstemp=T.id
				WHERE T.id_factura=@id_factura AND T.id_articulo=@id_articulotemp
				UNION ALL
				SELECT E.id_articulo,E.id_bodega,L.serie,0 selected 
				FROM ExistenciaLoteSerie L 
				INNER JOIN Existencia E ON  E.id=L.id_existencia
				WHERE 
				serie NOT IN(SELECT  S.serie 
				FROM [MovFacturaSeriesTemp] S 
				INNER JOIN MOVFacturaItemsTemp T ON S.id_itemstemp=T.id
				WHERE T.id_factura=@id_factura) and E.id_articulo=@id_articulotemp AND E.id_bodega=@id_bodegatemp
				
			)
			SELECT C.serie,ISNULL(selected, 0) selected 
			FROM ExistenciaLoteSerie S
			INNER JOIN Existencia E ON E.id = S.id_existencia 
			LEFT JOIN CTE C ON S.serie = C.serie AND E.id_articulo = C.id_articulo 
			AND E.id_bodega = C.id_bodega  
			WHERE C.serie is NOT NULL and S.existencia>0	
				
		END

		ELSE IF (@op = 'F')
		BEGIN
			SELECT serie, 1 selected  FROM MovFacturaSeries WHERE id_items = @id_articulo
		END
		---ESTA LINEA LA AGREGA CZULBARAN PORQUE LA USA PARA TRAER LAS SERIES EN CONVERSION DE ARTICULO Y NO TENER QUE CREAR OTRO SP
		ELSE IF (@op = 'Z')
		BEGIN		
		
				SELECT id, serie, selected 
				FROM[dbo].[MovEntradasSeriesTemp] 
				WHERE id_itemstemp = @id_articulo	
			
		END
		ELSE IF (@op = 'D')
		BEGIN				
			SELECT id, serie, selected 
			FROM[dbo].[MovDevFacturasSeries] 
			WHERE id_items = @id_articulo				
		END
		ELSE IF(@op = 'X')
		BEGIN
			SELECT S.id, S.serie, 1 selected 
			FROM MOVConversionesItemsSeries S INNER JOIN 
			MOVConversionesItems I ON I.id_conversion = S.id_conversion AND I.id = S.id_producto WHERE I.id = @id_articulo
		END
	END
	ELSE IF(@opcion = 'LF')
	BEGIN 
		IF(@op = 'T')
		BEGIN
			IF(@proceso='F')
			BEGIN
				;WITH CTE (id, id_lote, id_articulo, id_bodega, cantidad)
				AS (
					SELECT I.id, L.id_lote, I.id_articulo, I.id_bodega, L.cantidad
					FROM MOVFacturaItemsTemp I INNER JOIN MOVFacturaLotesTemp L ON I.id = L.id_itemtemp
					WHERE I.id_factura = @id_factura AND I.id = @id_articulo
				)
				SELECT L.id, L.lote + ' - (Vence: ' + CONVERT(VARCHAR(10), L.vencimiento_lote, 120)+')' lote, S.existencia, ISNULL(C.cantidad, 0) cantidad
				FROM ExistenciaLoteSerie S 
				INNER JOIN Existencia E ON E.id = S.id_existencia
				INNER JOIN MOVFacturaItemsTemp I ON E.id_articulo = I.id_articulo AND E.id_bodega = I.id_bodega
				INNER JOIN LotesProducto L ON S.id_lote = L.id
				LEFT JOIN CTE AS C ON L.id = C.id_lote AND E.id_articulo = C.id_articulo AND C.id_bodega = E.id_bodega
				WHERE I.id = @id_articulo AND S.existencia >0 AND + S.serie = '' AND CONVERT(VARCHAR(10), L.vencimiento_lote, 120) != '1900-01-01'
				ORDER BY L.vencimiento_lote ASC
			END
			ELSE 
			BEGIN 
				;WITH CTE (id, id_lote, id_articulo, id_bodega, cantidad, cantidaddev)
				AS (
					SELECT I.id, L.id_lote, I.id_articulo, I.id_bodega, L.cantidad, L.cantidaddev
					FROM MOVFacturaItemsTemp I INNER JOIN MOVFacturaLotesTemp L ON I.id = L.id_itemtemp
					WHERE I.id_factura = @id_factura AND I.id = @id_articulo
				)
				SELECT L.id, L.lote + ' - (Vence: ' + CONVERT(VARCHAR(10), L.vencimiento_lote, 120)+')' lote, C.cantidad existencia, ISNULL(C.cantidad, 0) cantidad, ISNULL(C.cantidaddev, 0) cantidaddev
				FROM CTE C INNER JOIN  MOVFacturaItemsTemp I ON C.id_articulo = I.id_articulo AND C.id_bodega = I.id_bodega
				INNER JOIN LotesProducto L ON C.id_lote = L.id
				WHERE I.id = @id_articulo   AND CONVERT(VARCHAR(10), L.vencimiento_lote, 120) != '1900-01-01'
				ORDER BY L.vencimiento_lote ASC
	
				END
		END
		ELSE IF (@op = 'F')
		BEGIN
			SELECT 0 id, L.lote + ' - (Vence: ' + CONVERT(VARCHAR(10), L.vencimiento_lote, 120)+')' lote, 0 existencia, IL.cantidad
			FROM MOVFacturaItems I INNER JOIN 
			MOVFacturaLotes IL ON I.id = IL.id_item INNER JOIN 
			LotesProducto L ON IL.id_lote = L.id
			WHERE I.id = @id_articulo
		END

	END
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


