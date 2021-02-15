--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id =
OBJECT_ID(N'[CNT].[MOVConciliacionList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [CNT].[MOVConciliacionList]
GO
CREATE PROCEDURE [CNT].[MOVConciliacionList]
/***************************************
*Nombre: [CNT].[MOVConciliacionList]
----------------------------------------
*Tipo: Procedimiento almacenado
*creación: 23/12/20
*Desarrollador: APUELLO
*Descripcion: Lista todos los movimientos conciliados que han realizado
***************************************/
	@page INT = 1,
	@numpage INT = 10,
	@countpage INT = 0 OUTPUT,
	@filter VARCHAR(50) = NULL
AS
DECLARE @error VARCHAR(MAX), @starpage INT = 1, @endpage INT = 1;
DECLARE @temp TABLE(id_record INT IDENTITY(1,1) ,id_pk INT )
BEGIN TRY
		SET @numpage = ISNULL(@numpage,10);

		SET @starpage = (@page * @numpage) - @numpage +1;
		SET @endpage = @numpage * @page;

		INSERT INTO @temp(id_pk)
		SELECT  id
		FROM [CNT].[MOVConciliados]
		WHERE	(ISNULL(@filter, '') = '' OR id like '%' + @filter + '%')
				OR (ISNULL(@filter, '') = '' OR CONVERT(VARCHAR(11),fecha_revertido,120) like '%' + @filter + '%')
				OR (ISNULL(@filter, '') = '' OR CONVERT(VARCHAR(11),fecha,120) like '%' + @filter + '%')
		ORDER BY id ASC;

		SET @countpage = @@rowcount;
		
		SELECT  Tm.id_record, 
				C.id,
				CASE C.estado WHEN 6 THEN 'PROCESADO' WHEN 13 THEN 'REVERSION' ELSE 'REVERTIDO' END estado,
				CASE WHEN fecha is null THEN CONVERT(VARCHAR(11),fecha_revertido,120) ELSE CONVERT(VARCHAR(11),fecha,120) END fecha,
				CASE WHEN debito_t IS NULL THEN 0 ELSE debito_t END debito_t,
				CASE WHEN credito_t IS NULL THEN 0 ELSE credito_t END credito_t
		FROM @temp Tm
				INNER JOIN [CNT].[MOVConciliados] C ON C.id = Tm.id_pk
		WHERE id_record between @starpage AND @endpage
		ORDER BY Tm.id_record DESC;				
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
