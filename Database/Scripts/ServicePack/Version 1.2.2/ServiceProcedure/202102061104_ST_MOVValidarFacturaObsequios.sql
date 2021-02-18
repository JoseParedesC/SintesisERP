--liquibase formatted sql
--changeset ,JPAREDES:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_MOVValidarFacturaObsequios]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_MOVValidarFacturaObsequios]
GO
CREATE PROCEDURE [dbo].[ST_MOVValidarFacturaObsequios]
@fechadoc		VARCHAR(10),
@id_ccosto		BIGINT,
@isfe			BIT,
@id_tercero		BIGINT,
@idToken		VARCHAR(255),
@valorcredito	NUMERIC(18,2),
@valorformas	NUMERIC(18,2),
@anticipo		NUMERIC(18,2),
@id_user		INT,
@valortotal		NUMERIC(18,2) OUTPUT

--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[Dbo].[ST_MOVValidarFacturaObsequios]
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creaciOn:		10/02/21
*Desarrollador:  JPAREDES
*Descripcion:	Se realizan EL PROCESO DE FACTURAR LAS ENTRADAS
***************************************/
Declare @idestado INT, @Cantidad INT, @valor NUMERIC(18,2) = 0;
Declare @id_resolucion int, @resolucion VARCHAR(50), @consefac int, @prefijo varchar(20), @mensaje varchar(max), 
@mensaje2 VARCHAR(200), @id_articulo bigint, @id_bodega BIGINT;
DECLARE @table TABLE (id int identity(1,1), id_item bigint, id_articulo BIGINT, id_bodega BIGINT, cantidad NUMERIC(18,2), costo NUMERIC(18,2), precio NUMERIC(18,2), serie bit, lote bit);

