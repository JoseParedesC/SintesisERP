--liquibase formatted sql
--changeset ,jteheran:3 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_MovEntradaAddArticulo]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [dbo].[ST_MovEntradaAddArticulo]
GO
CREATE PROCEDURE [dbo].[ST_MovEntradaAddArticulo]
	@id_proveedor	[int] = null,
	@id_proveedorfle BIGINT = null,
	@id_entrada		[int],
    @id_articulo	[INT],
	@serie			BIT,
	@islote			BIT,
	@lote			VARCHAR(200),
	@vencimiento_lote VARCHAR (10),
    @cantidad		[NUMERIC] (18,2),
    @costo			[NUMERIC] (18,2),
    @descuento		[NUMERIC] (18,2),
	@pordescuento	[NUMERIC] (5,2),
	@id_iva         [BIGINT],
	@id_inc         [BIGINT],
	@id_retefuente  [BIGINT],
	@id_reteiva		[BIGINT],
	@id_reteica	    [BIGINT],
	@flete			[NUMERIC] (18,2) = 0,
	@inventario		BIT,
    @id_user		[INT],
	@anticipo       [NUMERIC] (18,2)
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[Dbo].[PA_EntradaAddArticulo]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		09/05/2017
*Desarrollador: (JTOUS)
***************************************/
DECLARE @error VARCHAR(MAX), @id int, @dsserie VARCHAR(200), @cantidadNuevo NUMERIC (18,2), @porceniva numeric(4,2), @porceninc numeric(4,2),@porcenrefuente numeric(4,2),@porcenreiva numeric(4,2),@porcenreica numeric(4,2), @dataid INT = 0, @count decimal(18,2)= 0,@id_catFiscal BIGINT,@id_cat INT, @retiene BIT;
DECLARE @tableserie TABLE (id int identity(1,1) NOT NULL, serie VARCHAR(200));
BEGIN TRY
BEGIN TRAN
	
	SET @id_catFiscal = (SELECT id_catfiscal FROM CNT.Terceros T  WHERE T.id = @id_proveedor);
	SELECT @id_cat = F.id, @retiene =  F.retiene FROM  CNTCategoriaFiscal F WHERE F.id = @id_catFiscal AND F.retiene != 0

	SET @id_retefuente=(IIF(@retiene!=0,@id_retefuente,0))
	SET @id_reteica=(IIF(@retiene!=0,@id_reteica,0))
	SET @id_reteiva=(IIF(@retiene!=0,@id_reteiva,0))

	SET @porceniva = ISNULL((SELECT ISNULL(I.VALOR,0)  FROM  CNT.Impuestos I  WHERE I.id = @id_iva),0);
	SET @porceninc = ISNULL((SELECT ISNULL(I.VALOR,0)  FROM  CNT.Impuestos I  WHERE I.id = @id_inc),0);
	SET @porcenrefuente = ISNULL((SELECT ISNULL(I.VALOR,0)  FROM  CNT.Impuestos I  WHERE I.id = @id_retefuente),0);
	SET @porcenreica = ISNULL((SELECT ISNULL(I.VALOR,0)  FROM  CNT.Impuestos I  WHERE I.id = @id_reteica),0);
	SET @porcenreiva = ISNULL((SELECT ISNULL(I.VALOR,0)  FROM  CNT.Impuestos I  WHERE I.id = @id_reteiva),0);

	SET @dataid = (SELECT id FROM dbo.[MOVEntradasItemsTemp] WHERE id_articulo = @id_articulo and id_entrada = @id_entrada and id_lote = @lote and costo = @costo and pordescuento = @pordescuento and serie = @serie AND id_iva = CASE WHEN @id_iva = 0 THEN NULL ELSE @id_iva END AND id_inc = CASE WHEN @id_inc = 0 THEN NULL ELSE @id_inc END AND CONVERT(VARCHAR(10), vencimientolote, 112) = @vencimiento_lote)
	

	IF (ISNULL(@dataid, 0) = 0)
	BEGIN
	 
		IF EXISTS(SELECT 1 FROM MOVEntradasItemsTemp WHERE id_entrada = @id_entrada AND id_lote = @lote and vencimientolote != @vencimiento_lote)
		BEGIN
			RAISERROR('La fecha de vencimiento no coincide con el mismo lote relacionado anteriormente ', 16, 0);
		END

		IF @lote != '' AND EXISTS (SELECT 1 FROM LotesProducto L WHERE lote = @lote AND CONVERT(VARCHAR(10), vencimiento_lote, 112) != @vencimiento_lote)
		BEGIN		
			SELECT TOP 1 @error = 'El lote (' + @lote +') ya existe con este ('+CONVERT(VARCHAR(10), vencimiento_lote, 120)+') vencimiento en inventario' 
			FROM Dbo.LotesProducto WHERE lote = @lote; 
			RAISERROR(@error, 16, 0)
		END	
		
		INSERT INTO [dbo].[MOVEntradasItemsTemp] (id_entrada, id_articulo, serie, lote, id_lote, vencimientolote, id_bodega, cantidad, costo, precio, id_iva, porceniva, iva, id_inc, porceninc, inc,id_retefuente,porcerefuente,retefuente,id_reteiva,porcereiva,reteiva,id_reteica,porcereica,reteica ,descuentound, pordescuento, descuento, costototal, flete, inventarial, id_user)
		SELECT 
			@id_entrada, @id_articulo, @serie, @islote, @lote, @vencimiento_lote, NULL, @cantidad, C.costo, C.precio, CASE WHEN @id_iva = 0 THEN NULL ELSE @id_iva END, @porceniva, C.iva, CASE WHEN @id_inc = 0 THEN NULL ELSE @id_inc END, @porceninc, C.inc,CASE WHEN @id_retefuente = 0 THEN NULL ELSE @id_retefuente END ,@porcenrefuente,C.retefuente,CASE WHEN @id_reteiva = 0 THEN NULL ELSE @id_reteiva END ,@porcenreiva,C.reteiva,CASE WHEN @id_reteica = 0 THEN NULL ELSE @id_reteica END ,@porcenreica,C.reteica,C.descuentound, @pordescuento, @descuento, C.costototal, 0, @inventario, @id_user
		FROM Dbo.ST_FnCostoArticulo(@id_articulo, @costo, @cantidad, @descuento, @porceninc, @porceniva, @pordescuento,@porcenrefuente,@porcenreiva,@porcenreica,@retiene) AS C;

		SET @id = SCOPE_IDENTITY();
	END
	ELSE
		BEGIN						
			UPDATE T SET T.cantidad += @cantidad, T.iva = C.iva, T.inc = C.inc, T.costototal = C.costototal, T.descuento += @descuento, T.descuentound = C.descuentound,T.retefuente=C.retefuente,T.reteica=C.reteica,T.reteiva=C.reteiva
			FROM [dbo].[MOVEntradasItemsTemp]  T CROSS APPLY Dbo.ST_FnCostoArticulo(T.id_articulo, T.costo, (T.cantidad + @cantidad), T.descuento + @descuento, T.porceninc, T.porceniva, T.pordescuento,ISNULL(T.porcerefuente,0),ISNULL(T.porcereiva,0),ISNULL(T.porcereica,0),@retiene) C				
			WHERE T.id = @dataid;
	END
	
	SELECT 	R.porfuente, R.retfuente, R.poriva, R.retiva, R.porica, R.retica, R.costo Tcosto, (R.iva+R.ivaFlete) Tiva,R.tinc Tinc, R.descuento Tdesc, R.total Ttotal , @anticipo valoranticipo
	FROM  Dbo.ST_FnCalRetenciones(@id_proveedor, @id_entrada, @flete,'EN', 0, @id_proveedorfle,@id_catfiscal,@id_cat,@retiene) R
	
COMMIT TRAN;
END TRY
BEGIN CATCH
		ROLLBACK TRAN;
	    --Getting the error description
	    SELECT @error   =  ERROR_MESSAGE()
	    -- save the error in a Log file
	    RAISERROR(@error,16,1);
	    RETURN  
END CATCH