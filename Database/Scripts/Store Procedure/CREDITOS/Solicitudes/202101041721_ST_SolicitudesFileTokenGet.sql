--liquibase formatted sql
--changeset ,jarciniegas:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id =
OBJECT_ID(N'[CRE].[ST_SolicitudesFileTokenGet]') and OBJECTPROPERTY(id, N'IsProcedure') = 1) DROP PROCEDURE [CRE].[ST_SolicitudesFileTokenGet]
GO
CREATE PROCEDURE [CRE].[ST_SolicitudesFileTokenGet]
@token VARCHAR(255) ,
@opcion CHAR(2) = 'SO'

 
AS

/***************************************
*Nombre:		[CRE].[ST_SolicitudesFileTokenGet]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		27/03/17
*Desarrollador: (JTOUS)
***************************************/

DECLARE @id_return INT, @error VARCHAR(MAX), @ID INT;
BEGIN TRY
	IF (@opcion = 'SO')
		IF EXISTS(SELECT 1 FROM [CRE].[Solicitud_Archivos] WHERE token = @token)
			SELECT urlarchivo[file] FROM [CRE].[Solicitud_Archivos] WHERE token = @token
		ELSE
		BEGIN
			SELECT urlperfil [file] FROM [CRE].[Personas] WHERE urlimgper = @token
		END
	--ELSE IF (@opcion = 'PC')
	--	SELECT urlarchivo [file] FROM [CRE].[ClientesCotizaciones] WHERE token = @token;
	--ELSE IF (@opcion = 'VC')
	--	SELECT urlarchivo [file] FROM [CRE].[CotizacionArchivos] WHERE token = @token;

END TRY
BEGIN CATCH
	SET @error = 'Error: '+ERROR_MESSAGE();
	RAISERROR(@error,16,0);			
END CATCH
