--liquibase formatted sql
--changeset ,JTOUS:4 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[DocumentListSNCount]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [CNT].[DocumentListSNCount]
GO


CREATE PROCEDURE [CNT].[DocumentListSNCount]
	@page INT = 1,
	@numpage INT = 10,
	@countpage INT = 0 OUTPUT,
	@filter VARCHAR(50) = NULL,
	@fechaini SMALLDATETIME,
	@fechafin SMALLDATETIME
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[dbo].[ProductosList]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		16/11/17
*Desarrollador: (Jeteheran)

Sp lista los documentos sin contabilizar del modulo de inventario (Entradas, Ajustes, Traslados, notas creditos)
***************************************/
DECLARE @error VARCHAR(MAX), @starpage INT = 1, @endpage INT = 1;
DECLARE @temp TABLE(id_record INT IDENTITY(1,1) ,id INT,tipodocumento VARCHAR(50),fecha VARCHAR(10),factura VARCHAR(30),total NUMERIC(18,2),vista VARCHAR(50),anomes varchar(6) )
BEGIN TRY
		SET @numpage = ISNULL(@numpage,10);

		SET @starpage = (@page * @numpage) - @numpage +1;
		SET @endpage = @numpage * @page;

		
		INSERT INTO @temp(id,tipodocumento,fecha,factura,total,vista,anomes)
		SELECT  A.id,A.tipodoc tipodocumento,A.fecha,A.factura,A.total,A.vista,A.anomes
		FROM CNT.VW_PROCESOSCONTABILIZAR A
		WHERE  ((isnull(@filter,'')='' or id like '%' + @filter + '%')	OR			
			   (isnull(@filter,'')='' or fecha like '%' + @filter + '%')	OR			
			   (isnull(@filter,'')='' or tipodoc like '%' + @filter + '%')    OR			
			   (isnull(@filter,'')='' or factura like '%' + @filter + '%'))	AND 
			   Esquema='dbo' AND fecha between convert(VARCHAR(10),@fechaini,120) and convert(VARCHAR(10),@fechafin,120)  
		ORDER BY nivel,id ASC;

		SET @countpage = @@rowcount;

		SELECT *
		FROM @temp Tm
		WHERE id_record between @starpage AND @endpage ;
				
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


