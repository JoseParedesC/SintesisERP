--liquibase formatted sql
--changeset ,jeteme:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[CNT].[VW_CategoriaFiscal]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
Drop View CNT.VW_CategoriaFiscal
END
GO
CREATE VIEW [CNT].[VW_CategoriaFiscal]
AS
SELECT  
		  CF.id
		, CF.codigo
		, CF.descripcion
		, ISNULL(I1.id,0) id_retefuente
		, ISNULL(I1.valor, 0) retefuente
		, CF.valorfuente
		, ISNULL(I2.id, 0) id_reteiva
		, ISNULL(I2.valor, 0) reteiva
		, CF.valoriva
		, ISNULL(I3.id, 0) id_reteica
		, ISNULL(I3.valor, 0) reteica
		, CF.valorica
		, CF.retiene
		, CF.estado
FROM        CNTCategoriaFiscal CF
LEFT JOIN	CNT.Impuestos I1 ON CF.id_retefuente = I1.id
LEFT JOIN	CNT.Impuestos I2 ON CF.id_reteiva = I2.id
LEFT JOIN	CNT.Impuestos I3 ON CF.id_reteica = I3.id              


GO


