--liquibase formatted sql
--changeset ,jeteme:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[CNT].[VW_PROCESOSCONTABILIZAR]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
Drop View [CNT].[VW_PROCESOSCONTABILIZAR]
END
GO




CREATE VIEW [CNT].[VW_PROCESOSCONTABILIZAR]
AS 
/****** Movimientos de Inventarios por contabilizar ************/
	SELECT L.id id,CONVERT(VARCHAR(10), L.fechadocumen, 120) fecha,CONVERT(VARCHAR(6), L.fechadocumen, 112) anomes,'CNT.VW_TRANSACIONES_ENTRADAS' vista,'dbo' Esquema,1 NIVEL,'Entradas' tipodoc,L.numfactura factura,valor total 
	FROM dbo.MOVEntradas L  
	WHERE        (L.estado = dbo.ST_FnGetIdList('PROCE')) AND contabilizado=0 
	UNION 
	SELECT L.id id,CONVERT(VARCHAR(10), L.fechadocumen, 120) fecha,CONVERT(VARCHAR(6), L.fechadocumen, 112) anomes,'CNT.VW_TRANSACIONES_DEVENTRADAS' vista,'dbo' Esquema,2 NIVEL,'Devolucion Entradas' tipodoc,M.numfactura factura,L.valor total       
	FROM dbo.MOVDevEntradas L INNER JOIN dbo.MOVEntradas M ON  L.id_entrada=M.id
	WHERE        (L.estado = dbo.ST_FnGetIdList('PROCE')) AND L.contabilizado=0 
	UNION 
	SELECT L.id id,CONVERT(VARCHAR(10), L.fecha, 120) fecha,CONVERT(VARCHAR(6), L.fecha, 112) anomes,'CNT.VW_TRANSACIONES_AJUSTES' vista,'dbo' Esquema,3 NIVEL,'Ajustes' tipodoc,'' factura,costototal total       
	FROM dbo.MOVAjustes L  
	WHERE        (L.estado = dbo.ST_FnGetIdList('PROCE')) AND contabilizado=0 
	UNION 
	SELECT L.id id,CONVERT(VARCHAR(10), L.fecha, 120) fecha,CONVERT(VARCHAR(6), L.fecha, 112) anomes,'CNT.VW_TRANSACIONES_TRASLADOS' vista,'dbo' Esquema,4 NIVEL,'Traslados' tipodoc,'' factura,costototal total       
	FROM dbo.MOVTraslados L  
	WHERE        (L.estado = dbo.ST_FnGetIdList('PROCE')) AND contabilizado=0 
	UNION 
/****** Movimientos de Facturacion por contabilizar ************/
	SELECT L.id id,CONVERT(VARCHAR(10), L.fechafac, 120) fecha,CONVERT(VARCHAR(6), L.fechafac, 112) anomes,'CNT.VW_TRANSACIONES_FACTURAS' vista,'dbo' Esquema,5 NIVEL,'Facturas' tipodoc,CONCAT(L.prefijo,'-',L.consecutivo) factura,total       
	FROM dbo.MOVFactura L  
	WHERE        (L.estado = dbo.ST_FnGetIdList('PROCE')) AND contabilizado=0 
	UNION 
	SELECT L.id id,CONVERT(VARCHAR(10), L.fecha, 120) fecha,CONVERT(VARCHAR(6), L.fecha, 112) anomes,'CNT.VW_TRANSACIONES_DEVFACTURAS' vista,'dbo' Esquema,6 NIVEL,'Devolucion de Facturas' tipodoc,CONCAT(M.prefijo,'-',M.consecutivo) factura,L.total       
	FROM dbo.MOVDevFactura L INNER JOIN  MOVFactura M ON L.id_factura=M.id  
	WHERE        (L.estado = dbo.ST_FnGetIdList('PROCE')) AND L.contabilizado=0 
	UNION
/****** Movimientos Contables a contabilizar       **************/
	SELECT L.id id,CONVERT(VARCHAR(10), L.fecha, 120) fecha,CONVERT(VARCHAR(6), L.fecha, 112) anomes,'CNT.VW_TRANSACIONES_COMPROBANTESCONTABLE' vista,'CNT' Esquema,9 NIVEL,'Comprobante Contable' tipodoc,'' factura,0 total       
	FROM CNT.MOVComprobantesContables L  
	WHERE        (L.estado = dbo.ST_FnGetIdList('PROCE')) 
	UNION 
	SELECT L.id id,CONVERT(VARCHAR(10), L.fecha, 120) fecha,CONVERT(VARCHAR(6), L.fecha, 112) anomes,'CNT.VW_TRANSACIONES_RECIBOCAJA' vista, 'CNT' Esquema,7 NIVEL,'Recibo de Caja' tipodoc,'' factura,L.valorcliente+L.valorconcepto-L.valorDescuento total       
	FROM CNT.MOVReciboCajas L  
	WHERE        (L.estado = dbo.ST_FnGetIdList('PROCE')) 
	UNION 
	SELECT L.id id,CONVERT(VARCHAR(10), L.fecha, 120) fecha,CONVERT(VARCHAR(6), L.fecha, 112) anomes,'CNT.VW_TRANSACIONES_COMPROBANTESEGRESO' vista,'CNT' Esquema,8 NIVEL,'Comprobante Egreso' tipodoc,'' factura,L.valorpagado+L.valorconcepto total        
	FROM CNT.MOVComprobantesEgresos L  
	WHERE        (L.estado = dbo.ST_FnGetIdList('PROCE')) 








GO


