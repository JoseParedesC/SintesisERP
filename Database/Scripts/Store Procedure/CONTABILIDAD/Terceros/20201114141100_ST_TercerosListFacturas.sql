--liquibase formatted sql
--changeset ,jteheran:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[ST_TercerosListFacturas]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [CNT].[ST_TercerosListFacturas]
GO
CREATE PROCEDURE [CNT].[ST_TercerosListFacturas]
	@page INT = 1,
	@numpage INT = 10,
	@countpage INT = 0 OUTPUT,
	@filter VARCHAR(50) = NULL,	
	@id_tercero BIGINT,
	@all INT
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[CNT].[ST_TercerosListFacturas]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		07/09/20
*Desarrollador: jparedes
***************************************/
DECLARE @error VARCHAR(MAX), @starpage INT = 1, @endpage INT = 1;
DECLARE @temp TABLE(id_record INT IDENTITY(1,1) ,id_pk INT );
DECLARE @terceros TABLE(id INT)
BEGIN TRY

	SET @numpage = ISNULL(@numpage,10);

	SET @starpage = (@page * @numpage) - @numpage +1;
	SET @endpage = @numpage * @page;

			INSERT INTO @temp(id_pk)
			SELECT  id	
			FROM dbo.VW_MOVFacturas 
			WHERE 
			((isnull(@filter,'')='' or CAST(id AS Varchar) like '%' + @filter + '%') OR	
			(isnull(@filter,'')='' or CAST(consecutivo AS Varchar) like '%' + @filter + '%') OR	
			(isnull(@filter,'')='' or cliente like '%' + @filter + '%') OR	
			(isnull(@filter,'')='' or prefijo like '%' + @filter + '%')) AND id_cliente=@id_tercero and totalcredito>0
			ORDER BY id DESC;

			SELECT TOP 1 sc.fechaactual, scc.nrofactura, scc.cuota, scc.cancelada
				FROM [CNT].[SaldoCliente_Cuotas] scc INNER JOIN 
					 [CNT].[SaldoCliente] sc ON sc.id_cliente = scc.id_cliente INNER JOIN
					 [CNT].[VW_Terceros] tt ON tt.id = @id_tercero
					 ORDER BY scc.cuota DESC
						
END TRY
BEGIN CATCH

	    --Getting the error description
	    Select @error   =  ERROR_PROCEDURE() + 
					';  ' + convert(varchar,ERROR_LINE()) + 
					'; ' + ERROR_MESSAGE()
	    -- save the error in a Log file
	    RaisError(@error,16,1)
	    Return  
END CATCH