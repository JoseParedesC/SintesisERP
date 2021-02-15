--liquibase formatted sql
--changeset ,kmartinez07:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[dbo].[VW_MOVFacturaRecurrentesItems]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
Drop View [dbo].[VW_MOVFacturaRecurrentesItems]
END
GO

CREATE VIEW [dbo].[VW_MOVFacturaRecurrentesItems]

/***************************************
*Nombre: [dbo].[VW_MOVFacturaRecurrentesItems]
----------------------------------------
*Tipo: Vista
*creación: 15/10/2020
*Desarrollador: (Kmartinez)Kevin Jose Martinez Teheran
*Descripcion: Esta vista es para Mostar el servicio de factura recurrentes
***************************************/

AS
SELECT      FI.id_factura, 
			FI.id, 
			FI.id_producto,
			FI.id_bodega,
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
			F.id_user AS [user]
FROM  [dbo].[MOVFacturaRecurrentesItems] AS FI INNER JOIN
      [dbo].[MOVFacturasRecurrentes] AS F ON F.id = FI.id_factura INNER JOIN
      dbo.Bodegas AS B ON B.id = FI.id_bodega INNER JOIN
      dbo.VW_Productos AS A ON A.id = FI.id_producto
GO


