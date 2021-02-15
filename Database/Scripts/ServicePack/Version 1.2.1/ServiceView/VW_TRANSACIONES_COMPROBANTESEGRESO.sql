--liquibase formatted sql
--changeset ,jeteme:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[CNT].[VW_TRANSACIONES_COMPROBANTESEGRESO]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
Drop View [CNT].[VW_TRANSACIONES_COMPROBANTESEGRESO]
END
GO


CREATE VIEW [CNT].[VW_TRANSACIONES_COMPROBANTESEGRESO]
AS
/***************************************
*Nombre:		[CNT].[VW_TRANSACIONES_COMPROBANTESEGRESO]
----------------------------------------
*Tipo:			Vista
*creaci�n:		16/04/20
*Desarrollador: (JETEME)
***************************************/ 
SELECT R.id id, 
                        CONVERT(VARCHAR(6), R.fecha, 112) ANOMES,  IIF(R.id_centrocosto=0,null,R.Id_centrocosto) CENTROCOSTO, R.id NRODOCUMENTO, '' nrofactura, CONVERT(varchar, R.FECHA, 111) FECHADCTO,C.id CUENTA, 
                        ISNULL(R.id_proveedor,'') IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO, iif(L.nombre='Debito',I.valor,I.valor*-1)  VALOR, '' FORMAPAGO,0 BASEIMP,0 PORCEIMP, 0 CANTIDAD, 'CE' TIPODOC, CONCAT('PAGO CONCEPTO ',P.nombre) DESCRIPCION,Dbo.ST_FnGetIdList('PROCE') ESTADO,NULL FECHAVENCIMIENTO,0 CIERRE 
FROM					CNT.MOVComprobantesEgresos AS R INNER JOIN 
						CNT.VW_MOVComprobantesEgresosConceptos AS I ON R.id=I.id_comprobante INNER JOIN
						dbo.Productos AS P ON P.id=I.id_concepto INNER JOIN
						dbo.CNTCuentas C ON C.id=P.id_ctacontable LEFT JOIN
						dbo.ST_listados AS L ON P.id_naturaleza=L.id
WHERE					(R.estado = Dbo.ST_FnGetIdList('PROCE')) and I.valor>0
UNION ALL
SELECT R.id id, 
                        CONVERT(VARCHAR(6), R.fecha, 112) ANOMES, IIF(R.id_centrocosto=0,null,R.Id_centrocosto) CENTROCOSTO, R.id NRODOCUMENTO,'' nrofactura, CONVERT(varchar, R.FECHA, 111) FECHADCTO, C.id CUENTA, 
                        ISNULL(R.id_proveedor,'') IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO, (SUM(F.valor)-cambio) *-1  VALOR, O.nombre FORMAPAGO, 0 BASEIMP,0 PORCEIMP,0 CANTIDAD, 'CE' TIPODOC, 'FORMA DE PAGO' DESCRIPCION,Dbo.ST_FnGetIdList('PROCE') ESTADO,NULL FECHAVENCIMIENTO,0 CIERRE 
FROM					CNT.MOVComprobantesEgresos AS R INNER JOIN 
						CNT.MOVComprobanteEgresoFormaPago F ON  F.id_comprobante=R.id INNER JOIN
						dbo.FormaPagos AS O ON F.id_formapago=O.id LEFT JOIN
						dbo.CNTCuentas C ON C.id=O.id_cuenta
WHERE					(R.estado = Dbo.ST_FnGetIdList('PROCE')) 
GROUP BY R.id,R.fecha,C.id,R.id_proveedor,O.nombre,cambio,R.valoranticipo,R.id_centrocosto
UNION ALL
SELECT R.id id, 
                        CONVERT(VARCHAR(6), R.fecha, 112) ANOMES,  IIF(R.id_centrocosto=0,null,R.Id_centrocosto) CENTROCOSTO, R.id NRODOCUMENTO, CONVERT(VARCHAR(10),S.nrofactura) nrofactura, CONVERT(varchar, R.FECHA, 111) FECHADCTO, S.id_cuenta CUENTA, 
                        R.id_proveedor IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO, I.valor  VALOR, '' FORMAPAGO,0 BASEIMP,0 PORCEIMP, 0 CANTIDAD, 'CE' TIPODOC, CONCAT('ABONO / PAGO CUOTA N� ',S.nrofactura) DESCRIPCION,Dbo.ST_FnGetIdList('PROCE') ESTADO,NULL FECHAVENCIMIENTO,0 CIERRE 
FROM					CNT.MOVComprobantesEgresos AS R INNER JOIN 
						CNT.VW_MOVComprobantesEgresosItems AS I ON R.id=I.id_comprobante INNER JOIN
						CNT.SaldoProveedor AS S ON I.id_documento=S.id 
WHERE					(R.estado = Dbo.ST_FnGetIdList('PROCE'))
UNION ALL
SELECT					E.id id, CONVERT(VARCHAR(6),E.fecha, 112) ANOMES, IIF(E.id_centrocosto=0,null,E.Id_centrocosto) CENTROCOSTO, E.id NRODOCUMENTO, '' nrofactura, CONVERT(varchar, E.FECHA, 111) FECHADCTO, 
						E.id_ctaant CUENTA, E.id_proveedor IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO, E.valoranticipo*-1 VALOR, '' FORMAPAGO,0 BASEIMP,0 PORCEIMP, 0 CANTIDAD, 'CE' TIPODOC, 'CUENTA DE ANTICIPO' DESCRIPCION, 
						Dbo.ST_FnGetIdList('PROCE') ESTADO,NULL FECHAVENCIMIENTO,0 CIERRE
FROM					CNT.MOVComprobantesEgresos   AS E                          
WHERE					E.Estado = Dbo.ST_FnGetIdList('PROCE')  AND E.valoranticipo != 0

GO


