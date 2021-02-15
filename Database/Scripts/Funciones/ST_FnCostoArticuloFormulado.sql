--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_FnCostoArticuloFormulado]') and OBJECTPROPERTY(id, N'IsScalarFunction') = 1)
DROP FUNCTION [dbo].[ST_FnCostoArticuloFormulado]
GO
CREATE Function  [dbo].[ST_FnCostoArticuloFormulado] (@id_articulo INT, @id_bodega INT)
RETURNS NUMERIC(18,4)
--With Encryption 
As
BEGIN
	Declare  @costo NUMERIC(18,4), @stock bit;

	SELECT @stock = stock, @costo = costoestandar FROM Productos WHERE id = @id_articulo;

	IF(ISNULL(@costo, 0) = 0)
	BEGIN
		IF(ISNULL(@stock,0) = 0)
		BEGIN
			SELECT @costo = SUM(costo*F.cantidad) 
			FROM Existencia E
			INNER JOIN ArticulosFormula F ON F.id_articulo = E.id_articulo AND E.id_bodega = @id_bodega
			WHERE F.id_articuloformu = @id_articulo;
		END
		ELSE
		BEGIN
			SELECT TOP 1 @costo = costo 
			FROM Existencia E WHERE E.id_articulo = @id_articulo AND E.id_bodega = @id_bodega
		END
	END

	RETURN ISNULL(@costo, 0)
End

GO


