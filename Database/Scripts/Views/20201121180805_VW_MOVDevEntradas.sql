--liquibase formatted sql
--changeset ,jeteme:3 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[dbo].[VW_MOVDevEntradas]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
	Drop View [dbo].[VW_MOVDevEntradas]
END
GO


CREATE VIEW [dbo].[VW_MOVDevEntradas]
AS
SELECT      D.id, 
			D.id_entrada, 
			CONVERT(VARCHAR(10), D.fechadocumen, 120) AS fechadocumen, 
			D.fechadocumen AS rptfechadocumen, 
			P.fechadocumen fechacompra,
			P.fechafactura, 
			P.fechavence, 
			P.numfactura, 
			P.diasvence, 
			P.estado idestado,
			L.nombre AS estado, 
			D.id_bodega,
			P.nombrebodega,
			P.id_proveedor, 
			P.proveedor,
			D.costo, 
			D.iva, 
			D.descuento, 
			D.valor, 
			D.id_reversion, 
			D.poriva,
			D.reteiva,
			D.porica, 
			D.reteica,
			D.porfuente, 
			D.retefuente,
			D.created, 
			P.id_formaPagos,
			P.FormaPago,
			D.inc, 
			P.id_centro,
			P.centrocosto,
			P.id_tipodoc,
			P.tipodocumento,
			D.contabilizado,
			D.id_ctaant,
			CONCAT(C.id,'-',C.nombre) ctaanticipo,
			D.valoranticipo
FROM    dbo.MOVDevEntradas AS D INNER JOIN
        dbo.VW_MOVEntradas AS P ON D.id_entrada = P.id LEFT OUTER JOIN            
        dbo.ST_Listados AS L ON L.id = D.estado        LEFT OUTER JOIN
		CNTCuentas			AS C ON D.id_ctaant			= C.id

GO


