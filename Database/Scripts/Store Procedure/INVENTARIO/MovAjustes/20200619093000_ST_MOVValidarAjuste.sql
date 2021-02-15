--liquibase formatted sql
--changeset ,jteheran:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_MOVValidarAjuste]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [dbo].[ST_MOVValidarAjuste]
GO
CREATE PROCEDURE [dbo].[ST_MOVValidarAjuste]
@fechadoc  SMALLDATETIME,
@id_entrada bigint,
@id_user INT

--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[Dbo].[ST_MOVValidarAjuste]
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		19/05/2020
*Desarrollador:  Jose Luis Tous P�rez (jtous)
*Descripcion:	Se realizan EL PROCESO DE FACTURAR LAS ENTRADAS
***************************************/
Declare @idestado INT, @Cantidad int,@id_bodega BIGINT;
Declare @mensaje varchar(max),@mensaje2 varchar(max), @id_articulo int, @serie VARCHAR(200) = '', @lote VARCHAR(200) = '';
DECLARE @table TABLE (id int identity(1,1), id_item bigint, id_articulo BIGINT, id_bodega BIGINT, cantidad NUMERIC(18,2), costo NUMERIC(18,2), precio NUMERIC(18,2), serie bit, lote bit);
DECLARE @tableSL TABLE (id int identity(1,1), id_item bigint, id_articulo BIGINT, id_bodega BIGINT, cantidad NUMERIC(18,2), serie VARCHAR(200), id_lote BIGINT, lote bit);

