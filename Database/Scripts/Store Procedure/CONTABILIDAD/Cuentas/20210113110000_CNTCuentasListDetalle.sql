--liquibase formatted sql
--changeset ,jteheran:3 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[Dbo].[CNTCuentasListDetalle]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [Dbo].[CNTCuentasListDetalle]
GO



CREATE PROCEDURE [dbo].[CNTCuentasListDetalle]
	@page INT = 1,
	@numpage INT = 10,
	@countpage INT = 0 OUTPUT,
	@filter VARCHAR(50) = NULL,
	@tipo VARCHAR(6) = NULL
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[dbo].[ST_CNTCuentasListDetalle]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		15/11/19
*Desarrollador: (JETEHERAN)
***************************************/
DECLARE @error VARCHAR(MAX), @starpage INT = 1, @endpage INT = 1;
DECLARE @temp TABLE(id_record INT IDENTITY(1,1) ,id_pk INT )
BEGIN TRY
		SET @numpage = ISNULL(@numpage,10);

		SET @starpage = (@page * @numpage) - @numpage +1;
		SET @endpage = @numpage * @page;

		INSERT INTO @temp(id_pk)
		SELECT  id	
		FROM dbo.VW_CNTCuentas
		WHERE tipo != 0 and estado != 0 AND (Isnull(@tipo,'') = '' OR id_tipocta = DBO.ST_FnGetIdList(@tipo))  AND
			((isnull(@filter,'')='' or codigo like  + @filter + '%') OR	
			 (isnull(@filter,'')='' or nombre like '%' + @filter + '%') OR
			 (isnull(@filter,'')='' or id_padre like '%' + @filter + '%'))
		ORDER BY CODIGO ASC;

		SET @countpage = @@rowcount;		
		
		SELECT Tm.id_record, A.id, A.codigo, A.nombre, A.codigo +' - '+A.nombre cuentacompleta
		FROM @temp Tm
				Inner join dbo.VW_CNTCuentas A on Tm.id_pk = A.id
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
