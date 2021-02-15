--liquibase formatted sql
--changeset ,jeteme:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[CNT].[VW_TRANSACIONES_FACTURAS]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
Drop View [CNT].[VW_TRANSACIONES_FACTURAS]
END
GO


CREATE VIEW [CNT].[VW_TRANSACIONES_FACTURAS]
AS
/***************************************
*Nombre:		[CNT].[VW_TRANSACIONES_FACTURAS]
----------------------------------------
*Tipo:			Vista
*creaci�n:		29/01/20
*Desarrollador: (JETEME)
***************************************/ 


SELECT        F.id id, CONVERT(VARCHAR(6),F.fechafac, 112) ANOMES, IIF(F.id_centrocostos=0,null,F.Id_centrocostos) CENTROCOSTO, F.id NRODOCUMENTO, CONCAT(F.prefijo,'-',F.consecutivo) nrofactura, CONVERT(varchar, F.fechafac, 111) FECHADCTO, 
                         C.id CUENTA, F.id_tercero IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO, sum(P.valor - F.cambio) VALOR, FP.nombre FORMAPAGO,0 BASEIMP,0 PORCEIMP, 0 CANTIDAD, 'FV' TIPODOC, 'FORMA DE PAGO EN EFECTIVO' DESCRIPCION, Dbo.ST_FnGetIdList('PROCE') ESTADO,
                         'SOLOPROD' CONDICION,NULL FECHAVENCIMIENTO,0 CIERRE 
FROM        [dbo].[MOVFactura]          AS F                                   INNER JOIN
            [dbo].[MOVFacturaFormaPago] AS P  ON P.id_factura = F.id           INNER JOIN
            [dbo].[FormaPagos]          AS FP ON FP.id        = P.id_formapago INNER JOIN
			[dbo].[CNTCuentas]          AS C  ON C.id         = FP.id_cuenta   
WHERE       F.Estado = Dbo.ST_FnGetIdList('PROCE') AND  FP.id_tipo != dbo.ST_FnGetIdList('CARTERA') AND F.contabilizado=0
GROUP BY  F.id_tercero, F.fechafac, C.id, FP.nombre, F.created, F.id,f.consecutivo,F.id_centrocostos,F.prefijo
UNION
SELECT      F.id id, CONVERT(VARCHAR(6),F.fechafac, 112) ANOMES, IIF(F.id_centrocostos=0,null,F.Id_centrocostos) CENTROCOSTO, F.id NRODOCUMENTO, CONCAT(F.prefijo,'-',F.consecutivo) nrofactura, CONVERT(varchar, F.fechafac, 111) FECHADCTO, 
            C.id CUENTA, F.id_tercero IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO, Cu.valorcuota VALOR, FP.nombre FORMAPAGO,0 BASEIMP,0 PORCEIMP, 0 CANTIDAD, 'FV' TIPODOC, CONCAT ('CUOTA NO.',CU.cuota) DESCRIPCION, Dbo.ST_FnGetIdList('PROCE') ESTADO,
            'SOLOPROD' CONDICION,CU.vencimiento FECHAVENCIMIENTO,0 CIERRE 
FROM        [dbo].[MOVFactura]          AS F INNER JOIN
            [dbo].[MOVFacturaFormaPago] AS P  ON P.id_factura   = F.id            INNER JOIN
			[dbo].[MovFacturaCuotas]    AS CU ON CU.id_factura  = F.id            INNER JOIN
            [dbo].[FormaPagos]          AS FP ON FP.id          = P.id_formapago  INNER JOIN
			[dbo].[CNTCuentas]          AS C  ON C.id           = FP.id_cuenta    
WHERE       F.Estado = Dbo.ST_FnGetIdList('PROCE')  AND FP.id_tipo= dbo.ST_FnGetIdList('CARTERA') AND F.contabilizado=0
UNION
SELECT      F.id id, CONVERT(VARCHAR(6),F.fechafac, 112) ANOMES, IIF(F.id_centrocostos=0,null,F.Id_centrocostos) CENTROCOSTO, F.id NRODOCUMENTO, CONCAT(F.prefijo,'-',F.consecutivo) nrofactura, CONVERT(varchar, F.fechafac, 111) FECHADCTO, 
            L.id_ctacredito  CUENTA, CL.id IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO, Cu.acapital VALOR, 'FINANCIERO' FORMAPAGO,0 BASEIMP,0 PORCEIMP, 0 CANTIDAD, 'FV' TIPODOC, CONCAT ('CUOTA NO.',CU.cuota) DESCRIPCION, Dbo.ST_FnGetIdList('PROCE') ESTADO,
            'SOLOPROD' CONDICION,REPLACE(CU.vencimiento, '-','') FECHAVENCIMIENTO, 0 CIERRE
