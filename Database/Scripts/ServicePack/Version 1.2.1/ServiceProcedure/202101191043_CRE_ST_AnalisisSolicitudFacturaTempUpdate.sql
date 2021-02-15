--liquibase formatted sql
--changeset ,JPAREDES:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CRE].[ST_AnalisisSolicitudFacturaTempUpdate]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [CRE].[ST_AnalisisSolicitudFacturaTempUpdate]
GO
CREATE PROCEDURE [CRE].[ST_AnalisisSolicitudFacturaTempUpdate]

@id_solicitud BIGINT,
@id_cotizacion BIGINT,
@idToken VARCHAR(255),
@id_user BIGINT

AS


/**********************************************************
*Nombre:		[CRE].[ST_AnalisisSolicitudFacturaTempUppdate]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		18/01/2021
*Desarrollador: JPAREDES
*Descripcion:	INSERTA EN LA TABLA "[MOVFacturaItemsTemp]"
				para luego hacer las respectivas operaciones 
				financieras
*************************************************************/

DECLARE @cont BIGINT =1, @error VARCHAR(MAX);
DECLARE @temp TABLE(id_pk BIGINT IDENTITY,idToken VARCHAR(255), id_articulo BIGINT, id_bodega BIGINT, cantidad NUMERIC, precio NUMERIC, id_user BIGINT)
DECLARE @id_articulo BIGINT, @id_bodega BIGINT, @cantidad NUMERIC, @precio NUMERIC;
DECLARE @token VARCHAR(255) = NULL;

BEGIN TRY

IF NOT EXISTS(SELECT 1 FROM [dbo].[MOVFacturaItemsTemp] T INNER JOIN 
						[dbo].[MOVCotizacionItems] CI ON CI.id_articulo = T.id_articulo INNER JOIN
						[CRE].[Solicitudes]			S ON S.id_cotizacion = CI.id_Cotizacion
							WHERE S.id = @id_solicitud AND CI.id_Cotizacion = @id_cotizacion)
BEGIN
	-- INSERTA EN LA TABLA "[MOVFacturaItemsTemp]" para luego hacer las respectivas operaciones financieras
		INSERT INTO @temp (IDTOKEN, ID_ARTICULO, ID_BODEGA, CANTIDAD, PRECIO, ID_USER)
			SELECT @idToken,
			   CI.id_articulo,
			   CI.id_bodega,
			   CI.cantidad,
			   CI.precio,
			   @id_user
		FROM [dbo].[MOVCotizacion] C
			INNER JOIN [dbo].[MOVCotizacionItems] CI ON CI.id_Cotizacion = C.id
			INNER JOIN [CRE].[Solicitudes] S ON S.id_cotizacion = C.id
			INNER JOIN [dbo].[Productos] Pro ON Pro.id = CI.id_articulo
			LEFT JOIN [FIN].[LineasCreditos] LC ON LC.id = C.lineacredit
			WHERE S.id = @id_solicitud AND C.id = @id_cotizacion 

		WHILE (SELECT id_pk FROM @temp where id_pk = @cont) != 0
			BEGIN
				SELECT @idToken = IDTOKEN, 
					   @id_articulo = ID_ARTICULO, 
					   @id_bodega = ID_BODEGA, 
					   @cantidad = CANTIDAD, 
					   @precio = PRECIO, 
					   @id_user = ID_USER 
				FROM @temp where id_pk = @cont

				EXEC [dbo].[ST_MovCotizacionAddArticulo] @idToken, @id_articulo,@id_bodega, @cantidad, @precio, @id_user 
				SELECT @cont += 1;
			END

END
ELSE
BEGIN
	SET @token = (SELECT TOP 1 T.id_factura FROM [dbo].[MOVFacturaItemsTemp] T INNER JOIN 
						[dbo].[MOVCotizacionItems] CI ON CI.id_articulo = T.id_articulo INNER JOIN
						[CRE].[Solicitudes]			S ON S.id_cotizacion = CI.id_Cotizacion
							WHERE S.id = @id_solicitud AND CI.id_Cotizacion = @id_cotizacion)
END

SELECT iva Tiva, precio Tprecio, descuentoart Tdctoart, 0 Tdesc, total Ttotal 
		FROM Dbo.ST_FnCalTotalFactura(ISNULL(@token,@idToken), 0);

END TRY
BEGIN CATCH
--Getting the error description
	SET @error   =  ERROR_PROCEDURE() + 
					';  ' + CONVERT(VARCHAR,ERROR_LINE()) + 
					'; ' + ERROR_MESSAGE()
	-- save the error in a Log file
	RAISERROR(@error,16,1)
	RETURN
END CATCH