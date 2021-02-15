--liquibase formatted sql
--changeset ,jeteme:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[dbo].[VW_MOVFacturaCuotas]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
	Drop View [dbo].[VW_MOVFacturaCuotas]
END
GO
CREATE VIEW [dbo].[VW_MOVFacturaCuotas]
AS
		SELECT 
			P.id,
			P.id_factura,
			P.cuota,
			P.valorcuota,	
			P.vencimiento,
		    c.id_tercero id_cliente,
			c.prefijo+'-'+CONVERT(VARCHAR,c.consecutivo) factura
		FROM   
			dbo.MovFacturaCuotas	AS P
		INNER JOIN Dbo.MOVFactura C ON P.id_factura = C.id

GO


