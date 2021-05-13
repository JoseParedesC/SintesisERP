--liquibase formatted sql
--changeset ,jarciniegas:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[NOM].[ST_LiquidacionListContrato]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [NOM].[ST_LiquidacionListContrato]
GO
CREATE PROCEDURE [NOM].[ST_LiquidacionListContrato]

	@id_periodo BIGINT = NULL,
	@page INT = 1,
	@numpage INT = 10,
	@countpage INT = 0 OUTPUT,
	@filter VARCHAR(50) = NULL

AS
/***************************************
*Nombre:		[NOM].[ST_LiquidacionListContrato]
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

		IF(ISNULL(@id_periodo,0) = 0)
		BEGIN

			INSERT INTO @temp(id_pk)
			SELECT  DISTINCT C.id_contrato	
				FROM [NOM].[VW_Contratos] C 
				INNER JOIN [NOM].[Periodos_Por_Contrato] PC ON PC.id_contrato = C.id_contrato 
				INNER JOIN [NOM].[Periodos_Pago] PP ON PP.id = PC.id_periodo 
				WHERE   ((ISNULL(@filter,'')='' OR C.diasapagar like '%' + @filter + '%') OR
						 (ISNULL(@filter,'')='' OR PC.fecha_pago like '%' + @filter + '%')) AND
						 PC.estado = 0 

			SET @countpage = @@ROWCOUNT;
		
		
			SELECT DISTINCT Tm.id_pk id, 
							EM.razonsocial ,
							C.diasapagar dias_pagar, 
							C.nombre_cargo,
							PC.id id_periodo_contrato
							
				FROM @temp Tm 
				INNER JOIN [NOM].[VW_Contratos] C ON C.id_contrato = Tm.id_pk 	
				INNER JOIN [NOM].[Periodos_Por_Contrato] PC ON PC.id_contrato = C.id_contrato 
				INNER JOIN [NOM].[Periodos_Pago] PP ON PP.id =  PC.id_periodo
				INNER JOIN [NOM].[VW_Empleados] EM ON  EM.id = C.id_empleado
				WHERE C.estado = 'Vigente' AND PC.estado = 0 AND id_record BETWEEN @starpage AND @endpage;

		END 
		ELSE BEGIN

			INSERT INTO @temp(id_pk)
			SELECT  DISTINCT C.id	
				FROM [NOM].[Contrato] C 
				INNER JOIN [NOM].[Periodos_Por_Contrato] PC ON PC.id_contrato = C.id 
				INNER JOIN [NOM].[Periodos_Pago] PP ON PP.id = PC.id_periodo 
				WHERE   ((ISNULL(@filter,'')='' OR C.diasapagar like '%' + @filter + '%') OR
						 (ISNULL(@filter,'')='' OR PC.fecha_pago like '%' + @filter + '%')) AND
						 PC.estado = 0 AND PP.id = @id_periodo;

			SET @countpage = @@ROWCOUNT;
		
		
				SELECT DISTINCT Tm.id_pk id, 
								EM.razonsocial ,
								C.diasapagar dias_pagar, 
								C.nombre_cargo, 
								PC.id id_periodo_contrato
					FROM @temp Tm 
					INNER JOIN [NOM].[VW_Contratos] C ON C.id_contrato = Tm.id_pk 	
					INNER JOIN [NOM].[Periodos_Por_Contrato] PC ON PC.id_contrato = C.id_contrato 
					INNER JOIN [NOM].[Periodos_Pago] PP ON PP.id =  PC.id_periodo
					INNER JOIN [NOM].[VW_Empleados] EM ON  EM.id = C.id_empleado
					WHERE C.estado = 'Vigente' AND PC.estado = 0 AND id_record BETWEEN @starpage AND @endpage
					AND PP.id = @id_periodo;

		END

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
