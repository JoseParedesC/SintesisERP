--liquibase formatted sql
--changeset ,apuello:3 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id =
OBJECT_ID(N'[dbo].[ST_PerfilesList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_PerfilesList]
GO
CREATE PROCEDURE [dbo].[ST_PerfilesList]

/***************************************
*Nombre: [dbo].[ST_PerfilesList]
----------------------------------------
*Tipo: Procedimiento almacenado
*creación: 28/11/210
*Desarrollador: APUELLO
*Descripcion: Lista los perfiles que existente escluyendo
			  a los que ya están prestablecidos en el sistema
***************************************/

	@page INT = 1,
	@numpage INT = 10,
	@filter VARCHAR(50) = NULL,
	@countpage INT = 0 OUTPUT
AS
DECLARE @error VARCHAR(MAX), @starpage INT = 1, @endpage INT = 1;
DECLARE @temp TABLE(id_record INT IDENTITY (1,1), id_pk INT)
BEGIN TRY

	SET @numpage = ISNULL(@numpage, 10);

	SET @starpage = (@page * @numpage) - @numpage  + 1;
	SET @endpage = @numpage * @page;
	INSERT INTO @temp(id_pk)
	SELECT id
	FROM dbo.aspnet_Roles 
	WHERE id > 2 AND 
	(ISNULL(@filter,'')= '' or RoleName like '%' + @filter + '%')

	ORDER BY id ASC;

	SET @countpage = @@ROWCOUNT;

	SELECT Tm.id_record, R.id, R.RoleName nombre, A.ApplicationName app, R.estado
	FROM @temp Tm
			Inner join dbo.aspnet_Roles R ON Tm.id_pk = R.id
			Inner join dbo.aspnet_Applications A ON A.ApplicationId = R.ApplicationId
	WHERE	id_record between @starpage AND @endpage;
END TRY


 BEGIN CATCH
	select @error = ERROR_PROCEDURE() +
		'; ' + CONVERT(VARCHAR, ERROR_LINE()) +
		'; ' + ERROR_MESSAGE()

	RaisError(@error,16,1)
	Return
End Catch

