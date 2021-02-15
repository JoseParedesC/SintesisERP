--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[ST_MOVComprobanteContaList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [CNT].[ST_MOVComprobanteContaList]
GO

CREATE PROCEDURE [CNT].[ST_MOVComprobanteContaList]
	@page INT = 1,
	@numpage INT = 10,
	@countpage INT = 0 OUTPUT,
	@filter VARCHAR(50) = NULL

--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[CNT].[ST_MOVComprobanteContaList]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		10/07/20
*Desarrollador: (Jeteme)

SP que lista los comprobantes contables realizados

***************************************/
DECLARE @error VARCHAR(MAX), @starpage INT = 1, @endpage INT = 1;
DECLARE @temp TABLE(id_record INT IDENTITY(1,1) ,id_pk INT )

BEGIN TRY


		SET @numpage = ISNULL(@numpage,10);

		SET @starpage = (@page * @numpage) - @numpage +1;
		SET @endpage = @numpage * @page;

		INSERT INTO @temp(id_pk)
		SELECT  id	
		FROM CNT.MOVComprobantesContables
		WHERE   
		(isnull(@filter,'')='' or CAST(id AS Varchar) like '%' + @filter + '%') OR	
		(isnull(@filter,'')='' or CAST(detalle AS Varchar) like '%' + @filter + '%')


		ORDER BY id DESC;

		SET @countpage = @@rowcount;		
		
		if (@numpage = -1)
			SET @endpage = @countpage;

		SELECT  M.id, CONVERT(VARCHAR(10), M.fecha, 120) AS fecha, M.detalle, dbo.ST_FnGetNombreList(M.estado) estado
		FROM @temp Tm
				Inner join CNT.MOVComprobantesContables M on Tm.id_pk = M.id
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

GO


