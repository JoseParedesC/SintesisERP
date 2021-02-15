--liquibase formatted sql
--changeset ,jeteme:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[dbo].[VW_MOVEntradasItems]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
Drop View [dbo].[VW_MOVEntradasItems]
END
GO


CREATE VIEW [dbo].[VW_MOVEntradasItems]
AS
SELECT      M.id, 
			M.id_entrada, 
			A.id AS id_articulo, 
			A.codigo, 
			A.presentacion, 
			A.nombre, 
			B.id AS id_bodega, 
			B.nombre AS bodega, 
			M.id_lote, 
			L.lote, 
			M.cantidad, 
			M.iva, 
			M.costo, 
			M.descuento, 
			M.descuentound,
			M.costototal, 
			M.inc, 
			M.flete, 
			M.porceninc, 
			M.serie,			
			M.porceniva, 
			CONVERT(VARCHAR(10), L.vencimiento_lote, 120) AS vencimientoLote,
			M.id_ctainc,
			M.id_ctaiva,
			E.estado,
			E.idestado,
			E.created,
			E.fechadocumen fechaentra
FROM   dbo.MOVEntradasItems AS M INNER JOIN
		dbo.Productos		AS A ON M.id_articulo = A.id INNER JOIN
		dbo.Bodegas			AS B ON M.id_bodega = B.id LEFT OUTER JOIN
		dbo.LotesProducto	AS L ON M.id_lote = L.id INNER JOIN
		dbo.VW_MOVEntradas     AS E ON M.id_entrada=E.id
GO


