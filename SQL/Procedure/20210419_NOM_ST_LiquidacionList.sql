--liquibase formatted sql
--changeset ,jarciniegas:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[NOM].[ST_LiquidacionList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [NOM].[ST_LiquidacionList]
GO
CREATE PROCEDURE [NOM].[ST_LiquidacionList]


	@page INT = 1,
	@numpage INT = 10,
	@countpage INT = 0 OUTPUT,
	@filter VARCHAR(50) = NULL

AS
/***************************************
*Nombre:		[NOM].[ST_LiquidacionList]
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
		SELECT  DISTINCT PP.id	
		FROM [NOM].[Contrato] C 
		INNER JOIN [NOM].[Periodos_Por_Contrato] PC ON PC.id_contrato = C.id 
		INNER JOIN [NOM].[Periodos_Pago] PP ON PP.id = PC.id_periodo 
		WHERE   ((ISNULL(@filter,'')='' OR C.diasapagar like '%' + @filter + '%') OR
				 (ISNULL(@filter,'')='' OR PC.fecha_pago like '%' + @filter + '%')) AND
				 PC.estado = 0

		SET @countpage = @@ROWCOUNT;
		
		
		--SELECT Tm.id_record, B.id, B.nombre
		--FROM @temp Tm 
		--		INNER JOIN [NOM].[Embargos] B ON Tm.id_pk = B.id 
		--WHERE id_record BETWEEN @starpage AND @endpage
				
				SELECT DISTINCT Tm.id_pk id, 
				C.diasapagar dias_pagar, 
				CONVERT(VARCHAR(10),PC.fecha_pago, 120) Fecha_pago
				FROM @temp Tm 
				INNER JOIN [NOM].[Periodos_Pago] PP ON PP.id = Tm.id_pk 
				INNER JOIN [NOM].[Periodos_Por_Contrato] PC ON PC.id_periodo = PP.id 
				INNER JOIN [NOM].[Contrato] C ON C.id = PC.id_contrato	
				WHERE PC.estado = 0 AND id_record BETWEEN @starpage AND @endpage;

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
