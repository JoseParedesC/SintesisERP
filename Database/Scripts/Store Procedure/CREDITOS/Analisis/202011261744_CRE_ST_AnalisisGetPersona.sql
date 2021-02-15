--liquibase formatted sql
--changeset ,JPAREDES:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CRE].[ST_AnalisisGetPersona]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [CRE].[ST_AnalisisGetPersona]
GO
CREATE PROCEDURE [CRE].[ST_AnalisisGetPersona]

@id_persona BIGINT,
@id_solicitud BIGINT,
@id_user BIGINT

AS

/*********************************************************
*Nombre:		[CRE].[ST_AnalisisGetPersona]
----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		11/26/2020
*Desarrollador: JPAREDES
*Descripcion:	Recupera los datos de Personas 
				de la tabla Personas/PersonasCotizacion,
				para mostrarlos en la vista
***********************************************************/

DECLARE @error VARCHAR(MAX)

BEGIN TRY
	
	SELECT P.primernombre,
		   P.segundonombre,
		   P.primerapellido,
		   P.segundoapellido,
		   P.tipo_persona,
		   P.identificacion,
		   P.id_tipoiden,
		   CONVERT(VARCHAR(10),P.fechanacimiento,120) fechanacimiento,
		   CONVERT(VARCHAR(10),P.fechaexpedicion,120) fechaexpedicion,
		   P.id_ciudad,
		   P.id_ciudadexp,
		   P.tipo_tercero tipoper,
		   P.id_genero,
		   P.id_estrato,
		   P.id_estadocivil,
		   P.profesion,
		   P.telefono,
		   P.celular,
		   P.otrotel,
		   P.direccion,
		   P.correo,
		   P.id_viveinmueble,
		   P.valorarriendo,
		   P.id_fincaraiz,
		   P.cualfinca,
		   P.vehiculo,
		   P.percargo,
		   P.digverificacion verificacion,
		   P.id_escolaridad,
		   P.id id_persona,
		   PA.connombre,
		   PA.contipoid,
		   PA.coniden,
		   PA.contelefono,
		   PA.concorreo,
		   PA.conempresa,
		   P.urlimgper urlimg,
		   PA.condireccionemp,
		   PA.contelefonoemp,
		   PA.consalario,
		   PA.id_tipoact,
		   PA.id_tipoemp,
		   Pa.empresalab,
		   PA.direccionemp,
		   PA.telefonoemp,
		   PA.cargo,
		   PA.id_tiempoemp,
		   PA.salarioemp,
		   PA.otroingreso,
		   PA.concepto,
		   PA.gastos,
		   PA.banco,
		   PA.id_tipocuenta,
		   PA.numcuenta,
		   ISNULL(SE.evaldatos,'') evaldatos,
		   ISNULL(SE.evallaboral,'') evallaboral,
		   ISNULL(SE.evalbancaria,'') evalbancaria,
		   ISNULL(SE.evalreferencia,'') evalreferencia
	FROM [CRE].[Personas] P 
		 INNER JOIN [CRE].[Personas_Adicionales] PA ON PA.id_persona = P.id
		 LEFT JOIN [CRE].[Solicitud_Evaluacion] SE ON SE.id_solicitudpersona = (SELECT id FROM [CRE].[Solicitud_Personas] PS WHERE PS.id_persona = @id_persona AND PS.id_solicitud = @id_solicitud)
	WHERE PA.id_persona = @id_persona AND PA.id_solicitud = @id_solicitud


	SELECT PR.nombre,
		   PR.direccion,
		   PR.telefono,
		   (SELECT nombre FROM [DBO].[ST_Listados] WHERE id = PR.id_tiporef) tipo,
		   (SELECT id_tiporef FROM [DBO].[ST_Listados] WHERE id = PR.id_tiporef) id_tipo,
		   (SELECT nombre FROM [DBO].[ST_Listados] WHERE id = PR.id_parentezco) parentezco,
		   (SELECT id_parentezco FROM [DBO].[ST_Listados] WHERE id = PR.id_parentezco) id_paren,
		   PR.id,
		   PR.estado
	FROM [CRE].[Personas_Referencias] PR 
	WHERE id_persona = @id_persona AND id_solicitud = @id_solicitud

	SELECT id, name, 'SO' op, id_persol, token FROM [CRE].[Solicitud_Archivos]
			WHERE id_persol = (SELECT id  FROM [CRE].[Solicitud_Personas] WHERE id_persona = @id_persona AND id_solicitud = @id_solicitud);

END TRY
BEGIN CATCH
	--Getting the error description
	SELECT @error   =  ERROR_PROCEDURE() + 
				';  ' + CONVERT(VARCHAR,ERROR_LINE()) + 
				'; ' + ERROR_MESSAGE()
	-- save the error in a Log file
	RAISERROR(@error,16,1)
	RETURN 
END CATCH