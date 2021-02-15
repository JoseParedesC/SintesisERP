--liquibase formatted sql
--changeset ,CZULBARAN:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_MovCotizacionAddArticulo]') and OBJECTPROPERTY(id, N'IsProcedure') = 1) 
DROP PROCEDURE dbo.ST_MovCotizacionAddArticulo
GO
CREATE PROCEDURE [dbo].[ST_MovCotizacionAddArticulo]
	@idToken		[VARCHAR] (255),
    @id_articulo	[INT],    
    @id_bodega		[INT],    
	@cantidad		[NUMERIC] (18,2),
    @precio			[NUMERIC] (18,2),
    @id_user		[INT],
	@descuento      [NUMERIC] (18,2)=0,
	@cuota_ini		[NUMERIC] (18,2)=0    
 
AS
/***************************************
*Nombre:		[Dbo].[ST_MovCotizacionAddArticulo]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		09/05/2017
*Desarrollador: (JTOUS)
***************************************/
DECLARE @error VARCHAR(MAX), @id int;
BEGIN TRY
BEGIN TRAN

	IF EXISTS (SELECT 1 FROM [dbo].[MOVFacturaItemsTemp] WHERE id_factura = @idToken AND id_articulo = @id_articulo AND precio != @precio)
		RAISERROR ('Ya existe un art�culo dentro de esta cotizaci�n y esta con precio diferente. Verifique.!', 16, 0);
		--CZULBARAN AGREGÓ @DESCUENTO Y @CUOTAINI EN LAS COLUMNAS DESCUENTO Y COSTO PARA UTILIZARLAS EN COTIZACION
	INSERT INTO [dbo].[MOVFacturaItemsTemp] (id_factura, id_articulo,id_bodega ,cantidad, precio, descuento, id_iva, iva, inc, total, id_user, costo, preciodes, poriva,serie,lote,pordescuento,porinc)
	SELECT @idToken, @id_articulo,@id_bodega ,@cantidad, precio, @descuento, id_iva, iva, inc, total, @id_user, @cuota_ini, preciodes, poriva,0,0,0,0
	FROM Dbo.ST_FnPrecioArticulo (@id_articulo, @precio, @cantidad,0);

	SET @id = SCOPE_IDENTITY();

	IF(ISNULL(@id,0) = 0)
		RAISERROR('No se inserto art�culo en la cotizaci�n.', 16, 0);

	SELECT 
		I.id, A.codigo, A.presentacion, A.nombre, I.cantidad, I.precio, I.iva, I.descuento,  I.total,
		R.precio Tprecio, R.iva Tiva, R.descuentoart Tdctoart, R.total Ttotal, isnull(R.inc,0) Tinc, (0 +R.descuentoart) Tdesc 
	FROM 
		[dbo].[MOVFacturaItemsTemp] I
		INNER JOIN Dbo.Productos A ON A.id = I.id_articulo		
		Cross Apply Dbo.ST_FnCalTotalFactura(@idToken, 0) R
	WHERE 
		I.id = @id;

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