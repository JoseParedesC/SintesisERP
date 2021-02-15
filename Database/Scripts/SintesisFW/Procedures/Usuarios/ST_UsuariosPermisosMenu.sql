--liquibase formatted sql
--changeset ,apuello:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_UsuariosPermisosMenu]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[ST_UsuariosPermisosMenu]
GO
CREATE PROCEDURE [dbo].[ST_UsuariosPermisosMenu] 
	@id_user BIGINT,
	@page INT = 1,
	@numpage INT = 10,
	@countpage INT = 0 OUTPUT,
	@filter VARCHAR(50) = NULL
/***************************************
*Nombre: [dbo].[ST_UsuariosPermisosMenu]
----------------------------------------
*Tipo: Procedimiento almacenado
*creación: 22/11/20
*Desarrollador: (APUELLO)
*Descripcion: Lista todos los menus que están 
			  en la base de datos, excluyendo a los menus con los usuarios 
			  con el rol de super administrador y administrador
***************************************/
AS

BEGIN TRY
	DECLARE @error VARCHAR(MAX), @starpage INT = 1, @endpage INT = 1;
	DECLARE @temp TABLE(id_record INT IDENTITY(1,1) ,id_pk INT )
		
		SET @numpage = ISNULL(@numpage,10);

		SET @starpage = (@page * @numpage) - @numpage +1;
		SET @endpage = @numpage * @page;

IF EXISTS(SELECT 1 FROM Usuarios WHERE id_perfil NOT IN (1,2) AND id = @id_user)
BEGIN

	;WITH CTE(id, id_menu,	nombrepagina,	[view],	crea,	updat,	delet,	modific)
	AS (
		SELECT 
			0 id, M.id id_menu, M.nombrepagina, 1 [view], 1 [crea], 1 [updat], 1 [delet], '0' modific
		FROM Menus M INNER JOIN 
			MenusPerfiles P ON M.id = P.id_menu INNER JOIN
			Usuarios U ON U.id_perfil = P.id_perfil
		WHERE M.padre = 0 AND P.id_perfil NOT IN (1,2) AND U.id = @id_user
	),
	CTE2(id, id_menu,	nombrepagina,	[view],	crea,	updat,	delet,	modific)AS
	(
		SELECT 
		PU.id, M.id id_menu, M.nombrepagina menu, ISNULL(PU.reader,0) [view], ISNULL(PU.creater,0) [crea], 
		ISNULL(PU.updater,0) [updat], ISNULL(PU.deleter,0) [delet], '1' modific  
		FROM Menus M LEFT JOIN 
			dbo.MenuPermisosUser PU ON PU.id_menu = M.id
		WHERE M.id NOT IN (SELECT id_menu FROM CTE) AND M.padre = 0 AND PU.id_user = @id_user AND M.pathpagina != 'Default.aspx' AND M.estado != 0
	)

	SELECT id, id_menu,	nombrepagina menu,	[view],	crea,	updat,	delet,	modific FROM CTE
	UNION ALL
	SELECT id, id_menu,	nombrepagina menu,	[view],	crea,	updat,	delet,	modific FROM CTE2
	UNION ALL
	SELECT
		PU.id, M.id id_menu, M.nombrepagina menu, ISNULL(PU.reader,0) [view], ISNULL(PU.creater,0) [crea], 
		ISNULL(PU.updater,0) [updat], ISNULL(PU.deleter,0) [delet], '1' modific  
	FROM Menus M LEFT JOIN 
		dbo.MenuPermisosUser PU ON PU.id_menu = M.id AND PU.id_user = @id_user
	WHERE M.id NOT IN (SELECT id_menu FROM CTE UNION SELECT id_menu FROM CTE2)  AND M.padre = 0	AND M.pathpagina != 'Default.aspx' AND M.estado != 0
	
	ORDER BY modific asc, id DESC, nombrepagina ASC	

END
ELSE
	SELECT id_pk id, id_pk id_menu, id_pk menu,id_pk [view], id_pk crea, id_pk updat,  id_pk delet, id_pk modif FROM @temp

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