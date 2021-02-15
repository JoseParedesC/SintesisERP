--liquibase formatted sql
--changeset ,jeteme:4 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[CNT].[VW_TRANSACIONES_DEVFACTURAS]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
Drop View [CNT].[VW_TRANSACIONES_DEVFACTURAS]
END
GO




CREATE VIEW [CNT].[VW_TRANSACIONES_DEVFACTURAS]
AS
/***************************************
*Nombre:		[CNT].[VW_TRANSACIONES_FACTURAS]
----------------------------------------
*Tipo:			Vista
*creaci�n:		29/01/20
*Desarrollador: (JETEME)
***************************************/ 
SELECT        DF.id id, CONVERT(VARCHAR(6), DF.fecha, 112) ANOMES, IIF(DF.id_centrocostos=0,null,DF.Id_centrocostos) CENTROCOSTO, DF.id NRODOCUMENTO, CONCAT(F.prefijo,'-',F.consecutivo) nrofactura, CONVERT(varchar, DF.fecha, 111) FECHADCTO, 
                         C.id CUENTA, CL.id IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO, dbo.FnVlrDescFP(DF.id_factura,FP.id,(DF.total-DF.valoranticipo-DF.dsctofinanciero))*-1 VALOR, FP.nombre FORMAPAGO,0 BASEIMP,0 PORCEIMP, 0 CANTIDAD, 'DF' TIPODOC, 'FORMA DE PAGO EN EFECTIVO' DESCRIPCION, Dbo.ST_FnGetIdList('PROCE') ESTADO,
                         'SOLOPROD' CONDICION,NULL FECHAVENCIMIENTO,0 CIERRE 
FROM        [dbo].[MOVDevFactura]   AS DF                                  INNER JOIN	
	        [dbo].[MOVFactura]          AS F  ON DF.id_factura= F.id           INNER JOIN
            [dbo].[MOVFacturaFormaPago] AS P  ON P.id_factura = F.id           INNER JOIN
            [CNT].[Terceros]            AS CL ON CL.id        = F.id_tercero   INNER JOIN
            [dbo].[FormaPagos]          AS FP ON FP.id        = P.id_formapago INNER JOIN
			[dbo].[CNTCuentas]          AS C  ON C.id         = FP.id_cuenta   INNER JOIN
			[dbo].[ST_Listados]         AS S  ON S.id         = F.estado
WHERE       DF.estado = dbo.ST_FnGetIdList('PROCE') AND FP.nombre = 'Efectivo' AND dbo.FnVlrDescFP(DF.id_factura,FP.id,(DF.total-DF.valoranticipo-DF.dsctofinanciero)) IS NOT NULL and DF.contabilizado=0
GROUP BY  CL.id, DF.fecha, C.id, FP.nombre, F.created, DF.id,f.consecutivo,DF.id_centrocostos,DF.total,DF.id_factura,FP.id,DF.valoranticipo,F.prefijo,DF.dsctofinanciero
UNION
 SELECT        DF.id id, CONVERT(VARCHAR(6), DF.fecha, 112) ANOMES, IIF(DF.id_centrocostos=0,null,DF.Id_centrocostos) CENTROCOSTO, DF.id NRODOCUMENTO, CONCAT(F.prefijo,'-',F.consecutivo) nrofactura, CONVERT(varchar, DF.fecha, 111) FECHADCTO, 
                         C.id CUENTA, CL.id IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO, dbo.FnVlrDescFP(DF.id_factura,FP.id,(DF.total-DF.valoranticipo-DF.dsctofinanciero))*-1 VALOR, FP.nombre FORMAPAGO,0 BASEIMP,0 PORCEIMP, 0 CANTIDAD, 'DF' TIPODOC, CONCAT('FORMA DE PAGO ',FP.nombre) DESCRIPCION, Dbo.ST_FnGetIdList('PROCE') ESTADO,
                         'SOLOPROD' CONDICION,NULL FECHAVENCIMIENTO,0 CIERRE 
FROM        [dbo].[MOVDevFactura]   AS DF                                  INNER JOIN	
	        [dbo].[MOVFactura]          AS F  ON DF.id_factura= F.id           INNER JOIN
            [dbo].[MOVFacturaFormaPago] AS P  ON P.id_factura = F.id           INNER JOIN
            [CNT].[Terceros]            AS CL ON CL.id        = F.id_tercero   INNER JOIN
            [dbo].[FormaPagos]          AS FP ON FP.id        = P.id_formapago INNER JOIN
			[dbo].[CNTCuentas]          AS C  ON C.id         = FP.id_cuenta   INNER JOIN
			[dbo].[ST_Listados]         AS S  ON S.id         = F.estado
