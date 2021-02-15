--liquibase formatted sql
--changeset ,kmartinez:5 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[CNT].[VW_TRANSACIONES_RECAUDOCARTERA]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
Drop View [CNT].[VW_TRANSACIONES_RECAUDOCARTERA]
END
GO

CREATE  VIEW [CNT].[VW_TRANSACIONES_RECAUDOCARTERA]
AS
/***************************************
*Nombre:		[CNT].[VW_TRANSACIONES_RECAUDOCARTERA]
----------------------------------------
*Tipo:			Vista
*creaci�n:		4/01/21
*Desarrollador: (Kmartinez)
***************************************/ 
SELECT R.id id,  CONVERT(VARCHAR(6), R.fecha, 112) ANOMES, IIF(R.id_centrocostos=0,null,R.Id_centrocostos) CENTROCOSTO, R.id NRODOCUMENTO, I.id_factura nrofactura, CONVERT(varchar, R.FECHA, 111) FECHADCTO, F.id_ctafin CUENTA						
		,CL.id IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO, (I.pagoCuota - valorServicios) * -1  VALOR, '' FORMAPAGO,0 BASEIMP,0 PORCEIMP  ,0 CANTIDAD, 'RF' TIPODOC, CONCAT('ABONO / PAGO CUOTA N° ',I.cuota) DESCRIPCION,Dbo.ST_FnGetIdList('PROCE') ESTADO,I.vencimiento_cuota FECHAVENCIMIENTO,0 CIERRE 
FROM		FIN.Recaudocartera AS R INNER JOIN
			FIN.VW_RecaudoReciboCarteraItems AS I ON R.id = I.id_recibo			INNER JOIN			
			[CNT].[Terceros]            AS CL ON CL.id        = R.id_cliente	INNER JOIN
			[dbo].[MOVFactura]          AS f ON I.id_factura  = CONCAT(F.prefijo,'-',f.consecutivo) 
		  WHERE (R.estado = Dbo.ST_FnGetIdList('PROCE'))  AND I.pagoCuota > 0 AND (I.pagoCuota - valorServicios) > 0

UNION ALL

SELECT R.id id,  CONVERT(VARCHAR(6), R.fecha, 112) ANOMES, IIF(R.id_centrocostos=0,null,R.Id_centrocostos) CENTROCOSTO, R.id NRODOCUMENTO, I.id_factura nrofactura, CONVERT(varchar, R.FECHA, 111) FECHADCTO, LC.id_ctaantFianza CUENTA						
		,CL.id IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO, valorServicios * -1  VALOR, '' FORMAPAGO,0 BASEIMP,0 PORCEIMP  ,0 CANTIDAD, 'RF' TIPODOC, CONCAT('ABONO A FIANZA CUOTA N° ',I.cuota) DESCRIPCION,Dbo.ST_FnGetIdList('PROCE') ESTADO,I.vencimiento_cuota FECHAVENCIMIENTO,0 CIERRE 
FROM		FIN.Recaudocartera AS R INNER JOIN
			FIN.VW_RecaudoReciboCarteraItems AS I ON R.id = I.id_recibo			INNER JOIN
			[CNT].[Terceros]            AS CL ON CL.id        = R.id_cliente	INNER JOIN
			[dbo].[MOVFactura]          AS f ON I.id_factura  = CONCAT(F.prefijo,'-',f.consecutivo) INNER JOIN
			FIN.LineasCreditos			AS LC ON LC.id = F.pagoFinan 	
		  WHERE (R.estado = Dbo.ST_FnGetIdList('PROCE'))  AND I.pagoCuota > 0 AND valorServicios > 0

UNION ALL

