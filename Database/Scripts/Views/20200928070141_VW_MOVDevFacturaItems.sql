--liquibase formatted sql
--changeset ,JTOUS:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[dbo].[VW_MOVDevFacturaItems]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
Drop View [dbo].[VW_MOVDevFacturaItems]
END
GO

CREATE VIEW [dbo].[VW_MOVDevFacturaItems]

AS
		SELECT 			
			FI.id,
			FI.id_devolucion,
			F.id_factura,
			FI.id_articulo,			
			A.codigo,
			A.presentacion,
			A.nombre, 
			FI.cantidad, 
			FI.precio, 
			FI.serie,
			FI.lote,
			FI.descuento,
			FI.iva,
			FI.porceniva poriva,
			FI.inc,
			FI.porceninc porinc,
			FI.pordescuento pordsto,
			FI.precio * FI.cantidad AS preciobruto,			
			F.id_user [user],
			FI.total,
			ISNULL(B.nombre, '') bodega,
			F.estado,
			FI.id_bodega, 
			F.created,
			convert(varchar(10), F.fecha, 120) fechadev,
			FI.id_itemfac,
			FI.inventarial,
			FI.preciodesc
		FROM   
			dbo.MOVDevFacturaItems AS FI 
			INNER JOIN dbo.MOVDevFactura	AS F ON F.id = FI.id_devolucion
			INNER JOIN dbo.Productos	AS A ON A.id = FI.id_articulo			
			LEFT JOIN Dbo.Bodegas B ON B.id = FI.id_bodega;


GO


