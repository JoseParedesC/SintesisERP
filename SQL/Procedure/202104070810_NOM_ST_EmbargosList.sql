--liquibase formatted sql
--changeset ,jarciniegas:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[NOM].[ST_EmbargosList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [NOM].[ST_EmbargosList]
GO
CREATE PROCEDURE [NOM].[ST_EmbargosList]


	@page INT = 1,
	@numpage INT = 10,
	@countpage INT = 0 OUTPUT,
	@filter VARCHAR(50) = NULL
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[NOM].[ST_EmbargosList]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		16/10/2020
*Desarrollador: (JARCINIEGAS)
*DESCRIPCIÓN:	Lista la información de 
				la tabla [dbo].[Embargos]
				en la tabla de la vista
				Embargos.aspx y crea los 
				filtros para la busqueda 
				de la información
***************************************/
DECLARE @error VARCHAR(MAX), @starpage INT = 1, @endpage INT = 1;
DECLARE @temp TABLE(id_record INT IDENTITY(1,1) ,id_pk INT )
BEGIN TRY
		SET @numpage = ISNULL(@numpage,10);

		SET @starpage = (@page * @numpage) - @numpage +1;
		SET @endpage = @numpage * @page;

		INSERT INTO @temp(id_pk)
		SELECT  id	
		FROM  [NOM].[Embargos]
		WHERE   (ISNULL(@filter,'')='' OR nombre like '%' + @filter + '%')
				

		SET @countpage = @@ROWCOUNT;
		
		
		SELECT Tm.id_record, B.id, B.nombre
		FROM @temp Tm 
				INNER JOIN [NOM].[Embargos] B ON Tm.id_pk = B.id 
		WHERE id_record BETWEEN @starpage AND @endpage
				
END TRY
BEGIN CATCH

	    --Getting the error description
	    SELECT @error   =  ERROR_PROCEDURE() + 
					';  ' + CONVERT(VARCHAR,ERROR_LINE()) + 
					'; ' + ERROR_MESSAGE()
	    -- save the error in a Log file
	    RaisError(@error,16,1)
	    Return  
End Catch
