--liquibase formatted sql
--changeset ,jarciniegas:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[NOM].[ST_ContratosList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [NOM].[ST_ContratosList]
GO
CREATE PROCEDURE [NOM].[ST_ContratosList]
	@id_empleado bigint = 40,
	@page INT = 1,
	@numpage INT = 10,
	@countpage INT = 0 OUTPUT,
	@filter VARCHAR(50) = NULL

AS
/********************************************
*Nombre:		[NOM].[ST_ContratosList]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		23/10/2020
*Desarrollador: (JARCINIEGAS)
*DESCRIPCIÓN:	Lista la información de [dbo]
				.[Aplasos] y [dbo].[Desarroll-
				adores] filtrada por la tabla 
				[dbo].[Releases] 
********************************************/
DECLARE @error VARCHAR(MAX), @starpage INT = 1, @endpage INT = 1;
DECLARE @temp TABLE(id_record INT IDENTITY(1,1) ,id_pk INT );
BEGIN TRY
		SET @numpage = ISNULL(@numpage,10);

		SET @starpage = (@page * @numpage) - @numpage +1;
		SET @endpage = @numpage * @page;

		INSERT INTO @temp(id_pk)
		SELECT  C.id	
		FROM [NOM].[Contrato] C 
		INNER JOIN [CNT].[Terceros] T ON T.id = C.id_empleado 
		WHERE  (isnull(@filter,'')='' OR C.consecutivo LIKE '%' + @filter + '%')
		OR	   (ISNULL(@filter,'')='' OR convert(varchar,C.fecha_inicio,120) LIKE '%' + @filter + '%')
		OR	   (ISNULL(@filter,'')='' OR convert(varchar,C.fecha_final,120) LIKE '%' + @filter + '%')
		AND C.id_empleado = @id_empleado
		


		ORDER BY id ASC;

		SET @countpage = @@rowcount;
		
		

		SELECT Tm.id_pk id, 
				C.consecutivo,
				(SELECT nombre FROM ST_Listados WHERE id = C.id_tipo_contrato) tipo,
				C.salario,
				C.diasapagar,
				convert(varchar(10),C.fecha_inicio,120) fecha,
				(SELECT nombre FROM [CNT].[CentroCosto] WHERE id = C.centrocosto) centrocosto,
				C.estado idestado,
				(SELECT nombre FROM ST_Listados WHERE id = C.estado) estado

				
		FROM @temp Tm 
				INNER JOIN 	[NOM].[Contrato] C ON C.id = Tm.id_pk
				INNER JOIN [CNT].[Terceros] T ON T.id = C.id_empleado 


			WHERE C.id_empleado = @id_empleado
					

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
