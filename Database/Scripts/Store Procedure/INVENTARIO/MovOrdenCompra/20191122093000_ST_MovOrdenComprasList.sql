--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_MovOrdenComprasList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_MovOrdenComprasList]
GO
CREATE PROCEDURE [dbo].[ST_MovOrdenComprasList]
	@page INT = 1,
	@numpage INT = 10,
	@countpage INT = 0 OUTPUT,
	@filter VARCHAR(50) = NULL
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[dbo].[ST_MovOrdenComprasList]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		22/11/19
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
		FROM dbo.VW_MOVOrdenCompras
		WHERE  (isnull(@filter,'')='' or CAST(id AS Varchar) like '%' + @filter + '%')	OR
			   (isnull(@filter,'')='' or proveedor like '%' + @filter + '%')	 OR
			    (isnull(@filter,'')='' or nombrebodega like '%' + @filter + '%')
		ORDER BY id DESC;

		SET @countpage = @@rowcount;		
		
		if (@numpage = -1)
			SET @endpage = @countpage;

		SELECT  A.id, A.fechadocumen, A.estado, A.proveedor,A.nombrebodega, A.costo, A.tipodocumento, A.centrocosto
		FROM @temp Tm
				Inner join dbo.VW_MOVOrdenCompras A on Tm.id_pk = A.id
		WHERE id_record between @starpage AND @endpage
		ORDER  BY A.id DESC;
				
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