DECLARE @tableSL TABLE (id int identity(1,1), id_item bigint, id_articulo BIGINT, id_bodega BIGINT, cantidad NUMERIC(18,2), serie VARCHAR(200), id_lote BIGINT, lote bit);
BEGIN TRY

	SET @valortotal = (ISNULL(@valorcredito,0) + ISNULL(@valorformas, 0)+ISNULL(@anticipo, 0));
	
	--Valida el cliente si existe.
	IF NOT EXISTS (SELECT  1 FROM CNT.Terceros C  WHERE C.id = @id_tercero) 
		RAISERROR('Cliente no existe.',16,0);	

	--Valida el consecutivo de facturaci�n junto a la resoluci�n y prefijo.
	SELECT TOP 1 @id_resolucion = id_resolucion, @resolucion = resolucion, @consefac = consecutivo, @prefijo = prefijo
	FROM Dbo.ST_FnConsecutivoFactura(@id_ccosto, @isfe);
	IF(ISNULL(@id_resolucion, 0) = 0)
		RAISERROR('No tiene resoluci�n para el centro de costo seleccionado.',16,0);

	IF EXISTS (SELECT 1 FROM DBO.MovFactura WHERE consecutivo = @consefac AND id_resolucion = @id_resolucion 
												AND prefijo = @prefijo AND resolucion = @resolucion)
	BEGIN
		RAISERROR('El consecutivo de facturaci�n ya existe en otro documento. Verifique Consecutivos...',16,0);
	END

	INSERT INTO @table (id_item, id_articulo, id_bodega, cantidad, costo, precio, serie, lote)
	SELECT	T.id,
			T.id_articulo, 
			T.id_bodega, 
			T.cantidad cantidad, 
			ISNULL(E.costo,0) costo, 
			T.preciodes,
			T.serie,
			T.lote
	FROM Dbo.MOVFacturaItemsTemp T
	LEFT JOIN Existencia E ON E.id_articulo = T.id_articulo AND T.id_bodega = E.id_bodega
	WHERE T.id_factura = @idToken AND T.formulado = 0 AND T.inventarial != 0	
	
	--Valida si hay articulos en la factura
	SELECT  @Cantidad = COUNT(1)  FROM @table
	IF ISNULL(@Cantidad, 0) > 0
	BEGIN

		INSERT INTO @tableSL (id_item, id_articulo, id_bodega, cantidad, serie, lote, id_lote)
		SELECT	T.id,
				T.id_articulo, 
				T.id_bodega, 
				CASE WHEN ISNULL(S.serie, '') != '' THEN 
										CASE WHEN ISNULL(S.serie, '') = '' THEN 0 ELSE 1 END
					WHEN T.lote != 0 THEN ISNULL(L.cantidad, 0)
					ELSE 0 END  cantidad, 
				ISNULL(S.serie,'') serie,
				T.lote,
				ISNULL(L.id_lote, 0) id_lote
		FROM Dbo.MOVFacturaItemsTemp T
		LEFT JOIN Dbo.MovFacturaSeriesTemp S ON T.id = S.id_itemstemp
		LEFT JOIN Dbo.MOVFacturaLotesTemp  L ON T.id = L.id_itemtemp
		WHERE T.id_factura = @idToken AND T.formulado = 0 AND T.inventarial != 0 AND (T.serie != 0 OR T.lote != 0) 
	
		;WITH series(id_item, cantidad) AS (
			SELECT id_item, SUM(cantidad) FROM @tableSL GROUP BY id_item
		)
		SELECT TOP 1 @id_articulo = S.id_item FROM @table T INNER JOIN series S ON S.id_item = T.id_item
		WHERE S.cantidad <> T.cantidad

		IF ISNULL(@id_articulo, 0) > 0
		BEGIN
			SELECT @mensaje = 'El art�culo ('+P.codigo +' - '+P.nombre+') presenta diferencia de cantidades en '+
			CASE WHEN T.lote != 0 THEN 'los lotes seleccionados' ELSE 'las series seleccionadas' END + ' en la bodega "'+
			B.nombre+'"'
			FROM @table T INNER JOIN Productos P ON P.id = T.id_articulo INNER JOIN Bodegas B ON B.id = T.id_bodega
			WHERE T.id_item = @id_articulo;

			RAISERROR(@mensaje,16,0);			
		END
		
		--Valida si hay existencia de articulos.
		;WITH ARTICLES (id_articulo, id_bodega, cantidad) AS (
			SELECT id_articulo, id_bodega, SUM(cantidad) 
			FROM @table T WHERE serie = 0 AND lote = 0
			GROUP BY id_articulo, id_bodega
		)
		SELECT TOP 1 @id_articulo = T.id_articulo, @id_bodega = T.id_bodega 
		FROM ARTICLES T 
		LEFT JOIN Dbo.Existencia E ON T.id_articulo = E.id_articulo AND E.id_bodega = T.id_bodega
		WHERE T.cantidad > ISNULL(E.existencia, 0)

		IF(ISNULL(@id_articulo, 0) != 0)
		BEGIN	
			SELECT TOP 1 @mensaje = codigo +' - '+nombre FROM Dbo.Productos WHERE id = @id_articulo ;
			SELECT TOP 1 @mensaje2 = nombre FROM dbo.Bodegas WHERE id = @id_bodega;			 
			SET  @mensaje = 'El art�culo ('+@mensaje+') No tiene suficientes existencias en la bodega "'+@mensaje2+'"';
			RAISERROR(@mensaje,16,0);
		END

		--Valida serie en existencias sobre cantidad a vender

		SELECT @id_articulo = T.id_item, @mensaje2 = T.serie
		FROM @tableSL T INNER JOIN Existencia E ON T.id_articulo = E.id_articulo AND E.id_bodega = T.id_bodega
		INNER JOIN ExistenciaLoteSerie L ON E.id = L.id_existencia AND T.serie = L.serie
		WHERE T.serie != '' AND (ISNULL(L.existencia, 0) - T.cantidad) < 0

		IF ISNULL(@id_articulo, 0) > 0
		BEGIN
			SELECT @mensaje = 'El art�culo ('+P.codigo +' - '+P.nombre+') presenta existencia con la serie '+
			@mensaje2 + ' en la bodega "'+ B.nombre+'"'
			FROM @table T INNER JOIN Productos P ON P.id = T.id_articulo INNER JOIN Bodegas B ON B.id = T.id_bodega
			WHERE T.id_item = @id_articulo;

			RAISERROR(@mensaje,16,0);			
		END

		--Valida existencias en lotes sobre cantidad a vender
		SELECT @id_articulo = T.id_item, @mensaje2 = T.serie
		FROM @tableSL T INNER JOIN Existencia E ON T.id_articulo = E.id_articulo AND E.id_bodega = T.id_bodega
		INNER JOIN ExistenciaLoteSerie L ON E.id = L.id_existencia AND T.id_lote = L.id_lote
		WHERE T.id_lote != 0 AND (ISNULL(L.existencia, 0) - T.cantidad) < 0

		
		IF ISNULL(@id_articulo, 0) > 0
		BEGIN
			SELECT @mensaje = 'El art�culo ('+P.codigo +' - '+P.nombre+') no presenta la cantidad requerida en existencia en los lotes seleccionados en'+
			@mensaje2 + ' en la bodega "'+ B.nombre+'"'
			FROM @table T INNER JOIN Productos P ON P.id = T.id_articulo INNER JOIN Bodegas B ON B.id = T.id_bodega
			WHERE T.id_item = @id_articulo;

			RAISERROR(@mensaje,16,0);			
		END

		--Valida si existe un articulo con precio mas bajo que el costo de existencia en esa bodega.
		
		SELECT TOP 1 @id_articulo = T.id_articulo , @id_bodega = T.id_bodega
		FROM @table T
		WHERE T.precio < T.costo;

		IF (ISNULL(@id_articulo ,0) != 0)							
		BEGIN
			SELECT TOP 1 @mensaje = codigo +' - '+nombre FROM Dbo.Productos WHERE id = @id_articulo ;
			SELECT TOP 1 @mensaje2 = nombre FROM dbo.Bodegas WHERE id = @id_bodega;
			SET  @mensaje = 'El art�culo ('+@mensaje+') presenta valor por debajo del costo en la bodega "'+@mensaje2+'"';
			RAISERROR(@mensaje,16,0);
		END	
			
	END

	--Valida si hay productos para facturar.
	IF NOT EXISTS(SELECT 1 FROM MOVFacturaItemsTemp WHERE id_factura = @idToken)
	BEGIN	
		RAISERROR('No se cargaron productos a la Factura, verifique..',16,0);
	END		

	--Valida que el valor pagado en la factura este bien.
	SELECT @valor = T.total FROM Dbo.ST_FnCalTotalFactura(@idToken, @anticipo) T;
	
	set @valortotal= IIF(@valor=@anticipo,@valor,@valortotal)

	--SELECT @valortotal
	--RAISERROR('16',16,0)
	--IF(@valortotal < ISNULL(@valor,0))
	--	RAISERROR('El valor pagado es menor que el de la factura. verifique las formas de pago o el valor del anticipo.', 16, 0);
		

END TRY
BEGIN CATCH	
	SET @mensaje = ERROR_MESSAGE();
	RAISERROR(@Mensaje,16,0);	
END CATCH
