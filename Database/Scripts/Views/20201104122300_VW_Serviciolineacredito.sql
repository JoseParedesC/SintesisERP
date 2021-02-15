--liquibase formatted sql
--changeset ,kmartinez:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[FIN].[VW_Serviciolineacredito]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
Drop View [FIN].[VW_Serviciolineacredito]
END
GO

CREATE VIEW [FIN].[VW_Serviciolineacredito]
AS
SELECT t.id, t.id_financiero, s.nombre as Servicios, t.id_lineascredito, t.porcentaje FROM  [FIN].[Financiero_lineacreditos] AS t inner join [FIN].[ServiciosFinanciero] s
on s.id = t.id_financiero

 




GO


