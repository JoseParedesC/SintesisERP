--liquibase formatted sql
--changeset ,JARCINIEGAS:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[NOM].[ST_SegsocialList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [NOM].[ST_SegsocialList]
GO
CREATE PROCEDURE [NOM].[ST_SegsocialList]
	
	@id_tiposeg BIGINT ,
	@page INT = 1,
	@numpage INT = 10,
	@countpage INT = 0 OUTPUT,
	@filter VARCHAR(50) = NULL

AS

/***************************************
*Nombre:		[NOM].[ST_SegsocialList]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		2020/11/25
*Desarrollador: JARCINIEGAS	
*Descripcion:	Listar las solicitudes del 
				cliente, en estaodo de 
				solocitado, creado y re-
				procesado y la información 
				de las personas 
***************************************/

DECLARE @error VARCHAR(MAX), @starpage INT = 1, @endpage INT = 1;
DECLARE @temp TABLE(id_record INT IDENTITY(1,1) ,id_pk INT )

BEGIN TRY
	SET @numpage = ISNULL(@numpage,10);

		SET @starpage = (@page * @numpage) - @numpage +1;
		SET @endpage = @numpage * @page;

		IF(@id_tiposeg = 0 OR @id_tiposeg = (SELECT id FROM ST_Listados WHERE iden = 'SEPS'))
		BEGIN

			INSERT INTO @temp(id_pk)
			SELECT EPS.id FROM [NOM].[Entidades_de_Salud] EPS 
			WHERE	((isnull(@filter,'')='' or EPS.nombre		like '%' + @filter + '%') OR
					 (isnull(@filter,'')='' or EPS.cod_ext	like '%' + @filter + '%')) 
					 AND id_tiposeg = @id_tiposeg

			SET @countpage = @@rowcount;



				SELECT  id_pk id,
						ES.nombre nombre,
						ES.cod_ext
				FROM [NOM].[Entidades_de_Salud] ES 
					INNER JOIN @temp tl ON tl.id_pk = ES.id
				WHERE id_tiposeg = @id_tiposeg
		END
		ELSE IF(@id_tiposeg = (SELECT id FROM ST_Listados WHERE iden = 'SPEN'))
		BEGIN

		INSERT INTO @temp(id_pk)
		SELECT P.id FROM [NOM].[Entidades_de_Salud] P 
		WHERE	((isnull(@filter,'')='' or P.nombre		like '%' + @filter + '%') OR
			     (isnull(@filter,'')='' or P.cod_ext	like '%' + @filter + '%')) 
				 AND id_tiposeg = @id_tiposeg

		SET @countpage = @@rowcount;



			SELECT  id_pk id,
					P.nombre nombre,
					P.cod_ext
			FROM [NOM].[Entidades_de_Salud] P 
				INNER JOIN @temp tl ON tl.id_pk = P.id
			WHERE id_tiposeg = @id_tiposeg

		END
		ELSE IF(@id_tiposeg = (SELECT id FROM ST_Listados WHERE iden = 'SCAJA'))
		BEGIN

		INSERT INTO @temp(id_pk)
		SELECT CC.id FROM [NOM].[Entidades_de_Salud] CC 
		WHERE	((isnull(@filter,'')='' or CC.nombre		like '%' + @filter + '%') OR
			     (isnull(@filter,'')='' or CC.cod_ext	like '%' + @filter + '%')) 
				 AND id_tiposeg = @id_tiposeg

		SET @countpage = @@rowcount;



			SELECT  id_pk id,
					CC.nombre nombre,
					CC.cod_ext
			FROM [NOM].[Entidades_de_Salud] CC 
				INNER JOIN @temp tl ON tl.id_pk = CC.id
			WHERE id_tiposeg = @id_tiposeg

		END
		ELSE IF(@id_tiposeg = (SELECT id FROM ST_Listados WHERE iden = 'SARL'))
		BEGIN

		INSERT INTO @temp(id_pk)
		SELECT ARL.id FROM [NOM].[Entidades_de_Salud] ARL 
		WHERE	((isnull(@filter,'')='' or ARL.nombre		like '%' + @filter + '%') OR
			     (isnull(@filter,'')='' or ARL.cod_ext	like '%' + @filter + '%')) 
				 AND id_tiposeg = @id_tiposeg

		SET @countpage = @@rowcount;



			SELECT  id_pk id,
					ARL.nombre nombre,
					ARL.cod_ext
			FROM [NOM].[Entidades_de_Salud] ARL 
				INNER JOIN @temp tl ON tl.id_pk = ARL.id
			WHERE id_tiposeg = @id_tiposeg

		END
			

END TRY
BEGIN CATCH
	--Getting the error description
	SELECT @error   =  ERROR_PROCEDURE() + 
				';  ' + convert(varchar,ERROR_LINE()) + 
				'; ' + ERROR_MESSAGE()
	-- save the error in a Log file
	RAISERROR(@error,16,1)
	RETURN  
END CATCH