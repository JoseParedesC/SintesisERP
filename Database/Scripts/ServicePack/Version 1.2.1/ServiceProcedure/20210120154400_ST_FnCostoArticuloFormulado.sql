--liquibase formatted sql
--changeset ,CZULBARAN:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_FnCostoArticuloFormulado]') and OBJECTPROPERTY(id, N'IsScalarFunction') = 1)
DROP FUNCTION dbo.ST_FnCostoArticuloFormulado
GO
CREATE FUNCTION  [dbo].[ST_FnCostoArticuloFormulado] (@id_articulo INT, @id_bodega INT)
RETURNS NUMERIC(18,4)
--With Encryption 
As
BEGIN
	Declare  @costo NUMERIC(18,4), @stock bit;

					SELECT @costo = sum (precio * cantidad) from DBO.Productos P INNER JOIN 
					Productos_Formulados PF ON P.id = PF.id_item
					WHERE PF.id_producto = @id_articulo
					--GROUP BY P.precio, P.stock




	IF(ISNULL(@costo, 0) = 0)
	BEGIN
		IF(ISNULL(@stock,0) = 0)
		BEGIN
			SELECT @costo = SUM(costo*F.cantidad) 
			FROM Existencia E
			INNER JOIN Productos_Formulados F ON F.id_item = E.id_articulo AND E.id_bodega = @id_bodega
			WHERE F.id_producto = @id_articulo;
		END
		ELSE
		BEGIN
			SELECT TOP 1 @costo = costo 
			FROM Existencia E WHERE E.id_articulo = @id_articulo AND E.id_bodega = @id_bodega
		END
	END

	RETURN ISNULL(@costo, 0)
End