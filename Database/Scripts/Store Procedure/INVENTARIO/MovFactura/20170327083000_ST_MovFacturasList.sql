--liquibase formatted sql
--changeset ,KMARTINEZ:3 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_MovFacturasList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_MovFacturasList]
GO

CREATE PROCEDURE [dbo].[ST_MovFacturasList]
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
*creación:		27/03/17
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
	WHERE ispos = 0  AND
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
			Inner join dbo.VW_MOVFacturas A on Tm.id_pk = A.id
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


