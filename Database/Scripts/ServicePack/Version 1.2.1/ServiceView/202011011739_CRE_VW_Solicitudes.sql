--liquibase formatted sql
--changeset ,JPAREDES:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CRE].[VW_Solicitudes]') and OBJECTPROPERTY(id, N'IsView') = 1)
DROP VIEW [CRE].[VW_Solicitudes]
GO
CREATE VIEW [CRE].[VW_Solicitudes]

AS

SELECT         S.id AS id_solicitud, 
			   S.consecutivo, 
			   CONVERT(VARCHAR(10),S.fechasolicitud,120) fecha, 
			   P.identificacion,
			   P.primernombre+' '+P.primerapellido cliente,
			   P.id id_persona,
			   P.tipo_tercero,
			   U.nombre AS asesor, 
			   U.id AS id_asesor, 
			   E.nombre AS estacion, 
			   E.id AS id_estacion, 
			   S.estado solestado,
			   --CI.id_Cotizacion AS id_cotizacion,
			   L.nombre estado,
			   --Pro.nombre producto,
			   L.iden iden,
			   C.id id_cotizacion
FROM            CRE.Solicitudes AS S INNER JOIN
						 [CRE].[Solicitud_Personas] AS PS ON S.id = PS.id_solicitud INNER JOIN
						 [CRE].Personas AS P ON PS.id_persona = P.id AND PS.id_persona = P.id LEFT JOIN 
						 [dbo].[MOVCotizacion] C ON C.id = S.id_cotizacion INNER JOIN 
                         --[dbo].[MOVCotizacionItems] AS CI ON CI.id_Cotizacion = S.id_cotizacion INNER JOIN
                         [dbo].Usuarios AS U ON U.id = S.id_userasign LEFT JOIN
                         [CRE].Estaciones AS E ON E.id = S.id_estacion LEFT JOIN
						 --[dbo].[Productos] Pro ON Pro.id = CI.id_articulo LEFT JOIN 
						 [DBO].[ST_Listados] L ON L.id = S.estado


GO