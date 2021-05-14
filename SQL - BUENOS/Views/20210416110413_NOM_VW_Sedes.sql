--liquibase formatted sql
--changeset ,JPAREDES:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[NOM].[VW_Sedes]') AND OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
DROP VIEW [NOM].[VW_Sedes]
END
GO
CREATE VIEW [NOM].[VW_Sedes]

AS
	SELECT  S.id,
			S.id_ciudad,
			S.nombre sede,
			S.estado,
			D.nombre ciudad,
			D.nombredep depart,
			CONCAT(D.nombredep,' - ',D.nombre) nombredep
	FROM [NOM].[Sedes] S
	INNER JOIN [dbo].[DivPolitica] D ON D.id = S.id_ciudad