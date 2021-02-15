--liquibase formatted sql
--changeset ,kmartinez:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[FIN].[ST_RecaudocarteraList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [FIN].[ST_RecaudocarteraList]
GO

CREATE PROCEDURE [FIN].[ST_RecaudocarteraList]
	@page INT = 1,
	@numpage INT = 10,
	@countpage INT = 0 OUTPUT,
	@filter VARCHAR(50) = NULL
	
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		 [FIN].[ST_RecaudocarteraList]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		26/11/2020
*Desarrollador: (jeteme)

 ***************************************/
DECLARE @error VARCHAR(MAX), @starpage INT = 1, @endpage INT = 1;
DECLARE @temp TABLE(id_record INT IDENTITY(1,1) ,id_pk INT )
BEGIN TRY
		SET @numpage = ISNULL(@numpage,10);

		SET @starpage = (@page * @numpage) - @numpage +1;
		SET @endpage = @numpage * @page;

		INSERT INTO @temp(id_pk)
		SELECT  A.id	
		FROM [FIN].[VW_Recaudocartera] A 
		WHERE  ((isnull(@filter,'')='' or CAST(A.id AS Varchar) like '%' + @filter + '%')	OR
			   (isnull(@filter,'')='' or cliente like '%' + @filter + '%')) 
		ORDER BY A.id DESC;

		SET @countpage = @@rowcount;		
		
		if (@numpage = -1)
			SET @endpage = @countpage;

		SELECT  A.id, A.fecha,A.cliente, A.valorcliente,A.valorconcepto,  A.estado 
	
		FROM @temp Tm
				Inner join [FIN].[VW_Recaudocartera] A on Tm.id_pk = A.id 
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