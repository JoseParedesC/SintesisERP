--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[TercerosList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE CNT.[TercerosList]
GO
CREATE PROCEDURE [CNT].[TercerosList]
	@page INT = 1,
	@numpage INT = 10,
	@countpage INT = 0 OUTPUT,
	@filter VARCHAR(50) = NULL
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[dbo].[TercerosList]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		04/11/19
*Desarrollador: (jeteme)
***************************************/
DECLARE @error VARCHAR(MAX), @starpage INT = 1, @endpage INT = 1;
DECLARE @temp TABLE(id_record INT IDENTITY(1,1) ,id_pk INT )
BEGIN TRY
		SET @numpage = ISNULL(@numpage,10);

		SET @starpage = (@page * @numpage) - @numpage +1;
		SET @endpage = @numpage * @page;

		INSERT INTO @temp(id_pk)
		SELECT  id	
		FROM CNT.VW_Terceros
		WHERE  (isnull(@filter,'')='' or tercero like '%' + @filter + '%') OR	
			   (isnull(@filter,'')='' or iden like '%' + @filter + '%') 
		ORDER BY id ASC;

		SET @countpage = @@rowcount;		
		
		SELECT Tm.id_record, A.id, A.iden, A.tercero, A.estado
		FROM @temp Tm
				Inner join CNT.VW_Terceros A on Tm.id_pk = A.id
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