BEGIN TRY

	--Valida si la empresa esta creada como tercero
			IF NOT EXISTS (SELECT 1 FROM cnt.Terceros T  JOIN Empresas E ON T.iden=E.nit)
			RAISERROR('Empresa no esta creada como terceros',16,0);
	

	--Valida los articulos que manejan lote y no estan llenos
		INSERT INTO @table (id_item, id_articulo, id_bodega, cantidad, costo,  serie, lote)
			SELECT	T.id,
					T.id_articulo, 
					T.id_bodega, 
					T.cantidad cantidad, 
					ISNULL(E.costo,0) costo, 
					T.serie,
					T.lote
			FROM Dbo.MOVEntradasItemsTemp T
			LEFT JOIN Existencia E ON E.id_articulo = T.id_articulo AND T.id_bodega = E.id_bodega
			WHERE T.id_entrada = @id_entrada AND T.inventarial != 0

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
				FROM Dbo.MOVEntradasItemsTemp T
				LEFT JOIN Dbo.MovEntradasSeriesTemp S ON T.id = S.id_itemstemp
				LEFT JOIN Dbo.MOVEntradaLotesTemp  L ON T.id = L.id_itemtemp
				WHERE T.id_entrada = @id_entrada  AND T.inventarial != 0 AND (T.serie != 0 OR T.lote != 0) 
	
				;WITH series(id_item, cantidad) AS (
					SELECT id_item, SUM(cantidad) FROM @tableSL GROUP BY id_item
				)
				SELECT TOP 1 @id_articulo = S.id_item FROM @table T INNER JOIN series S ON S.id_item = T.id_item
				WHERE S.cantidad <>  IIF(T.serie=1 and T.cantidad<0,T.cantidad*-1,T.cantidad)
				IF ISNULL(@id_articulo, 0) > 0
				BEGIN
					SELECT @mensaje = 'El art�culo ('+P.codigo +' - '+P.nombre+') presenta diferencia de cantidades en '+
					CASE WHEN T.lote != 0 THEN 'los lotes seleccionados' ELSE 'las series seleccionadas' END + ' en la bodega "'+
					B.nombre+'"'
					FROM @table T INNER JOIN Productos P ON P.id = T.id_articulo INNER JOIN Bodegas B ON B.id = T.id_bodega
					WHERE T.id_item = @id_articulo;

					RAISERROR(@mensaje,16,0);			
				END


	--Validar series de articulos temporales
	;WITH CTESERIE (id, id_articulo, cantidad, [count])
	AS(
		SELECT I.id, I.id_articulo, I.cantidad, SUM(CASE WHEN S.serie IS NULL THEN 0 ELSE 1 END) [count]
		FROM Dbo.MOVEntradasItemsTemp I LEFT JOIN 
			 Dbo.MovEntradasSeriesTemp S ON S.[id_itemstemp] = I.id 
		WHERE I.serie != 0 AND I.id_entrada = @id_entrada and I.cantidad>0
		GROUP BY I.id, I.id_articulo, I.cantidad
	) 
	SELECT TOP 1 @id_articulo = id_articulo FROM CTESERIE WHERE cantidad != [count]

	IF(ISNULL(@id_articulo, 0 ) != 0)
	BEGIN
		SELECT TOP 1 @mensaje = 'El producto ' + nombre +' no ha configurado todas las series' 
		FROM Dbo.Productos WHERE id = @id_articulo; 
		RAISERROR(@mensaje, 16, 0)
	END	

		--Validar series de articulos existencia
	SELECT TOP 1 @mensaje = 'El producto ' + P.nombre +' ya tiene existencia con esta (' + S.serie + ') serie' 
	FROM			Dbo.MOVEntradasItemsTemp  I
		 INNER JOIN Dbo.MovEntradasSeriesTemp S  ON S.[id_itemstemp] = I.id
		 INNER JOIN Dbo.Productos P ON P.id = I.id_articulo
		 LEFT JOIN Dbo.VW_ExistenciaLoteSerie E ON E.id_articulo = I.id_articulo AND E.id_bodega = I.id_bodega AND E.serie = S.serie
	WHERE I.serie != 0 AND I.inventarial != 0 AND I.id_entrada = @id_entrada AND E.serie IS NOT NULL AND I.cantidad > 0;
	
	--Valida si hay existencia de articulos.
		;WITH ARTICLES (id_articulo, id_bodega, cantidad) AS (
			SELECT id_articulo, id_bodega, SUM(cantidad) 
			FROM @table T WHERE serie = 0 AND lote = 0
			GROUP BY id_articulo, id_bodega
		)
		SELECT TOP 1 @id_articulo = T.id_articulo, @id_bodega = T.id_bodega 
		FROM ARTICLES T 
		LEFT JOIN Dbo.Existencia E ON T.id_articulo = E.id_articulo AND E.id_bodega = T.id_bodega
		WHERE ((T.cantidad*-1) > ISNULL(E.existencia, 0) and T.cantidad < 0) OR (T.cantidad > 0 AND T.cantidad+ISNULL(E.existencia, 0) < 0 )

		IF(ISNULL(@id_articulo, 0) != 0)
		BEGIN	
			SELECT TOP 1 @mensaje = codigo +' - '+nombre FROM Dbo.Productos WHERE id = @id_articulo ;
			SELECT TOP 1 @mensaje2 = nombre FROM dbo.Bodegas WHERE id = @id_bodega;			 
			SET  @mensaje = 'El art�culo ('+@mensaje+') No tiene suficientes existencias en la bodega "'+@mensaje2+'"';
			RAISERROR(@mensaje,16,0);
		END

			--Valida serie en existencias sobre cantidad a Ajustar
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

		--Valida existencias en lotes sobre cantidad a Ajustar
		SELECT @id_articulo = T.id_item, @mensaje2 = T.serie
		FROM @tableSL T INNER JOIN Existencia E ON T.id_articulo = E.id_articulo AND E.id_bodega = T.id_bodega
		INNER JOIN ExistenciaLoteSerie L ON E.id = L.id_existencia AND T.id_lote = L.id_lote
		WHERE T.id_lote != 0 AND ((ISNULL(L.existencia, 0) - (T.cantidad*-1)) < 0 AND T.cantidad < 0) OR (T.cantidad + (ISNULL(L.existencia, 0)) < 0 AND T.cantidad > 0)

		
		IF ISNULL(@id_articulo, 0) > 0
		BEGIN
			SELECT @mensaje = 'El art�culo ('+P.codigo +' - '+P.nombre+') no presenta la cantidad requerida en existencia en los lotes seleccionados en'+
			@mensaje2 + ' en la bodega "'+ B.nombre+'"'
			FROM @table T INNER JOIN Productos P ON P.id = T.id_articulo INNER JOIN Bodegas B ON B.id = T.id_bodega
			WHERE T.id_item = @id_articulo;

			RAISERROR(@mensaje,16,0);			
		END
	IF(ISNULL(@mensaje, '' ) != '')
		RAISERROR(@mensaje, 16, 0);
END TRY
BEGIN CATCH	
	SET @mensaje = ERROR_MESSAGE();
	RAISERROR(@Mensaje,16,0);	
END CATCH