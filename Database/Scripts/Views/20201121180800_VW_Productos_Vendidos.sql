--liquibase formatted sql
--changeset ,jeteme:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[dbo].[VW_Productos_Vendidos]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
Drop View [dbo].[VW_Productos_Vendidos]
END
GO

CREATE VIEW [dbo].[VW_Productos_Vendidos]
AS

SELECT	F.id,
		F.id_tercero,
		P.id id_producto,
		codigo,
		p.nombre,
		P.serie,
		ISNULL(LO.lote,'') Lote,
		ISNULL((SELECT STUFF((SELECT ', ' + serie
		FROM dbo.MovFacturaSeries L INNER join MOVFactura E ON L.id_factura=E.id where L.id_items=I.id
		FOR XML PATH ('')),1,2,'')),'') Series,
		presentacion,
		nombreTipoProducto,
		L.id_lote,
		IIF(L.id_lote is NULL,SUM(I.cantidad),SUM(L.cantidad)) cantidad,
		SUM(i.preciodesc) valorbruto,
		SUM(i.preciodesc)-SUM(i.descuento) subtotal,
		SUM(i.descuento) descuento,
		ISNULL(SUM(i.iva),0) total_iva,
		ISNULL(SUM(i.inc),0) total_inc,
		(SUM(i.preciodesc)-SUM(i.descuento)+ISNULL(SUM(i.iva),0)+ISNULL(SUM(i.INC),0))*IIF(L.id_lote is NULL,SUM(I.cantidad),SUM(L.cantidad))  total,
		F.fechafac
		FROM dbo.VW_Productos p inner join MOVFacturaItems i ON
		p.id=i.id_producto 	INNER JOIN MOVFactura F ON F.id=I.id_factura left outer join MOVFacturaLotes L ON
		L.id_factura=F.id AND L.id_item=I.id LEFT JOIN LotesProducto LO ON LO.id=L.id_lote
		GROUP BY codigo,p.nombre,nombreTipoProducto,presentacion,i.serie,I.ID,F.id,F.fechafac,F.id_tercero,LO.lote,L.id_lote,P.serie,P.id
		HAVING IIF(L.id_lote is NULL,SUM(I.cantidad),SUM(L.cantidad)) >0


GO


