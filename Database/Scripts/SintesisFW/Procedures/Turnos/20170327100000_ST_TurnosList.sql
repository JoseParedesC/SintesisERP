--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_TurnosList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_TurnosList]
GO
CREATE PROCEDURE dbo.ST_TurnosList
	@page INT = 1,
	@numpage INT = 10,
	@countpage INT = 0 OUTPUT,
	@filter VARCHAR(50) = NULL
WITH ENCRYPTION
AS
/***************************************
*Nombre:		[dbo].[ST_TurnosList]
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
		FROM dbo.Turnos
		WHERE  (isnull(@filter,'')='' or horainicio like '%' + @filter + '%') OR	
			   (isnull(@filter,'')='' or horafin like '%' + @filter + '%')
		ORDER BY id ASC;

		SET @countpage = @@rowcount;		
		
		SELECT Tm.id_record, A.id, A.horainicio, A.horafin, A.estado
		FROM @temp Tm
				Inner join dbo.Turnos A on Tm.id_pk = A.id
		WHERE id_record between @starpage AND @endpage;
				
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
