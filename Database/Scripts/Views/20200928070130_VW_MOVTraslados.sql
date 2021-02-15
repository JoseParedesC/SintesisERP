--liquibase formatted sql
--changeset ,jeteme:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[dbo].[VW_MOVTraslados]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
Drop View [dbo].[VW_MOVTraslados]
END
GO



CREATE VIEW [dbo].[VW_MOVTraslados]
AS
		SELECT P.id, 
			   P.id_tipodoc,
			   T.nombre tipodocumento,
			   CONVERT(VARCHAR(10), P.fecha, 120) AS fecha, 
			   P.fecha AS rptfechadocumen, 
			   L.nombre AS estado, 
			   P.id_reversion, 
			   P.contabilizado, 
			   P.id_centrocosto,
			   C.nombre CentroCosto,
			   P.created,
			   P.descripcion,p.costototal
		FROM dbo.MOVTraslados AS P 
		LEFT OUTER JOIN	dbo.ST_Listados AS L ON L.id = P.estado
		LEFT OUTER JOIN CNT.CentroCosto AS C ON P.id_centrocosto=C.id
		LEFT OUTER JOIN CNT.TipoDocumentos AS T ON P.id_tipodoc=T.id




GO


