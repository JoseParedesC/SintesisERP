--liquibase formatted sql
--changeset ,jteheran:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_FnCalTotalFactura]') and OBJECTPROPERTY(id, N'IsTableFunction') = 1)
DROP FUNCTION [dbo].[ST_FnCalTotalFactura]
GO


CREATE Function  [dbo].[ST_FnCalTotalFactura] (@id_factura varchar(255), @anticipo NUMERIC(18,2))
RETURNS @TblResultante  TABLE ( Id Int Identity (1,1) Not Null, iva NUMERIC(18,2),inc NUMERIC(18,2), 
								precio NUMERIC(18,2), descuentoart NUMERIC(18,2), 
								total NUMERIC(18,2), anticipo NUMERIC(18,2))

--With Encryption 
As
BEGIN
	Declare  @ivaart		NUMERIC(18,2) = 0,
			 @inc			NUMERIC(18,2) = 0,
			 @descuentoart	NUMERIC(18,2) = 0,
			 @precioart		NUMERIC(18,2) = 0,
			 @preciodesc	NUMERIC(18,2) = 0,
			 @totalfac		NUMERIC(18,2) = 0;
			 	
	Select 
		@precioart		= 	ISNULL(SUM((preciodes +descuentound) * cantidad), 0),
		@preciodesc		= 	ISNULL(SUM(preciodes * cantidad), 0),
		@ivaart			= 	ISNULL(SUM(iva * cantidad), 0),
		@inc			= 	ISNULL(SUM(inc * cantidad), 0),
		@descuentoart	= 	ISNULL(SUM(descuento), 0)
	FROM [dbo].[MOVFacturaItemsTemp]
	Where id_factura = @id_factura	 

	SET @totalfac = (@preciodesc + @ivaart + @inc);

	Insert Into @TblResultante (precio, iva,inc ,descuentoart, total, anticipo)
	Values	(@precioart, @ivaart, @inc ,@descuentoart, (@totalfac - @anticipo), iif(@totalfac>@anticipo,@anticipo,@totalfac));	
	RETURN
End
