--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_MovFacturaSetItemTemp]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_MovFacturaSetItemTemp]
GO


CREATE PROCEDURE [dbo].[ST_MovFacturaSetItemTemp] 
	@id				BIGINT,
	@id_factura		VARCHAR(255),
	@column			VARCHAR(20),	
	@anticipo		DECIMAL(18,2),
	@valor			DECIMAL(18,2),	
	@extravalor		VARCHAR(max),
	@op				CHAR(1) = '',
	@xml			XML,
	@id_facturaofi	BIGINT	= 0
--WITH ENCRYPTION
AS
BEGIN
/***************************************
*Nombre:		[dbo].[ST_MovFacturaSetItemTemp]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		18/05/20
*Desarrollador: (JTous)
***************************************/
------------------------------------------------------------------------------
-- Declaring variables Page_Nav
------------------------------------------------------------------------------
DECLARE @ds_error VARCHAR(MAX), @count decimal(18,2)= 0, @serie VARCHAR(200), @id_imp BIGINT, @porimp DECIMAL(5,2) = 0, @manejador INT;
DECLARE @tableserie TABLE (id int identity(1,1) not null, serie varchar(200))
DECLARE @tablelote TABLE (id int identity(1,1) not null, id_lote [bigint], cantidad [NUMERIC](18,2))
Begin Try

	IF(@column = 'CANTIDAD')
	BEGIN		
		IF (@op = 'D')			
			UPDATE I SET I.cantidaddev = @valor, I.descuentound = A.descuentound, I.descuento = A.descuento, 
			I.iva = CASE WHEN I.iscausacion != 0 THEN I.iva ELSE A.iva END,
			I.inc = A.inc, I.total = A.total, I.preciodes = A.preciodes, I.id_iva = A.id_iva, I.id_inc = A.id_inc
			FROM [MOVFacturaItemsTemp] I CROSS APPLY Dbo.ST_FnPrecioArticulo (id_articulo, precio, @valor, I.descuento) A
			WHERE I.id = @id AND I.id_factura = @id_factura
		ELSE
			UPDATE I SET I.cantidad = @valor, I.descuentound = A.descuentound, I.descuento = A.descuento, I.iva = A.iva,
			I.inc = A.inc, I.total = A.total, I.preciodes = A.preciodes, I.id_iva = A.id_iva, I.id_inc = A.id_inc
			FROM [MOVFacturaItemsTemp] I CROSS APPLY Dbo.ST_FnPrecioArticulo (id_articulo, precio, @valor, I.descuento) A
			WHERE I.id = @id AND I.id_factura = @id_factura
	END
	ELSE IF (@column = 'SERIE')
	BEGIN
		IF(@op='D')
		BEGIN
					UPDATE MovFacturaSeriesTemp SET selected = 0 WHERE id_itemstemp = @id AND id_facturatemp = @id_factura;

					
					--UPDATE MovFacturaSeriesTemp   SET selected=1 where id in (substring(@extravalor,0,len(@extravalor)))
					UPDATE T SET T.selected = 1 FROM MovFacturaSeriesTemp  T 
					INNER JOIN [dbo].[ST_FnTextToTable](@extravalor, ',') C ON T.id = CAST(C.item AS BIGINT) AND T.id_itemstemp = @id-- ADICION 22/01/2021
					WHERE item != '' AND T.id_facturatemp = @id_factura

					SET @count = ISNULL((SELECT COUNT(1) FROM MovFacturaSeriesTemp WHERE id_itemstemp = @id AND selected != 0),0)
					--UPDATE MOVEntradasItemsTemp SET cantidaddev = @count WHERE id = @id;
			
					UPDATE T SET T.cantidaddev = @count, T.iva = A.iva, T.inc = A.inc,  T.descuento =  CAST((T.costo * T.pordescuento/100)* @count as decimal(18,2))
					FROM [dbo].[MOVFacturaItemsTemp]  T CROSS APPLY Dbo.ST_FnPrecioArticulo (id_articulo, precio, @count, T.descuento) A
					WHERE T.id = @id;
		
			END
		ELSE 
		BEGIN
			DELETE [MovFacturaSeriesTemp] WHERE id_itemstemp = @id AND id_facturatemp = @id_factura;

			INSERT INTO [dbo].[MovFacturaSeriesTemp] (id_itemstemp, id_facturatemp, serie, selected)
			SELECT @id, @id_factura, item, 0 FROM DBo.ST_FnTextToTable(@extravalor, ',')
			WHERE item != ''
				
			SELECT @count = COUNT(1) FROM [MovFacturaSeriesTemp] WHERE id_itemstemp = @id AND id_facturatemp = @id_factura;
			IF (ISNULL(@count, 0) != 0)			
				UPDATE I SET I.cantidad = @count, I.descuentound = A.descuentound, I.descuento = A.descuento, I.iva = A.iva,
				I.inc = A.inc, I.total = A.total, I.preciodes = A.preciodes, I.id_iva = A.id_iva, I.id_inc = A.id_inc
				FROM [MOVFacturaItemsTemp] I CROSS APPLY Dbo.ST_FnPrecioArticulo (id_articulo, precio, @count, I.descuento) A
				WHERE I.id = @id AND I.id_factura = @id_factura
			END
	END
	ELSE IF (@column = 'LOTE')
	BEGIN
		
		EXEC sp_xml_preparedocument @manejador OUTPUT, @xml; 	

		INSERT INTO @tablelote
		(id_lote, cantidad)
		SELECT idlote, can
		FROM OPENXML(@manejador, N'items/item') 
		WITH (  idlote [bigint] '@idlote',
				can [NUMERIC](18,2) '@cant'
				) AS P
											
		EXEC sp_xml_removedocument @manejador;

		SELECT @count = SUM(cantidad) FROM @tablelote

		IF(@op='D')
		BEGIN
			
			UPDATE T SET T.cantidaddev = L.cantidad FROM [MOVFacturaLotesTemp] T 
			INNER JOIN @tablelote L ON T.id_factura = @id_factura AND T.id_itemtemp = @id AND T.id_lote = L.id_lote
			

			IF (ISNULL(@count, 0) != 0)			
				UPDATE I SET I.cantidaddev = @count, I.descuentound = A.descuentound, I.descuento = A.descuento, I.iva = A.iva,
				I.inc = A.inc, I.total = A.total, I.preciodes = A.preciodes, I.id_iva = A.id_iva, I.id_inc = A.id_inc
				FROM [MOVFacturaItemsTemp] I CROSS APPLY Dbo.ST_FnPrecioArticulo (id_articulo, precio, @count, I.descuento) A
				WHERE I.id = @id AND I.id_factura = @id_factura
		END
		ELSE 
		BEGIN
			DELETE [dbo].[MOVFacturaLotesTemp] WHERE id_itemtemp = @id AND id_factura = @id_factura;

			INSERT INTO [dbo].[MOVFacturaLotesTemp]  (id_itemtemp, id_lote, id_factura, cantidad)
			SELECT @id, id_lote, @id_factura, cantidad
			FROM @tablelote

			IF (ISNULL(@count, 0) != 0)			
				UPDATE I SET I.cantidad = @count, I.descuentound = A.descuentound, I.descuento = A.descuento, I.iva = A.iva,
				I.inc = A.inc, I.total = A.total, I.preciodes = A.preciodes, I.id_iva = A.id_iva, I.id_inc = A.id_inc
				FROM [MOVFacturaItemsTemp] I CROSS APPLY Dbo.ST_FnPrecioArticulo (id_articulo, precio, @count, I.descuento) A
				WHERE I.id = @id AND I.id_factura = @id_factura
		END
	END
	
	ELSE IF (@column = 'SELECTED')
	BEGIN
		UPDATE T SET T.selected = CASE WHEN @valor != 0 THEN 1 ELSE 0 END
		FROM [dbo].[MOVFacturaItemsTemp]  T
		WHERE T.id = @id;
	END

	ELSE IF (@column = 'ALLSELECTED')
	BEGIN
		UPDATE T SET T.selected = CASE WHEN @valor != 0 THEN 1 ELSE 0 END
		FROM [dbo].[MOVFacturaItemsTemp]  T
		WHERE T.id_factura = @id_factura
	END
	
	IF(@op = 'D')		
		SELECT 
			R.precio Tprecio, R.iva Tiva,isnull(R.inc,0) Tinc ,R.descuentoart Tdctoart, R.total Ttotal, (R.descuentoart) Tdesc
		FROM Dbo.ST_FnCalDevTotalFactura(@id_factura, 0) R
	ELSE
		SELECT 
			R.precio Tprecio, R.iva Tiva,isnull(R.inc,0) Tinc ,R.descuentoart Tdctoart, R.total Ttotal, (R.descuentoart) Tdesc
		FROM Dbo.ST_FnCalTotalFactura(@id_factura, @anticipo) R

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


