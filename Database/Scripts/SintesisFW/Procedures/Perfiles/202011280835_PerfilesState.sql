--liquibase formatted sql
--changeset ,apuello:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id =
OBJECT_ID(N'[dbo].[ST_PerfilesState]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_PerfilesState]
GO
CREATE PROCEDURE [dbo].[ST_PerfilesState]

/***************************************
*Nombre: [dbo].[ST_PerfilesState]
----------------------------------------
*Tipo: Procedimiento almacenado
*creación: 28/11/20
*Desarrollador: APUELLO
*Descripcion: Cambia el estado del perfil teniendo como referencia su id
***************************************/

	@id BIGINT

AS
BEGIN
	Declare @ds_error varchar(max)
	
	Begin Try
		UPDATE dbo.aspnet_Roles
			SET estado	= CASE estado WHEN 0 THEN 1 ELSE 0 END
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