WHERE       DF.estado = dbo.ST_FnGetIdList('PROCE') AND FP.nombre != 'Efectivo' AND FP.id_tipo != dbo.ST_FnGetIdList('CARTERA')  AND dbo.FnVlrDescFP(DF.id_factura,FP.id,(DF.total-DF.valoranticipo-DF.dsctofinanciero)) IS NOT NULL  and DF.contabilizado=0
GROUP BY  CL.id, DF.fecha, C.id, FP.nombre, F.created, DF.id,f.consecutivo,DF.id_centrocostos,DF.total,DF.id_factura,FP.id,DF.valoranticipo,F.prefijo,DF.dsctofinanciero
UNION
SELECT        DF.id id, CONVERT(VARCHAR(6), DF.fecha, 112) ANOMES,  IIF(DF.id_centrocostos=0,null,DF.Id_centrocostos) CENTROCOSTO, DF.id NRODOCUMENTO, CONCAT(F.prefijo,'-',F.consecutivo) nrofactura, CONVERT(varchar, DF.fecha, 111) FECHADCTO, 
              DC.id_cuenta CUENTA, F.id_tercero IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO, DC.valorcuotadev*-1 VALOR, '' FORMAPAGO,0 BASEIMP,0 PORCEIMP ,0 CANTIDAD, 'DF' TIPODOC, CONCAT('ACREDITA CUOTA ',DC.cuota) DESCRIPCION, Dbo.ST_FnGetIdList('PROCE') ESTADO,
             'SOLOPROD' CONDICION,DC.vencimiento FECHAVENCIMIENTO,0 CIERRE 
FROM        [dbo].[MOVDevFactura]   AS DF				         	 INNER JOIN	
			[dbo].[MOVFactura]      AS F	   ON DF.id_factura=F.id INNER JOIN
																							 
																						 
																								  
	        [dbo].[MovDevFacturaCuotas] AS DC  ON DF.id=DC.id_devolucion
WHERE       DF.estado = dbo.ST_FnGetIdList('PROCE') AND  DF.contabilizado=0 
UNION ALL
																																																				  
																																																																							 
																							
																					  
																					  
																						 
																						 
																						 
																																																													
																																																			
		 
SELECT      DF.id id, CONVERT(VARCHAR(6), DF.fecha, 112) ANOMES,  IIF(DF.id_centrocostos=0,null,DF.Id_centrocostos) CENTROCOSTO, DF.id NRODOCUMENTO, CONCAT(F.prefijo,'-',F.consecutivo) nrofactura, CONVERT(varchar, DF.fecha, 111) FECHADCTO, 
            C.id CUENTA, CL.id IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO, DF.valoranticipo*-1 VALOR, '' FORMAPAGO,0 BASEIMP,0 PORCEIMP ,0 CANTIDAD, 'DF' TIPODOC, 'CUENTA DE ANTICIPO' DESCRIPCION,Dbo.ST_FnGetIdList('PROCE') ESTADO, 
            'SOLOPROD' CONDICION,NULL FECHAVENCIMIENTO,0 CIERRE 
FROM        [dbo].[MOVDevFactura]   AS DF				              INNER JOIN	
			[dbo].[MOVFactura]			AS F  ON DF.id_factura = F.id     INNER JOIN  
            [CNT].[Terceros]            AS CL ON CL.id        = F.id_tercero   INNER JOIN
			[dbo].[CNTCuentas]			AS C  ON C.id  = F.id_ctaant      INNER JOIN
			[dbo].[ST_Listados]			AS S  ON S.id  = F.estado
WHERE      DF.estado = dbo.ST_FnGetIdList('PROCE')  AND DF.valoranticipo != 0  and DF.contabilizado=0
UNION ALL
SELECT      DF.id id, CONVERT(VARCHAR(6), DF.fecha, 112) ANOMES,  IIF(DF.id_centrocostos=0,null,DF.Id_centrocostos) CENTROCOSTO, DF.id NRODOCUMENTO, CONCAT(F.prefijo,'-',F.consecutivo) nrofactura, CONVERT(varchar, DF.fecha, 111) FECHADCTO, 
            C.id CUENTA, CL.id IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO, DF.dsctofinanciero*-1 VALOR, '' FORMAPAGO,0 BASEIMP,0 PORCEIMP ,0 CANTIDAD, 'DF' TIPODOC, 'CUENTA DE DESCUENTO FINANCIERO' DESCRIPCION,Dbo.ST_FnGetIdList('PROCE') ESTADO, 
            'SOLOPROD' CONDICION,NULL FECHAVENCIMIENTO,0 CIERRE 
