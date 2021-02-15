--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[Dbo].[LotesList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE Dbo.LotesList
GO

CREATE PROCEDURE [dbo].[LotesList]
	@page INT = 1,
	@numpage INT = 10,
	@countpage INT = 0 OUTPUT,
	@filter VARCHAR(50) = NULL
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[dbo].[LotesList]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		22/10/19
*Desarrollador: (Jeteme)
***************************************/
DECLARE @error VARCHAR(MAX), @starpage INT = 1, @endpage INT = 1;
DECLARE @temp TABLE(id_record INT IDENTITY(1,1) ,id_pk INT )
BEGIN TRY
		
		SET @numpage = ISNULL(@numpage,10);

		SET @starpage = (@page * @numpage) - @numpage +1;
		SET @endpage = @numpage * @page;

		INSERT INTO @temp(id_pk)
		SELECT  id	
		FROM dbo.LotesProducto 
		WHERE  [default] = 0 AND (isnull(@filter,'')='' or lote like '%' + @filter + '%') 
		ORDER BY id ASC;

		SET @countpage = @@rowcount;		
		
		SELECT Tm.id_record, c.id ,c.lote,  CONVERT(VARCHAR(10),c.vencimiento_lote, 120) vencimiento_lote, c.estado, CONVERT(VARCHAR(16),c.updated,120) updated
		FROM @temp Tm
				Inner join dbo.LotesProducto C on Tm.id_pk = c.id
		WHERE id_record between @starpage AND @endpage
		ORDER BY id ASC;
				
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


