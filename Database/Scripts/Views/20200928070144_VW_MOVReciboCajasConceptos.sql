--liquibase formatted sql
--changeset ,jeteme:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[CNT].[VW_MOVReciboCajasConceptos]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
Drop View CNT.VW_MOVReciboCajasConceptos
END
GO

CREATE VIEW [CNT].[VW_MOVReciboCajasConceptos]
AS

SELECT R.id,R.id_recibo,R.id_concepto,P.nombre concepto,R.valor FROM CNT.MovReciboCajasConcepto R INNER JOIN dbo.productos P
	   on R.id_concepto=P.id
	



GO