FROM        [dbo].[MOVDevFactura]   AS DF				              INNER JOIN	
			[dbo].[MOVFactura]			AS F  ON DF.id_factura = F.id     INNER JOIN  
            [CNT].[Terceros]            AS CL ON CL.id        = F.id_tercero   INNER JOIN
			[dbo].[CNTCuentas]			AS C  ON C.id  = DF.ctadescuento      INNER JOIN
			[dbo].[ST_Listados]			AS S  ON S.id  = F.estado
WHERE      DF.estado = dbo.ST_FnGetIdList('PROCE')  AND DF.dsctofinanciero != 0  and DF.contabilizado=0
UNION ALL
SELECT      DF.id id, CONVERT(VARCHAR(6), DF.fecha, 112) ANOMES,  IIF(DF.id_centrocostos=0,null,DF.Id_centrocostos) CENTROCOSTO, DF.id NRODOCUMENTO, CONCAT(F.prefijo,'-',F.consecutivo) nrofactura, CONVERT(varchar, DF.fecha, 111) FECHADCTO, 
            CN.id_ctadevVenta CUENTA, CL.id IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO, SUM(FI.iva*Fi.cantidad) VALOR, '' FORMAPAGO,SUM(FI.preciodesc*cantidad) BASEIMP,fi.porceniva PORCEIMP, 0 CANTIDAD, 'DF' TIPODOC, 'CUENTA DE IVA' DESCRIPCION,Dbo.ST_FnGetIdList('PROCE') ESTADO, 
            'SOLOPROD' CONDICION,NULL FECHAVENCIMIENTO,0 CIERRE 

FROM        [dbo].[MOVDevFactura]      AS DF                          INNER JOIN	
			[dbo].[MOVFactura]         AS F ON			DF.id_factura=F.id     INNER JOIN
            [dbo].[MOVDevFacturaItems] AS FI ON DF.id   = FI.id_devolucion  INNER JOIN
            [CNT].[Terceros]           AS CL ON CL.id        = F.id_tercero   INNER JOIN
			[dbo].[Productos]          AS C  ON C.id   = FI.id_articulo INNER JOIN 
			[CNT].[Impuestos]          AS CN ON CN.id  = FI.id_iva   INNER JOIN
			[dbo].[ST_Listados]        AS S  ON S.id   = F.estado       INNER JOIN 
			[dbo].[ST_Listados]        AS SL ON SL.id  = C.tipoproducto
WHERE       DF.estado = dbo.ST_FnGetIdList('PROCE') AND  Fi.iva > 0 AND SL.nombre!='SERVICIO'  and DF.contabilizado=0
GROUP BY CL.id, CN.id_ctadevVenta, DF.fecha,  F.created, DF.id, f.consecutivo,DF.id_centrocostos,F.prefijo,FI.porceniva
UNION ALL
SELECT      DF.id id, CONVERT(VARCHAR(6), DF.fecha, 112) ANOMES,  IIF(DF.id_centrocostos=0,null,DF.Id_centrocostos) CENTROCOSTO, DF.id NRODOCUMENTO, CONCAT(F.prefijo,'-',F.consecutivo) nrofactura, CONVERT(varchar, DF.fecha, 111) FECHADCTO, 
            CN.id_ctadevVenta CUENTA, CL.id IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO, SUM(FI.inc*Fi.cantidad) VALOR, '' FORMAPAGO,SUM(FI.preciodesc*cantidad) BASEIMP,fi.porceninc PORCEIMP ,0 CANTIDAD, 'DF' TIPODOC, 'CUENTA DE INC' DESCRIPCION,Dbo.ST_FnGetIdList('PROCE') ESTADO, 
            'SOLOPROD' CONDICION,NULL FECHAVENCIMIENTO,0 CIERRE 