FROM        [dbo].[MOVFactura]          AS F INNER JOIN
            [dbo].[MovFacturaCuotas]    AS CU ON CU.id_factura  = F.id            INNER JOIN
            [CNT].[Terceros]            AS CL ON CL.id          = F.id_tercero    INNER JOIN
            [FIN].[LineasCreditos]      AS L  ON L.id            = F.PagoFinan      
WHERE       F.Estado = Dbo.ST_FnGetIdList('PROCE')  AND F.contabilizado=0 AND F.iscausacion = 0
UNION
SELECT      F.id id, CONVERT(VARCHAR(6),F.fechafac, 112) ANOMES,IIF(F.id_centrocostos=0,null,F.Id_centrocostos) CENTROCOSTO, F.id NRODOCUMENTO, CONCAT(F.prefijo,'-',F.consecutivo) nrofactura, CONVERT(varchar, F.fechafac, 111) FECHADCTO, 
            C.id CUENTA, F.id_tercero IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO, F.valoranticipo VALOR, '' FORMAPAGO,0 BASEIMP,0 PORCEIMP, 0 CANTIDAD, 'FV' TIPODOC, 'CUENTA DE ANTICIPO' DESCRIPCION,Dbo.ST_FnGetIdList('PROCE') ESTADO, 
            'SOLOPROD' CONDICION,NULL FECHAVENCIMIENTO,0 CIERRE 
FROM        [dbo].[MOVFactura]   AS F                          INNER JOIN  
			[dbo].[CNTCuentas]   AS C  ON C.id  = F.id_ctaant  
WHERE       F.Estado = Dbo.ST_FnGetIdList('PROCE')  AND F.valoranticipo != 0 AND F.contabilizado=0
UNION
SELECT      F.id id, CONVERT(VARCHAR(6),F.fechafac, 112) ANOMES,IIF(F.id_centrocostos=0,null,F.Id_centrocostos) CENTROCOSTO, F.id NRODOCUMENTO, CONCAT(F.prefijo,'-',F.consecutivo) nrofactura, CONVERT(varchar, F.fechafac, 111) FECHADCTO, 
            C.id CUENTA, F.id_tercero IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO, F.dsctoFinanciero VALOR, '' FORMAPAGO,0 BASEIMP,0 PORCEIMP, 0 CANTIDAD, 'FV' TIPODOC, 'CUENTA DE DESCUENTO FINANCIERO' DESCRIPCION,Dbo.ST_FnGetIdList('PROCE') ESTADO, 
            'SOLOPROD' CONDICION,NULL FECHAVENCIMIENTO,0 CIERRE 
FROM        [dbo].[MOVFactura]   AS F                          INNER JOIN  
			[dbo].[CNTCuentas]   AS C  ON C.id  = F.ctadescuento  
WHERE       F.Estado = Dbo.ST_FnGetIdList('PROCE')  AND F.dsctoFinanciero != 0 AND F.contabilizado=0
UNION
SELECT      F.id id, CONVERT(VARCHAR(6),F.fechafac, 112) ANOMES, IIF(F.id_centrocostos=0,null,F.Id_centrocostos) CENTROCOSTO, F.id NRODOCUMENTO, CONCAT(F.prefijo,'-',F.consecutivo) nrofactura, CONVERT(varchar, F.fechafac, 111) FECHADCTO, 
            CN.id CUENTA, F.id_tercero IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO, SUM(FI.iva * FI.cantidad) * - 1 VALOR, '' FORMAPAGO,SUM(preciodesc) BASEIMP,FI.poriva PORCEIMP  ,0 CANTIDAD, 'FV' TIPODOC, 'CUENTA DE IVA' DESCRIPCION,Dbo.ST_FnGetIdList('PROCE') ESTADO, 
            'SOLOPROD' CONDICION,NULL FECHAVENCIMIENTO,0 CIERRE 
FROM        [dbo].[MOVFactura]      AS F                             INNER JOIN
            [dbo].[MOVFacturaItems] AS FI ON F.id   = FI.id_factura  INNER JOIN
			[dbo].[Productos]       AS C  ON C.id   = FI.id_producto INNER JOIN 
			[dbo].[CNTCuentas]      AS CN ON CN.id  = FI.id_ctaiva   INNER JOIN
			[dbo].[ST_Listados]     AS SL ON SL.id  = C.tipoproducto
