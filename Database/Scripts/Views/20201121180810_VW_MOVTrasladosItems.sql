--liquibase formatted sql
--changeset ,jeteme:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[dbo].[VW_MOVTrasladosItems]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
Drop View [dbo].[VW_MOVTrasladosItems]
END
GO

CREATE VIEW [dbo].[VW_MOVTrasladosItems]
AS
	SELECT 
			Ti.id,
			A.id id_articulo,
			A.codigo,
			A.presentacion,
			A.nombre, 
			A.lote,
			A.serie,
			B.id id_bodega,
			BD.id id_bodegades,
			B.nombre AS bodega, 
			BD.nombre AS bodegades, 
			[TI].cantidad,
			[TI].costo,
			[TI].cantidad*[TI].costo costototal,
			id_traslado,
			id_reversion,
			T.created,
			T.estado,
			Ti.id iditem,
			Convert(varchar(10), T.fecha, 120) fecha
		FROM   
			[dbo].[MOVTrasladosItems] AS [TI] 
			INNER JOIN dbo.MOVTraslados	AS T ON T.id = [TI].id_traslado
			INNER JOIN dbo.Bodegas		AS B ON B.id = [TI].id_Bodega 
			INNER JOIN dbo.Bodegas		AS BD ON BD.id = [TI].id_bodegades
			INNER JOIN dbo.Productos	AS A ON A.id = [TI].id_articulo;

GO


