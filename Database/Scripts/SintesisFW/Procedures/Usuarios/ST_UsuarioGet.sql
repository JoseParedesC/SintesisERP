--liquibase formatted sql
--changeset ,jtous:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[Dbo].[ST_UsuarioGet]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
Drop Procedure Dbo.ST_UsuarioGet
GO
CREATE PROCEDURE Dbo.ST_UsuarioGet 
	@id [int] = null
WITH ENCRYPTION
AS
BEGIN
/***************************************
*Nombre:		[Dbo].[ST_UsuarioGet]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		10/04/17
*Desarrollador: (JTOUS)
***************************************/
	------------------------------------------------------------------------------
	-- Declaring variables Page_Nav
	------------------------------------------------------------------------------
	Declare @ds_error varchar(max),
			@cajas varchar(200);
	
	Begin Try
		SELECT @cajas= COALESCE(@cajas + ',', '') + CAST(id_caja AS VARCHAR) 
		FROM [dbo].[aspnet_UsersInCajas]
		WHERE [user_id] = @id;

		Select U.id, U.nombre, U.identificacion, U.username, U.id_perfil, id_turno, U.email, U.telefono, ISNULL(@cajas,'') cajas
		From  Dbo.Usuarios U
		Where U.id = @id;
		
	End Try
    Begin Catch
	--Getting the error description
	Set @ds_error   =  ERROR_PROCEDURE() + 
					';  ' + convert(varchar,ERROR_LINE()) + 
					'; ' + ERROR_MESSAGE()
	-- save the error in a Log file
	RaisError(@ds_error,16,1)
	return
	End Catch
END
GO