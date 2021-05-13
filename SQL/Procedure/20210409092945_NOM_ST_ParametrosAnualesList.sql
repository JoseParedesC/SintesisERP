--liquibase formatted sql
--changeset ,JPAREDES:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[NOM].[ST_ParametrosAnualesList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [NOM].[ST_ParametrosAnualesList]
GO
CREATE PROCEDURE [NOM].[ST_ParametrosAnualesList]

@page BIGINT,
@numpage BIGINT,
@filter VARCHAR(50),
@countpage BIGINT OUTPUT,
@id_user BIGINT

AS

/***************************************
*Nombre:		[NOM].[ST_ParametrosAnualesList]
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		30/03/2021
*Desarrollador:  JPAREDES
*Descripcion:	Lista todos los registros de Parametros Anuales
***************************************/

DECLARE @starpage BIGINT, @endpage BIGINT, @error VARCHAR(MAX);
DECLARE @temp TABLE(id_pk BIGINT)
BEGIN TRY

	SET @starpage = (@page * @numpage) - @numpage +1;
	SET @endpage = @numpage * @page;
	
	INSERT INTO @temp
		SELECT  P.id_paramAnuales
		FROM [NOM].[VW_ParametrosAnuales] P
		WHERE	(ISNULL(@filter,'')='' OR P.fecha_vigencia like '%' + @filter + '%') OR
				(ISNULL(@filter,'')='' OR P.salario_MinimoLegal like '%' + @filter + '%') OR
				(ISNULL(@filter,'')='' OR P.aux_transporte like '%' + @filter + '%')
		GROUP BY P.id_paramAnuales;

	SELECT P.id_paramAnuales id,
			P.salario_MinimoLegal SMMLV,
			CONVERT(VARCHAR(4),P.fecha_vigencia,120) ano,
			P.aux_transporte aux
	FROM [NOM].[VW_ParametrosAnuales] P INNER JOIN @temp tm ON tm.id_pk = P.id_paramAnuales

	SET @countpage = @@ROWCOUNT

END TRY
BEGIN CATCH				
	SET @error = 'Error: '+ERROR_MESSAGE();
	RAISERROR(@error,16,0);	
END CATCH
