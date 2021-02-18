--liquibase formatted sql
--changeset ,JPAREDES:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[VW_MOVFacturas]') and OBJECTPROPERTY(id, N'IsView') = 1)
DROP VIEW [dbo].[VW_MOVFacturas]
GO
CREATE VIEW [dbo].[VW_MOVFacturas]
AS
SELECT      P.id, 
			P.consecutivo, 
			CONVERT(VARCHAR(10), P.fechafac, 120) AS fechadoc, 
			L.nombre AS estado, 
			P.iva, 
			P.inc,
			P.descuento, 
			P.subtotal, 
			P.subtotal - P.descuento AS ssubtotal,
			P.total, 
			P.totalcredito,
			P.valorpagado, 
			P.prefijo + '-' + CAST(P.consecutivo AS VARCHAR) AS rptconsecutivo, 
            P.prefijo, 
			P.resolucion,
			D.leyenda,
			R.iden,
			R.razonsocial AS cliente,
			R.direccion,
			R.telefono,
			R.ciudad,
            P.id_resolucion, 
			ISNULL(T.horainicio + ' - ' + T.horafin, '') AS turno, 
			U.username, 
			P.cambio, 
			R.id AS id_cliente, 			
			P.valoranticipo anticipo, 
			U.nombre AS nomusuario, 
			P.id_user,
			P.cufe	,
			'' relacionado,
			'EFE' moneda,
			P.valoranticipo,
			P.id_ctaant,
			CASE WHEN C.codigo IS NULL THEN '' ELSE C.codigo + ' - ' +C.nombre END cuentaant,
			P.id_vendedor,
			V.nombre vendedor,
			P.id_tipodoc,
			P.id_centrocostos,
			O.nombre centrocosto,
			P.isFe,
			P.ispos,
			p.id_caja,
			CC.nombre caja,
			P.contabilizado,
			E.email correo,
			P.observaciones,
			P.fechaautorizacion,
			CONVERT(VARCHAR(10), P.fechavence, 120) fechavence,
			P.tipofactura AS formaPagoFinan,
			P.id_turno,
			P.iscausacion,
			P.id_ctafin,
			P.PagoFinan,
			P.keyid,
			P.dsctoFinanciero,
			P.ctadescuento,
			CONCAT(CD.codigo,'-',CD.nombre) CuentaDescuentoFin,
			ST.nombre Modalidadventa,
			P.isOb isob -- adicion JPAREDES
FROM    dbo.MOVFactura AS P INNER JOIN 
		CNT.VW_Terceros E ON E.id = P.id_tercero LEFT OUTER JOIN
		DocumentosTecnicaKey D ON D.id = P.id_resolucion LEFT OUTER JOIN
        dbo.ST_Listados AS L ON L.id = P.estado LEFT OUTER JOIN
        CNT.VW_Terceros AS R ON P.id_tercero = R.id LEFT JOIN 
        dbo.Turnos AS T ON P.id_turno = T.id LEFT OUTER JOIN
        dbo.Usuarios AS U ON P.id_user = U.id LEFT JOIN
		VW_CNTCuentas C ON C.id = P.id_ctaant OR C.id = P.id_ctaobs LEFT JOIN --JPAREDES
		Vendedores V ON V.id = P.id_vendedor LEFT JOIN
		CNT.VW_CentroCosto O ON O.id = P.id_centrocostos LEFT JOIN 
		Cajas CC ON CC.id = p.id_caja LEFT JOIN 
		VW_CNTCuentas CD ON CD.id=p.ctadescuento  LEFT JOIN
		dbo.ST_Listados ST ON ST.id=P.tipofactura

GO