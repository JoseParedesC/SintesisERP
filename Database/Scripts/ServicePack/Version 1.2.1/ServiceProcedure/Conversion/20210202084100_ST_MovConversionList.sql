--liquibase formatted sql
--changeset ,CZULBARAN:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_MovConversionList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1) 
DROP PROCEDURE dbo.ST_MovConversionList
GO
CREATE  PROCEDURE [dbo].[ST_MovConversionList]
	@page INT = 1,
	@numpage INT = 10,
	@countpage INT = 0 OUTPUT,
	@filter VARCHAR(50) = NULL
AS
/***************************************
*Nombre:		[dbo].[ST_MovConversionList]
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
		SELECT  C.id	
		FROM [dbo].[VW_MOVConversiones] C
		WHERE  (isnull(@filter,'')='' or CAST(C.id AS Varchar) like '%' + @filter + '%')
		ORDER BY id DESC;

		SET @countpage = @@rowcount;		
		
		if (@numpage = -1)
			SET @endpage = @countpage;

		SELECT  A.id, 
		CONVERT(VARCHAR(10),A.fechadocumen,120) fechadocumen, 
		CASE WHEN A.estado='PROCE' THEN 'PROCESADO' 
		     WHEN A.estado='REVER' THEN 'REVERTIDO' 
			 WHEN A.estado ='REVON' THEN 'REVERSION' END estado, 
			 A.costo
		FROM @temp Tm
		INNER JOIN [dbo].[VW_MOVConversiones] A on Tm.id_pk = A.id
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
