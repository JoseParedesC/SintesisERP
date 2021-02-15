--liquibase formatted sql
--changeset ,jeteme:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[dbo].[VW_MOVDevAnticipos]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
Drop View [dbo].[VW_MOVDevAnticipos]
END
GO




CREATE VIEW [dbo].[VW_MOVDevAnticipos]
AS
/***************************************
*Nombre:		[dbo].[VW_MOVDevAnticipos]
----------------------------------------
*Tipo:			Vista
*creaci�n:		15/01/21
*Desarrollador: (Jeteheran)
***************************************/
		SELECT
		A.id_tipodoc, 
		A.id_centrocostos,
		C.nombre centrocostos,
		A.id, 
		L.nombre		estado,
		A.descripcion,
		valor,
		A.id_cliente id_tercero,
		r.razonsocial tercero,
		CONVERT(VARCHAR(10), A.fecha, 120)		fecha,
		A.id_cta,
		CU.nombre cuenta,
		A.id_formapago,
		F.nombre formapago,
		id_reversion,
		R.iden,
		A.id_tipoanticipo ,
		S.nombre Tipo,
		U.username,
		U.nombre usuario,
		A.id_user,
		A.estado id_estado
		FROM   [dbo].[MOVDevAnticipos] A
		INNER JOIN Dbo.ST_Listados L ON L.id = A.estado
		INNER JOIN CNT.Terceros	R ON R.id = A.id_cliente 
		LEFT JOIN Dbo.Usuarios U ON U.id = A.id_user
		LEFT JOIN CNT.CentroCosto C ON C.id = A.id_centrocostos
		INNER JOIN CNTCuentas CU ON CU.id = A.id_cta
		LEFT JOIN dbo.FormaPagos F ON F.id = A.id_formapago
		INNER JOIN Dbo.ST_Listados S ON S.id = A.id_tipoanticipo


GO


