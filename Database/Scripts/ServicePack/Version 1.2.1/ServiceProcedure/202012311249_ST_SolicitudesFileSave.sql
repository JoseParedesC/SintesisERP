--liquibase formatted sql
--changeset ,JARCINIEGAS:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CRE].[ST_SolicitudesFileSave]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [CRE].[ST_SolicitudesFileSave]
GO
CREATE PROCEDURE [CRE].[ST_SolicitudesFileSave]
@id_solicitud		BIGINT,
@xml				XML,
@id_user			INT

 
AS

/***************************************
*Nombre:		[CRE].[ST_SolicitudesFileSave]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		27/03/17
*Desarrollador: (JARCINIEGAS)
***************************************/

DECLARE @error VARCHAR(MAX);
DECLARE @manejador int, @id_persona BIGINT, @idsolicitud BIGINT, @tokenimg VARCHAR(MAX);
DECLARE @temp TABLE (id INT IDENTITY(1,1), id_persol INT, urlarchivo VARCHAR(MAX), rutaapp VARCHAR(MAX), id_user INT, name VARCHAR(MAX))
BEGIN TRANSACTION
BEGIN TRY

	SELECT @idsolicitud = id_solicitud, @id_persona = id_persona FROM [CRE].[Solicitud_Personas] WHERE id = @id_solicitud;
	
	EXEC sp_xml_preparedocument @manejador OUTPUT, @xml; 				
								
		INSERT INTO @temp(id_persol, urlarchivo, rutaapp, id_user, name)
		SELECT @id_solicitud, serverurl, relatiurl, @id_user, name
		FROM OPENXML(@manejador, N'items/item') 
			WITH (  serverurl VARCHAR(MAX) '@serverurl',
					relatiurl VARCHAR(MAX) '@relatiurl',
					name VARCHAR(200) '@name'
			) AS P
	EXEC sp_xml_removedocument @manejador;
	
	INSERT INTO [CRE].[Solicitud_Archivos](id_persol, urlarchivo, rutaapp, id_user, name)
	SELECT id_persol, urlarchivo, rutaapp, id_user, name
	FROM @temp
	WHERE name != 'FotoPerfil_Sintesis.png'

	SET @tokenimg = (SELECT rutaapp FROM @temp WHERE name = 'FotoPerfil_Sintesis.png');
	IF(ISNULL(@tokenimg,'') != '')
	BEGIN
		UPDATE [CRE].[Personas] 
		SET	urlperfil = @tokenimg,
			urlimgper = newid()	
		WHERE id = @id_persona;
	END
	ELSE
	BEGIN
	 UPDATE [CRE].[Personas] 
		SET	urlperfil = (SELECT TOP 1 urlperfil FROM [CRE].[Personas] WHERE identificacion = (SELECT identificacion FROM [CRE].[Personas] WHERE id= @id_persona)),
			urlimgper = (SELECT TOP 1 urlimgper FROM [CRE].[Personas] WHERE identificacion = (SELECT identificacion FROM [CRE].[Personas] WHERE id= @id_persona))	
		WHERE id = @id_persona;
	END

	SELECT urlimgper urlimg, id FROM  [CRE].[Personas] WHERE id = @id_persona;
		
	COMMIT TRANSACTION;
END TRY
BEGIN CATCH
	SET @error = ERROR_MESSAGE();
	RAISERROR(@error,16,0);		
	ROLLBACK TRANSACTION;
END CATCH
