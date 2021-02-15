--liquibase formatted sql
--changeset ,jeteme:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[CNT].[VW_MOVComprobantesEgresos]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
Drop View [CNT].[VW_MOVComprobantesEgresos]
END
GO




CREATE VIEW [CNT].[VW_MOVComprobantesEgresos]
AS
select		c.id ,
			CONVERT(VARCHAR(10), c.fecha, 120) AS fecha, 
			CONVERT(VARCHAR(10), c.fecha, 120) AS fechadoc,
			R.razonsocial AS proveedor,
			c.id_proveedor,
			c.valorpagado valorproveedor,
			c.valorconcepto,
			c.estado,
			l.nombre nomestado,
			c.updated,
			c.detalle,
			c.cambio,
			c.id_tipodoc,
			D.nombre tipodoc,
			c.id_centrocosto,
			O.nombre centrocosto,
			c.id_reversion,
			C.id_ctaant,
			CONCAT(CU.id,'-',CU.nombre) ctaanticipo,
			C.valoranticipo
			from CNT.MOVComprobantesEgresos C                           LEFT OUTER JOIN 
				 CNT.Terceros       R  ON   C.id_proveedor=R.id         LEFT OUTER JOIN 
				 dbo.ST_Listados    L  ON   L.id = C.estado             LEFT OUTER JOIN
				 CNT.TipoDocumentos D  ON   C.id_tipodoc=d.id	    	LEFT OUTER JOIN
				 CNT.CentroCosto    O  ON   O.id=c.id_centrocosto		LEFT OUTER JOIN
				 CNTCuentas         CU ON	C.id_ctaant=CU.id



GO


