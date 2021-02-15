--liquibase formatted sql
--changeset ,jteheran:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_FnPrecioArticulo]') and OBJECTPROPERTY(id, N'IsTableFunction') = 1)
DROP FUNCTION [dbo].[ST_FnPrecioArticulo]
GO

CREATE Function  [dbo].[ST_FnPrecioArticulo] (@id_articulo INT, @precio NUMERIC(18,2), @cantidad NUMERIC(18,2), @descuento NUMERIC(18,2))
RETURNS @TblResultante  TABLE (Id Int Identity (1,1) Not Null, 
								precio		NUMERIC(18,2), 
								preciodes	NUMERIC(18,2), 
								poriva		NUMERIC(5,2),
								iva			NUMERIC(18,2), 
								porinc		NUMERIC(5,2),
								inc			NUMERIC(18,2),
								descuentound NUMERIC(18,2),
								descuento	NUMERIC(18,2), 
								total		NUMERIC(18,2), 
								formulado	BIT,
								id_iva		BIGINT,
								id_inc		BIGINT)
--With Encryption 
As
BEGIN
	Declare  @valprecio		NUMERIC(18,2),
			 @valpreciodes	NUMERIC(18,2),
			 @valinc		NUMERIC(18,2),
			 @valiva		NUMERIC(18,2),	
			 @valpreciototal NUMERIC(18,2),
			 @poriva		NUMERIC(5,2),
			 @ivaincluido	BIT,
			 @incincluido	BIT,
			 @porcendsc   	FLOAT,
			 @porinc		NUMERIC(5,2),
			 @costo			NUMERIC(18,2),
			 @formulado		BIT,
			 @id_inc		BIGINT,
			 @id_iva		BIGINT;

	SELECT TOP 1 @poriva	= poriva, 
			@ivaincluido	= ivaincluido, 
			@porinc			= porinc, 
			@formulado		= formulado,
			@id_iva			= id_iva,
			@id_inc			= id_inc
	FROM Dbo.VW_Productos A WHERE A.id = @id_articulo;
	
	SET @valprecio = CASE WHEN @ivaincluido = 0
						 THEN @precio 
						 Else ROUND(@precio / (1 + (@poriva / 100)),2) End;

	SET @porcendsc  = CASE WHEN @precio = 0 THEN @precio ELSE ((@descuento/@cantidad)* 100)/@precio END
	--SET @descuento  = ROUND((@valprecio * @porcendsc / 100),2);
	SET @valprecio = (@valprecio - @descuento);

	SET @valiva = ROUND((@valprecio * @poriva / 100),2);
	SET @valinc = ROUND((@valprecio * @porinc / 100),2);

	IF ((@valprecio + @valiva) <> @precio AND @ivaincluido = 1 AND @porcendsc = 0 AND @poriva > 0)
	BEGIN
		SET @valiva = @precio - @valprecio;
	END

	Insert Into @TblResultante (precio, preciodes, poriva, iva, porinc, inc, descuentound, descuento, total, formulado, id_iva, id_inc)
	Values(@precio, @valprecio, @poriva, @valiva, @porinc, @valinc, @descuento, (@descuento * @cantidad), ((@valprecio + @valiva + @valinc) * @cantidad), @formulado, @id_iva, @id_inc);	
	
	RETURN
End