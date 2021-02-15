--liquibase formatted sql
--changeset ,JPAREDES:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CRE].[ST_Analisis_RemoveItem_MOVCotizacion]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [CRE].[ST_Analisis_RemoveItem_MOVCotizacion]
GO
CREATE PROCEDURE [CRE].[ST_Analisis_RemoveItem_MOVCotizacion]

@id_solicitud BIGINT,
@id_cotizacion BIGINT,
@id_articulo BIGINT,
@idToken VARCHAR(255),
@id_anticipo BIGINT = 0

AS

/***************************************************
*Nombre:		[CRE].[ST_Analisis_RemoveItem_MOVCotizacion]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		16/01/2021
*Desarrollador: JPAREDES
*Descripcion:	Elimina el Producto de la tabla 
				MOVCotizacion y MOVCotizacionItem
****************************************************/

DECLARE @error VARCHAR(MAX)

BEGIN TRY
	

	BEGIN

		DECLARE @token VARCHAR(255) = (SELECT T.id_factura FROM [dbo].[MOVFacturaItemsTemp] T INNER JOIN 
						[dbo].[MOVCotizacionItems] CI ON CI.id_articulo = T.id_articulo INNER JOIN
						[CRE].[Solicitudes]			S ON S.id_cotizacion = CI.id
							WHERE S.id = @id_solicitud AND CI.id_Cotizacion = @id_cotizacion)

		--DELETE [dbo].MOVFacturaLotesTemp WHERE id_itemtemp = @id_articulo AND id_factura = @idToken;
		--DELETE [dbo].MovFacturaSeriesTemp WHERE id_itemstemp = @id_articulo AND id_facturatemp = @idToken;
		DELETE [dbo].[MOVFacturaItemsTemp] WHERE id_articulo = @id_articulo AND id_factura = @idToken

		SELECT iva Tiva, precio Tprecio, descuentoart Tdctoart, 0 Tdesc, total Ttotal 
		FROM Dbo.ST_FnCalTotalFactura(@idToken, @id_anticipo);

	--DELETE FROM [dbo].[MOVFacturaItemsTemp] WHERE id_articulo = @id_articulo AND id_factura = @idToken
	END

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