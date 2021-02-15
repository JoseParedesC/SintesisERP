--liquibase formatted sql
--changeset ,JPAREDES:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CRE].[ST_AnalisisMovFacturasTempAdd]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [CRE].[ST_AnalisisMovFacturasTempAdd]
GO
CREATE PROCEDURE [CRE].[ST_AnalisisMovFacturasTempAdd]

@id_articulo	BIGINT,
@id_bodega		BIGINT,
@cantidad		NUMERIC,
@precio			NUMERIC,
@idToken		VARCHAR(255),
@id_user		BIGINT,
@id_anticipo BIGINT = 0

AS


/***********************************************************
*Nombre:		[CRE].[ST_AnalisisMovFacturasTempAdd]
-------------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		16/01/2021
*Desarrollador: JPAREDES
*Descripcion:	Inserta la ifnromacion del Item que 
				en la tabla temporal "MOVFacturasItemTemp"
************************************************************/
DECLARE @error VARCHAR(MAX);

BEGIN TRY

	IF EXISTS (SELECT 1 FROM [dbo].[MOVFacturaItemsTemp] WHERE id_factura = @idToken AND id_articulo = @id_articulo AND precio != @precio)
		RAISERROR ('Ya existe un artículo dentro de esta cotización y esta con precio diferente. Verifique.!', 16, 0);

	INSERT INTO [dbo].[MOVFacturaItemsTemp] (id_factura, id_articulo,id_bodega ,cantidad, precio, descuento, id_iva, iva, inc, total, id_user, costo, preciodes, poriva,serie,lote,pordescuento,porinc)
	SELECT @idToken, 
		   @id_articulo,
		   @id_bodega ,
		   @cantidad, 
		   precio, 
		   descuento, 
		   id_iva, 
		   iva, 
		   inc, 
		   total, 
		   @id_user, 
		   0, 
		   preciodes, 
		   poriva,
		   0,
		   0,
		   0,
		   0
	FROM Dbo.ST_FnPrecioArticulo (@id_articulo, @precio, @cantidad,0);

	SELECT iva Tiva, precio Tprecio, descuentoart Tdctoart, 0 Tdesc, total Ttotal 
		FROM Dbo.ST_FnCalTotalFactura(@idToken, @id_anticipo);

END TRY
BEGIN CATCH
	--Getting the error description
	SELECT @error   =  ERROR_PROCEDURE() + 
				';  ' + CONVERT(VARCHAR,ERROR_LINE()) + 
				'; ' + ERROR_MESSAGE()
	-- save the error in a Log file
	RAISERROR(@error,16,1)
	RETURN 
END CATCH