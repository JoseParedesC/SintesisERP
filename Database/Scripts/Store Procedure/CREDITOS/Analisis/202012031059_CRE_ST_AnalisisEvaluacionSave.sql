--liquibase formatted sql
--changeset ,JPAREDES:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CRE].[ST_AnalisisEvaluacionSave]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [CRE].[ST_AnalisisEvaluacionSave]
GO
CREATE PROCEDURE [CRE].[ST_AnalisisEvaluacionSave]

@id_solpersona	BIGINT,
@id_user		BIGINT,
@op				CHAR(2),
@valor			CHAR(2)

AS

DECLARE @error VARCHAR(MAX)

BEGIN TRY 

/*********************************************************
*Nombre:		[CRE].[ST_AnalisisEvaluacionSave]
----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		03/12/2020
*Desarrollador: JPAREDES
*Descripcion:	Guarda el nivel de aprobacion que tiene 
				cada categoria de la solicitud
***********************************************************/

IF NOT EXISTS (SELECT 1 FROM [CRE].[Solicitud_Evaluacion] WHERE id_solicitudpersona = @id_solpersona)
	BEGIN
		INSERT INTO [CRE].[Solicitud_Evaluacion] (id_solicitudpersona, id_user)
		VALUES(@id_solpersona, @id_user)
	END

	DECLARE @id_solicitud BIGINT = (SELECT id_solicitud FROM [CRE].[Solicitud_Personas] WHERE id = @id_solpersona)

	IF (@op = 'DT')
	BEGIN
		UPDATE [CRE].[Solicitud_Evaluacion] SET evaldatos = @valor, updated = GETDATE() WHERE id_solicitudpersona = @id_solpersona;
	END
	ELSE IF (@op = 'LB')
	BEGIN
		UPDATE [CRE].[Solicitud_Evaluacion] SET evallaboral = @valor, updated = GETDATE() WHERE id_solicitudpersona = @id_solpersona;
	END
	ELSE IF (@op = 'BC')
	BEGIN
		UPDATE [CRE].[Solicitud_Evaluacion] SET evalbancaria = @valor, updated = GETDATE() WHERE id_solicitudpersona = @id_solpersona;
	END
	ELSE IF (@op = 'RF')
	BEGIN
		UPDATE [CRE].[Solicitud_Evaluacion] SET evalreferencia = @valor, updated = GETDATE() WHERE id_solicitudpersona = @id_solpersona;
	END

	EXEC [CRE].[ST_BitacoraAnalisisGet] @id_sol = @id_solicitud, @id_user = @id_user

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