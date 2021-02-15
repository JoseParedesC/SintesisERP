--liquibase formatted sql
--changeset ,jarciniegas:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id =
OBJECT_ID(N'[CRE].[ST_SolicitudDeleteCodeudor]') and OBJECTPROPERTY(id, N'IsProcedure') = 1) DROP PROCEDURE [CRE].[ST_SolicitudDeleteCodeudor]
GO
CREATE PROCEDURE [CRE].[ST_SolicitudDeleteCodeudor]

@id BIGINT
 
AS
/*************************************************
*Nombre 		[CRE].[ST_SolicitudDeleteCodeudor]
--------------------------------------------------
*Tipo 			Procedimiento almacenado
*creaci�n 		19/12/2020
*Desarrollador  (JARCINIEGAS)
*DESCRIPCI�N 	Elimina la persona con tipo_tercero
				CO que est� seleccionado 
*************************************************/

DECLARE @id_return INT, @error VARCHAR(MAX), @id_solicitud BIGINT;
DECLARE @TableFile Table(id int identity, rutaarchivo varchar(MAX));
BEGIN TRANSACTION
BEGIN TRY
	
	IF EXISTS (SELECT 1 FROM [CRE].[Personas] WHERE id = @id)
	BEGIN
		SET @id_solicitud = (SELECT TOP 1 id_solicitud FROM [CRE].[Solicitud_Personas] WHERE id_persona = @id);
		

		DELETE PR FROM [CRE].[Personas_Referencias] PR 
		INNER JOIN [CRE].[Solicitud_Personas] SP ON PR.id_persona = SP.id_persona AND SP.id_solicitud = PR.id_solicitud
		WHERE SP.id_persona = @id;

		DELETE [CRE].[Solicitud_Evaluacion] WHERE id_solicitudpersona = (SELECT id FROM [CRE].[Solicitud_Personas] WHERE id_persona = @id);
		
		UPDATE PR SET estado = 0 FROM [CRE].[Personas_Adicionales] PR 
		INNER JOIN [CRE].[Solicitud_Personas] SP ON PR.id_persona = SP.id_persona AND SP.id_solicitud = PR.id_solicitud
		WHERE SP.id_persona = @id;

		INSERT INTO @TableFile (rutaarchivo)
		SELECT DISTINCT urlarchivo FROM [CRE].[Solicitud_Archivos] PR 
		INNER JOIN [CRE].[Solicitud_Personas] SP ON SP.id = PR.id_persol
		WHERE SP.id_persona = @id;

		DELETE PR FROM [CRE].[Solicitud_Archivos] PR 
		INNER JOIN [CRE].[Solicitud_Personas] SP ON SP.id = PR.id_persol
		WHERE SP.id_persona = @id;

		DELETE [CRE].[Solicitud_Personas] WHERE id_persona = @id;
		
		SELECT P.tipo_tercero, 'Solicitante' class, S.id, P.primernombre pnombre, P.segundonombre snombre,
		P.primerapellido papellido, P.segundoapellido sapellido, P.urlperfil urlimg, P.telefono, P.celular, P.correo
		FROM [CRE].[Solicitud_Personas] S
		INNER JOIN [CRE].[Personas] P ON P.id = S.id_persona
		INNER JOIN [CRE].[Personas_Adicionales] A ON A.id_solicitud = S.id_solicitud AND P.id = A.id_persona
		WHERE S.id_solicitud = @id_solicitud;
		
		--SELECT rutaarchivo FROM @TableFile;
	END
	ELSE
		RAISERROR ('Ya este codeudor no esta en esta solicitud. Verifique!',16,0);
	COMMIT TRANSACTION;
END TRY
BEGIN CATCH
	SET @error = 'Error: '+ERROR_MESSAGE();
	RAISERROR(@error,16,0);		
	ROLLBACK TRANSACTION;
END CATCH
