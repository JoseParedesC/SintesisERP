--liquibase formatted sql
--changeset ,jeteme:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[CNT].[VW_TipoDocumentos]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
	Drop View CNT.[VW_TipoDocumentos]
END
GO


CREATE VIEW [CNT].[VW_TipoDocumentos]
AS
SELECT 		t.id, 
			t.codigo, 
			t.nombre, 
			c.id AS id_centrocosto,
			id_tipo, 
			t.isccosto, 
			c.codigo + ' - ' + c.nombre AS centrocosto, 
			t.estado, 
			t.created, 
			t.updated, 
			t.id_usercreated, 
			t.id_userupdated
FROM    CNT.TipoDocumentos AS t LEFT OUTER JOIN
        CNT.CentroCosto AS c ON t.id_centrocosto = c.id
GO


