--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_MovDevEntradaAddArticulo]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_MovDevEntradaAddArticulo]
GO

CREATE PROCEDURE [dbo].[ST_MovDevEntradaAddArticulo]
	@id_devolucion	[INT],
    @id_articulo	[INT],  
	@serie		VARCHAR(200),
	@lote		VARCHAR(30),
	@id_bodega		[INT],
	@cantidad		[NUMERIC] (18,2),
	@id_entrada		[INT],
    @id_user		[INT]
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[Dbo].[ST_MovDevEntradaAddArticulo]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		09/05/2017
*Desarrollador: (JTOUS)
***************************************/
DECLARE @error VARCHAR(MAX), @id int,@id_proveedor BIGINT;
BEGIN TRY
BEGIN TRAN

	IF EXISTS(SELECT 1 FROM MOVEntradasItemsTemp WHERE id_bodega = @id_bodega AND id_articulo = @id_articulo AND id_entrada = @id_devolucion)
		RAISERROR ('Ya existe este artículo con esta bodega en esta devolución. Verifique!', 16, 0);

	/*IF (@cantidad > Dbo.ST_FnCantidadArtMov(@id_articulo, @id_entrada, 'EN', @id_bodega))
		RAISERROR ('La cantidad disponible que tiene este artículo para devolver es menor. Verifique!', 16, 0);*/

	INSERT INTO [dbo].[MOVEntradasItemsTemp] (id_entrada, id_articulo, serie,id_lote,id_bodega, cantidad, costo, precio,porceniva ,iva,porceninc,inc ,descuento, costototal, flete, id_user)
	SELECT @id_devolucion, id_articulo,@serie,@lote ,id_bodega, @cantidad, (costo+(flete/cantidad)), 0, porceninc,iva,porceninc,inc/cantidad*@cantidad,descuento / cantidad * @cantidad, ((costo+(flete/cantidad))+iva+(inc/cantidad*@cantidad))* @cantidad, 0, @id_user
	FROM Dbo.MOVEntradasItems WHERE id_entrada = @id_entrada AND id_articulo = @id_articulo AND serie=@serie AND id_lote=@lote AND id_bodega = @id_bodega;

	SET @id = SCOPE_IDENTITY();
	SET @id_proveedor=(SELECT id_proveedor FROM DBO.MOVEntradas WHERE ID=@id_entrada)	
	SELECT 
		I.id, A.codigo, A.presentacion, A.nombre, I.cantidad, I.costo, I.iva, I.inc,I.descuento, I.costototal,
		R.retfuente, R.retiva, R.retica, R.costo Tcosto, R.iva Tiva,R.tinc Tinc, R.descuento Tdesc, R.total Ttotal
	FROM 
		Dbo.[MOVEntradasItemsTemp]  I
		INNER JOIN Dbo.Productos A ON A.id = I.id_articulo
		Cross Apply Dbo.ST_FnCalRetenciones(@id_proveedor, @id_devolucion, 0,'DVC', 0, 0, 0, 0, 0) R
	WHERE 
		I.id = @id;
	

COMMIT TRAN;
END TRY
BEGIN CATCH
		ROLLBACK TRAN;
	    --Getting the error description
	    SELECT @error   = ERROR_MESSAGE()
	    -- save the error in a Log file
	    RAISERROR(@error,16,1);
	    RETURN  
END CATCH