FROM        [dbo].[MOVDevFactura] AS DF                          INNER JOIN	
			[dbo].[MOVFactura]        AS F ON			DF.id_factura=F.id     INNER JOIN
            [dbo].[MOVDevFacturaItems] AS FI ON DF.id   = FI.id_devolucion  INNER JOIN
            [CNT].[Terceros]            AS CL ON CL.id        = F.id_tercero   INNER JOIN
			[dbo].[Productos]       AS C  ON C.id   = FI.id_articulo INNER JOIN 
			[CNT].[Impuestos]       AS CN ON CN.id  = FI.id_inc      INNER JOIN
			[dbo].[ST_Listados]     AS S  ON S.id   = F.estado       INNER JOIN 
			[dbo].[ST_Listados]     AS SL ON SL.id  = C.tipoproducto
WHERE       DF.estado = dbo.ST_FnGetIdList('PROCE') AND  Fi.inc > 0   and DF.contabilizado=0
GROUP BY CL.id, CN.id_ctadevVenta, DF.fecha,  F.created, DF.id, f.consecutivo,DF.id_centrocostos,F.prefijo,FI.porceninc
UNION ALL
SELECT      DF.id id, CONVERT(VARCHAR(6), DF.fecha, 112) ANOMES, IIF(DF.id_centrocostos=0,null,DF.Id_centrocostos) CENTROCOSTO, DF.id NRODOCUMENTO, CONCAT(F.prefijo,'-',F.consecutivo) nrofactura, CONVERT(varchar, DF.fecha, 111) FECHADCTO, 
            B.ctaingreso CUENTA, CL.id IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO,SUM(FI.Preciodesc * cantidad)  VALOR, '' FORMAPAGO,0 BASEIMP,0 PORCEIMP ,0 CANTIDAD, 'DF' TIPODOC, 'CUENTA DE INGRESOS' DESCRIPCION, Dbo.ST_FnGetIdList('PROCE') ESTADO,
            'SOLOPROD' CONDICION,NULL FECHAVENCIMIENTO,0 CIERRE 
FROM        [dbo].[MOVDevFactura] AS DF                            INNER JOIN	
			[dbo].[MOVFactura]    AS F  ON DF.id_factura=F.id          INNER JOIN
            [dbo].MovDEVfacturaitems AS FI ON DF.id = FI.id_devolucion INNER JOIN
            [dbo].[VW_Bodegas]    AS B ON B.id = FI.id_bodega          INNER JOIN
            [CNT].[Terceros]            AS CL ON CL.id        = F.id_tercero   INNER JOIN
			[dbo].[Productos]     AS Z ON Z.id = FI.id_articulo        INNER JOIN
			[dbo].ST_Listados     AS S  ON S.id=F.estado               INNER JOIN
			[dbo].ST_Listados     AS SL ON SL.id = Z.tipoproducto
WHERE       DF.estado = dbo.ST_FnGetIdList('PROCE') AND Fi.iva > 0  AND SL.nombre!='SERVICIO'  and DF.contabilizado=0
GROUP BY CL.id, DF.fecha, B.ctaingreso, F.created, DF.id, f.consecutivo,DF.id_centrocostos,F.prefijo
UNION ALl
SELECT      DF.id id, CONVERT(VARCHAR(6), DF.fecha, 112) ANOMES, IIF(DF.id_centrocostos=0,null,DF.Id_centrocostos) CENTROCOSTO, DF.id NRODOCUMENTO, CONCAT(F.prefijo,'-',F.consecutivo) nrofactura, CONVERT(varchar, DF.fecha, 111) FECHADCTO, 
            B.ctaingresoexc CUENTA, CL.id IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO,SUM(FI.Preciodesc * cantidad)  VALOR, '' FORMAPAGO, 0 BASEIMP,0 PORCEIMP,0 CANTIDAD, 'DF' TIPODOC, 'INGRESO ARTICULOS EXCENTOS' DESCRIPCION,Dbo.ST_FnGetIdList('PROCE') ESTADO, 
            'SOLOPROD' CONDICION,NULL FECHAVENCIMIENTO,0 CIERRE 
FROM        [dbo].[MOVDevFactura] AS DF                                 INNER JOIN
			[dbo].[MOVFactura]      AS F  ON DF.id_factura = F.id           INNER JOIN
            [dbo].[MOVDevFacturaItems] AS FI ON DF.id   = FI.id_devolucion   INNER JOIN
            [dbo].[VW_Bodegas]      AS B  ON B.id   = FI.id_bodega          INNER JOIN
            [CNT].[Terceros]            AS CL ON CL.id        = F.id_tercero   INNER JOIN
			[dbo].[Productos]       AS Z  ON Z.id   = FI.id_articulo        INNER JOIN
			[dbo].[ST_Listados]     AS S  ON S.id   = F.estado              INNER JOIN
			[dbo].[ST_Listados]     AS SL ON SL.id  = Z.tipoproducto
