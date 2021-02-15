--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[ST_MOVReciboCajaConceptoList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [CNT].[ST_MOVReciboCajaConceptoList]
GO

CREATE PROCEDURE [CNT].[ST_MOVReciboCajaConceptoList]
	@page INT = 1,
	@numpage INT = 10,
	@countpage INT = 0 OUTPUT,
	@filter VARCHAR(50) = NULL,
	@id_recibo BIGINT=0
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		 CNT.[ST_MOVReciboCajaConceptoList]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		27/06/20
*Desarrollador: (jeteme)

SP para Listar los conceptos que han sido recaudados por id_recibo
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
				FROM CNT.VW_MOVReciboCajasConceptos A 
				WHERE  ((isnull(@filter,'')='' or CAST(A.id AS Varchar) like '%' + @filter + '%')	OR
					   (isnull(@filter,'')='' or concepto like '%' + @filter + '%')) AND A.id_recibo=@id_recibo 
				ORDER BY A.id_concepto ASC;

				SET @countpage = @@rowcount;		
		
				if (@numpage = -1)
					SET @endpage = @countpage;

				select  tm.id_pk id,c.id_recibo,c.id_concepto,c.concepto,c.valor,R.valorcliente,R.valorconcepto
				FROM @temp Tm
						INNER JOIN VW_MOVReciboCajasConceptos C ON tm.id_pk = C.id
						INNER JOIN CNT.MOVReciboCajas R ON C.id_recibo=R.id
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


