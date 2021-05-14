--liquibase formatted sql
--changeset ,JPAREDES:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[NOM].[ST_SedesList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [NOM].[ST_SedesList]
GO
CREATE PROCEDURE [NOM].[ST_SedesList]

@page BIGINT,
@numpage BIGINT,
@filter VARCHAR(50),
@countpage BIGINT OUTPUT,
@id_user BIGINT

AS

/***************************************
*Nombre:		[NOM].[ST_SedesList]
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		30/03/2021
*Desarrollador:  JPAREDES
*Descripcion:	Lista todos los registros de Sedes
***************************************/

DECLARE @starpage BIGINT, @endpage BIGINT;
DECLARE @temp TABLE(id_pk BIGINT)
BEGIN TRY

	SET @starpage = (@page * @numpage) - @numpage +1;
	SET @endpage = @numpage * @page;
	
	INSERT INTO @temp
		SELECT  S.id
		FROM [NOM].[VW_Sedes] S
		WHERE	(ISNULL(@filter,'')='' OR S.sede like '%' + @filter + '%') OR
				(ISNULL(@filter,'')='' OR S.ciudad like '%' + @filter + '%') OR
				(ISNULL(@filter,'')='' OR S.nombredep like '%' + @filter + '%')
		GROUP BY S.id;

	SELECT S.id, S.sede, S.nombredep ciudad, S.estado FROM [NOM].[VW_Sedes] S INNER JOIN @temp t ON t.id_pk = S.id

	SET @countpage = @@ROWCOUNT

END TRY
BEGIN CATCH	
	DECLARE @Mensaje VARCHAR(MAX) = 'Error: '+ERROR_MESSAGE();
	RAISERROR(@Mensaje,16,0);	
END CATCH
