--liquibase formatted sql
--changeset ,apuello:3 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id =
OBJECT_ID(N'[dbo].[ST_PerfilesSave]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_PerfilesSave]
GO
CREATE PROCEDURE [dbo].[ST_PerfilesSave]
/***************************************
*Nombre: [dbo].[CategoriasProductosList]
----------------------------------------
*Tipo: Procedimiento almacenado
*creación: 28/11/20
*Desarrollador: APUELLO
*Descripcion: Guarda o edita un perfil en el sistema,
			  validando que no exista un perfil con el mismo nombre
***************************************/

	@id BIGINT,
	@app VARCHAR(MAX),
	@nombre VARCHAR(50),
	@descripcion VARCHAR(MAX),
	@id_menus VARCHAR(MAX),
	@id_reportes VARCHAR(MAX),
	@id_user BIGINT

AS

BEGIN TRANSACTION

BEGIN TRY
	DECLARE @id_return INT, @error VARCHAR(MAX), @id_estado BIGINT
	IF EXISTS(SELECT 1 FROM dbo.aspnet_Roles WHERE RoleName = @nombre AND LoweredRoleName = @nombre AND id != ISNULL(@id,0))
		RAISERROR('Verifique el nombre del pefil... ya existe', 16,0)

	IF(ISNULL(@id,0) = 0)
		BEGIN
			INSERT INTO  dbo.aspnet_Roles(
											ApplicationId, 
											RoleName,
											LoweredRoleName,
											Description) 
									VALUES (
											@app,
											@nombre,
											@nombre,
											@descripcion)
			
			SET @id_return = SCOPE_IDENTITY();
			
				INSERT INTO dbo.MenusPerfiles 
						(id_perfil, 
						id_menu, 
						id_user)
				SELECT	
						@id_return,
						item,
						@id_user
				FROM [dbo].[ST_FnTextToTable](@id_menus,',')
			
				INSERT INTO aspnet_RolesInReports 
						(id_reporte,
						id_perfil,
						id_user)
				SELECT	
						item,
						@id_return,
						@id_user
				FROM [dbo].[ST_FnTextToTable](@id_reportes,',')
		END
	ELSE
		BEGIN
			IF (@id > 4)
			BEGIN
				UPDATE dbo.aspnet_Roles
					SET 
						ApplicationId		=	@app,
						RoleName			=	@nombre,
						LoweredRoleName		=	@nombre,
						Description			=	@descripcion
					WHERE id = @id
			END
			
			DELETE FROM MenusPerfiles WHERE id_perfil = @id
			DELETE FROM aspnet_RolesInReports WHERE id_perfil = @id

				INSERT INTO dbo.MenusPerfiles 
						(id_perfil, 
						id_menu, 
						id_user)
				SELECT	
						@id,
						item,
						@id_user
				FROM [dbo].[ST_FnTextToTable](@id_menus,',')

				INSERT INTO aspnet_RolesInReports 
						(id_reporte,
						id_perfil,
						id_user)
				SELECT	
						item,
						@id,
						@id_user
				FROM [dbo].[ST_FnTextToTable](@id_reportes,',')
		END
	COMMIT TRANSACTION;
END TRY
BEGIN CATCH
	SET @error = ERROR_MESSAGE();
	RAISERROR(@error,16,0);		
	ROLLBACK TRANSACTION;
END CATCH
