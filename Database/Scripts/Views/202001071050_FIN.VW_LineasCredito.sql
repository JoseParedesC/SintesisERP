--liquibase formatted sql
--changeset ,kmartinez:3 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[FIN].[VW_LineasCredito]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
Drop View [FIN].[VW_LineasCredito]
END
GO

CREATE VIEW [FIN].[VW_LineasCredito]
AS
SELECT        t.id, t.Codigo, t.Nombre, t.id_ctacredito, A.codigo + '-' + A.nombre AS CuentaCredito, t.id_ctaintcorriente, t.id_ctaiva, t.ivaIncluido, t.porcenIva, t.id_ctamora, t.id_ctaantFianza,  N.codigo + '-' + N.nombre AS CuentaFianza,  t.Porcentaje, B.codigo + '-' + B.nombre AS CuentaCorriente, C.codigo + '-' + C.nombre AS CuentaMora, D.codigo + '-' + D.nombre AS iva, t.iva AS Estado, t.created, 
                         t.updated, t.id_user
FROM            FIN.LineasCreditos AS t INNER JOIN
                         dbo.CNTCuentas AS A ON t.id_ctacredito = A.id LEFT OUTER JOIN
                         dbo.CNTCuentas AS B ON t.id_ctaintcorriente = B.id LEFT OUTER JOIN
                         dbo.CNTCuentas AS C ON t.id_ctamora = C.id LEFT OUTER JOIN
                         dbo.CNTCuentas AS D ON t.id_ctaiva = D.id LEFT OUTER JOIN
						 dbo.CNTCuentas AS N ON t.id_ctaantFianza = N.id

GO


