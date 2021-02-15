--liquibase formatted sql
--changeset ,jtous:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[dbo].[Aspnet_MembershipListMenus]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[Aspnet_MembershipListMenus]
GO
CREATE PROCEDURE [dbo].[aspnet_MembershipListMenus] 
@menu VARCHAR(50) = 'default.aspx',
@id_perfil VARCHAR(255), 
@id_user INT = 0 
--WITH ENCRYPTION
AS
BEGIN TRY
	DECLARE @error VARCHAR(MAX)
	Declare @childerenmenus table (id_padre int, id_menu int, NombrePagina varchar(100), PathPagina varchar(200), Orden int)
	Declare @ds_menu varchar(300),@ds_filepage varchar(400), @id_profile int
	Declare @ds_version varchar(50),@dt_lastupdated datetime 

	Insert into @childerenmenus(id_menu, id_padre, NombrePagina, PathPagina, Orden)
	(Select M.id, M.id_padre, M.NombrePagina, M.PathPagina, M.Orden
	From Dbo.Menus M
	inner join (Select id From Dbo.Menus Where Estado = 1 and Padre = 1) AS A ON A.id = M.id_Padre
	inner join Dbo.MenusPerfiles MP ON M.id = MP.id_menu
	Where M.Padre = 0 and M.Estado = 1  AND MP.id_perfil = (Select top 1 id FROM Dbo.aspnet_Roles Where RoleId = @id_perfil)
	UNION
	SELECT M.id, M.id_padre, M.nombrepagina, M.pathpagina, M.orden
	FROM DBO.MenuPermisosUser  P
	INNER JOIN Menus M ON P.id_menu = M.id 
	WHERE P.id_user = @id_user AND P.reader != 0);

	Select  NombrePagina, PathPagina
	From Dbo.Menus
	where LTrim(Rtrim(PathPagina)) = LTrim(Rtrim(@menu));
		
	;with cte (id_Padre, id, NombrePagina, PathPagina, Orden, icon ) 
	AS (
		Select 0, M.id, M.NombrePagina, M.PathPagina, M.Orden, M.icon
		From Dbo.Menus M
		Where Padre = 1 and M.Estado = 1 
				and id in 	(SELECT id_Padre from @childerenmenus )
				and estado = 1
	)
	Select table_name='menus', id_Padre id_parent, id as id, NombrePagina as menu, PathPagina filepage, Orden orden, icon
	From cte 
	WHERE id != 5
	Union
	Select table_name='menus',id_padre, id_menu, NombrePagina,  PathPAgina, Orden, ''
	From @childerenmenus
	--WHERE id_padre !
	Order by id_Padre, Orden;

	Select table_name='menus',id_padre, id_menu, NombrePagina,  PathPAgina, Orden, ''
	From @childerenmenus
	WHERE id_padre = 5
	Order by Orden ASC;


				
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
GO