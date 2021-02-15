--liquibase formatted sql
--changeset ,JPAREDES:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CRE].[ST_AnalisisSolicitudCreditoList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [CRE].[ST_AnalisisSolicitudCreditoList]
GO
CREATE PROCEDURE [CRE].[ST_AnalisisSolicitudCreditoList]

@id_solicitud BIGINT,
@id_cotizacion BIGINT,
@page BIGINT,
@numpage BIGINT,
@filter VARCHAR(50),
@countpage BIGINT OUTPUT,
@idToken VARCHAR(255) = NULL

AS

/**********************************************************
*Nombre:		[CRE].[ST_AnalisisSolicitudCreditoList]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		14/01/2021
*Desarrollador: JPAREDES
*Descripcion:	Lista los productos que estén 
				asociados a la solicitud del credito
*************************************************************/

DECLARE @error VARCHAR(MAX), @starpage INT = 1, @endpage INT = 1;
DECLARE @cont BIGINT =1;
DECLARE @temp TABLE(id_pk BIGINT IDENTITY,idToken VARCHAR(255), id_articulo BIGINT, id_bodega BIGINT, cantidad NUMERIC, precio NUMERIC, id_user BIGINT)
DECLARE @id_articulo BIGINT, @id_bodega BIGINT, @cantidad NUMERIC, @precio NUMERIC;

BEGIN TRY

	SET @starpage = (@page * @numpage) - @numpage +1;
	SET @endpage = @numpage * @page;

	DECLARE @token VARCHAR(255) = (SELECT TOP 1 T.id_factura FROM [dbo].[MOVFacturaItemsTemp] T INNER JOIN 
						[dbo].[MOVCotizacionItems] CI ON CI.id_articulo = T.id_articulo INNER JOIN
						[CRE].[Solicitudes]			S ON S.id_cotizacion = CI.id_Cotizacion
							WHERE S.id = @id_solicitud AND CI.id_Cotizacion = @id_cotizacion)

	BEGIN
		-- LISTA LA INROMACION QUE SE GUARDÓ EN LA TABLA "[MOVFacturaItemsTemp]"
		SELECT P.id id_producto,
			   P.codigo,
			   P.nombre,
			   T.cantidad,
			   T.precio,
			   T.iva,
			   T.inc,
			   T.descuento,
			   T.total,
			   T.id_bodega,
			   T.id_factura
		FROM [dbo].[MOVFacturaItemsTemp] T INNER JOIN 
			 [dbo].[Productos] P ON P.id = T.id_articulo
		WHERE T.id_factura = ISNULL(@token,@idToken)

		END
		
		SET @countpage = @@ROWCOUNT;

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

