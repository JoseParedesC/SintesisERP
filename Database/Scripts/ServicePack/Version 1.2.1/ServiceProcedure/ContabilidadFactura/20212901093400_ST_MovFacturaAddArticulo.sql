--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_MovFacturaAddArticulo]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_MovFacturaAddArticulo]
GO

/* Se le cambio el parametro que recibe en la funcion de tabla precioarticulo la cual antes recibia el porcentaje de descuento ahora recibe el valor*/
CREATE PROCEDURE [dbo].[ST_MovFacturaAddArticulo]
	@idToken		[VARCHAR] (255),
    @id_articulo	[BIGINT],    
	@id_bodega		[BIGINT],    
	@serie			[BIT],
	@series			[VARCHAR] (MAX),
	@lote			[BIT], 
	@cantidad		[NUMERIC] (18,2),
    @precio			[NUMERIC] (18,2),
	@porcendsc		[NUMERIC] (18,2),
	@descuento		[NUMERIC] (18,2),
	@anticipo		[DECIMAL](18,2) = 0,
    @id_user		[INT],
	@inventarial	[BIT],
	@descuentoFin   [NUMERIC](18,2)=0
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[Dbo].[ST_MovFacturaAddArticulo]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		09/05/2017
*Desarrollador: (JTOUS)
***************************************/
DECLARE @error VARCHAR(MAX), @preciotemp NUMERIC(18,4),@porceniva numeric(4,2),@porceninc numeric(4,2), @iva numeric(18,2), @inc numeric(18,2),
@id BIGINT = 0, @DatoID int;
BEGIN TRY
BEGIN TRAN
	
	SELECT @preciotemp  = precio, @iva = iva, @inc = inc 
	FROM Dbo.ST_FnPrecioArticulo (@id_articulo, @precio, @cantidad, @descuento);
	
	--IF EXISTS(SELECT 1 FROM [MOVFacturaItemsTemp] WHERE id_factura = @idToken AND inventarial != 0 AND id_bodega != @id_bodega)
	--	RAISERROR('En esta factura ya ha agregado productos con otra bodega.', 16, 0);

	IF EXISTS (SELECT 1 FROM [dbo].[MOVFacturaItemsTemp] 
	WHERE id_factura = @idToken AND id_articulo = @id_articulo AND precio != @preciotemp)
		RAISERROR ('Ya existe un art�culo dentro de esta factura y esta con precio diferente. Verifique.!', 16, 0);		

	SELECT TOP 1 @id = id FROM [dbo].[MOVFacturaItemsTemp] WHERE id_factura = @idToken AND id_articulo = @id_articulo AND iva = @iva AND inc = @inc AND pordescuento = @porcendsc

	IF (ISNULL(@id, 0) != 0)
	BEGIN
			UPDATE I SET I.cantidad += @cantidad, I.descuentound = A.descuentound, I.descuento = A.descuento, I.iva = A.iva,
			I.inc = A.inc, I.total = A.total, I.preciodes = A.preciodes, I.id_iva = A.id_iva, I.id_inc = A.id_inc
			FROM [MOVFacturaItemsTemp] I CROSS APPLY Dbo.ST_FnPrecioArticulo (id_articulo, precio, (I.cantidad + @cantidad), I.descuento) A
			WHERE I.id = @id AND I.id_factura = @idToken		

			IF(@serie != 0)
				INSERT INTO [dbo].[MovFacturaSeriesTemp] (id_itemstemp, id_facturatemp, serie, selected)
				SELECT @id, @idToken, item, 0 FROM DBo.ST_FnTextToTable(@series, ',')
				WHERE item != ''

	END
	ELSE
	BEGIN

	if(ISNUMERIC(@idToken) = 1)  
		 SET @DatoID = (SELECT TOP 1 id FROM [dbo].[MOVFacturasRecurrentes]  WHERE id = @idToken)
		
	IF (ISNULL(@DatoID, 0) != 0)
			BEGIN

			INSERT INTO [dbo].[MOVFacturaRecurrentesItems] (id_factura, id_producto, id_bodega, serie, lote, cantidad, costo, precio, preciodesc, descuentound, 
							pordescuento, descuento, id_ctaiva, poriva, iva, id_ctainc, porinc, inc, total, formulado, id_user, inventarial, id_itemtemp)
			 
			 SELECT @idToken, @id_articulo, @id_bodega, @serie, @lote, @cantidad, 0,
				A.precio, A.preciodes, A.descuentound, @porcendsc, A.descuento, A.id_iva, A.poriva, A.iva,
				A.id_inc, A.porinc, A.inc, A.total, A.formulado, @id_user, @inventarial, 0
				FROM Dbo.ST_FnPrecioArticulo (@id_articulo, @precio, @cantidad, @descuento) A;

					SET @id = SCOPE_IDENTITY();

				SELECT  @id id, 'PROCESADO' estado, R.precio Tprecio, R.iva Tiva, isnull(R.inc,0) Tinc ,R.descuentoart Tdctoart, R.total Ttotal, (R.descuentoart) Tdesc
				FROM [dbo].[ST_FnCalTotalFacturaRecurrente](@idToken) R

				--raiserror('16',16,0)
			END
			ELSE
		    BEGIN

				INSERT INTO [dbo].[MOVFacturaItemsTemp] (id_factura, id_articulo, id_bodega, serie, lote ,cantidad, 
				precio, descuentound, pordescuento, descuento, id_iva, poriva, iva,  
				id_inc, porinc, inc, total, id_user,costo,  preciodes, formulado, inventarial)
	
				SELECT @idToken, @id_articulo, @id_bodega, @serie, @lote, @cantidad, 
				A.precio, A.descuentound, @porcendsc, A.descuento, A.id_iva, A.poriva, A.iva,
				A.id_inc, A.porinc, A.inc, A.total, @id_user, 0, A.preciodes, A.formulado, @inventarial
				FROM Dbo.ST_FnPrecioArticulo (@id_articulo, @precio, @cantidad, @descuento) A;

				SET @id = SCOPE_IDENTITY();

				IF(ISNULL(@id,0) = 0)
					RAISERROR('No se inserto art�culo en la factura.', 16, 0);

				INSERT INTO [dbo].[MovFacturaSeriesTemp] (id_itemstemp, id_facturatemp, serie, selected)
				SELECT @id, @idToken, item, 0 FROM DBo.ST_FnTextToTable(@series, ',')
				WHERE item != ''

				SELECT 
					R.precio Tprecio, R.iva Tiva,isnull(R.inc,0) Tinc ,R.descuentoart Tdctoart, R.total-@descuentoFin Ttotal, R.descuentoart Tdesc
				FROM Dbo.ST_FnCalTotalFactura(@idToken, @anticipo) R

			END
	END

	
	

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


