--liquibase formatted sql
--changeset ,kmartinez:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[FIN].[VW_SaldoCliente_Cuotas]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
Drop View [FIN].[VW_SaldoCliente_Cuotas]
END
GO

CREATE VIEW [FIN].[VW_SaldoCliente_Cuotas]
AS

		SELECT DISTINCT
			P.id,
			P.porcenIva,
			C.tipofactura,
			P.id_saldo,
			P.id_saldo id_factura,
			P.cuota,
			P.vlrcuota,
			P.acapital,
			S.porcentaje,
			P.saldo,
			P.interes,
			P.saldo_anterior,
		    P.fecha_inicial,
			P.abono	,	
			P.vencimiento_cuota,
		    c.id_tercero id_cliente,
			c.prefijo+'-'+CONVERT(VARCHAR,c.consecutivo) factura,
			p.cancelada,
			p.devolucion,
			p.anomes,
			P.numfactura,
			P.CuotaFianza,
			P.AbonoFianza,
			P.InteresCausado,
			P.AbonoInteres,
			P.diasmora,
			P.diasintcorpagados,
			P.AbonoIntMora
		FROM   
			FIN.SaldoCliente_Cuotas	AS P
			INNER JOIN FIN.SaldoCliente S ON S.nrofactura = P.numfactura AND P.id_tercero = S.id_cliente
			LEFT JOIN Dbo.MOVFactura C ON S.id_documento = C.id  
			 
 



GO


