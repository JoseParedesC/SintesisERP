--liquibase formatted sql
--changeset ,jeteme:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[dbo].[VW_Bodegas]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
Drop View [dbo].[VW_Bodegas]
END
GO
CREATE VIEW [dbo].[VW_Bodegas]
AS
SELECT        B.id
			, B.codigo
			, B.nombre
			, B.ctainven
			, B.ctacosto
			, B.ctadescuento
			, B.ctaingreso
			, B.ctaingresoexc
			, b.ctaivaflete
			, B.estado
			, A.codigo AS nomctainven
			, C.codigo AS nomctacosto
			, H.codigo AS nomctadescuento
			, I.codigo AS nomctaingreso
			, J.codigo AS nomctaingexc
			, F.codigo AS nomctaivaflete
FROM            
			dbo.Bodegas AS B LEFT OUTER JOIN
            dbo.CNTCuentas AS A ON A.id = B.ctainven LEFT OUTER JOIN
            dbo.CNTCuentas AS C ON C.id = B.ctacosto LEFT OUTER JOIN
            dbo.CNTCuentas AS H ON H.id = B.ctadescuento LEFT OUTER JOIN
            dbo.CNTCuentas AS I ON I.id = B.ctaingreso LEFT OUTER JOIN
            dbo.CNTCuentas AS J ON J.id = B.ctaingresoexc LEFT OUTER JOIN
            dbo.CNTCuentas AS F ON F.id = B.ctaivaflete

GO