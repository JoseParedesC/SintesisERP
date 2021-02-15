--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[VendedoresList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[VendedoresList]
GO
CREATE PROCEDURE [dbo].[VendedoresList]
	@page INT = 1,
	@numpage INT = 10,
	@countpage INT = 0 OUTPUT,
	@filter VARCHAR(50) = NULL
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[dbo].[VendedoresList]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		15/11/19
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
		FROM dbo.Vendedores
		WHERE	((isnull(@filter,'')='' or codigo like '%' + @filter + '%') OR	
				(isnull(@filter,'')='' or nombre like '%' + @filter + '%') ) 
				
		ORDER BY id ASC;

		SET @countpage = @@rowcount;		
		
		SELECT Tm.id_record, m.id, m.codigo, m.nombre, m.codigo +' - '+m.nombre vendedor, m.estado
		FROM @temp Tm
				Inner join dbo.Vendedores m on Tm.id_pk = m.id
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


