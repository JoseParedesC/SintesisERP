--liquibase formatted sql
--changeset ,JARCINIEGAS:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[NOM].[ST_EmpleadosList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [NOM].[ST_EmpleadosList]
GO
CREATE PROCEDURE [NOM].[ST_EmpleadosList]
	
	@page INT = 1,
	@numpage INT = 10,
	@countpage INT = 0 OUTPUT,
	@filter VARCHAR(50) = NULL,
	@id_centrocosto BIGINT = NULL

AS

/***************************************
*Nombre:		[NOM].[NominaList]
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
DECLARE @temp TABLE(id_record INT IDENTITY(1,1) ,id_pk INT );
DECLARE @contraVERI TABLE(id INT IDENTITY(1,1), idcontrato BIGINT)
DECLARE @contraTIPO TABLE(id INT IDENTITY(1,1), idcontrato BIGINT)

BEGIN TRY
	SET @numpage = ISNULL(@numpage,10);

		SET @starpage = (@page * @numpage) - @numpage +1;
		SET @endpage = @numpage * @page;

		 
		 
		 INSERT INTO @contraVERI (idcontrato)
		 SELECT IIF(fecha_inicio <= GETDATE(), id
		 , 0) FROM [NOM].[Contrato] WHERE estado =  dbo.ST_FnGetIdList('ESP')

		 --select estado from [NOM].[Contrato] where id IN (SELECT idcontrato FROM @contraVERI)

		 --select * from @contraVERI

		 UPDATE  [NOM].[Contrato]
			SET estado			= dbo.ST_FnGetIdList('VIG')
			WHERE id = (SELECT idcontrato FROM @contraVERI WHERE idcontrato != 0);;

		--select estado from [NOM].[Contrato] where id IN (SELECT idcontrato FROM @contraVERI)

		--REVISAR EL CONTRATO?, PARA RENOVARLO AUTOMATICAMENTE

		--RAISERROR('Hola :3',16,0)

		IF(ISNULL(@id_centrocosto, 0) = 0)
		BEGIN

			INSERT INTO @temp(id_pk)
			SELECT
			EM.id FROM [NOM].[VW_Empleados] EM 
			LEFT JOIN [NOM].[VW_Contratos] CON ON CON.id_empleado = EM.id
			WHERE	((ISNULL(@filter,'')='' OR EM.iden		 LIKE '%' + @filter + '%') OR
					 (ISNULL(@filter,'')='' OR EM.razonsocial LIKE '%' + @filter + '%') OR
					 (ISNULL(@filter,'')='' OR EM.primernombre LIKE '%' + @filter + '%') OR
					 (ISNULL(@filter,'')='' OR EM.segundonombre LIKE '%' + @filter + '%') OR
					 (ISNULL(@filter,'')='' OR EM.primerapellido LIKE '%' + @filter + '%') OR
					 (ISNULL(@filter,'')='' OR EM.segundoapellido LIKE '%' + @filter + '%') OR
					 (ISNULL(@filter,'')='' OR CON.nombre_cargo	   LIKE '%' + @filter + '%'))  

			SET @countpage = @@rowcount;



				SELECT DISTINCT
						CON.id_empleado id,
						tl.id_pk,
						EM.iden +' - '+  (EM.razonsocial) nombre,
						(SELECT TOP 1 nombre_cargo FROM [NOM].[VW_Contratos] WHERE id_empleado = CON.id_empleado) cargo
				FROM [NOM].[VW_Empleados] EM
					INNER JOIN @temp tl ON tl.id_pk = EM.id
					LEFT JOIN [NOM].[VW_Contratos] CON ON CON.id_empleado = EM.id
				
		END
		ELSE
		BEGIN
		
			INSERT INTO @temp(id_pk)
			SELECT EM.id FROM [NOM].[VW_Empleados] EM 
					LEFT JOIN [NOM].[VW_Contratos] CON ON CON.id_empleado = EM.id
			WHERE	((ISNULL(@filter,'')='' OR EM.iden		 LIKE '%' + @filter + '%') OR
					 (ISNULL(@filter,'')='' OR EM.razonsocial LIKE '%' + @filter + '%') OR
					 (ISNULL(@filter,'')='' OR EM.primernombre LIKE '%' + @filter + '%') OR
					 (ISNULL(@filter,'')='' OR EM.segundonombre	LIKE '%' + @filter + '%') OR
					 (ISNULL(@filter,'')='' OR EM.primerapellido LIKE '%' + @filter + '%') OR
					 (ISNULL(@filter,'')='' OR EM.segundoapellido LIKE '%' + @filter + '%') OR
					 (ISNULL(@filter,'')='' OR CON.nombre_cargo    LIKE '%' + @filter + '%')) 
					 AND CON.centrocosto = @id_centrocosto

			SET @countpage = @@rowcount;



				SELECT  CON.id_empleado id,
						EM.iden +' - '+  (EM.razonsocial) nombre,
						(SELECT TOP 1 nombre_cargo FROM [NOM].[VW_Contratos] WHERE id_empleado = CON.id_empleado) cargo			  
				FROM [NOM].[VW_Empleados] EM					  
					INNER JOIN @temp tl ON tl.id_pk = EM.id	
					 LEFT JOIN [NOM].[VW_Contratos] CON ON CON.id_empleado = EM.id
					WHERE CON.centrocosto = @id_centrocosto
		
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