WHERE       F.Estado = Dbo.ST_FnGetIdList('PROCE') AND  Fi.iva > 0 AND SL.nombre!='SERVICIO' AND F.contabilizado=0
GROUP BY F.id_tercero, CN.id, F.fechafac,  F.created, F.id, f.consecutivo,F.id_centrocostos,F.prefijo,FI.poriva
UNION
SELECT      F.id id, CONVERT(VARCHAR(6),F.fechafac, 112) ANOMES, IIF(F.id_centrocostos=0,null,F.Id_centrocostos) CENTROCOSTO, F.id NRODOCUMENTO, CONCAT(F.prefijo,'-',F.consecutivo) nrofactura, CONVERT(varchar, F.fechafac, 111) FECHADCTO, 
            CN.id CUENTA, F.id_tercero IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO, SUM(FI.inc * FI.cantidad) * - 1 VALOR, '' FORMAPAGO,SUM(preciodesc) BASEIMP,FI.porinc PORCEIMP, 0 CANTIDAD, 'FV' TIPODOC, 'CUENTA DE INC' DESCRIPCION,Dbo.ST_FnGetIdList('PROCE') ESTADO, 
            'SOLOPROD' CONDICION,NULL FECHAVENCIMIENTO,0 CIERRE 
FROM        [dbo].[MOVFactura]      AS F                             INNER JOIN
            [dbo].[MOVFacturaItems] AS FI ON F.id   = FI.id_factura  INNER JOIN
			[dbo].[Productos]       AS C  ON C.id   = FI.id_producto INNER JOIN 
			[dbo].[CNTCuentas]      AS CN ON CN.id  = FI.id_ctainc   INNER JOIN
			[dbo].[ST_Listados]     AS SL ON SL.id  = C.tipoproducto
WHERE       F.Estado = Dbo.ST_FnGetIdList('PROCE') AND  Fi.inc > 0 AND F.contabilizado=0
GROUP BY F.id_tercero, CN.id, F.fechafac,  F.created, F.id, f.consecutivo,F.id_centrocostos,F.prefijo,FI.porinc
UNION
SELECT      F.id id, CONVERT(VARCHAR(6),F.fechafac, 112) ANOMES, IIF(F.id_centrocostos=0,null,F.Id_centrocostos) CENTROCOSTO, F.id NRODOCUMENTO, CONCAT(F.prefijo,'-',F.consecutivo) nrofactura, CONVERT(varchar, F.fechafac, 111) FECHADCTO, 
            B.ctaingreso CUENTA, F.id_tercero IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO,SUM(FI.Preciodesc * cantidad) * - 1 VALOR, '' FORMAPAGO,0 BASEIMP,0 PORCEIMP, 0 CANTIDAD, 'FV' TIPODOC, 'CUENTA DE INGRESOS' DESCRIPCION, Dbo.ST_FnGetIdList('PROCE') ESTADO,
            'SOLOPROD' CONDICION,NULL FECHAVENCIMIENTO,0 CIERRE 
FROM        [dbo].[MOVFactura]    AS F INNER JOIN
            [dbo].Movfacturaitems AS FI ON F.id = FI.id_factura INNER JOIN
            [dbo].[VW_Bodegas]    AS B ON B.id = FI.id_bodega INNER JOIN
			[dbo].[Productos]     AS Z ON Z.id = FI.id_producto INNER JOIN
			[dbo].ST_Listados     AS SL ON SL.id = Z.tipoproducto
WHERE       F.Estado = Dbo.ST_FnGetIdList('PROCE') AND Fi.iva > 0  AND SL.nombre!='SERVICIO' AND F.contabilizado=0
GROUP BY F.id_tercero, F.fechafac, B.ctaingreso, F.created, F.id, f.consecutivo,F.id_centrocostos,F.prefijo
UNION
SELECT      F.id id, CONVERT(VARCHAR(6),F.fechafac, 112) ANOMES,IIF(F.id_centrocostos=0,null,F.Id_centrocostos) CENTROCOSTO, F.id NRODOCUMENTO, CONCAT(F.prefijo,'-',F.consecutivo) nrofactura, CONVERT(varchar, F.fechafac, 111) FECHADCTO, 
            B.ctaingresoexc CUENTA, F.id_tercero IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO,SUM(FI.Preciodesc * cantidad) * - 1 VALOR, '' FORMAPAGO,0 BASEIMP,0 PORCEIMP, 0 CANTIDAD, 'FV' TIPODOC, 'INGRESO ARTICULOS EXCENTOS' DESCRIPCION,Dbo.ST_FnGetIdList('PROCE') ESTADO, 
            'SOLOPROD' CONDICION,NULL FECHAVENCIMIENTO,0 CIERRE 
