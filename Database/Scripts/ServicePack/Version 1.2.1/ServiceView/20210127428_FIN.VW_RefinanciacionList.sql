--liquibase formatted sql
--changeset ,kmartinez:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[FIN].[VW_RefinanciacionList]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
Drop View [FIN].[VW_RefinanciacionList]
END
GO

CREATE VIEW [FIN].[VW_RefinanciacionList]
AS
SELECT   
	 t.id id, 
	 CONVERT(VARCHAR(10),t.fechadoc, 120) AS fecha, 
	 t.numfactura numfactura, 
	 (t.totalcredito + ISNULL(T.valorintmora,0)) valor, 
	 t.id_factura,
	 L.nombre estado
FROM [FIN].[RefinanciacionFact] t LEFT JOIN [dbo].[ST_Listados]  L ON t.estado = L.id 
 


GO


