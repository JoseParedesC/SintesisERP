--liquibase formatted sql
--changeset ,jeteme:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[dbo].[VW_Productos_Comprados]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
Drop View [dbo].[VW_Productos_Comprados]
END
GO


CREATE VIEW [dbo].[VW_Productos_Comprados]
AS
SELECT	F.id,
		F.id_proveedor,
		codigo,
		p.id id_producto,
		p.nombre,
		P.serie,
		ISNULL((SELECT STUFF((SELECT ', ' + serie
		FROM dbo.MovEntradasSeries L INNER join MOVEntradas E ON L.id_entrada=E.id where L.id_items=I.id
		FOR XML PATH ('')),1,2,'')),'') Series,
		l.lote,
		l.vencimiento_lote,
		presentacion,
		nombreTipoProducto,
		SUM(cantidad) cantidad,
		SUM(i.costo) valorbruto,
		SUM(i.costo)+SUM(i.descuento) subtotal,
		SUM(i.descuento) descuento,
		ISNULL(SUM(i.iva),0) total_iva,
		ISNULL(SUM(i.inc),0) total_inc,
		SUM(i.costototal) total,
		F.fechadocumen
		FROM dbo.VW_Productos p inner join MOVEntradasItems i ON
		p.id=i.id_articulo left join dbo.LotesProducto L ON I.id_lote=l.id
		INNER JOIN MOVEntradas F ON F.id=I.id_entrada 
		GROUP BY codigo,p.nombre,nombreTipoProducto,presentacion,i.serie,L.lote,L.vencimiento_lote,I.ID,F.id,F.fechadocumen,F.id_proveedor,P.serie,P.id
GO


