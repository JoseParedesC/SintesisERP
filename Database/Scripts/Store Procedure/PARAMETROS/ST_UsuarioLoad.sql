--liquibase formatted sql
--changeset ,jtous:4 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[Dbo].[ST_UsuarioLoad]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
Drop Procedure Dbo.ST_UsuarioLoad
GO
CREATE PROCEDURE [Dbo].ST_UsuarioLoad
	@userId varchar(255)
WITH ENCRYPTION
AS
	
BEGIN TRY
/***************************************
*Nombre:		[Dbo].[ST_UsuarioLoad]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		10/04/17
*Desarrollador: (JTOUS)
***************************************/
	
	DECLARE @rolname VARCHAR(50) = '';
	DECLARE @error VARCHAR(MAX);
	DECLARE @nomempresa VARCHAR(250) = (SELECT TOP 1 razonsocial FROM Empresas);

	SELECT @rolname = R.RoleName 
	FROM aspnet_Roles R INNER JOIN Dbo.Usuarios U ON R.id = U.id_perfil
	WHERE U.userid = @userId;

	IF(UPPER(@rolname) = 'VENDEDOR')

		SELECT 
				U.id				id, 
				U.userid			userid, 
				'<b>'+ISNULL(@nomempresa,'') + '</b> - ' + U.nombre			nombre, 
				A.ApplicationName	aplicacion, 
				R.RoleID			idperfil, 
				U.perfil			perfil, 
				U.username			[user],				
				U.estado			estado,
				U.username			username,
				U.apptoken			apptoken,
				C.id_centrocosto	idccosto,
				C.centrocosto		centrocosto
		FROM Dbo.VW_Usuarios U		
		INNER JOIN aspnet_Roles R ON R.id = U.id_perfil
		INNER JOIN aspnet_applications A ON A.ApplicationId = R.ApplicationId
		LEFT JOIN VW_Cajas C ON C.userproceso = U.id
		WHERE U.userid = @userId;
			
	ELSE
		SELECT 
				U.id				id, 
				U.userid			userid, 
				'<b>'+ISNULL(@nomempresa,'') + '</b> - ' + U.nombre			nombre, 
				A.ApplicationName	aplicacion, 
				R.RoleId			idperfil, 
				U.perfil			perfil, 
				U.username			[user],				
				U.estado			estado,
				U.username			username,
				U.apptoken			apptoken,
				0					idbodegas,
				0					idcajas
		FROM Dbo.VW_Usuarios U
		INNER JOIN aspnet_Roles R ON R.id = U.id_perfil
		INNER JOIN aspnet_applications A ON A.ApplicationId = R.ApplicationId
		WHERE U.userid = @userId;
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
