--liquibase formatted sql
--changeset ,JPAREDES:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[NOM].[ST_JuzgadosList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [NOM].[ST_JuzgadosList]
GO
CREATE PROCEDURE [NOM].[ST_JuzgadosList]

@page BIGINT,
@numpage BIGINT,
@filter VARCHAR(50),
@countpage BIGINT OUTPUT,
@id_user BIGINT

AS

/***************************************
*Nombre:		[NOM].[ST_JuzgadosList]
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		30/03/2021
*Desarrollador:  JPAREDES
*Descripcion:	Lista todos los registros de Juzgados
***************************************/

DECLARE @starpage BIGINT, @endpage BIGINT;
DECLARE @temp TABLE(id_pk BIGINT)
BEGIN TRY

	SET @starpage = (@page * @numpage) - @numpage +1;
	SET @endpage = @numpage * @page;
	
	INSERT INTO @temp
		SELECT  J.id
		FROM [NOM].[Juzgados] J
		WHERE	(ISNULL(@filter,'')='' OR J.codigo like '%' + @filter + '%') OR
				(ISNULL(@filter,'')='' OR J.codigo_externo like '%' + @filter + '%')
		GROUP BY J.id;

	SELECT J.id,  J.codigo code, J.codigo_externo code_ext, ISNULL(J.estado, 0) estado FROM @temp T INNER JOIN [NOM].[Juzgados] J ON T.id_pk = J.id

	SET @countpage = @@ROWCOUNT

END TRY
BEGIN CATCH	
	DECLARE @Mensaje VARCHAR(MAX) = 'Error: '+ERROR_MESSAGE();
	RAISERROR(@Mensaje,16,0);	
END CATCH
