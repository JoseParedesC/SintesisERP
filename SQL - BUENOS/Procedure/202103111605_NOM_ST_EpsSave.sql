--liquibase formatted sql
--changeset ,JARCINIEGAS:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[NOM].[ST_SegsocialSave]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [NOM].[ST_SegsocialSave]
GO
CREATE PROCEDURE [NOM].[ST_SegsocialSave]

@id					BIGINT			= NULL,
@id_tiposeg			BIGINT				  ,
@nombre				VARCHAR  (60)		  , --
@codext				VARCHAR  (10)		  , --
@contrapartida		VARCHAR  (25)		  , --

@id_user			INT						--



AS

/*****************************************
*Nombre 		[NOM].[ST_SegsocialSave]
----------------------------------------
*Tipo 			Procedimiento almacenado
*creaci�n 		21/11/2020
*Desarrollador  (JARCINIEGAS)
*DESCRIPCI�N 	Guarda y/o la informaci�n capt-
				ada en el formulario de sol-
				icitud en las tablas 
				CRE.Solicitudes, 
				CRE.Solicitud_Personas, 
				CRE.Personas_Adicionales, 
				CRE.Personas_Referencias, 
				CRE.Consecutivo y envia los 
				datos a el procedimiento 
				CRE.ST_PersonasSave para gua-
				rdar la informaci�n en 
				CRE.Personas
*****************************************/

BEGIN TRANSACTION
BEGIN TRY
	
	DECLARE   @error VARCHAR(MAX);
	IF(ISNULL(@id,0) = 0) 
	BEGIN

		IF(@id_tiposeg = 0 OR @id_tiposeg = (SELECT id FROM ST_Listados WHERE iden = 'SEPS'))
		BEGIN

			IF EXISTS(SELECT 1 FROM [NOM].[Entidades_de_Salud] WHERE (nombre = @nombre OR cod_ext = @codext) AND id_tiposeg = @id_tiposeg)
			RAISERROR('Ya existe una E.P.S. con este nombre o codigo',16,0)
					   
				INSERT INTO [NOM].[Entidades_de_Salud](id_tiposeg, nombre, cod_ext, contrapartida,id_usercreated,id_userupdated)
				VALUES(@id_tiposeg, @nombre, @codext, @contrapartida, @id_user,@id_user)	

		END
		ELSE IF(@id_tiposeg = (SELECT id FROM ST_Listados WHERE iden = 'SPEN'))
		BEGIN

			IF EXISTS(SELECT 1 FROM [NOM].[Entidades_de_Salud] WHERE (nombre = @nombre OR cod_ext = @codext) AND id_tiposeg = @id_tiposeg)
			RAISERROR('Ya existe una pension con este nombre o codigo',16,0)
					   
				INSERT INTO [NOM].[Entidades_de_Salud](id_tiposeg, nombre, cod_ext, contrapartida,id_usercreated,id_userupdated)
				VALUES(@id_tiposeg, @nombre, @codext, @contrapartida, @id_user,@id_user)	

		END
		ELSE IF(@id_tiposeg = (SELECT id FROM ST_Listados WHERE iden = 'SCAJA'))
		BEGIN

			IF EXISTS(SELECT 1 FROM [NOM].[Entidades_de_Salud] WHERE (nombre = @nombre OR cod_ext = @codext) AND id_tiposeg = @id_tiposeg)
			RAISERROR('Ya existe una caja de compensación con este nombre o codigo',16,0)
					   
				INSERT INTO [NOM].[Entidades_de_Salud](id_tiposeg, nombre, cod_ext, contrapartida,id_usercreated,id_userupdated)
				VALUES(@id_tiposeg, @nombre, @codext, @contrapartida, @id_user,@id_user)	

		END
		ELSE IF(@id_tiposeg = (SELECT id FROM ST_Listados WHERE iden = 'SARL'))
		BEGIN

			IF EXISTS(SELECT 1 FROM [NOM].[Entidades_de_Salud] WHERE (nombre = @nombre OR cod_ext = @codext) AND id_tiposeg = @id_tiposeg)
			RAISERROR('Ya existe una A.R.L. con este nombre o codigo',16,0)
					   
			INSERT INTO [NOM].[Entidades_de_Salud](id_tiposeg, nombre, cod_ext, contrapartida,id_usercreated,id_userupdated)
				VALUES(@id_tiposeg, @nombre, @codext, @contrapartida, @id_user,@id_user)	

		END
		


		
	END
	ELSE
	BEGIN
		
		IF(@id_tiposeg = 0 OR @id_tiposeg = (SELECT id FROM ST_Listados WHERE iden = 'SEPS'))
		BEGIN

			UPDATE  [NOM].[Entidades_de_Salud]
		SET nombre				= @nombre		,
			cod_ext				= @codext		,
			contrapartida		= @contrapartida,
			updated				= GETDATE()		,
			id_userupdated		= @id_user
		WHERE id = @id;;

		END
		ELSE IF(@id_tiposeg = (SELECT id FROM ST_Listados WHERE iden = 'SPEN'))
		BEGIN

		UPDATE  [NOM].[Entidades_de_Salud]
		SET nombre				= @nombre		,
			cod_ext				= @codext		,
			contrapartida		= @contrapartida,
			updated				= GETDATE()		,
			id_userupdated		= @id_user
		WHERE id = @id;;

		END
		ELSE IF(@id_tiposeg = (SELECT id FROM ST_Listados WHERE iden = 'SCAJA'))
		BEGIN

		UPDATE  [NOM].[Entidades_de_Salud]
		SET nombre				= @nombre		,
			cod_ext				= @codext		,
			contrapartida		= @contrapartida,
			updated				= GETDATE()		,
			id_userupdated		= @id_user
		WHERE id = @id;;

		END
		ELSE IF(@id_tiposeg = (SELECT id FROM ST_Listados WHERE iden = 'SARL'))
		BEGIN

		UPDATE  [NOM].[Entidades_de_Salud]
		SET nombre				= @nombre		,
			cod_ext				= @codext		,
			contrapartida		= @contrapartida,
			updated				= GETDATE()		,
			id_userupdated		= @id_user
		WHERE id = @id;;

		END
		

			
			
		
	END

	COMMIT TRANSACTION;
END TRY
BEGIN CATCH
	SET @error = 'Error '+ERROR_MESSAGE();
	RAISERROR(@error,16,0);		
	ROLLBACK TRANSACTION;
END CATCH

--SELECT @id_return id ;