WHERE       DF.estado = dbo.ST_FnGetIdList('PROCE') AND Fi.iva = 0 AND SL.nombre!='SERVICIO' and DF.contabilizado=0
GROUP BY CL.id, DF.fecha, B.ctaingresoexc, F.created, DF.id, F.consecutivo,DF.id_centrocostos,F.prefijo
UNION ALl
SELECT      DF.id id, CONVERT(VARCHAR(6), DF.fecha, 112) ANOMES,  IIF(DF.id_centrocostos=0,null,DF.Id_centrocostos) CENTROCOSTO, DF.id NRODOCUMENTO, CONCAT(F.prefijo,'-',F.consecutivo) nrofactura, CONVERT(varchar, DF.fecha, 111) FECHADCTO, 
            C.id CUENTA, CL.id IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO,SUM(FI.preciodesc*FI.cantidad)  VALOR, '' FORMAPAGO,0 BASEIMP,0 PORCEIMP ,0 CANTIDAD, 'DF' TIPODOC, 'CUENTA DE INGRESOS DE '+Z.nombre DESCRIPCION,Dbo.ST_FnGetIdList('PROCE') ESTADO, 
            'SOLOPROD' CONDICION,NULL FECHAVENCIMIENTO,0 CIERRE   
FROM        [dbo].[MOVDevFactura] AS DF                                  INNER JOIN
			[dbo].[MOVFactura]      AS F  ON DF.id_factura=F.id              INNER JOIN
            [dbo].[Movdevfacturaitems] AS FI ON DF.id   = FI.id_devolucion    INNER JOIN
			[CNT].[Terceros]            AS CL ON CL.id        = F.id_tercero   INNER JOIN
			[dbo].[Productos]       AS Z  ON Z.id   = FI.id_articulo         INNER JOIN
			[dbo].[CNTCuentas]      AS C  ON C.id   = Z.id_ctacontable       INNER JOIN
			[dbo].[ST_Listados]     AS S  ON S.id   = F.estado
WHERE       DF.estado = dbo.ST_FnGetIdList('PROCE') and DF.contabilizado=0
GROUP BY CL.id, DF.fecha, C.id, F.created, DF.id,f.consecutivo,z.nombre,DF.id_centrocostos,F.prefijo
UNION ALl
SELECT      DF.id id, CONVERT(VARCHAR(6), DF.fecha, 112) ANOMES,  IIF(DF.id_centrocostos=0,null,DF.Id_centrocostos) CENTROCOSTO, DF.id NRODOCUMENTO, CONCAT(F.prefijo,'-',F.consecutivo) nrofactura, CONVERT(varchar, DF.fecha, 111) FECHADCTO, 
            C.id_ctadevVenta CUENTA, CL.id IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO,SUM(FI.iva*FI.cantidad)  VALOR, '' FORMAPAGO,sum(fi.preciodesc*fi.cantidad) BASEIMP,FI.porceniva,0 CANTIDAD, 'DF' TIPODOC, 'CUENTA DE IVA DE '+Z.nombre DESCRIPCION,Dbo.ST_FnGetIdList('PROCE') ESTADO, 
            'SOLOPROD' CONDICION,NULL FECHAVENCIMIENTO,0 CIERRE 
FROM        [dbo].[MOVDevFactura] AS DF                                  INNER JOIN
			[dbo].[MOVFactura]      AS F  ON DF.id_factura=F.id                          INNER JOIN
            [dbo].[MOVDevFacturaItems] AS FI ON DF.id  = FI.id_devolucion  INNER JOIN
																			  
            [CNT].[Terceros]            AS CL ON CL.id        = F.id_tercero   INNER JOIN
			[dbo].[Productos]       AS Z  ON Z.id  = FI.id_articulo INNER JOIN
			[CNT].[Impuestos]       AS C  ON C.id  = FI.id_iva      INNER JOIN
			[dbo].[ST_Listados]     AS S  ON S.id  = F.estado       INNER JOIN
			[dbo].[ST_Listados]     AS SL ON SL.id = Z.tipoproducto
