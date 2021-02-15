--liquibase formatted sql
--changeset ,kmartinez:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[FIN].[ST_RefinanciacionCuotaList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [FIN].[ST_RefinanciacionCuotaList]
GO

CREATE PROCEDURE [FIN].[ST_RefinanciacionCuotaList]
	@page INT = 1,
	@numpage INT = 10,
	@countpage INT = 0 OUTPUT,
	@filter VARCHAR(50) = NULL,
	@id int
 
AS
/***************************************
*Nombre:		[FIN].[ST_RefinanciacionCuotaList]
*Tipo:			Procedimiento almacenado
*creaci�n:		26/11/19
*Desarrollador: (Jeteme)
***************************************/

DECLARE @error VARCHAR(MAX), @starpage INT = 1, @endpage INT = 1;
DECLARE @temp TABLE(id_record INT IDENTITY(1,1) ,id_pk INT )
BEGIN TRY
		SET @numpage = ISNULL(@numpage,10);

		SET @starpage = (@page * @numpage) - @numpage +1;
		SET @endpage = @numpage * @page;

		INSERT INTO @temp(id_pk)
		SELECT  A.id	
		FROM [FIN].[RefinanciacionItems] A 
		WHERE  ((isnull(@filter,'')='' or CAST(A.id AS Varchar) like '%' + @filter + '%')	OR
			   (isnull(@filter,'')='' or numfactura like '%' + @filter + '%')) AND id_refinan = @id AND new = 0
		ORDER BY A.id;

		SET @countpage = @@rowcount;		
		
		if (@numpage = -1)
			SET @endpage = @countpage;

	 SELECT id,
				id_refinan, 
				id_cliente, 
				id_factura,  
				numfactura, 
				new, 
				cuota, 
				valorcuota, 
				saldo, 
				saldo_anterior, 
				interes, 
				acapital, 
				porcentaje, 
				fecha_inicial, 
				vencimiento,
				fecha_pagointeres
		FROM @temp Tm
				INNER JOIN [FIN].[RefinanciacionItems] A on Tm.id_pk = A.id 
		WHERE id_record between @starpage AND @endpage AND id_refinan = @id AND new = 0
		ORDER  BY A.id;
				
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


 