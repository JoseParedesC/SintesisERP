--liquibase formatted sql
--changeset ,apuello:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_UsuariosPermisosSave]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[ST_UsuariosPermisosSave]
GO
CREATE PROCEDURE [dbo].[ST_UsuariosPermisosSave]
	@user_id BIGINT,
	@permisosXml XML,
	@id_user BIGINT
/***************************************
*Nombre: [dbo].[ST_UsuariosPermisosSave]
----------------------------------------
*Tipo: Procedimiento almacenado
*creación: 24/11/20
*Desarrollador: (APUELLO)
*Descripcion: Recibe un XML de C#, guarda o actualiza
			el permiso adicional de un usuario en especifico
***************************************/

AS
BEGIN TRY
	DECLARE @error VARCHAR(MAX), @idper INT
	DECLARE @permisos TABLE(id int identity, id_menu INT ,reader bit, creater bit, updater bit, deleter bit)
		
	EXEC sp_xml_preparedocument @idper OUTPUT, @permisosXml

	INSERT INTO @permisos (id_menu, reader, creater, updater, deleter)	
	SELECT 
		id_menu, 
		viewer, 
		created, 
		updated, 
		deleter 
	FROM OPENXML(@idper, N'items/item') 
	WITH (  id_menu		INT '@id_menu',
			viewer		BIT '@viewer',
			created		BIT	'@created',
			updated		BIT	'@updated',
			deleter		BIT	'@deleter'
	) AS P
	
	UPDATE MPU SET 
		MPU.creater	= P.creater,
		MPU.deleter = P.deleter,
		MPU.reader  = P.reader,
		MPU.updater = P.updater,
		MPU.id_userupdated = @id_user
	FROM dbo.MenuPermisosUser MPU
	INNER JOIN @permisos P ON MPU.id_menu = P.id_menu AND MPU.id_user = @user_id	
	
	INSERT INTO dbo.MenuPermisosUser (id_menu, id_user, creater, reader, updater, deleter, id_usercreated, id_userupdated) 	
	SELECT	 
		P.id_menu, 
		@user_id, 
		P.creater, 
		P.reader, 
		P.updater, 
		P.deleter,
		@id_user,
		@id_user
	FROM @permisos P LEFT JOIN dbo.MenuPermisosUser MPU ON MPU.id_menu = P.id_menu AND MPU.id_user = @user_id
	WHERE MPU.id_menu IS NULL
	
END TRY
BEGIN CATCH

	    --Getting the error description
	    Select @error   =  ERROR_PROCEDURE() + 
					';  ' + convert(varchar,ERROR_LINE()) + 
					'; ' + ERROR_MESSAGE()
	    -- save the error in a Log file
	    RaisError(@error,16,1)
	    Return  
End Catch
