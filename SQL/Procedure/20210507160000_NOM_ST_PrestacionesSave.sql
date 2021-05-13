--liquibase formatted sql
--changeset ,JPAREDES 1 dbms mssql runOnChange true endDelimiter GO stripComments false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[NOM].[ST_PrestacionesSave]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [NOM].[ST_PrestacionesSave]
GO
CREATE PROCEDURE [NOM].[ST_PrestacionesSave]

	@id BIGINT, 
	@codigo BIGINT, 
	@nombre VARCHAR(60), 
	@contrapartida BIGINT, 
	@provisiones NUMERIC, 
	@tipo_prestacion NUMERIC, 
	@id_user BIGINT

AS

/***************************************
*Nombre 		[NOM].[ST_PrestacionesSave]
-----------------------------------------------------------
*Tipo 			Procedimiento almacenado
*creaci�n 		08/05/2021
*Desarrollador   JPAREDES
*Descripcion 	Guarda la informacion de la seguridad social
***************************************/


DECLARE @error VARCHAR(MAX);
BEGIN TRY

	IF(@codigo = 0) SET @codigo = NULL

	IF EXISTS(SELECT 1 FROM [NOM].[Prestaciones] WHERE codigo = @codigo AND id != @id AND tipo_prestacion = @tipo_prestacion)
		RAISERROR('El Codigo ya existe', 16, 0)

	IF EXISTS(SELECT 1 FROM [NOM].[Prestaciones] WHERE nombre = @nombre AND id != @id AND tipo_prestacion = @tipo_prestacion)
		RAISERROR('El Nombre ya existe', 16, 0)

	IF(ISNULL(@ID,0) = 0)
	BEGIN
		
		INSERT INTO [NOM].[Prestaciones] (codigo, nombre, contrapartida, provision, tipo_prestacion, created, id_usercreated, updated, id_userupdated)
			SELECT @codigo, @nombre, @contrapartida, @provisiones, @tipo_prestacion, GETDATE(), @id_user, GETDATE(), @id_user

	END
	ELSE
	BEGIN
		
		UPDATE [NOM].[Prestaciones] 
			SET nombre = @nombre,
				codigo = @codigo,
				contrapartida = @contrapartida,
				provision = @provisiones,
				tipo_prestacion = @tipo_prestacion,
				updated = getdate(),
				id_userupdated = @id_user
		WHERE id = @id

	END
	

END TRY
BEGIN CATCH	
	IF ERROR_NUMBER() = 547
		SET @error = 'La cuenta ingresada no existe'
	ELSE
		SET @error = 'Error  '+ ERROR_MESSAGE();
	RAISERROR(@error,16,0);	
END CATCH
