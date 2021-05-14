--liquibase formatted sql
--changeset ,JPAREDES:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[NOM].[ST_SubtiposCotizanteList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [NOM].[ST_SubtiposCotizanteList]
GO
CREATE PROCEDURE [NOM].[ST_SubtiposCotizanteList]

@page BIGINT,
@numpage BIGINT,
@filter VARCHAR(50),
@countpage BIGINT OUTPUT,
@id_user BIGINT

AS

/***************************************
*Nombre:		[NOM].[ST_SubtiposCotizanteList]
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		30/03/2021
*Desarrollador:  JPAREDES
*Descripcion:	Lista todos los registros de Tipos de cotizante
***************************************/

DECLARE @starpage BIGINT, @endpage BIGINT;
DECLARE @temp TABLE(id_pk BIGINT)
BEGIN TRY

	SET @starpage = (@page * @numpage) - @numpage +1;
	SET @endpage = @numpage * @page;
	
	INSERT INTO @temp
		SELECT  T.id
		FROM [NOM].[SubtiposCotizante] T
		WHERE	(ISNULL(@filter,'')='' OR T.codigo like '%' + @filter + '%') OR
				(ISNULL(@filter,'')='' OR T.codigo_externo like '%' + @filter + '%')
		GROUP BY T.id;

	SELECT C.id,  C.codigo code, C.codigo_externo code_ext, ISNULL(C.estado, 0) estado FROM @temp T INNER JOIN [NOM].[SubtiposCotizante] C ON T.id_pk = C.id

	SET @countpage = @@ROWCOUNT

END TRY
BEGIN CATCH	
	DECLARE @Mensaje VARCHAR(MAX) = 'Error: '+ERROR_MESSAGE();
	RAISERROR(@Mensaje,16,0);	
END CATCH
