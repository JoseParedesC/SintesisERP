--liquibase formatted sql
--changeset ,JTOUS:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (SELECT 1 from dbo.sysobjects where id = object_id(N'[CNT].[VW_MOVNotascartera]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
DROP VIEW [CNT].[VW_MOVNotascartera]
END
GO
/*JTOUS: se Agrego validacion en subconsultas para saber las que son de clientes y las de proveedor por el campo nuevo 
		 agregado tipoter en la tabla CNT.MovNotasCarteras.
*/
CREATE VIEW [CNT].[VW_MOVNotascartera]
AS
SELECT 	c.id ,
		CONVERT(VARCHAR(10), c.fecha, 120) AS fecha,
		c.fecha rptfecha,
		IIF(SL.nombre='cliente',dbo.ST_FnGetIdList('CL'),dbo.ST_FnGetIdList('PR')) id_tipotercero,
		IIF(SL.nombre='cliente','CLIENTE','PROVEEDOR') tipotercero,
		TP.razonsocial AS tercero,
		c.id_tercero,
		c.estado id_estado,						 
		l.nombre estado,
		c.id_saldo,
		c.id_ctaant,
		CU.codigo codigoctaanterior,
		CU.nombre cuentanterior,
		c.id_ctaact,
		CS.codigo codigocuentaactual,
		CS.nombre cuentaactual,
		CONVERT(VARCHAR(10), c.vencimientoact, 120) vencimientoact,
		c.detalle,
		c.id_tipodoc,
		TT.nombre tipodocumento,
		c.id_centrocosto,
		CN.nombre Centrocostos,
		id_reversion,
		S.nrofactura,
		c.id_saldoact,
		ISNULL(c.id_tipoven,0) id_tipoven,
		ISNULL(c.nrocuotas,0) nrocuotas,
		ISNULL(c.saldoactual,0) saldoactual,
		ISNULL(c.dia,0) dia
FROM	cnt.MOVNotasCartera c 
		INNER JOIN Cnt.Terceros TP		ON C.id_tercero = TP.id
		INNER JOIN dbo.ST_Listados L	ON L.id = c.estado
		LEFT JOIN CNT.CentroCosto CN	ON CN.id=C.id_centrocosto
		INNER  JOIN CNT.SaldoCliente S	ON S.id = C.id_saldo 
		LEFT JOIN  CNTCuentas CU		ON CU.id=C.id_ctaant
		LEFT JOIN  CNTCuentas CS        ON CS.id = C.id_ctaact 
		INNER JOIN CNT.TipoDocumentos TT ON TT.id = C.id_tipodoc 
		INNER JOIN ST_Listados SL		 ON SL.id = CU.categoria
WHERE Tipoter = 'CL'			
UNION ALL

SELECT 	c.id ,
		CONVERT(VARCHAR(10), c.fecha, 120) AS fecha,
		c.fecha rptfecha,
		IIF(SL.nombre='cliente',dbo.ST_FnGetIdList('CL'),dbo.ST_FnGetIdList('PR')) id_tipotercero,
		IIF(SL.nombre='cliente','CLIENTE','PROVEEDOR') tipotercero,
		TP.razonsocial AS tercero,
		c.id_tercero,
		c.estado id_estado,						 
		l.nombre estado,
		c.id_saldo,
		c.id_ctaant,
		CU.codigo codigoctaanterior,
		CU.nombre cuentanterior,
		c.id_ctaact,
		CS.codigo codigocuentaactual,
		CS.nombre cuentaactual,
		CONVERT(VARCHAR(10), c.vencimientoact, 120) vencimientoact,
		c.detalle,
		c.id_tipodoc,
		TT.nombre tipodocumento,
		c.id_centrocosto,
		CN.nombre Centrocostos,
		id_reversion,
		S.nrofactura,
		c.id_saldoact,
		ISNULL(c.id_tipoven,0) id_tipoven,
		ISNULL(c.nrocuotas,0) nrocuotas,
		ISNULL(c.saldoactual,0) saldoactual,
		ISNULL(c.dia,0) dia
FROM	CNT.MOVNotasCartera c 
		INNER JOIN CNT.Terceros TP	ON C.id_tercero = TP.id
		INNER JOIN dbo.ST_Listados AS L ON L.id = c.estado
		LEFT JOIN  CNT.CentroCosto CN	ON CN.id=C.id_centrocosto
		INNER JOIN CNT.SaldoProveedor S	ON S.id = C.id_saldo 
		LEFT JOIN  CNTCuentas CU		ON CU.id=C.id_ctaant
		LEFT JOIN  CNTCuentas CS        ON CS.id = C.id_ctaact
		INNER JOIN CNT.TipoDocumentos TT ON TT.id = C.id_tipodoc
		INNER JOIN ST_Listados SL		 ON SL.id = CU.categoria
WHERE Tipoter = 'PR'
GO


