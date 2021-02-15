--liquibase formatted sql
--changeset ,jeteme:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[dbo].[VW_MOVDevEntradaItems]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
Drop View [dbo].[VW_MOVDevEntradaItems]
END
GO


CREATE VIEW [dbo].[VW_MOVDevEntradaItems]
AS
SELECT       FI.id, 
			 F.estado estado,
			 F.id AS id_devolucion, 
			 F.id_entrada, 
			 FI.id_articulo, 
			 A.codigo, 
			 A.presentacion, 
			 A.nombre, 
			 FI.id_bodega, 
			 B.nombre AS bodega, 
			 FI.id_lote,
			 L.lote,
			 FI.cantidad, 
			 FI.iva, 
			 FI.costo, 
			 FI.descuento,
			 Fi.descuentound,
			 FI.costototal, 
			 FI.inc,
			 FI.porceninc,
			 FI.serie,
			 FI.porceniva,
			 CONVERT(VARCHAR(10), L.vencimiento_lote, 120) AS vencimientoLote,
			 FI.id_ctainc,
			 FI.id_ctaiva,
			 FI.id_itementra,
			 F.created,
			 Fi.id_iva,
			 Fi.id_inc,
			 CONVERT(VARCHAR(10), F.fechadocumen, 120) AS fechadev
FROM	dbo.MOVDevEntradasItems AS FI INNER JOIN
        dbo.MOVDevEntradas AS F ON F.id = FI.id_devolucion INNER JOIN
        dbo.Productos AS A ON A.id = FI.id_articulo INNER JOIN
        dbo.Bodegas AS B ON B.id = FI.id_bodega INNER JOIN
        dbo.LotesProducto AS L ON FI.id_lote = L.id
GO


