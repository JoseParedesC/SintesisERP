--liquibase formatted sql
--changeset ,jeteme:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[dbo].[VW_MOVOrdenCompras]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
Drop View [dbo].[VW_MOVOrdenCompras]
END
GO

CREATE VIEW [dbo].[VW_MOVOrdenCompras]
AS
/***************************************
*Nombre:		[dbo].[VW_MOVOrdenCompras]
----------------------------------------
*Tipo:			Vista
*creaci�n:		22/11/19
*Desarrollador: (Jeteme)
***************************************/
	SELECT  
				P.id, 
				CONVERT(VARCHAR(10), P.fechadocument, 120) AS fechadocumen, 
				L.nombre AS estado, P.id_proveedor, 
				R.razonsocial proveedor, 
				P.id_reversion, 
				P.created, 
				P.bodega, 
				B.codigo + ' - ' + B.nombre AS nombrebodega,
				P.id_tipodoc,
				TD.nombre tipodocumento,
				C.id id_cencostos,
				c.codigo + ' - ' + C.nombre centrocosto,
				P.costo
	FROM	dbo.MovOrdenCompras		AS P LEFT OUTER JOIN
			CNT.VW_Terceros	        AS R    ON P.id_proveedor	= R.id INNER  JOIN
			dbo.ST_Listados			AS L    ON L.id			= P.estado LEFT OUTER JOIN
			dbo.Bodegas				AS B    ON P.bodega		= B.id LEFT OUTER JOIN
			CNT.CentroCosto			AS C    ON C.id			= P.id_centrocostos INNER JOIN 
			CNT.TipoDocumentos      AS TD	ON P.id_tipodoc			= TD.id
GO


