--liquibase formatted sql
--changeset ,jtous:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[Dbo].[ST_UsuariosList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
Drop Procedure Dbo.ST_UsuariosList
GO
CREATE PROCEDURE Dbo.ST_UsuariosList
	@page INT = 1,
	@numpage INT = 10,
	@countpage INT = 0 OUTPUT,
	@filter VARCHAR(50) = NULL
WITH ENCRYPTION
AS
/***************************************
*Nombre:		[Dbo].[ST_UsuariosList]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		09/04/17
*Desarrollador: (JTOUS)
***************************************/
DECLARE @error VARCHAR(MAX), @starpage INT = 1, @endpage INT = 1;
DECLARE @temp TABLE(id_record INT IDENTITY(1,1) ,id_pk INT )
BEGIN TRY
		SET @page = ISNULL(@page,1);
		SET @numpage = ISNULL(@numpage,10);

		SET @starpage = (@page * @numpage) - (@numpage - 1);
		SET @endpage = @numpage * @page;
		INSERT INTO @temp(id_pk)
		SELECT  id	
		FROM Dbo.VW_Usuarios
		WHERE perfil != 'Super Administrador' AND ((isnull(@filter,'')='' or nombre like '%' + @filter + '%') OR	
			   (isnull(@filter,'')='' or username like '%' + @filter + '%'))
		ORDER BY id ASC;

		SET @countpage = @@rowcount;		
		
		SELECT Tm.id_record, U.id, U.nombre, U.username, U.estado, U.perfil, U.turno
		FROM @temp Tm
				Inner join Dbo.VW_Usuarios U on Tm.id_pk = U.id
		WHERE id_record between @starpage AND @endpage;
				
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
