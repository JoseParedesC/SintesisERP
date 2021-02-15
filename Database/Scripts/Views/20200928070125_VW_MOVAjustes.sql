--liquibase formatted sql
--changeset ,jeteme:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[dbo].[VW_MOVAjustes]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
	Drop View [dbo].[VW_MOVAjustes]
END
GO
CREATE VIEW [dbo].[VW_MOVAjustes]
AS
		SELECT 
			P.id,
			P.id_tipodoc,
			T.nombre tipodocumento,
			p.id_centrocosto,
			O.nombre centrocosto,
			Convert(VARCHAR(10), P.fecha, 120) fecha,
			L.nombre estado,
			P.id_concepto,
			C.nombre concepto,			
			P.costototal,
			P.id_reversion,
			P.contabilizado,
			p.detalle,
			P.created,
			CONVERT(varchar, P.fecha, 111) fechatran
		FROM   
			dbo.MOVAjustes	AS P
		LEFT JOIN Dbo.Productos C ON P.id_concepto = C.id
		LEFT JOIN Dbo.ST_Listados L ON L.id = P.estado
		LEFT JOIN CNT.TipoDocumentos T ON T.id=P.id_tipodoc
		LEFT JOIN CNT.CentroCosto O ON O.id=P.id_centrocosto

GO


