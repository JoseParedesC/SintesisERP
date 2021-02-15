--liquibase formatted sql
--changeset ,jeteme:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[CNT].[VW_CentroCosto]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
Drop View CNT.VW_CentroCosto
END
GO

CREATE VIEW [CNT].[VW_CentroCosto]
AS
SELECT  
		C.id, 
		ISNULL(CE.codigo,'') + C.subcodigo codigo, 
		C.nombre, 
		C.estado, 
		ISNULL(CE.codigo,'') id_padre, 
		C.detalle, 
		CONVERT(VARCHAR(16), C.created, 120) AS created, 
		CONVERT(VARCHAR(16), C.updated, 120) AS updated, 
        C.id_usercreated, 
		C.id_userupdated, 
		C.subcodigo, 
		C.indice, 
		C.idparent
FROM  CNT.CentroCosto AS C LEFT JOIN
	  CNT.CentroCosto AS CE ON C.idparent = CE.id

GO