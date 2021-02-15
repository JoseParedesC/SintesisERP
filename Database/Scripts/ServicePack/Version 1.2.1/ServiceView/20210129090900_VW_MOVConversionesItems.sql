--liquibase formatted sql
--changeset ,CZULBARAN:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[dbo].[VW_MOVConversionesItems]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
Drop View [dbo].[VW_MOVConversionesItems]
END
GO

CREATE VIEW [dbo].[VW_MOVConversionesItems]
AS

	SELECT  I.id,
			I.id_conversion, 
			P.id codigo, 
			B.nombre bodega, 
			P.nombre, 
			I.cantidad, 
			I.costo,
			I.costototal,
			I.serie,
			SUM(CAST(FO.serie AS INT)) config
	FROM Productos P 
	INNER JOIN [MOVConversionesItems] I ON P.id = I.id_articulo
	INNER JOIN DBO.Bodegas B ON B.id = I.id_bodega
	INNER JOIN DBO.MOVConversionesItemsForm FO ON FO.id_articulofac = I.id AND FO.id_conversion = I.id_conversion
	GROUP BY I.id, I.id_conversion, P.nombre, I.cantidad, I.costo, I.costototal, I.serie, P.id, B.nombre
GO