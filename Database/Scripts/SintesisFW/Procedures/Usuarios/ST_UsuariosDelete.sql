--liquibase formatted sql
--changeset ,jtous:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[Dbo].[ST_UsuariosDelete]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
Drop Procedure Dbo.ST_UsuariosDelete
GO
CREATE PROCEDURE Dbo.ST_UsuariosDelete
@id BIGINT
WITH ENCRYPTION
AS
/***************************************
*Nombre:		[Dbo].[ST_UsuariosDelete]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		09/04/17
*Desarrollador: (JTOUS)
***************************************/
Declare @ds_error Varchar(Max), @iduser varchar(255)
BEGIN TRANSACTION
BEGIN TRY 
		
		SET @iduser = (Select userid From Dbo.Usuarios Where id = @id);

		DELETE Dbo.Usuarios WHERE id = @id;
		DELETE Dbo.aspnet_UsersInRoles Where UserId = @iduser
		DELETE Dbo.aspnet_Membership Where UserId = @iduser
		DELETE Dbo.aspnet_Users Where UserId = @iduser

COMMIT TRANSACTION;
END TRY
BEGIN CATCH
		ROLLBACK TRANSACTION;
	    SELECT @ds_error = ERROR_MESSAGE()
	    RAISERROR(@ds_error,16,1)
	    RETURN
END CATCH
GO
