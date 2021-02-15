--liquibase formatted sql
--changeset ,jteheran:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[TercerosListTipo]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [CNT].[TercerosListTipo]
GO
CREATE PROCEDURE [CNT].[TercerosListTipo]
	@page INT = 1,
	@numpage INT = 10,
	@countpage INT = 0 OUTPUT,
	@filter VARCHAR(50) = NULL,
	@tipo varchar(2)
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[dbo].[TercerosListTipo]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		04/11/19
*Desarrollador: (jeteme)
***************************************/
DECLARE @error VARCHAR(MAX), @starpage INT = 1, @endpage INT = 1;
DECLARE @temp TABLE(id_record INT IDENTITY(1,1) ,id_pk INT,iden varchar(50),tercero varchar(200),tercerocompleto varchar(300),tipo varchar(50) )
BEGIN TRY
		SET @numpage = ISNULL(@numpage,10);

		SET @starpage = (@page * @numpage) - @numpage +1;
		SET @endpage = @numpage * @page;

		IF(@tipo='TC')
		BEGIN
			INSERT INTO @temp(id_pk,iden,tercero,tercerocompleto,tipo)
			SELECT distinct A.id_tercero id ,A.iden,A.tercero, A.iden + ' - ' + A.tercero tercompleto, tipo
			FROM [CNT].[VW_TercerosTipo] A WHERE A.codigo = 'TC' 
			AND 	 ((isnull(@filter,'')='' or tercero like '%' + @filter + '%') OR	
				   (isnull(@filter,'')='' or A.iden like '%' + @filter + '%') ) 
			ORDER BY A.tercero ASC;
		END
		ELSE
		BEGIN
			INSERT INTO @temp(id_pk,iden,tercero,tercerocompleto,tipo)
			SELECT distinct A.id_tercero id ,A.iden,A.tercero, A.iden + ' - ' + A.tercero tercompleto, tipo
			FROM [CNT].[VW_TercerosTipo] A  
			WHERE A.codigo = @tipo AND
				 ((isnull(@filter,'')='' or tercero like '%' + @filter + '%') OR	
				   (isnull(@filter,'')='' or A.iden like '%' + @filter + '%') ) 
			ORDER BY A.tercero ASC;
		END
		SET @countpage = @@rowcount;		
		
		SELECT  tm.id_pk id ,tm.iden,tm.tercero, tm.iden + ' - ' + tm.tercero tercompleto, tm.tipo
		FROM @temp Tm WHERE id_record between @starpage AND @endpage 
				
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