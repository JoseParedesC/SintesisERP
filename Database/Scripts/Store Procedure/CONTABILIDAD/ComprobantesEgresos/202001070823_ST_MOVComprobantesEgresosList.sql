--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[ST_MOVComprobantesEgresosList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [CNT].[ST_MOVComprobantesEgresosList]
GO

CREATE PROCEDURE [CNT].[ST_MOVComprobantesEgresosList]
	@page INT = 1,
	@numpage INT = 10,
	@countpage INT = 0 OUTPUT,
	@filter VARCHAR(50) = NULL
---WITH ENCRYPTION
AS
/***************************************
*Nombre:		[CNT].[ST_MOVComprobantesEgresosList]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		07/01/20
*Desarrollador: (Jeteme)
***************************************/
DECLARE @error VARCHAR(MAX), @starpage INT = 1, @endpage INT = 1;
DECLARE @temp TABLE(id_record INT IDENTITY(1,1) ,id_pk INT )
BEGIN TRY
		
		SET @numpage = ISNULL(@numpage,10);

		SET @starpage = (@page * @numpage) - @numpage +1;
		SET @endpage = @numpage * @page;

		INSERT INTO @temp(id_pk)
		SELECT  id
		FROM CNT.VW_MOVComprobantesEgresos
		WHERE	((isnull(@filter,'')='' or proveedor like '%' + @filter + '%') OR	
				(isnull(@filter,'')='' or valorproveedor like '%' + @filter + '%') ) 
				
		ORDER BY id desc;

		SET @countpage = @@rowcount;		
		
		SELECT Tm.id_record, c.id, c.proveedor,  c.estado,c.nomestado ,C.valorconcepto,C.valorproveedor, CONVERT(VARCHAR(16),c.updated,120) updated
		FROM @temp Tm
				Inner join CNT.VW_MOVComprobantesEgresos C on Tm.id_pk = c.id
		WHERE id_record between @starpage AND @endpage
		ORDER BY id desc;
				
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


