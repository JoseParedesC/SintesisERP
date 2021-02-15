--liquibase formatted sql
--changeset ,JTOUS:3 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
IF exists (select 1 from dbo.sysobjects where id = object_id(N'[CNT].[VW_TRANSACCIONES_MOVCAUSACION]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
	DROP VIEW [CNT].VW_TRANSACCIONES_MOVCAUSACION
END
GO

CREATE  VIEW [CNT].VW_TRANSACCIONES_MOVCAUSACION
AS
/***************************************
*Nombre:		[CNT].[VW_TRANSACCIONES_MOVCAUSACION]
----------------------------------------
*Tipo:			Vista
*creacion:		12/01/2021
*Desarrollador: (JTOUS)
jtous: Vista de contabilizacion de factura de causacion de intereses.
***************************************/ 
SELECT F.id id, 
       CONVERT(VARCHAR(6), F.fechafac, 112) ANOMES, iIf(F.id_centrocostos=0,null,F.Id_centrocostos) CENTROCOSTO, F.id NRODOCUMENTO, F.nrofactura, CONVERT(varchar, F.fechafac, 111) FECHADCTO, F.id_ctafin CUENTA,
       CL.id IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, ISNULL(I.descripcion, 'PAGO INTERESES') NOMPRODUCTO, F.total  VALOR, '' FORMAPAGO, F.subtotal BASEIMP, I.poriva PORCEIMP, 0 CANTIDAD, 'FC' TIPODOC, ISNULL(I.descripcion, 'PAGO INTERESES') DESCRIPCION, Dbo.ST_FnGetIdList('PROCE') ESTADO, '' FECHAVENCIMIENTO,0 CIERRE 
FROM		[dbo].[MOVFactura] F INNER JOIN			
			DBO.MOVFacturaItems I ON i.id_factura = F.id INNER JOIN
			[CNT].[Terceros]            AS CL ON CL.id        = F.id_tercero			
WHERE       F.Estado = Dbo.ST_FnGetIdList('PROCE')  AND F.contabilizado = 0  AND F.iscausacion != 0
UNION ALL
SELECT F.id id, 
       CONVERT(VARCHAR(6), F.fechafac, 112) ANOMES, iIf(F.id_centrocostos=0,null,F.Id_centrocostos) CENTROCOSTO, F.id NRODOCUMENTO, F.nrofactura, CONVERT(varchar, F.fechafac, 111) FECHADCTO, L.id_ctaintcorriente CUENTA,
       CL.id IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, 'INTERESES CORRIENTES' NOMPRODUCTO, F.subtotal *-1  VALOR, '' FORMAPAGO, 0 BASEIMP, 0 PORCEIMP, 0 CANTIDAD, 'FC' TIPODOC, 'INTERESES CORRIENTES' DESCRIPCION, Dbo.ST_FnGetIdList('PROCE') ESTADO, '' FECHAVENCIMIENTO,0 CIERRE 
FROM		[dbo].[MOVFactura] F INNER JOIN
			DBO.MOVFacturaItems I ON i.id_factura = F.id INNER JOIN
			[CNT].[Terceros]            AS CL ON CL.id        = F.id_tercero	
			LEFT JOIN FIN.LineasCreditos L ON L.id = F.PagoFinan
WHERE       F.Estado = Dbo.ST_FnGetIdList('PROCE')  AND F.contabilizado = 0 AND F.iscausacion != 0

UNION ALL
SELECT F.id id, 
       CONVERT(VARCHAR(6), F.fechafac, 112) ANOMES, iIf(F.id_centrocostos=0,null,F.Id_centrocostos) CENTROCOSTO, F.id NRODOCUMENTO, F.nrofactura, CONVERT(varchar, F.fechafac, 111) FECHADCTO, I.id_ctaiva CUENTA,
       CL.id IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, 'IVA - INTERESES CORRIENTES' NOMPRODUCTO, F.iva *-1  VALOR, '' FORMAPAGO, 0 BASEIMP, I.poriva PORCEIMP, 0 CANTIDAD, 'FC' TIPODOC, 'IVA - INTERESES CORRIENTES' DESCRIPCION, Dbo.ST_FnGetIdList('PROCE') ESTADO, '' FECHAVENCIMIENTO,0 CIERRE
FROM		[dbo].[MOVFactura] F INNER JOIN
			DBO.MOVFacturaItems I ON i.id_factura = F.id INNER JOIN
			[CNT].[Terceros]            AS CL ON CL.id        = F.id_tercero			
WHERE       F.Estado = Dbo.ST_FnGetIdList('PROCE')  AND F.contabilizado = 0 AND F.iscausacion != 0

GO