FROM        [dbo].[MOVFactura]      AS F                              INNER JOIN
            [dbo].[MOVFacturaItems] AS FI ON F.id   = FI.id_factura   INNER JOIN
            [dbo].[VW_Bodegas]      AS B  ON B.id   = FI.id_bodega    INNER JOIN
			[dbo].[Productos]       AS Z  ON Z.id   = FI.id_producto  INNER JOIN
			[dbo].[ST_Listados]     AS SL ON SL.id  = Z.tipoproducto
WHERE       F.Estado = Dbo.ST_FnGetIdList('PROCE') AND Fi.iva = 0 AND SL.nombre!='SERVICIO' AND F.contabilizado=0
GROUP BY F.id_tercero, F.fechafac, B.ctaingresoexc, F.created, F.id, F.consecutivo,F.id_centrocostos,F.prefijo
UNION
SELECT      F.id id, CONVERT(VARCHAR(6),F.fechafac, 112) ANOMES, IIF(F.id_centrocostos=0,null,F.Id_centrocostos) CENTROCOSTO, F.id NRODOCUMENTO, CONCAT(F.prefijo,'-',F.consecutivo) nrofactura, CONVERT(varchar, F.fechafac, 111) FECHADCTO, 
            C.id CUENTA, F.id_tercero IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO,SUM(FI.preciodesc*FI.cantidad) * - 1 VALOR, '' FORMAPAGO,0 BASEIMP,0 PORCEIMP ,0 CANTIDAD, 'FV' TIPODOC, 'CUENTA DE INGRESOS DE '+Z.nombre DESCRIPCION,Dbo.ST_FnGetIdList('PROCE') ESTADO, 
            'SOLOPROD' CONDICION,NULL FECHAVENCIMIENTO,0 CIERRE   
FROM        [dbo].[MOVFactura]      AS F                               INNER JOIN
            [dbo].[Movfacturaitems] AS FI ON F.id   = FI.id_factura    INNER JOIN
			[dbo].[Productos]       AS Z  ON Z.id   = FI.id_producto   INNER JOIN
			[dbo].[CNTCuentas]      AS C  ON C.id   = Z.id_ctacontable 
WHERE       F.Estado = Dbo.ST_FnGetIdList('PROCE') AND F.contabilizado=0
GROUP BY F.id_tercero, F.fechafac, C.id, F.created, F.id,f.consecutivo,z.nombre,F.id_centrocostos,F.prefijo
UNION
SELECT      F.id id, CONVERT(VARCHAR(6),F.fechafac, 112) ANOMES, IIF(F.id_centrocostos=0,null,F.Id_centrocostos) CENTROCOSTO, F.id NRODOCUMENTO, CONCAT(F.prefijo,'-',F.consecutivo) nrofactura, CONVERT(varchar, F.fechafac, 111) FECHADCTO, 
            C.id CUENTA, F.id_tercero IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO,SUM(FI.iva*FI.cantidad) * - 1 VALOR, '' FORMAPAGO,SUM(preciodesc) BASEIMP,FI.poriva PORCEIMP, 0 CANTIDAD, 'FV' TIPODOC, 'CUENTA DE IVA DE '+Z.nombre DESCRIPCION,Dbo.ST_FnGetIdList('PROCE') ESTADO, 
            'SOLOPROD' CONDICION,NULL FECHAVENCIMIENTO,0 CIERRE 
FROM        [dbo].[MOVFactura]      AS F                            INNER JOIN
            [dbo].[MOVFacturaItems] AS FI ON F.id  = FI.id_factura  INNER JOIN
			[dbo].[Productos]       AS Z  ON Z.id  = FI.id_producto INNER JOIN
			[dbo].[CNTCuentas]      AS C  ON C.id  = FI.id_ctaiva    INNER JOIN
			[dbo].[ST_Listados]     AS SL ON SL.id = Z.tipoproducto
