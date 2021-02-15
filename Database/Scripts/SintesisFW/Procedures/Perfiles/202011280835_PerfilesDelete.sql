--liquibase formatted sql
--changeset ,apuello:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id =
OBJECT_ID(N'[dbo].[ST_PerfilesDelete]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_PerfilesDelete]
GO
CREATE PROCEDURE [dbo].[ST_PerfilesDelete]

/***************************************
*Nombre: [dbo].[ST_PerfilesDelete]
----------------------------------------
*Tipo: Procedimiento almacenado
*creación: 28/11/20
*Desarrollador: APUELLO
*Descripcion: Elimina un perfil teniendo como referencia su id
***************************************/
	
	@id BIGINT
AS
BEGIN
	Declare @ds_error varchar(max)
	
	Begin Try
		DELETE FROM aspnet_RolesInReports 
		WHERE id_perfil = @id
		DELETE FROM MenusPerfiles
		WHERE id_perfil = @id
		DELETE FROM dbo.aspnet_Roles 
		WHERE id = @id
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

