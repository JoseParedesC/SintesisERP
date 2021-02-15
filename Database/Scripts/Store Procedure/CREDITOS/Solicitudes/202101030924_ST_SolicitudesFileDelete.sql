--liquibase formatted sql
--changeset ,jarciniegas:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id =
OBJECT_ID(N'[CRE].[ST_SolicitudesFileDelete]') and OBJECTPROPERTY(id, N'IsProcedure') = 1) DROP PROCEDURE [CRE].[ST_SolicitudesFileDelete]
GO
CREATE PROCEDURE [CRE].[ST_SolicitudesFileDelete]
@id_solicitudper	BIGINT,
@token				VARCHAR(255),
@id_user			INT

 
AS

/***************************************
*Nombre:		[dbo].[ST_SolicitudesFileDelete]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		27/03/17
*Desarrollador: (JTOUS)
***************************************/

DECLARE @error VARCHAR(MAX);
DECLARE @id_persona BIGINT, @idsolicitud BIGINT, @url VARCHAR(MAX) = '';
BEGIN TRANSACTION
BEGIN TRY
	
	SELECT @idsolicitud = id_solicitud, @id_persona = id_persona FROM [CRE].[Solicitud_Personas] WHERE id = @id_solicitudper;
	
	IF NOT EXISTS (SELECT 1 FROM [CRE].[Solicitud_Archivos] WHERE id_persol = @id_solicitudper AND token = @token)
		RAISERROR('No existe archivo, verifique.', 16, 0);

	SELECT @url = urlarchivo FROM [CRE].[Solicitud_Archivos] WHERE id_persol = @id_solicitudper AND token = @token;

	DELETE [CRE].[Solicitud_Archivos] WHERE id_persol = @id_solicitudper AND token = @token;
	
	SELECT ISNULL(@url,'') URL
	COMMIT TRANSACTION;
END TRY
BEGIN CATCH
	SET @error = ERROR_MESSAGE();
	RAISERROR(@error,16,0);		
	ROLLBACK TRANSACTION;
END CATCH
