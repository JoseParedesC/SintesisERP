--liquibase formatted sql
--changeset ,jtous:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[Dbo].[ST_ConceptosList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [Dbo].[ST_ConceptosList]
GO
CREATE PROCEDURE [dbo].[ST_ConceptosList]
	@page INT = 1,
	@numpage INT = 10,
	@countpage INT = 0 OUTPUT,
	@filter VARCHAR(50) = NULL,
	@esDesc INT = NULL,
	@tipodocu VARCHAR(10)=NULL
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[dbo].[ST_ConceptosList]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		16/11/19
*Desarrollador: (JTOUS)
***************************************/
DECLARE @error VARCHAR(MAX), @starpage INT = 1, @endpage INT = 1;
DECLARE @temp TABLE(id_record INT IDENTITY(1,1) ,id_pk INT )
BEGIN TRY
		SET @numpage = ISNULL(@numpage,10);

		SET @starpage = (@page * @numpage) - @numpage +1;
		SET @endpage = @numpage * @page;
		DECLARE @texto VARCHAR(200) = CASE WHEN ISNULL(@tipodocu, '') = 'CONTABLES' THEN 'SERVICIOS,CONSUMO' ELSE 'SERVICIOS' END

		INSERT INTO @temp(id_pk)
		SELECT  id
		FROM dbo.VW_Productos
		WHERE tipoproducto IN (SELECT Dbo.ST_FnGetIdList(item) FROM [dbo].[ST_FnTextToTable](@texto,',')) AND inventario = 0 AND esdescuento = ISNULL(@esDesc,0) AND
		(	(isnull(@filter,'')='' or codigo like '%' + @filter + '%')	OR			
			(isnull(@filter,'')='' or presentacion like '%' + @filter + '%') OR			
			(isnull(@filter,'')='' or nombre like '%' + @filter + '%')	OR			
			(isnull(@filter,'')='' or tipo like '%' + @filter + '%') )
		ORDER BY id ASC;

		SET @countpage = @@rowcount;
		
		
		SELECT Tm.id_record, id, A.codigo, A.presentacion, A.nombre, A.tipo,A.stock, A.estado, A.Cuentacontable
		FROM @temp Tm
				Inner join dbo.VW_Productos A on Tm.id_pk = A.id
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
