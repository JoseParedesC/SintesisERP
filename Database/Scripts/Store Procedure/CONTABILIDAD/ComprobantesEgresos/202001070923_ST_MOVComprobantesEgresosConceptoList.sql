--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[ST_MOVComprobantesEgresosConceptoList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [CNT].[ST_MOVComprobantesEgresosConceptoList]
GO
				


CREATE PROCEDURE [CNT].[ST_MOVComprobantesEgresosConceptoList]
	@page INT = 1,
	@numpage INT = 10,
	@countpage INT = 0 OUTPUT,
	@filter VARCHAR(50) = NULL,
	@id_comprobante BIGINT=0
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		 CNT.[ST_MOVComprobantesEgresosConceptoList]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		07/01/20
*Desarrollador: (jeteme)
***************************************/
DECLARE @error VARCHAR(MAX), @starpage INT = 1, @endpage INT = 1;
DECLARE @temp TABLE(id_record INT IDENTITY(1,1) ,id_pk BIGINT )
BEGIN TRY
		SET @numpage = ISNULL(@numpage,10);

		SET @starpage = (@page * @numpage) - @numpage +1;
		SET @endpage = @numpage * @page;

		BEGIN
		INSERT INTO @temp(id_pk)
				SELECT  A.id
				FROM CNT.VW_MOVComprobantesEgresosConceptos A 
				WHERE  ((isnull(@filter,'')='' or CAST(A.id AS Varchar) like '%' + @filter + '%')	OR
					   (isnull(@filter,'')='' or concepto like '%' + @filter + '%')) AND A.id_comprobante=@id_comprobante 
				ORDER BY A.id_concepto ASC;

				SET @countpage = @@rowcount;		
		
				if (@numpage = -1)
					SET @endpage = @countpage;

				select  tm.id_pk id,c.id_comprobante,c.id_concepto,c.concepto,c.valor,R.valorpagado valorproveedor,R.valorconcepto
				FROM @temp Tm
						INNER JOIN VW_MOVComprobantesEgresosConceptos C ON tm.id_pk = C.id
						INNER JOIN CNT.MOVComprobantesEgresos R ON C.id_comprobante=R.id
				WHERE id_record between @starpage AND @endpage 



		END
			
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


