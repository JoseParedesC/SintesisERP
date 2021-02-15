--liquibase formatted sql
--changeset ,jeteme:3 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[CNT].[VW_TRANSACIONES_RECIBOCAJA]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
Drop View [CNT].[VW_TRANSACIONES_RECIBOCAJA]
END
GO

CREATE VIEW [CNT].[VW_TRANSACIONES_RECIBOCAJA]
AS
/***************************************
*Nombre:		[CNT].[VW_TRANSACIONES_DEVENTRADAS]
----------------------------------------
*Tipo:			Vista
*creaci�n:		3/12/19
*Desarrollador: (JETEME)
***************************************/  SELECT R.id id, 
                        CONVERT(VARCHAR(6), R.fecha, 112) ANOMES, iIf(R.id_centrocostos=0,null,R.Id_centrocostos) CENTROCOSTO, R.id NRODOCUMENTO, I.id_factura nrofactura, CONVERT(varchar, R.FECHA, 111) FECHADCTO, C.id_cuenta CUENTA, 
                        R.id_cliente IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO, I.pagoCuota*-1  VALOR, '' FORMAPAGO,0 BASEIMP,0 PORCEIMP  ,0 CANTIDAD, 'RC' TIPODOC, CONCAT('ABONO / PAGO CUOTA N� ',C.cuota) DESCRIPCION,Dbo.ST_FnGetIdList('PROCE') ESTADO,C.vencimiento_cuota FECHAVENCIMIENTO,0 CIERRE 
FROM            CNT.MOVReciboCajas AS R INNER JOIN 
				CNT.VW_MOVReciboCajasItems AS I ON  R.id=I.id_recibo INNER JOIN
				CNT.SaldoCliente_Cuotas       C ON  C.cuota=I.cuota and C.nrofactura=I.id_factura and c.anomes=CONVERT(VARCHAR(6),R.fecha,112) and C.id_devolucion is null and C.id_nota is null 
WHERE        (R.estado = Dbo.ST_FnGetIdList('PROCE'))  AND I.pagoCuota>0
UNION ALL
SELECT R.id id, 
                         CONVERT(VARCHAR(6), R.fecha, 112) ANOMES, iIf(R.id_centrocostos=0,null,R.Id_centrocostos) CENTROCOSTO, R.id NRODOCUMENTO, I.id_factura nrofactura, CONVERT(varchar, R.FECHA, 111) FECHADCTO, dbo.GETParametrosValor('CUENTAINTERESMORA') CUENTA, 
                        R.id_cliente IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO, I.pagoInteres*-1  VALOR, '' FORMAPAGO,0 BASEIMP,0 PORCEIMP  ,0 CANTIDAD, 'RC' TIPODOC, CONCAT('ABONO / PAGO INTERES N� ',C.cuota) DESCRIPCION,Dbo.ST_FnGetIdList('PROCE') ESTADO,C.vencimiento_cuota FECHAVENCIMIENTO,0 CIERRE 
  FROM			CNT.MOVReciboCajas AS R INNER JOIN 
				CNT.VW_MOVReciboCajasItems AS I ON R.id=I.id_recibo INNER JOIN
				cnt.SaldoCliente_Cuotas AS C ON I.cuota=C.cuota and C.nrofactura=I.id_factura and c.anomes=CONVERT(VARCHAR(6),R.fecha,112) and C.id_devolucion is null and C.id_nota is null
WHERE        (R.estado = Dbo.ST_FnGetIdList('PROCE'))  AND I.pagoInteres>0
UNION ALL
SELECT R.id id, 
                         CONVERT(VARCHAR(6), R.fecha, 112) ANOMES, iIf(R.id_centrocostos=0,null,R.Id_centrocostos) CENTROCOSTO, R.id NRODOCUMENTO, '' nrofactura, CONVERT(varchar, R.FECHA, 111) FECHADCTO,C.id CUENTA, 
                         R.id_cliente IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO, iif(L.nombre='Debito',I.valor,I.valor*-1)  VALOR, '' FORMAPAGO, 0 BASEIMP,0 PORCEIMP ,0 CANTIDAD, 'RC' TIPODOC, CONCAT('PAGO CONCEPTO ',P.nombre) DESCRIPCION,Dbo.ST_FnGetIdList('PROCE') ESTADO,NULL FECHAVENCIMIENTO,0 CIERRE  
FROM            CNT.MOVReciboCajas AS R INNER JOIN 
				CNT.VW_MOVReciboCajasConceptos AS I ON R.id=I.id_recibo INNER JOIN
				dbo.Productos AS P ON P.id=I.id_concepto INNER JOIN
				dbo.CNTCuentas C ON C.id=P.id_ctacontable LEFT JOIN
				dbo.ST_listados AS L ON P.id_naturaleza=L.id
WHERE        (R.estado = Dbo.ST_FnGetIdList('PROCE')) and I.valor>0
UNION ALL
SELECT R.id id, 
                         CONVERT(VARCHAR(6), R.fecha, 112) ANOMES, iIf(R.id_centrocostos=0,null,R.Id_centrocostos) CENTROCOSTO, R.id NRODOCUMENTO, '' nrofactura, CONVERT(varchar, R.FECHA, 111) FECHADCTO,C.id CUENTA, 
                         R.id_cliente IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO,R.valorDescuento  VALOR, '' FORMAPAGO,0 BASEIMP,0 PORCEIMP  ,0 CANTIDAD, 'RC' TIPODOC, CONCAT('CONCEPTO ',P.nombre) DESCRIPCION,Dbo.ST_FnGetIdList('PROCE') ESTADO,NULL FECHAVENCIMIENTO,0 CIERRE  
FROM            CNT.MOVReciboCajas AS R INNER JOIN 
				dbo.Productos AS P ON P.id=R.id_conceptoDescuento INNER JOIN
				dbo.CNTCuentas C ON C.id=P.id_ctacontable LEFT JOIN
				dbo.ST_listados AS L ON P.id_naturaleza=L.id
WHERE        (R.estado = Dbo.ST_FnGetIdList('PROCE')) and R.valorDescuento>0
UNION ALL
SELECT R.id id, 
                         CONVERT(VARCHAR(6), R.fecha, 112) ANOMES, iIf(R.id_centrocostos=0,null,R.Id_centrocostos) CENTROCOSTO, R.id NRODOCUMENTO,'' nrofactura, CONVERT(varchar, R.FECHA, 111) FECHADCTO, C.id CUENTA, 
                        R.id_cliente IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO,F.valor-cambio  VALOR, O.nombre FORMAPAGO, 0 BASEIMP,0 PORCEIMP ,0 CANTIDAD, 'RC' TIPODOC, 'FORMA DE PAGO' DESCRIPCION,Dbo.ST_FnGetIdList('PROCE') ESTADO,NULL FECHAVENCIMIENTO,0 CIERRE  
FROM            CNT.MOVReciboCajas AS R INNER JOIN 
				CNT.MOVReciboCajasFormaPago AS F ON R.id=F.id_recibo INNER JOIN
				dbo.FormaPagos AS O ON F.id_formapago=O.id LEFT JOIN
				dbo.CNTCuentas C ON C.id=O.id_cuenta
WHERE        (R.estado = Dbo.ST_FnGetIdList('PROCE'))








GO


