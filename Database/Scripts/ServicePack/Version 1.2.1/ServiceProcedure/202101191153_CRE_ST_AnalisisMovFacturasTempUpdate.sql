--liquibase formatted sql
--changeset ,JPAREDES:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CRE].[ST_AnalisisMovFacturasTempUpdate]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [CRE].[ST_AnalisisMovFacturasTempUpdate]
GO
CREATE PROCEDURE [CRE].[ST_AnalisisMovFacturasTempUpdate]

@id_articulo	BIGINT,
@id_bodega		BIGINT,
@cantidad		NUMERIC,
@precio			NUMERIC,
@idToken		VARCHAR(255),
@id_user		BIGINT,
@id_anticipo BIGINT = 0

AS

/***********************************************************
*Nombre:		[CRE].[ST_AnalisisMovFacturasTempUpdate]
-------------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		16/01/2021
*Desarrollador: JPAREDES
*Descripcion:	Actualiza la ifnromacion del Item que 
				está en la tabla temporal 
				"MOVFacturasItemTemp"
************************************************************/

DECLARE @error VARCHAR(MAX);
DECLARE @temp TABLE(id_factura VARCHAR(255), id_articulo BIGINT,id_bodega BIGINT ,cantidad NUMERIC, precio NUMERIC, descuento NUMERIC, id_iva BIGINT, iva NUMERIC, inc NUMERIC, total NUMERIC, 
id_user BIGINT ,preciodes NUMERIC, poriva NUMERIC)

BEGIN TRY
	
	IF EXISTS(SELECT 1 FROM [dbo].[MOVFacturaItemsTemp] WHERE id_factura = @idToken AND id_articulo = @id_articulo AND id_bodega = @id_bodega)
		--RAISERROR('No se encontró ningun articulo relacionado con la factura',16,1)

		INSERT INTO @temp (id_factura, id_articulo,id_bodega ,cantidad, precio, descuento, id_iva, iva, inc, total, id_user, preciodes, poriva)
	SELECT @idToken, @id_articulo,@id_bodega ,@cantidad, precio, descuento, id_iva, iva, inc, total, @id_user, preciodes, poriva
	FROM Dbo.ST_FnPrecioArticulo (@id_articulo, @precio, @cantidad,0)


	UPDATE [dbo].[MOVFacturaItemsTemp]
		SET	id_factura		= @idToken, 
			id_articulo		= @id_articulo ,
			id_bodega		= @id_bodega ,
			cantidad		= @cantidad, 
			precio			= A.precio, 
			descuento		= A.descuento, 
			id_iva			= A.id_iva, 
			iva				= A.iva, 
			inc				= A.inc, 
			total			= A.total, 
			id_user			= @id_user, 
			costo			= 0, 
			preciodes		= A.preciodes, 
			poriva			= A.poriva,
			serie			= 0,
			lote			= 0,
			pordescuento	= 0,
			porinc			= 0
	FROM @temp A WHERE [dbo].[MOVFacturaItemsTemp].[id_articulo] = @id_articulo AND [dbo].[MOVFacturaItemsTemp].[id_factura] = @idToken

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