WHERE       DF.estado = dbo.ST_FnGetIdList('PROCE') AND Fi.iva > 0 AND SL.nombre = 'SERVICIO' and DF.contabilizado=0
GROUP BY CL.id, DF.fecha, C.id_ctadevVenta, F.created, DF.id,f.consecutivo,z.nombre,DF.id_centrocostos,F.prefijo,FI.porceniva
UNION ALL
SELECT      DF.id id, CONVERT(VARCHAR(6), DF.fecha, 112) ANOMES,  IIF(DF.id_centrocostos=0,null,DF.Id_centrocostos) CENTROCOSTO, DF.id NRODOCUMENTO, CONCAT(F.prefijo,'-',F.consecutivo) nrofactura, CONVERT(varchar, DF.fecha, 111) FECHADCTO, 
            B.ctainven CUENTA, CL.id IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO,SUM(FI.costo * FI.cantidad)  valor, '' FORMAPAGO,0 BASEIMP,0 PORCEIMP ,0 CANTIDAD, 'DF' TIPODOC, 'CUENTA DE INVENTARIO' DESCRIPCION,Dbo.ST_FnGetIdList('PROCE') ESTADO,
            'SOLOPROD' CONDICION,NULL FECHAVENCIMIENTO,0 CIERRE 
FROM        [dbo].[MOVDevFactura] AS DF						                          INNER JOIN
			[dbo].[MOVFactura] AS F  ON DF.id_factura=  F.id					          INNER JOIN
            [dbo].[MOVDevFacturaItems]      AS FI   ON FI.id_devolucion = DF.id           INNER JOIN
            [dbo].[VW_Bodegas]      AS B   ON B.id          = FI.id_bodega				  INNER JOIN
			[CNT].[Terceros]            AS CL ON CL.id        = F.id_tercero   INNER JOIN
			[dbo].[Productos]       AS Z   ON Z.id          = FI.id_articulo              INNER JOIN
			[dbo].[ST_Listados]     AS S   ON S.id          = F.estado       INNER JOIN
			[dbo].[ST_Listados]     AS SL  ON SL.id         = Z.tipoproducto
WHERE       DF.estado = dbo.ST_FnGetIdList('PROCE') AND SL.nombre != 'SERVICIO' and z.inventario = 1 and DF.contabilizado=0
GROUP BY CL.id, DF.fecha, B.ctainven, F.created, DF.id,f.consecutivo,DF.id_centrocostos,F.prefijo
UNION ALL
SELECT     DF.id id, CONVERT(VARCHAR(6), DF.fecha, 112) ANOMES,  IIF(DF.id_centrocostos=0,null,DF.Id_centrocostos) CENTROCOSTO, DF.id NRODOCUMENTO, CONCAT(F.prefijo,'-',F.consecutivo) nrofactura, CONVERT(varchar, DF.fecha, 111) FECHADCTO, 
            B.ctacosto CUENTA, CL.id IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO,SUM(FI.costo * FI.cantidad)*-1 valor, '' FORMAPAGO,0 BASEIMP,0 PORCEIMP ,0 CANTIDAD, 'DF' TIPODOC, 'CUENTA DE COSTOS DE VENTA' DESCRIPCION, Dbo.ST_FnGetIdList('PROCE') ESTADO,
            'SOLOPROD' CONDICION,NULL FECHAVENCIMIENTO,0 CIERRE 
FROM        [dbo].[MOVDevFactura] AS DF						                          INNER JOIN
			[dbo].[MOVFactura] AS F  ON DF.id_factura=  F.id					          INNER JOIN
            [dbo].[MOVDevFacturaItems]      AS FI   ON FI.id_devolucion = DF.id           INNER JOIN
            [dbo].[VW_Bodegas]       AS B   ON B.id          = FI.id_bodega   INNER JOIN
			[CNT].[Terceros]            AS CL ON CL.id        = F.id_tercero   INNER JOIN
			[dbo].[Productos]        AS Z   ON Z.id          = FI.id_articulo INNER JOIN
			[dbo].[ST_Listados]      AS S   ON S.id          = F.estado       INNER JOIN
			[dbo].[ST_Listados]      AS SL  ON SL.id         = Z.tipoproducto
WHERE       DF.estado = dbo.ST_FnGetIdList('PROCE') AND  SL.nombre != 'SERVICIO' AND Z.inventario=1 and DF.contabilizado=0
GROUP BY CL.id, DF.fecha, B.ctacosto, F.created, DF.id,f.consecutivo,DF.id_centrocostos,F.prefijo


GO


