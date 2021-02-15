--liquibase formatted sql
--changeset ,jtous:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_UsuarioSave]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.ST_UsuarioSave
GO
CREATE PROCEDURE dbo.ST_UsuarioSave
@id BIGINT = null,
@username VARCHAR(50), 
@identificacion VARCHAR(50),
@nombre VARCHAR(150), 
@id_turno BIGINT, 
@telefono VARCHAR(50), 
@email VARCHAR(100), 
@Password VARCHAR(255),
@id_cajas VARCHAR(100),
@id_perfil INT,
@id_user int

WITH ENCRYPTION
AS

/***************************************
*Nombre:		[dbo].[ST_UsuarioSave]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		10/04/17
*Desarrollador: (JTOUS)
***************************************/

BEGIN TRY
BEGIN TRANSACTION
	DECLARE @UserIde UNIQUEIDENTIFIER, @Rol VARCHAR(255)
	DECLARE @id_return INT, @error VARCHAR(MAX);
	DECLARE @datecreated SMALLDATETIME = GETDATE();

	IF EXISTS (SELECT 1 FROM Dbo.Usuarios U WHERE UPPER(U.username) = UPPER(@username) AND id <> @id)
		RAISERROR('Usuario ya existe.', 16, 0);

	IF(Isnull(@id,0) = 0)
	BEGIN

		EXECUTE [dbo].[aspnet_Membership_CreateUser] 
		@ApplicationName = 'SINTESIS ERP', 
		@UserName = @username, 
		@Password = @password, 
		@PasswordSalt = 'y3HuqhjZ8W1e89XCE/CnfQ==', 
		@Email = @email, 
		@PasswordQuestion = ' ', 
		@PasswordAnswer = ' ', 
		@IsApproved = 1, 
		@CurrentTimeUtc = @datecreated, 
		@CreateDate = @datecreated, 
		@UserId = @UserIde OUTPUT;
		
		INSERT INTO Dbo.Usuarios (username, nombre, identificacion, id_turno, telefono, email, userid, id_perfil, id_user)
		VALUES(@username, @nombre, @identificacion, @id_turno, @telefono, @email, @UserIde, @id_perfil, @id_user);
		
		SET @id_return = SCOPE_IDENTITY();
		
		IF @@Error <> 0 
			RAISERROR('Problema al guardar el usuario', 16, 0);

		SET @Rol = (SELECT TOP 1 RoleName FROM aspnet_Roles WHERE id = @id_perfil);

		EXECUTE [dbo].[aspnet_UsersInRoles_AddUsersToRoles] 
		@ApplicationName = 'PUNTO DE VENTA', 
		@UserNames = @username, 
		@RoleNames = @Rol, 
		@CurrentTimeUtc = @datecreated;
		
		IF @@Error <> 0 
			RAISERROR('Problema al asociar el perfil al usuario', 16, 0);

		INSERT INTO Dbo.aspnet_UsersInCajas ([user_id], id_caja, id_user)
		Select @id_return, item, @id_user FROM Dbo.ST_FnTextToTable(@id_cajas, ',');
		
	END	
	ELSE
	BEGIN
		DELETE Dbo.aspnet_UsersInCajas  WHERE [user_id]= @id;

		UPDATE Dbo.Usuarios 
		SET
			nombre					= @nombre,
			id_turno				= @id_turno,
			identificacion			= @identificacion,
			telefono				= @telefono,
			email					= @email,
			id_perfil				= @id_perfil,
			id_user					= @id_user,
			updated				= GETDATE()
		WHERE id = @id;
			
		INSERT INTO Dbo.aspnet_UsersInCajas ([user_id], id_caja, id_user)
		Select @id, item, @id_user FROM Dbo.ST_FnTextToTable(@id_cajas, ',');

		SET @id_return = @id;	
	END

	COMMIT TRANSACTION;
END TRY
BEGIN CATCH	
	ROLLBACK TRANSACTION;
	SET @error = 'Error: '+ERROR_MESSAGE();
	RAISERROR(@error,16,0);	
END CATCH

select @id_return id	
GO
