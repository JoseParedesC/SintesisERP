--liquibase formatted sql
--changeset ,CZULBARAN:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[dbo].[VW_MOVConversiones]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
Drop View [dbo].[VW_MOVConversiones]
END
GO

CREATE VIEW [dbo].[VW_MOVConversiones]
AS

		SELECT  A.id, 
		CONVERT(VARCHAR(10),A.fechadocumen,120) fechadocumen, 
		S.iden estado,
		A.costo,  
		A.id_centrocosto,
		CC.nombre centrocosto,
		A.id_bodegadef,
		B.nombre bodega,
		A.id_tipodoc
		FROM dbo.MOVConversiones A 
				INNER JOIN ST_Listados S ON S.id = A.estado
				INNER JOIN CNT.CentroCosto CC ON A.id_centrocosto = CC.id
				INNER JOIN Bodegas B ON B.id = A.id_bodegadef

GO


