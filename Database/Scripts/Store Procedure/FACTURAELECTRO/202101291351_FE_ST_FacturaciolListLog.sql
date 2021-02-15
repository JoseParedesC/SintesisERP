--liquibase formatted sql
--changeset ,JTOUS:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[FE].[ST_FacturaciolListLog]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	DROP PROCEDURE [FE].[ST_FacturaciolListLog]
GO
CREATE  PROCEDURE [FE].[ST_FacturaciolListLog] 
	@page INT = 1,
	@numpage INT = 10,
	@countpage INT = 0 OUTPUT,
	@filter VARCHAR(50) = NULL,
	@id_user int,
	@id VARCHAR(255),
	@tipo int 
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[Dbo].[ST_CajasLogContabilizar]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		28/03/17
*Desarrollador: (JTOUS)
***************************************/
DECLARE @error VARCHAR(MAX), @starpage INT = 1, @endpage INT = 1, @idusuario int;
DECLARE @temp TABLE(id_record INT IDENTITY(1,1) ,id_pk INT )
BEGIN TRY
		SET @numpage = 50;
		
		SET @numpage = ISNULL(@numpage,10);

		SET @starpage = (@page * @numpage) - @numpage +1;
		SET @endpage = @numpage * @page;

		INSERT INTO @temp(id_pk)
		SELECT  id
		FROM FE.DocumentosSeguimiento
		WHERE [key] = @id AND tipodocumento = @tipo 
		ORDER BY id DESC;

		SET @countpage = @@rowcount;							

		SELECT Tm.id_record, respuesta mensaje, CONVERT(varchar(16), fechaseguimiento, 120) fecha, coderespuesta codigo
		FROM @temp Tm
				Inner join FE.DocumentosSeguimiento A on Tm.id_pk = A.id
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