WHERE       F.Estado = Dbo.ST_FnGetIdList('PROCE') AND Fi.iva > 0 AND SL.nombre = 'SERVICIO' AND F.contabilizado=0
GROUP BY F.id_tercero, F.fechafac, C.id, F.created, F.id,f.consecutivo,z.nombre,F.id_centrocostos,F.prefijo,fi.poriva
UNION
SELECT      F.id id, CONVERT(VARCHAR(6),F.fechafac, 112) ANOMES, IIF(F.id_centrocostos=0,null,F.Id_centrocostos) CENTROCOSTO, F.id NRODOCUMENTO, CONCAT(F.prefijo,'-',F.consecutivo) nrofactura, CONVERT(varchar, F.fechafac, 111) FECHADCTO, 
            B.ctainven CUENTA, F.id_tercero IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO,SUM(FI.costo * FI.cantidad) * - 1 valor, '' FORMAPAGO,0 BASEIMP,0 PORCEIMP ,0 CANTIDAD, 'FV' TIPODOC, 'CUENTA DE INVENTARIO' DESCRIPCION,Dbo.ST_FnGetIdList('PROCE') ESTADO,
            'SOLOPROD' CONDICION,NULL FECHAVENCIMIENTO,0 CIERRE 
FROM        [dbo].[MOVFacturaItems] AS FI                                    INNER JOIN
            [dbo].[MovFactura]      AS F   ON FI.id_factura = F.id           INNER JOIN
            [dbo].[VW_Bodegas]      AS B   ON B.id          = FI.id_bodega   INNER JOIN
			[dbo].[Productos]       AS Z   ON Z.id          = FI.id_producto INNER JOIN
			[dbo].[ST_Listados]     AS SL  ON SL.id         = Z.tipoproducto
WHERE       F.Estado = Dbo.ST_FnGetIdList('PROCE') AND SL.nombre != 'SERVICIO' and z.inventario = 1 AND F.contabilizado=0
GROUP BY F.id_tercero, F.fechafac, B.ctainven, F.created, F.id,f.consecutivo,F.id_centrocostos,F.prefijo
UNION
SELECT      F.id id, CONVERT(VARCHAR(6),F.fechafac, 112) ANOMES, IIF(F.id_centrocostos=0,null,F.Id_centrocostos) CENTROCOSTO, F.id NRODOCUMENTO, CONCAT(F.prefijo,'-',F.consecutivo) nrofactura, CONVERT(varchar, F.fechafac, 111) FECHADCTO, 
            B.ctacosto CUENTA, F.id_tercero IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO,SUM(FI.costo * FI.cantidad) valor, '' FORMAPAGO,0 BASEIMP,0 PORCEIMP, 0 CANTIDAD, 'FV' TIPODOC, 'CUENTA DE COSTOS DE VENTA' DESCRIPCION, Dbo.ST_FnGetIdList('PROCE') ESTADO,
            'SOLOPROD' CONDICION,NULL FECHAVENCIMIENTO,0 CIERRE 
FROM        [dbo].[MOVFacturaItems]  AS FI                                    INNER JOIN
            [dbo].[MovFactura]       AS F   ON FI.id_factura = F.id           INNER JOIN
            [dbo].[VW_Bodegas]       AS B   ON B.id          = FI.id_bodega   INNER JOIN
			[dbo].[Productos]        AS Z   ON Z.id          = FI.id_producto INNER JOIN
			[dbo].[ST_Listados]      AS SL  ON SL.id         = Z.tipoproducto
WHERE       F.Estado = Dbo.ST_FnGetIdList('PROCE') AND  SL.nombre != 'SERVICIO' AND Z.inventario=1 AND F.contabilizado=0
GROUP BY F.id_tercero, F.fechafac, B.ctacosto, F.created, F.id,f.consecutivo,F.id_centrocostos,F.prefijo

UNION ALL 

SELECT id,	ANOMES,	CENTROCOSTO,	NRODOCUMENTO,	nrofactura,	FECHADCTO,	CUENTA, IDEN_TERCERO, CODPRODUCTO, PRESENPRODUCTO,	NOMPRODUCTO,	VALOR,	FORMAPAGO,	BASEIMP,	PORCEIMP,	CANTIDAD,	TIPODOC,	DESCRIPCION,	ESTADO,	'SOLOPROD' CONDICION, FECHAVENCIMIENTO,	CIERRE
FROM CNT.VW_TRANSACCIONES_MOVCAUSACION


GO
