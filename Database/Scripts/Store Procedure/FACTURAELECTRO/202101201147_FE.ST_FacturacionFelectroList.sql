--liquibase formatted sql
--changeset ,jtous:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[FE].[ST_FacturacionFelectroList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	DROP PROCEDURE [FE].[ST_FacturacionFelectroList]
GO
CREATE PROCEDURE [FE].[ST_FacturacionFelectroList]
	@page INT = 1,
	@numpage INT = 10,
	@countpage INT = 0 OUTPUT,
	@filter VARCHAR(50) = NULL,
	@factura VARCHAR(30),
	@estado VARCHAR(20),
	@fecha VARCHAR(10),
	@fechafin VARCHAR(10)
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[Dbo].[ST_FacturacionListSuccess]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		28/03/17
*Desarrollador: (JTOUS)
***************************************/
DECLARE @error VARCHAR(MAX), @starpage INT = 1, @endpage INT = 1;
DECLARE @temp TABLE(id_record INT IDENTITY(1,1), id_pk INT, tipodocumento INT )
BEGIN TRY
		SET @numpage = ISNULL(@numpage,10);

		SET @starpage = (@page * @numpage) - @numpage +1;
		SET @endpage = @numpage * @page;

		INSERT INTO @temp(id_pk, tipodocumento)
		SELECT consecutivo, tipodocumento
		FROM [FE].[VW_DocumentosFacturados]
		WHERE  estadoFE = [dbo].[ST_FnGetIdList] (@estado) AND fecha BETWEEN @fecha AND @fechafin AND (isnull(@factura,'')='' or factura like '%' + @factura + '%')		
		ORDER BY factura ASC, tipodocumento ASC;

		SET @countpage = @@rowcount;		
		
		if (@numpage = -1)
			SET @endpage = @countpage;

		SELECT A.consecutivo, A.fecha, A.resolucion, A.cliente, A.tipodocumento, factura,
		CASE WHEN A.tipodocumento = 1 THEN 'Factura Electronica' 
			 WHEN A.tipodocumento = 3 THEN 'Nota Credito' ELSE 'Documento Desconocido' END tipodoc, 
		CASE WHEN A.tipodocumento = 1 THEN 'F' 
			 WHEN A.tipodocumento = 3 THEN 'D' ELSE '' END op,
		A.keyid,
		A.cufe,
		A.tipodocumento
		FROM @temp Tm
				Inner join [FE].[VW_DocumentosFacturados] A on Tm.id_pk = A.consecutivo AND Tm.tipodocumento = A.tipodocumento
		WHERE id_record between @starpage AND @endpage;
				
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
