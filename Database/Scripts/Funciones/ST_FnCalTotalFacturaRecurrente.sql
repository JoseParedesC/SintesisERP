--liquibase formatted sql
--changeset ,kmartinez07:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id =
OBJECT_ID(N'[dbo].[ST_FnCalTotalFacturaRecurrente]') and OBJECTPROPERTY(id, N'IsTableFunction') = 1)
DROP FUNCTION [dbo].[ST_FnCalTotalFacturaRecurrente]
GO

CREATE Function  [dbo].[ST_FnCalTotalFacturaRecurrente] (@id_factura bigint)
RETURNS @TblResultante  TABLE ( Id Int Identity (1,1) Not Null, iva NUMERIC(18,2),inc NUMERIC(18,2), 
								precio NUMERIC(18,2), descuentoart NUMERIC(18,2), 
								total NUMERIC(18,2))

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
		@precioart		= 	ISNULL(SUM((FRTT.preciodesc + FRTT.descuentound) * FRTT.cantidad), 0),
		@preciodesc		= 	ISNULL(SUM(FRTT.preciodesc * FRTT.cantidad), 0),
		@ivaart			= 	ISNULL(SUM(FRTT.iva * FRTT.cantidad), 0),
		@inc			= 	ISNULL(SUM(FRTT.inc * FRTT.cantidad), 0),
		@descuentoart	= 	ISNULL(SUM(FRTT.descuento), 0) FROM [dbo].[MOVFacturaRecurrentesItems] FRTT
	    Where FRTT.id_factura = @id_factura	 

	SET @totalfac = (@preciodesc + @ivaart + @inc);

	Insert Into @TblResultante (precio, iva, inc ,descuentoart, total)
	Values	(@precioart, @ivaart, @inc ,@descuentoart, @totalfac);	
	RETURN
End