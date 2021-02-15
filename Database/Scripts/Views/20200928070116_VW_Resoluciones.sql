--liquibase formatted sql
--changeset ,JTOUS:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[dbo].[VW_Resoluciones]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
	Drop View [dbo].[VW_Resoluciones]
END
GO

CREATE VIEW [dbo].[VW_Resoluciones]
AS
/***************************************
*Nombre:		[dbo].[VW_CajaResolucion]
----------------------------------------
*Tipo:			Vista
*creaci�n:		08/04/17
*Desarrollador: (JTOUS)
***************************************/
		SELECT        
			CR.resolucion,
			CR.id_ccosto,
			CR.id,
			C.codigo + ' - ' + C.nombre centrocosto,
			CR.rangoini,
			CR.rangofin,
			CR.consecutivo,
			CR.prefijo,
			Convert(varchar(10), CR.fechaini,120) fechainicio,
			Convert(varchar(10), CR.fechafin,120) fechafin,			
			CR.isfe,
			CR.estado,
			CR.leyenda,
			CR.tecnicakey
		FROM    
			dbo.DocumentosTecnicaKey AS CR
		LEFT JOIN CNT.CentroCosto C ON C.id = CR.id_ccosto

GO


