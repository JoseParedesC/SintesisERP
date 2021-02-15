--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_FnCalDevTotalFactura]') and OBJECTPROPERTY(id, N'IsTableFunction') = 1)
DROP FUNCTION [dbo].[ST_FnCalDevTotalFactura]
GO




CREATE Function  [dbo].[ST_FnCalDevTotalFactura] (@id_factura varchar(255), @id_anticipo BIGINT)
RETURNS @TblResultante  TABLE ( Id Int Identity (1,1) Not Null, iva NUMERIC(18,2),inc NUMERIC(18,2), 
								precio NUMERIC(18,2), descuentoart NUMERIC(18,2), 
								total NUMERIC(18,2), anticipo NUMERIC(18,2))

--With Encryption 
As
BEGIN
	Declare  @ivaart		NUMERIC(18,2) = 0,
			 @descuentoart	NUMERIC(18,2) = 0,
			 @precioart		NUMERIC(18,2) = 0,
			 @ivacon		NUMERIC(18,2) = 0,
			 @valorcon		NUMERIC(18,2) = 0,
			 @valordesc		NUMERIC(18,2) = 0,
			 @preciodesc	NUMERIC(18,2) = 0,
			 @valanticipo	NUMERIC(18,2) = 0,
			 @totalfac		NUMERIC(18,2) = 0,
			 @inc			NUMERIC(18,2) =0;
			 
	--SET @valanticipo = ISNULL((SELECT saldoActual FROM Dbo.MOVAnticiposTotales WHERE id = @id_anticipo), 0);
	Select 
		@precioart		= ISNULL(SUM(precio * cantidadDev), 0),
		@preciodesc		= ISNULL(SUM(preciodes * cantidadDev), 0),
		@ivaart			= ISNULL(SUM(iva * cantidadDev), 0),
		@inc			= ISNULL(SUM(inc * cantidadDev), 0),
		@descuentoart	= ISNULL(SUM(descuento), 0)
	FROM [dbo].[MOVFacturaItemsTemp]
	Where id_factura = @id_factura and selected=1;


	SET @totalfac = (@preciodesc+@valordesc) + (@ivaart+@ivacon+@inc);
	--SET @valanticipo = CASE WHEN @totalfac <= 0				THEN 0 
	--						WHEN @totalfac < @valanticipo	THEN @totalfac
	--						ELSE @valanticipo				END;

	Insert Into @TblResultante (precio, iva , inc,descuentoart, total, anticipo)
	Values	(@precioart+@valorcon, @ivaart+@ivacon,@inc, @descuentoart, (@totalfac - @valanticipo), @valanticipo);	
	RETURN
End
GO


