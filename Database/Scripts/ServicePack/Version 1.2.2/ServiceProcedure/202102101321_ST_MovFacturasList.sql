USE [SintesisCloudMotoCredito2]
GO
/****** Object:  StoredProcedure [dbo].[ST_MovFacturasList]    Script Date: 16/02/2021 13:22:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[ST_MovFacturasList]
	@page INT = 1,
	@numpage INT = 10,
	@countpage INT = 0 OUTPUT,
	@filter VARCHAR(50) = NULL,	
	@id_user INT 
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[dbo].[ST_MovFacturasList]
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
	FROM dbo.VW_MOVFacturas
	WHERE ispos = 0  AND (isob = 0 OR isob IS NULL) AND
	((isnull(@filter,'')='' or CAST(id AS Varchar) like '%' + @filter + '%') OR	
	(isnull(@filter,'')='' or CAST(consecutivo AS Varchar) like '%' + @filter + '%') OR	
	(isnull(@filter,'')='' or cliente like '%' + @filter + '%') OR	
	(isnull(@filter,'')='' or prefijo like '%' + @filter + '%'))
	ORDER BY id DESC;
	SET @countpage = @@rowcount;		
		
	if (@numpage = -1)
		SET @endpage = @countpage;

	SELECT  A.id, A.fechadoc fechafac, A.rptconsecutivo consecutivo, A.total, A.estado, cliente, CASE WHEN A.totalcredito > 0 AND A.formaPagoFinan = DBO.ST_FnGetIdList('FINAN') THEN 0 ELSE NULL END Finan
	FROM @temp Tm
			INNER JOIN dbo.VW_MOVFacturas A on Tm.id_pk = A.id
	WHERE id_record BETWEEN @starpage AND @endpage
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
