--liquibase formatted sql
--changeset ,jeteme:3 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[dbo].[VW_MOVFacturaItems]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
Drop View [dbo].[VW_MOVFacturaItems]
END
GO

CREATE VIEW [dbo].[VW_MOVFacturaItems]
AS
SELECT      FI.id_factura, 
			FI.id, 
			FI.id_producto,
			FI.id_bodega,
			F.consecutivo, 
			CONVERT(VARCHAR(10), F.fechafac, 120) AS fechafac, 
			A.codigo, 
			A.presentacion, 
			A.nombre, 
			B.nombre AS Bodega, 
			FI.cantidad, 
			FI.precio, 
			FI.preciodesc,
			FI.descuentound,
			Fi.descuento,
			FI.pordescuento,
			FI.iva, 
			FI.poriva,
			FI.inc,  
			FI.porinc,
			(FI.precio * FI.cantidad) AS preciobruto, 
			FI.total, 
			FI.costo,   
			FI.formulado, 
			F.estado, 
			F.created, 
			FI.serie, 
			FI.lote,
			FI.inventarial,
			F.id_user AS [user],
			Fi.id_iva,
			Fi.id_inc,
			FI.descripcion,
			F.prefijo+'-'+CAST(F.consecutivo AS VARCHAR) consecutivofac,
			F.id_tercero terceroid,
			FI.cuota cuotacausa
FROM  dbo.MOVFacturaItems AS FI INNER JOIN
      dbo.MOVFactura AS F ON F.id = FI.id_factura LEFT JOIN
      dbo.Bodegas AS B ON B.id = FI.id_bodega INNER JOIN
      dbo.VW_Productos AS A ON A.id = FI.id_producto

GO
