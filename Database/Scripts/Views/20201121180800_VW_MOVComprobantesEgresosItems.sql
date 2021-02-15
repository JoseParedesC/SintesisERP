--liquibase formatted sql
--changeset ,jeteme:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[CNT].[VW_MOVComprobantesEgresosItems]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
Drop View [CNT].[VW_MOVComprobantesEgresosItems]
END
GO


CREATE VIEW [CNT].[VW_MOVComprobantesEgresosItems]
AS


	SELECT	R.id,
			R.id_comprobante,
			R.id_documento,
			R.nrofactura,
			R.valor
	FROM CNT.MOVComprobantesEgresosItems R INNER JOIN 
	CNT.SaldoProveedor F ON F.id = R.id_documento

GO


