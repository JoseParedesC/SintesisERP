--liquibase formatted sql
--changeset ,jeteme:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[dbo].[VW_CNTCuentas]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
Drop View [dbo].[VW_CNTCuentas]
END
GO


CREATE VIEW [dbo].[VW_CNTCuentas]
AS
/***************************************
*Nombre:		[dbo].[VW_CNTCuentas]
----------------------------------------
*Tipo:			Vista
*creaci�n:		08/04/17
*Desarrollador: (JTOUS)
***************************************/
		SELECT        
			C.id,
			ISNULL(CC.codigo,'') + C.subcodigo codigo,
			C.nombre,
			C.estado,
			ISNULL(CC.codigo,'') id_padre,
			C.tipo,
			C.bloqueada,
			C.subcodigo,
			C.indice,
			C.idparent,
			C.id_tipocta,
			C.categoria,
			cc.nombre padrenombre
		FROM    
			dbo.CNTCuentas AS C
		LEFT JOIN Dbo.CNTCuentas CC ON C.idparent = CC.id

GO


