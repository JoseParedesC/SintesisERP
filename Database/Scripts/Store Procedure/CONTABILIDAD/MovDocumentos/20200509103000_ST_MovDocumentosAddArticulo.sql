--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_MovDocumentosAddArticulo]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_MovDocumentosAddArticulo]
GO


CREATE PROCEDURE [dbo].[ST_MovDocumentosAddArticulo]
	@idToken		[VARCHAR] (255),
    @id_articulo	[BIGINT],    
	@id_bodega		[BIGINT],    
	@id_bodegadest	[BIGINT]=NULL,    
	@serie			[BIT],
	@series			[VARCHAR] (MAX),
	@lote			[BIT], 
	@cantidad		[NUMERIC] (18,2),
    @costo			[NUMERIC] (18,2),
	@inventario     [BIT],
    @id_user		[INT]
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[Dbo].[ST_MovDocumentosAddArticulo]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		09/05/2020
*Desarrollador: (JTOUS)
***************************************/
DECLARE @error VARCHAR(MAX), @id int;
DECLARE @cantidadval numeric(18,2)
BEGIN TRY
BEGIN TRAN
	
	

	--/*SET @cantidadval = (SELECT cantidad FROM [dbo].[MOVDocumentItemTemp] WHERE id_articulo = @id_articulo And serie=@serie And id_lote=@id_lote ANd id_bodega = @id_bodega AND idToken = @idToken AND tipodoc = 'A');

	--IF EXISTS (Select 1 From Dbo.Existencia Where id_articulo = @id_articulo And id_bodega = @id_bodega And serie=@serie And id_lote=@id_lote  And (existencia + ISNULL(@cantidadval, 0) + @cantidad) < 0)
	--	RAISERROR('Este artículo no se puede ajustar con esta cantidad, porque queda negativo en la bodega.', 16, 0);
	--*/
	--IF EXISTS (Select 1 From Dbo.[MOVEntradasItemsTemp] Where id_articulo = @id_articulo And id_bodega = @id_bodega  and costo!=@costo And id_entrada = @idToken)
	--	RAISERROR('Este producto ya presenta ajuste en este documento de ajuste y con un costo diferente.', 16, 0);
	IF(@id_bodegadest is NOT NULL)	
	 SELECT TOP 1 @id = id FROM [dbo].[MOVEntradasItemsTemp] WHERE id_entrada = @idToken AND id_articulo = @id_articulo AND id_bodega = @id_bodega  and id_bodegadest=@id_bodegadest and costo=@costo

	IF (ISNULL(@id, 0) != 0)
	BEGIN
			UPDATE I SET I.cantidad += @cantidad
			FROM [MOVEntradasItemsTemp] I 
			WHERE I.id = @id AND I.id_entrada = @idToken		
			
			IF(@serie != 0)
				INSERT INTO [dbo].[MovEntradasSeriesTemp] (id_itemstemp, id_entradatemp, serie, selected)
				SELECT @id, @idToken, item, 0 FROM DBo.ST_FnTextToTable(@series, ',')
				WHERE item != ''

	END
	ELSE
	BEGIN
	INSERT INTO [dbo].[MOVEntradasItemsTemp] (id_entrada, id_articulo, serie, lote, id_lote, vencimientolote, id_bodega,id_bodegadest ,cantidad, costo, precio, id_iva, porceniva, iva, id_inc, porceninc, inc, descuentound, pordescuento, descuento, costototal, flete, inventarial, id_user)
		SELECT 
			@idToken, @id_articulo, @serie, @lote,'', NULL, @id_bodega,@id_bodegadest ,@cantidad, isnull(C.costo,0) costo, C.precio, NULL,0, 0, NULL, 0, 0, 0, 0, 0, C.costototal, 0,@inventario ,@id_user
		FROM Dbo.ST_FnCostoArticulo(@id_articulo, @costo, @cantidad, 0, 0, 0, 0, 0, 0, 0, 0) AS C;

	SET @id = SCOPE_IDENTITY();

	IF(ISNULL(@id,0) = 0)
		RAISERROR('No se inserto artículo en el ajuste.', 16, 0);

	--Cambiar a moventradasseriestemp
	INSERT INTO [dbo].[MovEntradasSeriesTemp] (id_itemstemp, id_entradatemp, serie, selected)
		SELECT @id, @idToken, item, 0 FROM DBo.ST_FnTextToTable(@series, ',')
		WHERE item != ''

	END
	
	SELECT 
		
		I.costo, (costo * cantidad) costototal, (SELECT SUM(costo * cantidad) FROM [dbo].[MOVEntradasItemsTemp] Where id_entrada = @idtoken ) Ttotal
	FROM 
		[dbo].[MOVEntradasItemsTemp]  I
		INNER JOIN Dbo.Productos A ON A.id = I.id_articulo
	WHERE 
		I.id = @id;

COMMIT TRAN;
END TRY
BEGIN CATCH
		ROLLBACK TRAN;
	    --Getting the error description
	    SELECT @error   =  ERROR_MESSAGE();
	    -- save the error in a Log file
	    RAISERROR(@error,16,1);
	    RETURN  
END CATCH

GO


