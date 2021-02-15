--liquibase formatted sql
--changeset ,jtous:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[dbo].[VW_CNTCategoriaFiscal]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
Drop View [dbo].[VW_CNTCategoriaFiscal]
END
GO


CREATE VIEW [dbo].[VW_CNTCategoriaFiscal]
AS
/***************************************
*Nombre:		[dbo].[VW_CNTCategoriaFiscal]
----------------------------------------
*Tipo:			Vista
*creación:		02/04/17
*Desarrollador: (JTOUS)
***************************************/
		SELECT        
				F.id,
				F.codigo,
				F.descripcion,	
				F.id_retefuente,
				F.id_reteica,
				F.id_reteiva,
				A.nombre NombreRetefuente,
				B.nombre NombreReteIva,
				C.nombre NombreReteIca,
				F.valorfuente fuentebase,
				F.valorica icabase,
				F.valoriva ivabase,			
				F.retiene,
				F.estado,
				F.created
		FROM    dbo.CNTCategoriaFiscal AS F
		LEFT JOIN CNT.Impuestos A on A.id = F.id_retefuente
		LEFT JOIN CNT.Impuestos B on B.id = F.id_reteiva
		LEFT JOIN CNT.Impuestos C on C.id = F.id_reteica



GO


