--liquibase formatted sql
--changeset ,jteheran:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_MovAnticipoList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_MovAnticipoList]
GO
CREATE PROCEDURE [dbo].[ST_MovAnticipoList]
	@page INT = 1,
	@numpage INT = 10,
	@countpage INT = 0 OUTPUT,
	@filter VARCHAR(50) = NULL,
	@id_user INT 
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[dbo].[ST_MovAnticipoList]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		27/03/17
*Desarrollador: (JTOUS)
***************************************/
DECLARE @error VARCHAR(MAX), @starpage INT = 1, @endpage INT = 1;
DECLARE @temp TABLE(id_record INT IDENTITY(1,1) ,id_pk INT )
BEGIN TRY
	
	SET @numpage = ISNULL(@numpage,10);

	SET @starpage = (@page * @numpage) - @numpage +1;
	SET @endpage = @numpage * @page;

	INSERT INTO @temp(id_pk)
	SELECT  id
	FROM dbo.VW_MOVAnticipos
	WHERE  (
		(isnull(@filter,'')='' or CAST(id AS Varchar) like '%' + @filter + '%')	
		OR (isnull(@filter,'')='' or CAST(iden AS Varchar) like '%' + @filter + '%')
		OR (isnull(@filter,'')='' or CAST(tercero AS Varchar) like '%' + @filter + '%')
	)
	ORDER BY id DESC;

	SET @countpage = @@rowcount;		
		
	if (@numpage = -1)
		SET @endpage = @countpage;

	SELECT M.id, iden +' - ' +tercero tercero,Tipoanticipo tipo, valor, fecha, estado, valor
	FROM dbo.VW_MOVAnticipos M
	INNER JOIN @temp T ON T.id_pk = M.id
	WHERE id_record between @starpage AND @endpage
	ORDER  BY M.id DESC;
				
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