SELECT R.id id, 
                         CONVERT(VARCHAR(6), R.fecha, 112) ANOMES, iIf(R.id_centrocostos=0,null,R.Id_centrocostos) CENTROCOSTO, R.id NRODOCUMENTO, I.id_factura nrofactura, CONVERT(varchar, R.FECHA, 111) FECHADCTO, LI.id_ctamora CUENTA, 
                        R.id_cliente  IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO, I.InteresMora*-1  VALOR, '' FORMAPAGO,0 BASEIMP,0 PORCEIMP  ,0 CANTIDAD, 'RF' TIPODOC, CONCAT('ABONO / PAGO INTERES CUOTA N� ',I.cuota) DESCRIPCION,Dbo.ST_FnGetIdList('PROCE') ESTADO,NULL FECHAVENCIMIENTO,0 CIERRE 
  FROM			FIN.Recaudocartera AS R INNER JOIN 
				FIN.VW_RecaudoReciboCarteraItems AS I ON R.id=I.id_recibo INNER JOIN
				[CNT].[Terceros]            AS CL ON CL.id        = R.id_cliente   INNER JOIN
			    [dbo].[MOVFactura]          AS f ON I.id_factura  = CONCAT(F.prefijo,'-',f.consecutivo) INNER JOIN 
				[FIN].[LineasCreditos] AS LI ON LI.id = F.pagoFinan    
WHERE        (R.estado = Dbo.ST_FnGetIdList('PROCE'))  AND I.InteresMora > 0

UNION ALL 

SELECT R.id id, 
                         CONVERT(VARCHAR(6), R.fecha, 112) ANOMES, IIF(R.id_centrocostos=0,null,R.Id_centrocostos) CENTROCOSTO, R.id NRODOCUMENTO, '' nrofactura, CONVERT(varchar, R.FECHA, 111) FECHADCTO,C.id CUENTA, 
                         ISNULL(R.id_cliente,0) IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO,R.valorDescuento  VALOR, '' FORMAPAGO,0 BASEIMP,0 PORCEIMP  ,0 CANTIDAD, 'RF' TIPODOC, CONCAT('CONCEPTO ',P.nombre) DESCRIPCION,Dbo.ST_FnGetIdList('PROCE') ESTADO,NULL FECHAVENCIMIENTO,0 CIERRE 
FROM            FIN.Recaudocartera AS R INNER JOIN 
				dbo.Productos AS P ON P.id=R.id_conceptoDescuento INNER JOIN
				dbo.CNTCuentas C ON C.id=P.id_ctacontable LEFT JOIN
				[CNT].[Terceros]            AS CL ON CL.id        = R.id_cliente   Inner join
				dbo.ST_listados AS L ON P.id_naturaleza=L.id
WHERE        (R.estado = Dbo.ST_FnGetIdList('PROCE')) and R.valorDescuento > 0
UNION ALL
SELECT R.id id, 
                         CONVERT(VARCHAR(6), R.fecha, 112) ANOMES, IIF(R.id_centrocostos=0,null,R.Id_centrocostos) CENTROCOSTO, R.id NRODOCUMENTO,'' nrofactura, CONVERT(varchar, R.FECHA, 111) FECHADCTO, C.id CUENTA, 
                        ISNULL(R.id_cliente,0) IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO,F.valor-cambio  VALOR, O.nombre FORMAPAGO, 0 BASEIMP,0 PORCEIMP ,0 CANTIDAD, 'RF' TIPODOC, 'FORMA DE PAGO' DESCRIPCION,Dbo.ST_FnGetIdList('PROCE') ESTADO,NULL FECHAVENCIMIENTO ,0 CIERRE
FROM            FIN.Recaudocartera AS R INNER JOIN 
				[FIN].[RecaudoCarteraFormaPago] AS F ON R.id=F.id_recibo INNER JOIN
				dbo.FormaPagos AS O ON F.id_formapago = O.id LEFT JOIN
				[CNT].[Terceros]            AS CL ON CL.id        = R.id_cliente   Inner join
				dbo.CNTCuentas C ON C.id=O.id_cuenta
WHERE        (R.estado = Dbo.ST_FnGetIdList('PROCE'))

GO


