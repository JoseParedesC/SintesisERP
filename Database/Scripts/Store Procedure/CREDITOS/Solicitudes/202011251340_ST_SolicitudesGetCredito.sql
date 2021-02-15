--liquibase formatted sql
--changeset ,jarciniegas:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id =
OBJECT_ID(N'[CRE].[ST_SolicitudesGetCredito]') and OBJECTPROPERTY(id, N'IsProcedure') = 1) DROP PROCEDURE [CRE].[ST_SolicitudesGetCredito]
GO
CREATE PROCEDURE [CRE].[ST_SolicitudesGetCredito]
	
	@id_solicitud BIGINT,
	@id_user BIGINT 
AS

/***********************************************
*Nombre:		[CRE].[ST_SolicitudesGetCredito]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		24/11/2020
*Desarrollador: JARCINIEGAS
*Descripcion:	Muestra la informacion basica de 
				la solicitud y de la persona rela-
				cionada con la solicitud
************************************************/

DECLARE @error VARCHAR(MAX)

BEGIN TRY

	SELECT (SELECT nombre FROM ST_Listados WHERE id = S_V.estado) estado, 
	   		S_V.id, 
			CONVERT(VARCHAR(10), S_V.fechasolicitud,120) fecha, 
			S_V.consecutivo, 
			(CONVERT(VARCHAR(10),C.id)+' - '+C.cliente) cotizacion
	FROM [CRE].[Solicitudes] S_V 
	INNER JOIN dbo.VW_MOVCotizaciones C ON C.id = S_V.id_cotizacion
	WHERE  S_V.id= @id_solicitud

	SELECT S.id_solicitud,
		   P.id id_persona,
		   P.tipo_tercero tipo,
		   P.urlimgper urlimg,
		   P.primernombre pnombre,
		   P.segundonombre snombre,
		   P.primerapellido papellido,
		   P.segundoapellido sapellido,
		   P.correo,
		   ISNULL(P.telefono, 0) telefono,
		   P.celular
		FROM  [CRE].[VW_Solicitudes] S 
		INNER JOIN [CRE].[Solicitudes] SOL ON SOL.id = S.id_solicitud
		INNER JOIN [CRE].[Personas] P ON P.id = S.id_persona
		INNER JOIN [DBO].[ST_Listados] L ON L.id = P.tipo_persona
	WHERE S.id_solicitud = @id_solicitud AND p.tipo_tercero IN( 'CL', 'CO') ;
	
	

END TRY
BEGIN CATCH
--Getting the error description
	Set @error   =  ERROR_PROCEDURE() + 
					';  ' + convert(varchar,ERROR_LINE()) + 
					'; ' + ERROR_MESSAGE()
	-- save the error in a Log file
	RAISERROR(@error,16,1)
	RETURN
END CATCH
