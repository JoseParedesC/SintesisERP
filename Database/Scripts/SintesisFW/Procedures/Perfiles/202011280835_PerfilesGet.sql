--liquibase formatted sql
--changeset ,apuello:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id =
OBJECT_ID(N'[dbo].[ST_PerfilesGet]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_PerfilesGet]
GO
CREATE PROCEDURE [dbo].[ST_PerfilesGet]
	
/***************************************
*Nombre: [dbo].[ST_PerfilesGet]
----------------------------------------
*Tipo: Procedimiento almacenado
*creación: 28/11/20
*Desarrollador: APUELLO
*Descripcion: Consulta información de un perfil como; nombre, 
			  aplicación y descripción de este teniendo como referencia su id
***************************************/
	
	@id BIGINT

AS
BEGIN 

	Declare @ds_error varchar(max), @menus VARCHAR(MAX), @reportes VARCHAR(MAX), @valoresMenus VARCHAR(MAX), @valoresRepor VARCHAR(MAX)
	
	Begin Try
		SELECT @valoresMenus = COALESCE(@valoresMenus +',', '') + CAST(id_menu AS VARCHAR) FROM MenusPerfiles WHERE id_perfil = @id
		SET @menus = (SELECT @valoresMenus)

		SELECT @valoresRepor = COALESCE(@valoresRepor +',', '') + CAST(id_reporte AS VARCHAR) FROM aspnet_RolesInReports WHERE id_perfil = @id
		SET @reportes = (SELECT @valoresRepor)
		SELECT
		 R.id, 
		 R.LoweredRoleName nombre, 
		 ApplicationId app, 
		 Description descripcion,
		 @menus menus,
		 @reportes reportes
		FROM dbo.aspnet_Roles R 
		WHERE R.id = @id
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