--liquibase formatted sql
--changeset ,JPAREDES:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[VW_TRANSACIONES_FACTURAS_OBSEQUIOS]') and OBJECTPROPERTY(id, N'IsView') = 1)
DROP VIEW [CNT].[VW_TRANSACIONES_FACTURAS_OBSEQUIOS]
GO
CREATE VIEW [CNT].[VW_TRANSACIONES_FACTURAS_OBSEQUIOS]

AS

SELECT      F.id id, 
			CONVERT(VARCHAR(6),F.fechafac, 112) ANOMES, 
			IIF(F.id_centrocostos=0,null,F.Id_centrocostos) CENTROCOSTO, 
			F.id NRODOCUMENTO, 
			CONCAT(F.prefijo,'-',F.consecutivo) nrofactura, 
			CONVERT(varchar, F.fechafac, 111) FECHADCTO, 
            B.ctainven CUENTA, 
			F.id_tercero IDEN_TERCERO, 
			'' CODPRODUCTO, 
			'' PRESENPRODUCTO, 
			'' NOMPRODUCTO,
			SUM(FI.costo * FI.cantidad) * - 1 valor, 
			'' FORMAPAGO,
			0 BASEIMP,
			0 PORCEIMP ,
			0 CANTIDAD, 
			'FV' TIPODOC, 
			'CUENTA DE INVENTARIO' DESCRIPCION,
			Dbo.ST_FnGetIdList('PROCE') ESTADO,
            'SOLOPROD' CONDICION,
			NULL FECHAVENCIMIENTO,
			0 CIERRE 
FROM        [dbo].[MOVFacturaItems] AS FI                                    INNER JOIN
            [dbo].[MovFactura]      AS F   ON FI.id_factura = F.id           INNER JOIN
            [dbo].[VW_Bodegas]      AS B   ON B.id          = FI.id_bodega   INNER JOIN
            [dbo].[Productos]       AS Z   ON Z.id          = FI.id_producto INNER JOIN
            [dbo].[ST_Listados]     AS SL  ON SL.id         = Z.tipoproducto
WHERE       F.Estado = Dbo.ST_FnGetIdList('PROCE') AND SL.nombre != 'SERVICIO' and z.inventario = 1 AND F.contabilizado=0
GROUP BY F.id_tercero, F.fechafac, B.ctainven, F.created, F.id,f.consecutivo,F.id_centrocostos,F.prefijo

UNION ALL

SELECT      F.id id, 
			CONVERT(VARCHAR(6),
			F.fechafac, 112) ANOMES, 
			IIF(F.id_centrocostos=0,null,F.Id_centrocostos) CENTROCOSTO, 
			F.id NRODOCUMENTO, 
			CONCAT(F.prefijo,'-',F.consecutivo) nrofactura, 
			CONVERT(varchar, F.fechafac, 111) FECHADCTO, 
            CN.id CUENTA, 
			F.id_tercero IDEN_TERCERO, 
			'' CODPRODUCTO, 
			'' PRESENPRODUCTO, 
			'' NOMPRODUCTO, 
			SUM(FI.iva * FI.cantidad) * - 1 VALOR, 
			'' FORMAPAGO,SUM(preciodesc) BASEIMP,
			FI.poriva PORCEIMP  ,
			0 CANTIDAD, 
			'FV' TIPODOC, 
			'CUENTA DE IVA' DESCRIPCION,
			Dbo.ST_FnGetIdList('PROCE') ESTADO, 
            'SOLOPROD' CONDICION,
			NULL FECHAVENCIMIENTO,
			0 CIERRE 
FROM        [dbo].[MOVFactura]      AS F                             INNER JOIN
            [dbo].[MOVFacturaItems] AS FI ON F.id   = FI.id_factura  INNER JOIN
            [dbo].[Productos]       AS C  ON C.id   = FI.id_producto INNER JOIN 
            [dbo].[CNTCuentas]      AS CN ON CN.id  = FI.id_ctaiva   INNER JOIN
            [dbo].[ST_Listados]     AS SL ON SL.id  = C.tipoproducto
WHERE       F.Estado = Dbo.ST_FnGetIdList('PROCE') AND  Fi.iva > 0 AND SL.nombre!='SERVICIO' AND F.contabilizado=0
GROUP BY F.id_tercero, CN.id, F.fechafac,  F.created, F.id, f.consecutivo,F.id_centrocostos,F.prefijo,FI.poriva

UNION ALL

SELECT      F.id id, 
			CONVERT(VARCHAR(6),F.fechafac, 112) ANOMES, 
			IIF(F.id_centrocostos=0,null,F.Id_centrocostos) CENTROCOSTO, 
			F.id NRODOCUMENTO, 
			CONCAT(F.prefijo,'-',F.consecutivo) NROFACTURA, 
			CONVERT(varchar, F.fechafac, 111) FECHADCTO, 
			C.id CUENTA, 
			F.id_tercero IDEN_TERCERO, 
			'' CODPRODUCTO, 
			'' PRESENPRODUCTO, 
			'' NOMPRODUCTO, 
			F.total VALOR, 
			'' FORMAPAGO,
			0 BASEIMP,
			0 PORCEIMP, 
			0 CANTIDAD, 
			'FV' TIPODOC, 
			C.nombre DESCRIPCION, 
			Dbo.ST_FnGetIdList('PROCE') ESTADO,
			'SOLOPROD' CONDICION,
			NULL FECHAVENCIMIENTO,
			0 CIERRE 
 FROM        [dbo].[MOVFactura]          AS F							INNER JOIN
            [dbo].[CNTCuentas]          AS C  ON C.id         = F.id_ctaobs   
WHERE       F.Estado = Dbo.ST_FnGetIdList('PROCE') AND F.contabilizado=0