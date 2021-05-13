--liquibase formatted sql
--changeset ,JPAREDES:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[NOM].[ST_DiagnosticoList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [NOM].[ST_DiagnosticoList]
GO
CREATE PROCEDURE [NOM].[ST_DiagnosticoList]

@page BIGINT,
@numpage BIGINT,
@filter VARCHAR(50),
@countpage BIGINT OUTPUT,
@id_user BIGINT

AS

/***************************************
*Nombre:		[NOM].[ST_DiagnosticoList]
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		30/03/2021
*Desarrollador:  JPAREDES
*Descripcion:	Lista todos los Diagnosticos registrados
***************************************/

DECLARE @starpage BIGINT, @endpage BIGINT;
DECLARE @temp TABLE(id_pk BIGINT)
BEGIN TRY

	SET @starpage = (@page * @numpage) - @numpage +1;
	SET @endpage = @numpage * @page;
	
	INSERT INTO @temp
		SELECT  D.id
		FROM [NOM].[Diagnostico] D
		WHERE	(ISNULL(@filter,'')='' OR D.codigo like '%' + @filter + '%') OR
				(ISNULL(@filter,'')='' OR D.descripcion like '%' + @filter + '%')
		GROUP BY D.id;

	SELECT D.id,  D.codigo code, D.descripcion, ISNULL(D.estado, 0) estado FROM @temp T INNER JOIN [NOM].[Diagnostico] D ON T.id_pk = D.id

	SET @countpage = @@ROWCOUNT

END TRY
BEGIN CATCH	
	DECLARE @Mensaje VARCHAR(MAX) = 'Error: '+ERROR_MESSAGE();
	RAISERROR(@Mensaje,16,0);	
END CATCH
