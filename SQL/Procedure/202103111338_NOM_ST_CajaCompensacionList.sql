--liquibase formatted sql
--changeset ,JARCINIEGAS:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[NOM].[ST_CajaCompensacionList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [NOM].[ST_CajaCompensacionList]
GO
CREATE PROCEDURE [NOM].[ST_CajaCompensacionList]
	
	@page INT = 1,
	@numpage INT = 10,
	@countpage INT = 0 OUTPUT,
	@filter VARCHAR(50) = NULL

AS

/***************************************
*Nombre:		[NOM].[ST_CajaCompensacionList]
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
		SELECT CC.id FROM [NOM].[Cajas_de_Compensacion] CC 
		WHERE	((isnull(@filter,'')='' or CC.nombre		like '%' + @filter + '%') OR
			     (isnull(@filter,'')='' or CC.cod_ext	like '%' + @filter + '%')) 

		SET @countpage = @@rowcount;



			SELECT  id_pk id,
					CC.nombre nombre,
					CC.cod_ext
			FROM [NOM].[Cajas_de_Compensacion] CC 
				INNER JOIN @temp tl ON tl.id_pk = CC.id
			
			

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