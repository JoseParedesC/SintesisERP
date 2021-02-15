--liquibase formatted sql
--changeset ,jeteme:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[dbo].[VW_CajasProceso]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
Drop View [dbo].[VW_CajasProceso]
END
GO

CREATE VIEW [dbo].[VW_CajasProceso]
AS
/***************************************
*Nombre:		[dbo].[VW_CajasProceso]
----------------------------------------
*Tipo:			Vista
*creación:		28/03/17
*Desarrollador: (JTOUS)
***************************************/
		SELECT        
			P.id,
			P.id_caja,
			A.nombre caja,
			W.nombre userapertura,
			C.nombre usercierre,
			CONVERT(VARCHAR(10), P.fechaapertura, 120) fechaapert,
			CONVERT(VARCHAR(10), P.fechacierre, 120) fechacierre,
			P.id_userapertura id_user,
			P.estado,
			P.valor,
			P.contabilizado
		FROM [dbo].[CajasProceso] P
		LEFT OUTER JOIN	dbo.Cajas AS A ON P.id_caja = A.id
		LEFT OUTER JOIN dbo.Usuarios AS W ON W.id = P.id_userapertura
		LEFT OUTER JOIN dbo.Usuarios AS C ON C.id = P.id_usercierre

GO


