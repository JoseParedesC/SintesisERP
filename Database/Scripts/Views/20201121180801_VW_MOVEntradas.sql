--liquibase formatted sql
--changeset ,jeteme:3 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[dbo].[VW_MOVEntradas]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
Drop View [dbo].[VW_MOVEntradas]
END
GO

CREATE VIEW [dbo].[VW_MOVEntradas]
AS

SELECT      P.id, 
			CONVERT(VARCHAR(10), P.fechadocumen, 120) AS fechadocumen, 
			P.fechadocumen AS rptfechadocumen,
			CONVERT(VARCHAR(10), P.fechafactura, 120) AS fechafactura,
			CONVERT(VARCHAR(10), P.fechavence, 120) AS fechavence,
			P.numfactura,
			P.diasvence,
			L.nombre AS estado,
			P.estado idestado,
			P.id_bodega,
			B.nombre AS nombrebodega, 
			P.id_proveedor, 
			TT.razonsocial proveedor, 
			P.costo, 
			P.iva, 
			P.descuento, 
			P.flete, 
			P.valor, 
			P.id_reversion, 
			P.id_pedido, 
			P.poriva,
			P.reteiva, 
			P.porica,
            P.reteica,
			P.porfuente, 
			P.retefuente, 
			P.created, 
			P.id_formaPagos, 
			F.nombre AS FormaPago, 
			P.inc, 
			P.id_proveflete, 
			T.razonsocial proveedorFlete, 
			P.id_formapagoflete, 
			G.nombre AS FormaPagoFlete,
			P.id_centrocostos id_centro,
			H.codigo +' - ' + H.nombre centrocosto,
			P.id_tipodoc,
			D.nombre tipodocumento,
			P.ivaflete,
			B.ctaivaflete,
			P.contabilizado,
			P.id_ctaant,
			CONCAT(C.id,'-',C.nombre) ctaanticipo,
			P.valoranticipo
FROM	dbo.MOVEntradas		AS P									LEFT OUTER JOIN
		CNT.Terceros        AS TT ON TT.id = P.id_proveedor			LEFT OUTER JOIN        
        dbo.ST_Listados		AS L ON L.id				= P.estado	LEFT OUTER JOIN
        dbo.Bodegas			AS B ON P.id_bodega			= B.id		LEFT OUTER JOIN
        dbo.FormaPagos		AS F ON P.id_formaPagos		= F.id		LEFT OUTER JOIN
        CNT.Terceros		AS T ON P.id_proveflete		= T.id		LEFT OUTER JOIN
        dbo.FormaPagos		AS G ON P.id_formapagoflete = G.id		LEFT OUTER JOIN
		CNT.CentroCosto		AS H ON P.id_centrocostos	= H.id		LEFT OUTER JOIN
		CNT.TipoDocumentos	AS D ON P.id_tipodoc		= D.id		LEFT OUTER JOIN
		CNTCuentas			AS C ON P.id_ctaant			= C.id
GO


