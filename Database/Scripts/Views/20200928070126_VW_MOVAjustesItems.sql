--liquibase formatted sql
--changeset ,jeteme:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[dbo].[VW_MOVAjustesItems]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
	Drop View [dbo].[VW_MOVAjustesItems]
END
GO

CREATE VIEW [dbo].[VW_MOVAjustesItems]
AS
		SELECT 
			TI.id,
			A.id id_articulo,
			A.codigo,
			A.presentacion,
			A.nombre, 
			B.nombre AS bodega, 
			[TI].cantidad,
			[TI].costo,
			TI.costoante,
			ti.serie,
			ti.lote,
			id_ajuste,
			id_reversion,
			(costo * cantidad) costototal,
			T.created,
			[TI].id_bodega,
			TI.id iditem,
			T.estado,
			CONVERT(varchar(10), T.fecha, 120) fecha
		FROM   
			[dbo].[MOVAjustesItems] AS [TI] 
			INNER JOIN dbo.MOVAjustes	AS T ON T.id = [TI].id_ajuste
			INNER JOIN dbo.Bodegas		AS B ON B.id = [TI].id_Bodega 
			INNER JOIN dbo.Productos	AS A ON A.id = [TI].id_articulo;




GO


