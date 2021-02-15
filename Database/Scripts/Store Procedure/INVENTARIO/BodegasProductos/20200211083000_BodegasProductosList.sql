--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[Dbo].[BodegasProductosList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE Dbo.BodegasProductosList
GO


CREATE PROCEDURE [dbo].[BodegasProductosList]
	@page INT = 1,
	@numpage INT = 10,
	@countpage INT = 0 OUTPUT,
	@filter VARCHAR(50) = NULL,
	@id_producto BIGINT
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[dbo].[BodegasProductosList]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		20/11/19
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
		FROM dbo.VW_BodegasProductos
		WHERE	((isnull(@filter,'')='' or producto like '%' + @filter + '%') OR	
				(isnull(@filter,'')='' or bodega like '%' + @filter + '%') ) AND id_producto=@id_producto
				
		ORDER BY id ASC;

		SET @countpage = @@rowcount;		
		
		SELECT Tm.id_record, c.id, c.id_producto,c.producto, c.id_bodega,c.bodega, c.stockmin,c.stockmax, CONVERT(VARCHAR(16),c.updated,120) updated
		FROM @temp Tm
				Inner join dbo.VW_BodegasProductos C on Tm.id_pk = c.id
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


