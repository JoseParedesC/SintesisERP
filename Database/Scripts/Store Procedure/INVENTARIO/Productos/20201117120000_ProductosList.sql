--liquibase formatted sql
--changeset ,jteheran:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[Dbo].[ProductosList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [Dbo].[ProductosList]
GO


CREATE PROCEDURE [dbo].[ProductosList]
	@page INT = 1,
	@numpage INT = 10,
	@countpage INT = 0 OUTPUT,
	@filter VARCHAR(50) = NULL
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[dbo].[ProductosList]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		16/11/17
*Desarrollador: (Jeteheran)
***************************************/
DECLARE @error VARCHAR(MAX), @starpage INT = 1, @endpage INT = 1;
DECLARE @temp TABLE(id_record INT IDENTITY(1,1) ,id_pk INT )
BEGIN TRY
		SET @numpage = ISNULL(@numpage,10);

		SET @starpage = (@page * @numpage) - @numpage +1;
		SET @endpage = @numpage * @page;

		INSERT INTO @temp(id_pk)
		SELECT  id	
		FROM dbo.VW_Productos
		WHERE  (isnull(@filter,'')='' or codigo like '%' + @filter + '%')	OR			
			   (isnull(@filter,'')='' or presentacion like '%' + @filter + '%')	OR			
			   (isnull(@filter,'')='' or nombre like '%' + @filter + '%')	OR			
			   (isnull(@filter,'')='' or tipo like '%' + @filter + '%') OR			
			   (isnull(@filter,'')='' or nombreTipoProducto like '%' + @filter + '%')
		ORDER BY id ASC;

		SET @countpage = @@rowcount;
		
		
		SELECT Tm.id_record,CONCAT(UPPER(SUBSTRING( A.nombreTipoProducto,1,1)),LOWER(SUBSTRING( A.nombreTipoProducto,2,LEN( A.nombreTipoProducto))))  tipoproducto ,A.id, A.codigo, A.presentacion, A.nombre, A.tipo,A.stock, A.estado
		FROM @temp Tm
				Inner join dbo.VW_Productos A on Tm.id_pk = A.id
		WHERE id_record between @starpage AND @endpage ORDER BY A.tipoproducto;
				
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

