--liquibase formatted sql
--changeset ,JPAREDES:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CRE].[ST_AnalisisSeguimientoSave]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [CRE].[ST_AnalisisSeguimientoSave]
GO
CREATE PROCEDURE [CRE].[ST_AnalisisSeguimientoSave]

@id_solicitud	BIGINT,
@observaciones	VARCHAR(MAX),
@visible		BIT,
@id_user		BIGINT

AS

/*********************************************************
*Nombre:		[CRE].[ST_AnalisisSeguimientoSave]
----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		03/12/2020
*Desarrollador: JPAREDES
*Descripcion:	Guarda los seguimientos que se le aplican 
				a la solicitud que se analiza
***********************************************************/

DECLARE @error VARCHAR(MAX);
DECLARE @nombre VARCHAR(20);


BEGIN TRY

	IF EXISTS (SELECT 1 FROM [CRE].[VW_Solicitudes] WHERE id_solicitud = @id_solicitud AND solestado = 1)
		RAISERROR('No puede realizar seguimiento, la solicitud ya esta aprobado o rechazado.', 16, 0);

	SET @nombre = (SELECT nombre FROM [dbo].[Usuarios] WHERE id = @id_user)

	INSERT INTO [CRE].[Solicitud_Seguimientos] (id_solicitud, seguimiento, id_user, visible)
	VALUES (@id_solicitud, @observaciones, @id_user, @visible);
	
	EXEC [CRE].[ST_BitacoraAnalisisGet] @id_sol = @id_solicitud, @id_user = @id_user

END TRY
BEGIN CATCH
	--Getting the error description
	    SELECT @error   =  ERROR_PROCEDURE() + 
					';  ' + CONVERT(VARCHAR,ERROR_LINE()) + 
					'; ' + ERROR_MESSAGE()
	    -- save the error in a Log file
	    RAISERROR(@error,16,1)
END CATCH