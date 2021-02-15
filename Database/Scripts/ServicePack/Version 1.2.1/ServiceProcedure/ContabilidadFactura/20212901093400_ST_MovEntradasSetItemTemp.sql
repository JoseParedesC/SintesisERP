--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_MovEntradasSetItemTemp]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_MovEntradasSetItemTemp]
GO


CREATE PROCEDURE [dbo].[ST_MovEntradasSetItemTemp] 
	@id				BIGINT,
	@anticipo		NUMERIC(18,2) = 0,
	@id_entrada		BIGINT,
	@column			VARCHAR(20),
	@id_proveedor	BIGINT=null,
	@id_proveedorfle BIGINT,
	@flete			DECIMAL(18,2),
	@valor			DECIMAL(18,2),	
	@extravalor		VARCHAR(max)=NULL,
	@op				CHAR(1) = '',
	@id_entradaofi	BIGINT	= 0,
	@modulo			CHAR(1),
	@xml			XML=NULL
--WITH ENCRYPTION
AS
BEGIN
/***************************************
*Nombre:		[dbo].[ST_MovEntradasItemTempGet]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		18/05/20
*Desarrollador: (JTous)
***************************************/
------------------------------------------------------------------------------
-- Declaring variables Page_Nav
------------------------------------------------------------------------------
DECLARE @ds_error VARCHAR(MAX), @count decimal(18,2)= 0, @serie VARCHAR(200), @id_imp BIGINT, @porimp DECIMAL(5,2) = 0,@manejador INT,@id_catFiscal BIGINT,@id_cat INT, @retiene BIT;
DECLARE @tableserie TABLE (id int identity(1,1) not null, serie varchar(200))
Begin Try
	SET @id_catFiscal = (SELECT id_catfiscal FROM CNT.Terceros T   WHERE T.id = @id_proveedor);
	SELECT @id_cat = F.id, @retiene =  F.retiene FROM  CNTCategoriaFiscal F WHERE F.id = @id_catFiscal AND F.retiene != 0

	IF(@column = 'CANTIDAD')
	BEGIN		
		IF (@op = 'D')
			UPDATE T SET T.cantidaddev = @valor, T.iva = C.iva, T.inc = C.inc, T.costototal = C.costototal, T.descuento =  CAST((T.costo * T.pordescuento/100)* @valor as decimal(18,2))
			FROM [dbo].[MOVEntradasItemsTemp]  T CROSS APPLY Dbo.ST_FnCostoArticulo(T.id_articulo, T.costo, @valor,  CAST((T.costo * T.pordescuento/100)* @valor as decimal(18,2)), T.porceninc, T.porceniva, T.pordescuento,T.porcerefuente,T.porcereiva,T.porcereica,@retiene) C				
			WHERE T.id = @id;
		ELSE
			UPDATE T SET T.cantidad = @valor, T.iva = C.iva, T.inc = C.inc, T.costototal = C.costototal, T.descuento =  CAST((T.costo * T.pordescuento/100)* @valor as decimal(18,2)),T.retefuente=C.retefuente,T.reteiva=C.reteiva,T.reteica=C.reteica
			FROM [dbo].[MOVEntradasItemsTemp]  T CROSS APPLY Dbo.ST_FnCostoArticulo(T.id_articulo, T.costo, @valor,  CAST((T.costo * T.pordescuento/100)* @valor as decimal(18,2)), T.porceninc, T.porceniva, T.pordescuento,T.porcerefuente,T.porcereiva,T.porcereica,@retiene) C				
			WHERE T.id = @id;
	END
	ELSE IF (@column = 'COSTO')
	BEGIN
		UPDATE T SET T.costo = @valor, T.iva = C.iva, T.inc = C.inc, T.costototal = C.costototal, T.descuento = CAST(@valor * T.pordescuento/100 * cantidad as decimal(18,2)), T.descuentound = C.descuentound,T.retefuente=C.retefuente,T.reteiva=C.reteiva,T.reteica=C.reteica
		FROM [dbo].[MOVEntradasItemsTemp]  T CROSS APPLY Dbo.ST_FnCostoArticulo(T.id_articulo, @valor, T.cantidad, CAST((@valor * T.pordescuento/100)* T.cantidad as decimal(18,2)), T.porceninc, T.porceniva,  T.pordescuento,T.porcerefuente,T.porcereiva,T.porcereica,@retiene) C				
		WHERE T.id = @id;
	END
	ELSE IF (@column = 'SERIES')
	BEGIN
		IF(@modulo='E')
		BEGIN
				IF (@op = 'D')
				BEGIN
					UPDATE MovEntradasSeriesTemp SET selected = 0 WHERE id_itemstemp = @id AND id_entradatemp = @id_entrada;

					UPDATE T SET T.selected = 1 FROM MovEntradasSeriesTemp  T 
					INNER JOIN [dbo].[ST_FnTextToTable](@extravalor, ',') C ON T.id = CAST(C.item AS BIGINT) AND T.id_itemstemp = @id
					WHERE item != '' AND T.id_entradatemp = @id_entrada

					SET @count = ISNULL((SELECT COUNT(1) FROM MovEntradasSeriesTemp WHERE id_itemstemp = @id AND selected != 0),0)
					--UPDATE MOVEntradasItemsTemp SET cantidaddev = @count WHERE id = @id;
			
					UPDATE T SET T.cantidaddev = @count, T.iva = C.iva, T.inc = C.inc, T.costototal = C.costototal, T.descuento =  CAST((T.costo * T.pordescuento/100)* @count as decimal(18,2))
					FROM [dbo].[MOVEntradasItemsTemp]  T CROSS APPLY Dbo.ST_FnCostoArticulo(T.id_articulo, T.costo, @count,  CAST((T.costo * T.pordescuento/100)* @count as decimal(18,2)), T.porceninc, T.porceniva, T.pordescuento,T.porcerefuente,T.porcereiva,T.porcereica,@retiene) C				
					WHERE T.id = @id;
				END
				ELSE
				BEGIN	
					INSERT INTO @tableserie (serie)
					SELECT item FROM [dbo].[ST_FnTextToTable](@extravalor, ',') WHERE item != ''

					;WITH CTE(serie, cantidad)
					AS(
						SELECT serie, COUNT(1) FROM @tableserie GROUP BY serie
					)
					SELECT @serie = serie FROM CTE WHERE cantidad > 1;
		
					IF(ISNULL(@serie, '') = '')
					BEGIN
						DELETE [MovEntradasSeriesTemp] WHERE id_itemstemp = @id;

						INSERT INTO  [dbo].[MovEntradasSeriesTemp](id_itemstemp, id_entradatemp, serie)
						SELECT @id, @id_entrada, serie FROM @tableserie
					END
					ELSE
					BEGIN
						SET @ds_error = 'La serie '+ @serie + ' esta repetida en este articulo';
						RAISERROR(@ds_error, 16,0);
					END			
				END
		END
		ELSE
		BEGIN
			DELETE [MovEntradasSeriesTemp] WHERE id_itemstemp = @id AND id_entradatemp = @id_entrada;

			INSERT INTO [dbo].[MovEntradasSeriesTemp] (id_itemstemp, id_entradatemp, serie, selected)
			SELECT @id, @id_entrada, item, 0 FROM DBo.ST_FnTextToTable(@extravalor, ',')
			WHERE item != ''
				
			SELECT @count = COUNT(1) FROM [MovEntradasSeriesTemp] WHERE id_itemstemp = @id AND id_entradatemp = @id_entrada;
			IF (ISNULL(@count, 0) != 0)			
				UPDATE I SET I.cantidad = iif(@modulo='A',@count*-1,@count), I.costo=A.costo,I.costototal=A.costototal
				FROM [MOVEntradasItemsTemp] I CROSS APPLY Dbo.ST_FnCostoArticulo(id_articulo,I.costo,iif(@modulo='A',@count*-1,@count),0,0,0,0,0,0,0,@retiene) A
				WHERE I.id = @id AND I.id_entrada = @id_entrada	
		END
	END
	ELSE IF (@column = 'DESCUENTO')
	BEGIN
		UPDATE T SET T.iva = C.iva, T.inc = C.inc, T.costototal = C.costototal, T.descuento = CAST(T.costo * @valor/100 * T.cantidad as decimal(18,2)), T.descuentound = C.descuentound, T.pordescuento = @valor
		FROM [dbo].[MOVEntradasItemsTemp]  T CROSS APPLY Dbo.ST_FnCostoArticulo(T.id_articulo, costo, T.cantidad, CAST((costo * @valor/100)* T.cantidad as decimal(18,2)), T.porceninc, T.porceniva,  @valor,T.porcerefuente,T.porcereiva,T.porcereica,@retiene) C				
		WHERE T.id = @id;
	END
	ELSE IF (@column = 'INC')
	BEGIN
		SELECT @id_imp = id, @porimp = valor FROM CNT.VW_Impuestos WHERE id = CAST(@valor AS INT);

		UPDATE T SET T.id_inc = @id_imp, T.porceninc = ISNULL(@porimp, 0), T.inc = C.inc, T.costototal = C.costototal
		FROM [dbo].[MOVEntradasItemsTemp]  T CROSS APPLY Dbo.ST_FnCostoArticulo(T.id_articulo, costo, T.cantidad, T.descuento, ISNULL(@porimp, 0), T.porceniva,  T.pordescuento,T.porcerefuente,T.porcereiva,T.porcereica,@retiene) C				
		WHERE T.id = @id;
	END
	ELSE IF (@column = 'IVA')
	BEGIN
		SELECT @id_imp = id, @porimp = valor FROM CNT.VW_Impuestos WHERE id = CAST(@valor AS INT);

		UPDATE T SET T.id_iva = @id_imp, T.iva = C.iva, T.porceniva = ISNULL(@porimp, 0), T.costototal = C.costototal
		FROM [dbo].[MOVEntradasItemsTemp]  T CROSS APPLY Dbo.ST_FnCostoArticulo(T.id_articulo, costo, T.cantidad, T.descuento, T.porceninc, ISNULL(@porimp, 0),  T.pordescuento,T.porcerefuente,T.porcereiva,T.porcereica,@retiene) C				
		WHERE T.id = @id;
	END
	ELSE IF (@column = 'LOTE')
	BEGIN
		IF(@modulo='E')
		BEGIN
			UPDATE T SET T.id_lote = @extravalor
			FROM [dbo].[MOVEntradasItemsTemp]  T
			WHERE T.id = @id;
		END 
		ELSE 
		BEGIN
			DELETE [dbo].[MOVEntradaLotesTemp] WHERE id_itemtemp = @id AND id_factura = @id_entrada;

		EXEC sp_xml_preparedocument @manejador OUTPUT, @xml; 	

		INSERT INTO [dbo].[MOVEntradaLotesTemp] 
		(id_itemtemp, id_lote, id_factura, cantidad)
		SELECT @id, idlote, @id_entrada, can
		FROM OPENXML(@manejador, N'items/item') 
		WITH (  idlote [bigint] '@idlote',
				can [NUMERIC](18,2) '@cant'
				) AS P
											
		EXEC sp_xml_removedocument @manejador;

		SELECT @count = SUM(cantidad) FROM [MOVEntradaLotesTemp] WHERE id_itemtemp = @id AND id_factura = @id_entrada;

		IF (ISNULL(@count, 0) != 0)			
			UPDATE I SET I.cantidad = @count, I.costo=A.costo,I.costototal=A.costototal
			FROM [MOVEntradasItemsTemp] I CROSS APPLY Dbo.ST_FnCostoArticulo(id_articulo,I.costo,@count,0,0,0,0,0,0,0,@retiene) A
			WHERE I.id = @id AND I.id_entrada = @id_entrada
	END

	END

	ELSE IF (@column = 'VENCIMIENTO')
	BEGIN
		UPDATE T SET T.vencimientolote = REPLACE(@extravalor, '-','')
		FROM [dbo].[MOVEntradasItemsTemp]  T
		WHERE T.id = @id;
	END
		
	ELSE IF (@column = 'SELECTED')
	BEGIN
		UPDATE T SET T.selected = CASE WHEN @valor != 0 THEN 1 ELSE 0 END
		FROM [dbo].[MOVEntradasItemsTemp]  T
		WHERE T.id = @id;
	END

	ELSE IF (@column = 'ALLSELECTED')
	BEGIN
		UPDATE T SET T.selected = CASE WHEN @valor != 0 THEN 1 ELSE 0 END
		FROM [dbo].[MOVEntradasItemsTemp]  T
		WHERE T.id_entrada = @id_entrada;
	END

	IF(@op = 'D')
		SELECT 	R.porfuente, R.retfuente, R.poriva, R.retiva, R.porica, R.retica, R.costo Tcosto, R.iva+R.ivaFlete Tiva,R.tinc Tinc, R.descuento Tdesc, R.total Ttotal, @anticipo valoranticipo
		FROM  Dbo.ST_FnCalRetenciones(0, @id_entrada, 0,'DEV', @id_entradaofi, @id_proveedorfle,@id_catfiscal,@id_cat,@retiene) R
	ELSE
		SELECT 	R.porfuente, R.retfuente, R.poriva, R.retiva, R.porica, R.retica, R.costo Tcosto, R.iva+R.ivaFlete Tiva,R.tinc Tinc, R.descuento Tdesc, R.total Ttotal, @anticipo valoranticipo
		FROM  Dbo.ST_FnCalRetenciones(@id_proveedor, @id_entrada, @flete,'EN', 0, @id_proveedorfle,@id_catfiscal,@id_cat,@retiene) R
		
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


