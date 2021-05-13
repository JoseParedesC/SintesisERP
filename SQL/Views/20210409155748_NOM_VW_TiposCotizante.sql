--liquibase formatted sql
--changeset ,JPAREDES:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[NOM].[VW_TiposCotizante]') AND OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
DROP VIEW [NOM].[VW_TiposCotizante]
END
GO
CREATE VIEW [NOM].[VW_TiposCotizante]

AS

SELECT  TP.id id_subtipo,
		TP.codigo,
		TC.id_tipo id_padre,
		TC.id id_tipo_subtipo,
		TP.codigo_externo,
		TP.descripcion,
		CONVERT(VARCHAR(16), TP.created, 120) AS created, 
		CONVERT(VARCHAR(16), TP.updated, 120) AS updated,
		TP.id_usercreated,
		TP.id_userupdated
FROM [NOM].[SubtiposCotizante] TP INNER JOIN 
	 [NOM].[Tipos_SubtiposCotizantes] TC ON TC.id_subtipo = TP.id
	 WHERE TC.id_tipo IS NOT NULL

