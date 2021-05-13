--liquibase formatted sql
--changeset ,JARCINIEGAS:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[NOM].[ST_VacacionesList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [NOM].[ST_VacacionesList]
GO
CREATE PROCEDURE [NOM].[ST_VacacionesList]
	
	@page INT = 1,
	@numpage INT = 10,
	@countpage INT = 0 OUTPUT,
	@filter VARCHAR(50) = NULL

AS

/***************************************
*Nombre:		[NOM].[ST_VacacionesList]
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

		INSERT INTO @temp(id_pk)
		SELECT V.id FROM [NOM].[Vacaciones] V 
		WHERE	((isnull(@filter,'')='' or V.nombre		like '%' + @filter + '%')) 

		SET @countpage = @@rowcount;



			SELECT  id_pk id,
					V.nombre nombre
			FROM [NOM].[Vacaciones] V 
				INNER JOIN @temp tl ON tl.id_pk = V.id
			
			

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