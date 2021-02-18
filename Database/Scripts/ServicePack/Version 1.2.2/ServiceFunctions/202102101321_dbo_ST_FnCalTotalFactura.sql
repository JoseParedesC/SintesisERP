--liquibase formatted sql
--changeset ,JPAREDES:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS a WHERE id = OBJECT_ID(N'[dbo].[ST_FnCalTotalFactura]') and OBJECTPROPERTY(id, N'IsTableFunction') = 1)
DROP FUNCTION [dbo].[ST_FnCalTotalFactura]
GO
CREATE FUNCTION [dbo].[ST_FnCalTotalFactura] (@id_factura varchar(255), @anticipo NUMERIC(18,2))
RETURNS @TblResultante  TABLE ( Id Int Identity (1,1) Not Null, iva NUMERIC(18,2),inc NUMERIC(18,2), 
                                precio NUMERIC(18,2), descuentoart NUMERIC(18,2), 
                                total NUMERIC(18,2), anticipo NUMERIC(18,2), precioobs NUMERIC(18,2), totalfacObs NUMERIC(18,2))
 
--With Encryption 
AS
BEGIN
    DECLARE  @ivaart        NUMERIC(18,2) = 0,
             @inc            NUMERIC(18,2) = 0,
             @descuentoart    NUMERIC(18,2) = 0,
             @precioart        NUMERIC(18,2) = 0,
             @preciodesc    NUMERIC(18,2) = 0,
             @totalfac        NUMERIC(18,2) = 0,
			 @precioobs		NUMERIC(18,2) = 0,
			 @totalfacObs	NUMERIC(18,2) = 0
                 
    SELECT 
        @precioart        =     ISNULL(SUM((preciodes +descuentound) * cantidad), 0),
        @preciodesc        =     ISNULL(SUM(preciodes * cantidad), 0),
        @ivaart            =     ISNULL(SUM(iva * cantidad), 0),
        @inc            =     ISNULL(SUM(inc * cantidad), 0),
        @descuentoart    =     ISNULL(SUM(descuento), 0),
		@precioobs		=	ISNULL(SUM(costo), 0)
    FROM [dbo].[MOVFacturaItemsTemp]
    WHERE id_factura = @id_factura     
 
    SET @totalfac = (@preciodesc + @ivaart + @inc);
	SET @totalfacObs = (@precioobs+@ivaart);
 
    INSERT INTO @TblResultante (precio, iva,inc ,descuentoart, total, anticipo, precioobs, totalfacObs)
    VALUES    (@precioart, @ivaart, @inc ,@descuentoart, (@totalfac - @anticipo), iif(@totalfac>@anticipo,@anticipo,@totalfac), @precioobs, @totalfacObs);	
    RETURN
END