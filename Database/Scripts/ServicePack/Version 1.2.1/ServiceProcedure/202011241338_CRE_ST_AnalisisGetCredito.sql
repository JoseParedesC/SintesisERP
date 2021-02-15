--liquibase formatted sql
--changeset ,JPAREDES:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CRE].[ST_AnalisisGetCredito]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [CRE].[ST_AnalisisGetCredito]
GO
CREATE PROCEDURE [CRE].[ST_AnalisisGetCredito]
	
	@id_solicitud BIGINT,
	@id_persona BIGINT,
	@id_user BIGINT
AS

/***************************************
*Nombre:		[CRE].[AnalisisGetCredito]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		24/11/2020
*Desarrollador: JPAREDES
*Descripcion:	
***************************************/

DECLARE @error VARCHAR(MAX)

BEGIN TRY

IF NOT EXISTS(SELECT 1 FROM [CRE].[Solicitud_Personas] WHERE id_persona = @id_persona AND id_solicitud = @id_solicitud)
RAISERROR('No existe relación del Cliente con Solicitudes',16,0);
	
	DECLARE @nombre VARCHAR(50) = (SELECT nombre FROM [DBO].Usuarios WHERE id = @id_user)

	SELECT (SELECT nombre FROM ST_Listados WHERE id = S_V.solestado) estado, 
	   	   S_V.id_solicitud id, 
		   S_V.fecha, 
		   consecutivo, 
		   (id_cotizacion) cotizacion, 
		   @nombre usuario	
	FROM [CRE].[VW_Solicitudes] S_V 
	WHERE  S_V.id_solicitud = @id_solicitud AND S_V.id_persona = @id_persona


	SELECT S.id,
		   PS.id id_solper,
		   P.id id_persona, 
		   -- INFORMACION CREDITO
		   C.id id_credito,
		   ISNULL(C.subtotal,0) precio, 
		   ISNULL(C.descuento,0) descuentos,
		   ISNULL(C.total,0) valorfinanciar, 
		   ISNULL(C.numcuotas,0) numcuotas, 
		   ISNULL(C.cuotamen,0) valorcuotadia,
		   CONVERT(VARCHAR(10),ISNULL(C.fechaini,GETDATE()),120) fechaini,
		   C.observaciones,
		   C.credito,
		   ISNULL(C.iva,0) iva,
		   ISNULL(C.lineacredit,0) lineacredit,
		   C.id_bodega,
		   --Pro.codigo,
		   ISNULL(S.inicial,0) cuotainicial,
		   -- INFORMACION PERSONA
		   P.tipo_tercero tipo,
		   ISNULL(P.urlimgper,'') urlimg,
		   P.primernombre pnombre,
		   P.segundonombre snombre,
		   P.primerapellido papellido,
		   P.segundoapellido sapellido,
		   P.identificacion iden,
		   (SELECT x.iden FROM ST_Listados x WHERE x.id = S.estado) estadosol
	FROM [CRE].[Solicitud_Personas] PS
		INNER JOIN [CRE].[Personas] P ON P.id = PS.id_persona
		INNER JOIN [CRE].[Solicitudes] S ON S.id = PS.id_solicitud
		INNER JOIN [dbo].[MOVCotizacion] C ON C.id = S.id_Cotizacion
		INNER JOIN [DBO].[ST_Listados] L ON L.id = P.tipo_persona
		LEFT JOIN [FIN].[LineasCreditos] LC ON LC.id = C.lineacredit
		WHERE (PS.id_solicitud = @id_solicitud AND tipo_tercero IN( 'CL', 'CO')) --AND C.credito = 1


	EXEC [CRE].[ST_BitacoraAnalisisGet] @id_sol = @id_solicitud, @id_user = @id_user


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