--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_MovTrasladosList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_MovTrasladosList]
GO

CREATE PROCEDURE [dbo].[ST_MovTrasladosList]
	@page INT = 1,
	@numpage INT = 10,
	@countpage INT = 0 OUTPUT,
	@filter VARCHAR(50) = NULL
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[dbo].[ST_MovTrasladosList]
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
		SELECT  id	
		FROM dbo.MOVTraslados
		WHERE  (isnull(@filter,'')='' or CAST(id AS Varchar) like '%' + @filter + '%')	
		ORDER BY id DESC;

		SET @countpage = @@rowcount;		
		
		if (@numpage = -1)
			SET @endpage = @countpage;

		SELECT  A.id, CONVERT(VARCHAR(10), A.fecha, 120) fecha, A.descripcion, L.nombre estado, 
		ISNULL(P.cantidad,0) cantidad, ISNULL(P.costo,0) costototal,
		CASE WHEN A.estado = 12 AND A.contabilizado = 0 THEN 1 ELSE 0 END conta
		FROM @temp Tm
		Inner join dbo.MOVTraslados A on Tm.id_pk = A.id
		LEFT JOIN Dbo.ST_Listados L ON L.id = A.estado
		LEFT JOIN 
			(Select Count(1) cantidad, SUM(costo*cantidad) costo, id_traslado 
			 From Dbo.MOVTrasladosItems GROUP BY id_traslado) AS P ON P.id_traslado = CASE WHEN L.nombre IN ('REVERTIDO','PROCESADO') THEN A.id ELSE A.id_reversion END
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

GO


