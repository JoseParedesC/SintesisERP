--liquibase formatted sql
--changeset ,jeteme:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[dbo].[VW_MOVCotizacionItems]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
Drop View [dbo].[VW_MOVCotizacionItems]
END
GO

CREATE VIEW [dbo].[VW_MOVCotizacionItems]
AS
		SELECT 
			FI.id_cotizacion,
			FI.id,
			FI.id_articulo,
			CONVERT(VARCHAR(10), F.fechacot, 120) fechacot,
			A.codigo,
			A.presentacion,
			A.nombre,  
			FI.cantidad, 
			FI.precio, 
			FI.descuento,
			FI.iva,
			FI.precio * FI.cantidad AS preciobruto,			
			F.id_user [user],
			FI.total,
			F.id_caja,
			FI.inc
		FROM   
			dbo.MOVCotizacionItems AS FI 
			INNER JOIN dbo.MOVCotizacion	AS F ON F.id = FI.id_cotizacion
			INNER JOIN dbo.Productos	AS A ON A.id = FI.id_articulo;


GO


