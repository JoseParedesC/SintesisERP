--liquibase formatted sql
--changeset ,jeteme:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[dbo].[VW_ExistenciaLoteSerie]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
	Drop View [dbo].[VW_ExistenciaLoteSerie]
END
GO

CREATE VIEW [dbo].[VW_ExistenciaLoteSerie]

AS

SELECT 	E.id, 
		E.id_articulo, 
		E.id_bodega, 
		E.existencia, 
		E.costo, 
		S.serie, 
		S.id_lote 
FROM 	[dbo].[ExistenciaLoteSerie] S INNER JOIN
	[dbo].[Existencia] E ON E.id = S.id_existencia
GO


