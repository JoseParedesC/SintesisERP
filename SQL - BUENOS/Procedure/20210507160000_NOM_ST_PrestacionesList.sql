--liquibase formatted sql
--changeset ,JPAREDES:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[NOM].[ST_PrestacionesList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [NOM].[ST_PrestacionesList]
GO
CREATE PROCEDURE [NOM].[ST_PrestacionesList]

@op VARCHAR(10),
@page BIGINT,
@numpage BIGINT,
@filter VARCHAR(50),
@countpage BIGINT OUTPUT,
@id_user BIGINT

AS

/***************************************
*Nombre:		[NOM].[ST_PrestacionesList]
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		30/03/2021
*Desarrollador:  JPAREDES
*Descripcion:	Lista la seguridad social
***************************************/

DECLARE @starpage BIGINT, @endpage BIGINT;
DECLARE @temp TABLE(id_pk BIGINT);
DECLARE @error VARCHAR(MAX);
BEGIN TRY


	SET @starpage = (@page * @numpage) - @numpage +1;
	SET @endpage = @numpage * @page;
	
	IF(ISNULL(@op,'') = '')
		RAISERROR('No se encontró el tipo de Prestacin Social', 16, 0)


	INSERT INTO @temp
	SELECT  P.id
	FROM [NOM].[Prestaciones] P INNER JOIN [DBO].[CNTCuentas] C ON C.id = P.contrapartida
	WHERE	(ISNULL(@filter,'')='' OR P.nombre like '%' + @filter + '%') OR
			(ISNULL(@filter,'')='' OR P.codigo like '%' + @filter + '%') OR
			(ISNULL(@filter,'')='' OR C.nombre like '%' + @filter + '%') OR
			(ISNULL(@filter,'')='' OR C.subcodigo like '%' + @filter + '%')
	GROUP BY P.id;

	
	SELECT P.id, P.codigo, P.nombre  FROM [NOM].[Prestaciones] P INNER JOIN @temp t ON t.id_pk = P.id AND tipo_prestacion = [dbo].[ST_FnGetIdList](@op)

	SET @countpage = @@ROWCOUNT
	

END TRY
BEGIN CATCH	
	SET @error = 'Error: '+ ERROR_MESSAGE();
	RAISERROR(@error,16,0);	
END CATCH
