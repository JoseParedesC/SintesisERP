--liquibase formatted sql
--changeset ,jtous:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_PeriodosList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[ST_PeriodosList]
GO

CREATE PROCEDURE [dbo].[ST_PeriodosList]
	@page INT = 1,
	@numpage INT = 10,
	@countpage INT = 0 OUTPUT,
	@filter VARCHAR(50) = NULL,
	@anomes VARCHAR(10) = '2020'
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[Dbo].[ST_PeriodosList]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		09/04/17
*Desarrollador: (JTOUS)
***************************************/
DECLARE @error VARCHAR(MAX), @starpage INT = 1, @endpage INT = 1;
DECLARE @temp TABLE(id_record INT IDENTITY(1,1) ,id_pk INT )
DECLARE @periodoinicial VARCHAR(10) = ''
BEGIN TRY
		SET @periodoinicial = ISNULL((SELECT TOP 1 valor FROM Parametros WHERE codigo = 'ANOMESSTAR'), '');
		SET @numpage = ISNULL(@numpage,10);

		SET @starpage = (@page * @numpage) - @numpage +1;
		SET @endpage = @numpage * @page;

		SELECT DISTINCT id, anomes ano, CAST(anomes AS VARCHAR(4)) +'-'+SUBSTRING(anomes,5, 6) anomes, contabilidad, inventario
		FROM (
			SELECT  CR.id, CR.anomes, CR.contabilidad, CR.inventario
			FROM CNT.Periodos CR 
			WHERE @anomes = SUBSTRING(anomes, 1, 4)
			UNION ALL
			SELECT 0, F.anomes, 0 conta, 0 inven
			FROM [ST_FnAnomesPeriodo](@anomes) F LEFT JOIN CNT.Periodos CR ON CR.anomes = F.anomes
			WHERE CR.id IS NULL

		) AS T
		WHERE  anomes >= @periodoinicial AND
		(isnull(@filter,'')='' or T.anomes like '%' + @filter + '%') 
		
		ORDER BY anomes ASC;

		SET @countpage = @@rowcount;				
				

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
