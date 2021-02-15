--liquibase formatted sql
--changeset ,kmartinez:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[FIN].[VW_MOVRefinanciacionFianan]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
Drop View [FIN].[VW_MOVRefinanciacionFianan]
END
GO

CREATE VIEW [FIN].[VW_MOVRefinanciacionFianan]
AS
SELECT  
	F.id,
	id_tipodoc, 
	id_cliente,
	fechadoc,
	numfactura,
	totalcredito,
	cuotas,
	id_factura,
	C.id id_centrocosto,
	C.codigo centrocosto
FROM [FIN].[RefinanciacionFact]     F
LEFT JOIN CNT.VW_CentroCosto C ON F.id_centrocostos = C.id

		 




GO


