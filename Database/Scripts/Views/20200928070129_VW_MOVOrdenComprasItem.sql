--liquibase formatted sql
--changeset ,jeteme:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[dbo].[VW_MOVOrdenComprasItem]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
	Drop View [dbo].[VW_MOVOrdenComprasItem]
END
GO

CREATE VIEW [dbo].[VW_MOVOrdenComprasItem]
AS
SELECT        
			P.id, 
			EI.id_producto, 
			A.codigo, 
			A.presentacion, 
			A.nombre, 
			P.id AS id_orden, 
			B.nombre AS bodega, 
			EI.id_bodega, 
			EI.cantidad, 
			EI.costo,
			EI.costototal,
			P.estado, 
			P.created, 
			CONVERT(varchar(10), P.fechadocument, 120) AS fechaentra
FROM    dbo.MOVOrdenComprasItem		AS EI INNER JOIN
        dbo.MovOrdenCompras			AS P ON P.id = EI.id_ordencompra INNER JOIN
        dbo.Bodegas					AS B ON B.id = EI.id_bodega INNER JOIN
        dbo.Productos				AS A ON A.id = EI.id_producto


GO
