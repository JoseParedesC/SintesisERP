--liquibase formatted sql
--changeset ,jeteme:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[dbo].[VW_MOVAnticipos]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
Drop View [dbo].[VW_MOVAnticipos]
END
GO



CREATE VIEW [dbo].[VW_MOVAnticipos]
AS
SELECT      A.id, 
			L.nombre AS estado, 
			A.descripcion, 
			A.valor,  
			A.id_tercero, 
			A.id_tipoanticipo,
			S.nombre Tipoanticipo,
			R.iden, 
			R.razonsocial tercero,
            CONVERT(VARCHAR(10), A.fecha, 120) AS fecha, 
			A.id_reversion, 
			U.username, 
			U.nombre AS usuario, 
			A.id_user, 
			A.estado AS id_estado, 
			A.id_formapago, 
			id_tipodoc,
		    id_centrocostos,
			O.nombre centrocosto,
			A.id_cuenta,
			C.codigo cuenta
FROM    dbo.MOVAnticipos	A INNER JOIN
		Dbo.CNTCuentas		C ON C.id = A.id_cuenta	INNER JOIN
        dbo.ST_Listados		L ON L.id = A.estado INNER JOIN
        CNT.Terceros		R ON R.id = A.id_tercero INNER JOIN
        dbo.Usuarios		U ON U.id = A.id_user LEFT OUTER JOIN
		CNT.CentroCosto		O ON O.id = A.id_centrocostos INNER JOIN
		dbo.ST_Listados		S ON S.id = A.id_tipoanticipo
GO


