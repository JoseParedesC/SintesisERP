--liquibase formatted sql
--changeset ,kmartinez:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[FIN].[ServicioFinancieroList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [FIN].[ServicioFinancieroList]
GO

CREATE PROCEDURE [FIN].[ServicioFinancieroList]
	@page INT = 1,
	@numpage INT = 10,
	@countpage INT = 0 OUTPUT,
	@filter VARCHAR(50) = NULL

AS
/***************************************
*Nombre:		[FIN].[ServicioFinancieroList]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		27/10/2020
*Desarrollador: (Kmartinez)
*Descripcion: Este SP tiene como funcionalidad listar todo los servicios financiero para poder modificar y eliminar
***************************************/
DECLARE @error VARCHAR(MAX), @starpage INT = 1, @endpage INT = 1;
DECLARE @temp TABLE(id_record INT IDENTITY(1,1) ,id_pk INT )
BEGIN TRY
		
		SET @numpage = ISNULL(@numpage,10);

		SET @starpage = (@page * @numpage) - @numpage +1;
		SET @endpage = @numpage * @page;

		INSERT INTO @temp(id_pk)
		SELECT  id
		FROM [FIN].[VW_ServiciosFinanciero]
		WHERE	((isnull(@filter,'')='' or codigo like '%' + @filter + '%') OR	
				(isnull(@filter,'')='' or nombre like '%' + @filter + '%') ) 
				
		ORDER BY id ASC;

		SET @countpage = @@rowcount;		
		
		SELECT Tm.id_record, t.id, t.codigo, t.nombre ,t.id_cuenta, CONVERT(VARCHAR(16),t.updated,120) updated
		FROM @temp Tm
				Inner join [FIN].[VW_ServiciosFinanciero] t on Tm.id_pk = t.id
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
