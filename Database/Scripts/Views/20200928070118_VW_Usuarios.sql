--liquibase formatted sql
--changeset ,jeteme:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[dbo].[VW_Usuarios]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
	Drop View [dbo].[VW_Usuarios]
END
GO

CREATE VIEW [dbo].[VW_Usuarios]
AS
/***************************************
*Nombre:		[dbo].[VW_Usuarios]
----------------------------------------
*Tipo:			Vista
*creación:		02/04/17
*Desarrollador: (JTOUS)
***************************************/
		SELECT        
				U.id,
				U.nombre,
				U.username,
				U.email,
				U.telefono,
				U.identificacion,
				R.RoleName perfil,
				T.horainicio +' - ' +T.horafin turno,
				U.estado,
				U.userid,
				R.id id_perfil,
				U.apptoken,
				UPPER(R.RoleName) srole
		FROM    dbo.Usuarios AS U
		INNER JOIN dbo.aspnet_Roles R on R.id = U.id_perfil
		LEFT JOIN dbo.Turnos T ON T.id = U.id_turno

GO


