--liquibase formatted sql
--changeset ,jeteme:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[dbo].[VW_BodegasProductos]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
Drop View [dbo].[VW_BodegasProductos]
END
GO

CREATE VIEW [dbo].[VW_BodegasProductos]
AS
SELECT        t.id, 
			t.id_producto, 
			t.id_bodega, 
			t.stockmin, 
			CONVERT(VARCHAR(16), t.created, 120) AS created, 
			CONVERT(VARCHAR(16), t.updated, 120) AS updated, 
			t.id_usercreated, 
			t.id_userupdated, 
			p.nombre AS producto, 
            b.nombre AS bodega, 
			t.stockmax
FROM    dbo.BodegasProducto AS t LEFT OUTER JOIN
        dbo.Productos AS p ON t.id_producto = p.id LEFT OUTER JOIN
        dbo.Bodegas AS b ON t.id_bodega = b.id
GO
