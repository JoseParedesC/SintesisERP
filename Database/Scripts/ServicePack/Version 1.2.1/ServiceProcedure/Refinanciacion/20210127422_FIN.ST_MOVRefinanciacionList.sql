--liquibase formatted sql
--changeset ,kmartinez:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[FIN].[ST_MOVRefinanciacionList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [FIN].[ST_MOVRefinanciacionList]
GO

CREATE PROCEDURE [FIN].[ST_MOVRefinanciacionList]
	@page INT = 1,
	@numpage INT = 10,
	@countpage INT = 0 OUTPUT,
	@filter VARCHAR(50) = NULL

AS
/***************************************
*Nombre:		[FIN].[ST_MOVRefinanciacionList]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		25/01/2021
*Desarrollador: (Kmartinez)
*Descripcion: Este SP tiene como funcionalidad listar las refinanciacion 
***************************************/
DECLARE @error VARCHAR(MAX), @starpage INT = 1, @endpage INT = 1;
DECLARE @temp TABLE(id_record INT IDENTITY(1,1) ,id_pk INT )
BEGIN TRY
		
		SET @numpage = ISNULL(@numpage,10);

		SET @starpage = (@page * @numpage) - @numpage +1;
		SET @endpage = @numpage * @page;

		INSERT INTO @temp(id_pk)
		SELECT  id
		FROM [FIN].[VW_RefinanciacionList]
		WHERE	((isnull(@filter,'')='' or id like '%' + @filter + '%') OR	
				(isnull(@filter,'')='' or numfactura like '%' + @filter + '%') ) 
				
		ORDER BY id DESC;

		SET @countpage = @@rowcount;		
		
		SELECT   
		t.id Consecutivo, t.fecha, t.numfactura, t.valor, t.id_factura, t.estado 
		FROM @temp Tm
				Inner join [FIN].[VW_RefinanciacionList] t on Tm.id_pk = t.id
		WHERE id_record between @starpage AND @endpage
		ORDER BY id DESC;				
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
