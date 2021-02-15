--liquibase formatted sql
--changeset ,jeteme:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[CNT].[VW_MOVComprobantesEgresosConceptos]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
Drop View CNT.[VW_MOVComprobantesEgresosConceptos]
END
GO



CREATE VIEW [CNT].[VW_MOVComprobantesEgresosConceptos]
AS

SELECT R.id,R.id_comprobante,R.id_concepto,P.nombre concepto,R.valor FROM CNT.MOVComprobantesEgresosConcepto R INNER JOIN dbo.productos P
	   on R.id_concepto=P.id
	




GO


