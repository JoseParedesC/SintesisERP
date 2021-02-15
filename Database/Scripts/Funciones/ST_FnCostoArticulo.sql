--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_FnCostoArticulo]') and OBJECTPROPERTY(id, N'IsTableFunction') = 1)
DROP FUNCTION [dbo].[ST_FnCostoArticulo]
GO


CREATE Function  [dbo].[ST_FnCostoArticulo] (@id_articulo INT, @costo NUMERIC(18,2), @cantidad NUMERIC(18,2), @descuento  NUMERIC(18,2), @porceninc Numeric(4,2), @porcenIva Numeric(4,2), @pordescuento decimal(5,2), @porcenretefuente decimal(4,2),@porcenreteiva decimal(4,2),@porcenreteica decimal(4,2),@retiene BIT)
RETURNS @TblResultante  TABLE (Id Int Identity (1,1) Not Null, costo  NUMERIC(18,2), iva  NUMERIC(18,2),inc NUMERIC(18,2), 
								costototal  NUMERIC(18,2), precio NUMERIC(18,2), descuentound DECIMAL(18,2),retefuente NUMERIC(18,2),reteiva NUMERIC(18,2),reteica NUMERIC(18,2))

--With Encryption 
As
BEGIN
	Declare  @valcosto NUMERIC(18,2),
			 @valiva NUMERIC(18,2),
			 @valinc NUMERIC(18,2),
			 @valretefuente NUMERIC(18,2)=0,
			 @valreteiva NUMERIC(18,2)=0,
			 @valreteica NUMERIC(18,2)=0,
			 @valcostototal NUMERIC(18,2),
			 @iva BIt,
			 @ivaincluido BIT,
			 @inc Bit,
			 @incincludo BIT,
			 @precio NUMERIC(18,2),
			 @descuentound NUMERIC(18,2)

	Select @precio = precio 
	From Dbo.Productos A Where A.id = @id_articulo;
	
	SET @valcosto = @costo;
	
	SET @descuentound = CASE WHEN ISNULL(@pordescuento, 0) = 0 THEN 0 ELSE ROUND(@costo * @pordescuento / 100,2) END
		
	SET @valiva =		CASE WHEN @cantidad != 0 THEN ROUND((@valcosto * @cantidad - @descuento) * (@porceniva / 100) / @cantidad,2) ELSE 0 END;
	
	IF (@retiene != 0) OR EXISTS(SELECT 1 FROM Dbo.Productos WHERE id = @id_articulo AND tipoproducto = [dbo].[ST_FnGetIdList]('SERVICIOS'))
		SELECT @valretefuente = ROUND((@valcosto * @cantidad - @descuento) * (@porcenretefuente / 100) / @cantidad,2),
			   @valreteiva    =	ROUND((@valiva * @cantidad ) * (@porcenreteiva / 100) / @cantidad,2),
			   @valreteica    = ROUND((@valcosto * @cantidad - @descuento) * (@porcenreteica / 100) / @cantidad,2) 

	SET @valcostototal = (@valcosto *  @cantidad - @descuento);
	
	SET @valinc = CASE WHEN @cantidad != 0 THEN ROUND((@valcosto * @cantidad - @descuento)* (@porceninc/100) / @cantidad,2) ELSE 0 END;

	SET @valcostototal =  (@valcostototal + (@valiva * @cantidad) +(@valinc * @cantidad));

	Insert Into @TblResultante (costo, iva, inc,costototal, precio, descuentound,retefuente,reteica,reteiva)
	Values(@valcosto, @valiva,@valinc, @valcostototal, @precio, @descuentound,@valretefuente,@valreteica,@valreteiva);	
	
	RETURN
End