--liquibase formatted sql
--changeset ,jeteme:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[CNT].[VW_TercerosTipo]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
	Drop View CNT.VW_TercerosTipo
END
GO

CREATE VIEW [CNT].[VW_TercerosTipo]
AS
SELECT  
		  TT.id
		, C.id id_tercero
		, tercero
		, c.iden
		, nombretipoiden
		, L.id id_tipoter
		, L.nombre tipo
		, L.iden codigo
FROM	CNT.VW_Terceros AS C INNER JOIN
		CNT.TipoTerceros TT ON C.id  = TT.id_tercero INNER JOIN
		ST_Listados L ON TT.id_tipotercero = L.id
		
GO


