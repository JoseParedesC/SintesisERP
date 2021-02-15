--liquibase formatted sql
--changeset ,kmartinez:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[FIN].[TotalPorcentajeServiCredito]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
	Drop View [FIN].[TotalPorcentajeServiCredito]
END
GO
CREATE VIEW [FIN].[TotalPorcentajeServiCredito]
AS
	SELECT 
			A.id, 
			A.Codigo, 
			A.Nombre, 
			t.id_financiero, 
			t.id_lineascredito, 
			t.porcentaje
	FROM 	[FIN].[Financiero_lineacreditos] AS t INNER JOIN 
			[FIN].[LineasCreditos] AS A ON t.id_lineascredito = A.id

GO


