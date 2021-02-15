--liquibase formatted sql
--changeset ,JTOUS:5 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[dbo].[VW_MOVDevFacturas]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
Drop View [dbo].[VW_MOVDevFacturas]
END
GO
CREATE VIEW [dbo].[VW_MOVDevFacturas]

AS
			SELECT 
			P.id,		
			P.id_tipodoc,
			T.nombre Tipodocumento,
			P.id_centrocostos,
			CE.nombre Centrocosto,	
			Convert(VARCHAR(10), P.fecha, 120) fecha,
			L.nombre estado,
			P.iva,
			p.inc,
			P.id_bodega,
			P.descuento,
			P.subtotal,
			(P.subtotal - P.descuento) ssubtotal,
			(P.total - P.valoranticipo) total,			
			U.username,
			P.id_factura,
			F.rptconsecutivo consecutivo,
			P.id_caja,
			C.nombre caja,
			P.isPos,
			P.id_ctaant,
			Cu.nombre cuenta_ant,
			P.valoranticipo,
			P.isFe,
			F.id_vendedor,
			F.vendedor,
			P.contabilizado,
			F.id_cliente,
			P.estado id_estado,
			P.keyid,
			P.created,
			P.cufe,
			F.cufe cufefac,
			F.fechadoc fechafac,
			F.prefijo + CAST(F.consecutivo AS VARCHAR) preconfac,
			P.estadoFE,
			F.correo,
			F.iden + ' - ' +F.cliente cliente,
			F.direccion,
			F.telefono,
			F.ciudad,
			0 descuentogen,
			'EFE' moneda,
			'De Contado' modalidad
		FROM   
			dbo.MOVDevFactura	AS P
		LEFT JOIN Dbo.VW_MOVFacturas F ON F.id = P.id_factura
		LEFT JOIN Dbo.VW_Cajas C ON C.id = P.id_caja
		LEFT JOIN Dbo.ST_Listados L ON L.id = P.estado
		LEFT JOIN Dbo.Usuarios U ON P.id_user = U.id
		LEFT JOIN CNT.TipoDocumentos T ON P.id_tipodoc = T.id
		LEFT JOIN CNT.CentroCosto CE ON P.id_centrocostos = CE.id
		LEFT JOIN CNTCuentas CU ON CU.id = P.id_ctaant

GO


