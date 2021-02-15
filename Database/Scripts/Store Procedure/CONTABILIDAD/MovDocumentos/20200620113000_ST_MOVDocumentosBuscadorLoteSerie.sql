--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_MOVDocumentosBuscadorLoteSerie]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_MOVDocumentosBuscadorLoteSerie]
GO


CREATE PROCEDURE [dbo].[ST_MOVDocumentosBuscadorLoteSerie]
	@id_articulo BIGINT = 0,
	@id_bodega	BIGINT	= 0,
	@opcion		[CHAR] (2),
	@op			[CHAR] (1) ='',
	@id_documento VARCHAR(255) = ''
--WITH ENCRYPTION
AS
BEGIN
/***************************************
*Nombre:		[Dbo].[CREATE PROCEDURE [dbo].[ST_MOVDocumentosBuscadorLoteSerie]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		20/06/25
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
				FROM MovEntradasSeriesTemp S 
				INNER JOIN MOVEntradasItemsTemp T ON T.id = S.id_itemstemp
				WHERE T.id_entrada = @id_documento AND T.id_articulo = @id_articulo AND T.id_bodega = @id_bodega
			)
			SELECT S.serie, ISNULL(C.selected, 0) selected
			FROM ExistenciaLoteSerie S 
			INNER JOIN Existencia E ON E.id = S.id_existencia
			LEFT JOIN CTE C ON S.serie = C.serie AND E.id_articulo = C.id_articulo AND E.id_bodega = C.id_bodega 
			WHERE S.existencia > 0 AND C.serie IS NULL AND S.serie != '' AND E.id_bodega = @id_bodega and E.id_articulo=@id_articulo;-- en esta linea le agregue la condicion del id_articulo;
		END
		ELSE IF(@op = 'P')
		BEGIN
			DECLARE @id_articulotemp BIGINT, @id_bodegatemp BIGINT;
			SELECT @id_articulotemp = id_articulo, @id_bodegatemp = id_bodega 
			FROM MOVEntradasItemsTemp WHERE id = @id_articulo;

			;WITH CTE(id_articulo, id_bodega, serie, selected) AS
			(
				SELECT T.id_articulo, T.id_bodega, S.serie,1 selected FROM [MovEntradasSeriesTemp] S INNER JOIN MOVEntradasItemsTemp T ON S.id_itemstemp=T.id
				where T.id_entrada=@id_documento and T.id_articulo=@id_articulotemp
				UNION ALL
				select E.id_articulo,E.id_bodega,L.serie,0 selected from ExistenciaLoteSerie L inner JOIN Existencia E ON  E.id=L.id_existencia
				where 
				serie NOT IN(select  S.serie from [MovEntradasSeriesTemp] S inner join MOVEntradasItemsTemp T ON S.id_itemstemp=T.id
				where T.id_entrada=@id_documento) and E.id_articulo=@id_articulotemp and E.id_bodega=@id_bodegatemp
				--SELECT T.id_articulo, T.id_bodega, S.serie, 0 selected
				--FROM MovEntradasSeriesTemp S 
				--INNER JOIN MOVEntradasItemsTemp T ON T.id = S.id_itemstemp
				--WHERE T.id_articulo = @id_articulotemp AND T.id_bodega = @id_bodegatemp AND T.id != @id_articulo AND id_entrada = @id_documento
				--UNION ALL
				--SELECT T.id_articulo, T.id_bodega, S.serie, 1 selected
				--FROM MovEntradasSeriesTemp S 
				--INNER JOIN MOVEntradasItemsTemp T ON T.id = S.id_itemstemp
				--WHERE T.id = @id_articulo AND T.id_entrada = @id_documento
			)
			SELECT C.serie,ISNULL(selected, 0) selected  FROM ExistenciaLoteSerie S
			INNER JOIN Existencia E ON E.id = S.id_existencia left join CTE C ON S.serie = C.serie AND E.id_articulo = C.id_articulo AND E.id_bodega = C.id_bodega  
			WHERE C.serie is NOT NULL and S.existencia>0	
			--SELECT S.serie, ISNULL(selected, 0) selected 
			--FROM ExistenciaLoteSerie S 
			--INNER JOIN Existencia E ON E.id = S.id_existencia
			--LEFT JOIN CTE C ON S.serie = C.serie AND E.id_articulo = C.id_articulo AND E.id_bodega = C.id_bodega 
			--WHERE (S.existencia > 0 AND C.serie IS NULL AND S.serie != '') OR C.selected != 0 ;	
		END ELSE IF(@op = 'A')
		BEGIN
			SELECT S.serie, 1 selected 
			FROM MovAjustesSeries S inner join MOVAjustesItems A ON S.id_items=A.id
			WHERE S.id_items=@id_articulo;	
		END  ELSE IF(@op = 'L')
		BEGIN
			SELECT S.serie, 1 selected 
			FROM MOVTrasladosSeries S inner join MOVTrasladosItems A ON S.id_items=A.id
			WHERE S.id_items=@id_articulo;	
		END
	END
	ELSE IF(@opcion = 'LF')
	BEGIN 
		IF(@op = 'T')
		BEGIN
			;WITH CTE (id, id_lote, id_articulo, id_bodega, cantidad)
			AS (
				SELECT I.id, L.id_lote, I.id_articulo, I.id_bodega, L.cantidad
				FROM MOVEntradasItemsTemp I INNER JOIN MOVEntradaLotesTemp L ON I.id = L.id_itemtemp
				WHERE I.id_entrada = @id_documento AND I.id = @id_articulo
			)
			SELECT L.id, L.lote + ' - (Vence: ' + CONVERT(VARCHAR(10), L.vencimiento_lote, 120)+')' lote, S.existencia, ISNULL(C.cantidad, 0) cantidad
			FROM ExistenciaLoteSerie S 
			INNER JOIN Existencia E ON E.id = S.id_existencia
			INNER JOIN MOVEntradasItemsTemp I ON E.id_articulo = I.id_articulo AND E.id_bodega = I.id_bodega
			INNER JOIN LotesProducto L ON S.id_lote = L.id
			LEFT JOIN CTE AS C ON L.id = C.id_lote AND E.id_articulo = C.id_articulo AND C.id_bodega = E.id_bodega
			WHERE I.id = @id_articulo /*AND S.existencia > 0 */AND S.serie = '' AND CONVERT(VARCHAR(10), L.vencimiento_lote, 120) != '1900-01-01'
			ORDER BY L.vencimiento_lote ASC
		END
		ELSE IF (@op = 'F')
		BEGIN
			SELECT 0 id, L.lote + ' - (Vence: ' + CONVERT(VARCHAR(10), L.vencimiento_lote, 120)+')' lote, 0 existencia, IL.cantidad
			FROM MOVFacturaItems I INNER JOIN 
			MOVFacturaLotes IL ON I.id = IL.id_item INNER JOIN 
			LotesProducto L ON IL.id_lote = L.id
			WHERE I.id = @id_articulo

		END ELSE IF (@op='A')
		BEGIN
			SELECT 0 id, L.lote + ' - (Vence: ' + CONVERT(VARCHAR(10), L.vencimiento_lote, 120)+')' lote, 0 existencia, IL.cantidad
			FROM MOVAjustesItems I INNER JOIN 
			MovAjustesLotes IL ON I.id = IL.id_item INNER JOIN 
			LotesProducto L ON IL.id_lote = L.id
			WHERE I.id = @id_articulo

		END ELSE IF (@op='L')
		BEGIN
			SELECT 0 id, L.lote + ' - (Vence: ' + CONVERT(VARCHAR(10), L.vencimiento_lote, 120)+')' lote, 0 existencia, IL.cantidad
			FROM MOVTrasladosItems I INNER JOIN 
			MOVTrasladosLotes IL ON I.id = IL.id_item INNER JOIN 
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


