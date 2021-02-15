--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[Dbo].[CategoriasProductosList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE Dbo.CategoriasProductosList
GO
CREATE PROCEDURE [dbo].[CategoriasProductosList]
	@page INT = 1,
	@numpage INT = 10,
	@countpage INT = 0 OUTPUT,
	@filter VARCHAR(50) = NULL

AS
/***************************************
*Nombre:		[dbo].[CategoriasProductosList]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		29/10/19
*Desarrollador: (JTHERAN)
***************************************/

DECLARE @error VARCHAR(MAX), @starpage INT = 1, @endpage INT = 1;
DECLARE @temp TABLE(id_record INT IDENTITY(1,1) ,id_pk INT )
BEGIN TRY
		SET @numpage = ISNULL(@numpage,10);

		SET @starpage = (@page * @numpage) - @numpage +1;
		SET @endpage = @numpage * @page;

		INSERT INTO @temp(id_pk)
		SELECT  id	
		FROM dbo.CategoriasProductos
		WHERE  (isnull(@filter,'')='' or nombre like '%' + @filter + '%')	
		ORDER BY id ASC;

		SET @countpage = @@rowcount;		
		
		if (@numpage = -1)
			SET @endpage = @countpage;

		SELECT  A.id, A.nombre, A.estado
		FROM @temp Tm
				Inner join dbo.CategoriasProductos A on Tm.id_pk = A.id
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
