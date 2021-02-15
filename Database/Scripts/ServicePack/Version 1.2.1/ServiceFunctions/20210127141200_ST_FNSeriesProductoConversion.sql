--liquibase formatted sql
--changeset ,CZULBARAN:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_FNSeriesProductoConversion]') and OBJECTPROPERTY(id, N'IsScalarFunction') = 1)
DROP FUNCTION dbo.ST_FNSeriesProductoConversion
GO
CREATE FUNCTION [dbo].[ST_FNSeriesProductoConversion]
(
  @id_item BIGINT,
  @op char(1)
)
RETURNS NVARCHAR(MAX)
AS 
BEGIN
  DECLARE @str NVARCHAR(MAX);
	
	IF(@op='T')
	SELECT @str = COALESCE(@str + '', '') + '<option value="'+S.serie+'" '+CASE WHEN SR.id IS NULL THEN '' ELSE 'selected="true"' END + '>'+S.serie+'</option>'	
	FROM ExistenciaLoteSerie S
	INNER JOIN Existencia E ON E.id = S.id_existencia
	LEFT JOIN MOVFacturaItemsTemp T ON E.id_bodega = T.id_bodega AND T.id_articulo = E.id_articulo
	LEFT JOIN MovFacturaSeriesTemp SR ON SR.id_itemstemp = T.id AND SR.id_facturatemp = T.id_factura AND S.serie = SR.serie
	WHERE T.id = @id_item AND S.existencia > 0
	ELSE
	SELECT @str = COALESCE(@str + '', '') + '<option value="'+SR.serie+'" '+CASE WHEN SR.id IS NULL THEN '' ELSE 'selected="true"' END + '>'+SR.serie+'</option>'	
	FROM 
	  MOVConversionesItemsForm T LEFT JOIN MOVConversionesItemsSeriesForm SR ON SR.id_producto = T.id AND SR.id_conversion = T.id_conversion AND T.serie=1
	WHERE T.id = @id_item  
  RETURN (@str);
END
