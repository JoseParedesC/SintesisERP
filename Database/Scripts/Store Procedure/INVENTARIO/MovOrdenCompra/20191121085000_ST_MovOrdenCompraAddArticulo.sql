--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_MovOrdenCompraAddArticulo]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_MovOrdenCompraAddArticulo]
GO
CREATE PROCEDURE [dbo].[ST_MovOrdenCompraAddArticulo]	
@id_orden		[int],
    @id_articulo	[INT],
    @id_bodega		[INT],
    @cantidad		[NUMERIC] (18,2),
    @id_user		[INT]
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[Dbo].[ST_MovOrdenCompraAddArticulo]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		21/11/2019
*Desarrollador: (Jeteme)
***************************************/
DECLARE @error VARCHAR(MAX), @id int, @costo DECIMAL(18,2) = 0, @idbodegaext BIGINT = 0;
BEGIN TRY
BEGIN TRAN
	
	SELECT TOP 1 @idbodegaext = id_bodega FROM [MOVEntradasItemsTemp] WHERE id_entrada = @id_orden AND id_bodega != @id_bodega
	
	IF (ISNULL(@idbodegaext, 0) != 0)
	BEGIN
		SET @error = (SELECT 'Esta orden de compra ya tiene asociada la bodega ('+codigo+' - '+nombre+')' FROM Bodegas WHERE id = @id_bodega);
		RAISERROR(@error, 16,0);
	END

	IF NOT EXISTS (SELECT 1 FROM dbo.[MOVEntradasItemsTemp] WHERE id_articulo = @id_articulo and id_entrada = @id_orden)
	BEGIN
		SET @costo = (SELECT TOP 1 costo FROM Existencia WHERE id_articulo = @id_articulo AND id_bodega = @id_bodega);

		INSERT INTO [dbo].[MOVEntradasItemsTemp] (id_entrada, id_articulo, serie, id_lote, vencimientolote, id_bodega, cantidad, costo, precio, id_iva, porceniva, iva, 
												id_inc, porceninc, inc, descuentound, pordescuento, descuento, costototal, flete, inventarial, id_user, lote)
		SELECT 
			@id_orden, 
			@id_articulo, 
			'', 
			'', 
			'', 
			@id_bodega, 
			@cantidad, 
			C.costo, 
			0 precio, 
			NULL, 
			0 poriva, 
			C.iva, 
			NULL , 
			0 porinc, 
			C.inc, 
			0 descuentound, 
			0 pordescuento, 
			0 descuento, 
			C.costototal, 
			0 flete, 
			1 inventarial, 
			@id_user,
			''
		FROM Dbo.ST_FnCostoArticulo(@id_articulo, ISNULL(@costo, 0), @cantidad, 0, 0, 0, 0, 0, 0, 0, 0) AS C;
		
		SET @id = SCOPE_IDENTITY();

	
	END
	ELSE
	BEGIN
		UPDATE [dbo].[MOVEntradasItemsTemp]
		SET
			cantidad += @cantidad
		WHERE
			id_articulo = @id_articulo and id_entrada = @id_orden;

	END
		
	SELECT 	R.costo Tcosto
	FROM  Dbo.ST_FnCalRetenciones(0, @id_orden, 0,'EN', 0, 0, 0, 0, 0) R


COMMIT TRAN;
END TRY
BEGIN CATCH
		ROLLBACK TRAN;
	    --Getting the error description
	    SELECT @error   =  ERROR_PROCEDURE() + 
					';  ' + convert(varchar,ERROR_LINE()) + 
					'; ' + ERROR_MESSAGE()
	    -- save the error in a Log file
	    RAISERROR(@error,16,1);
	    RETURN  
END CATCH

GO


