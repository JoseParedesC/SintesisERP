--liquibase formatted sql
--changeset ,JARCINIEGAS:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CRE].[ST_Historial_Solicitud]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [CRE].[ST_Historial_Solicitud]
GO
CREATE PROCEDURE [CRE].[ST_Historial_Solicitud]
	
	@page INT = 1,
	@numpage INT = 10,
	@countpage INT = 0 OUTPUT,
	@filter VARCHAR(50) = NULL

AS

/*********************************************
*Nombre:		[CRE].[ST_Historial_Solicitud]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		2021/01/18
*Desarrollador: JARCINIEGAS	
*Descripcion:	Listar las todas las solicitu-
				des, independientemente de el 
				estado de la misma 
**********************************************/

DECLARE @error VARCHAR(MAX), @starpage INT = 1, @endpage INT = 1;
DECLARE @temp TABLE(id_record INT IDENTITY(1,1) ,id_pk INT )

BEGIN TRY
	SET @numpage = ISNULL(@numpage,10);

		SET @starpage = (@page * @numpage) - @numpage +1;
		SET @endpage = @numpage * @page;

		INSERT INTO @temp(id_pk)
		SELECT S_V.id_solicitud FROM [CRE].[VW_Solicitudes] S_V 
		INNER JOIN CRE.Personas P ON P.id= S_V.id_persona
		INNER JOIN [DBO].[ST_Listados] L ON L.nombre = S_V.estado
		WHERE	((isnull(@filter,'')='' or S_V.asesor like '%' + @filter + '%') OR	
				(isnull(@filter,'')='' or P.identificacion like '%' + @filter + '%') OR	
				(isnull(@filter,'')='' or CAST(S_V.fecha AS VARCHAR(10)) like '%' + @filter + '%') OR	
				(isnull(@filter,'')='' or S_V.consecutivo like '%' + @filter + '%') OR	
				(isnull(@filter,'')='' or S_V.estado like '%' + @filter + '%') OR	
				(isnull(@filter,'')='' or S_V.cliente like '%' + @filter + '%'))
				AND P.tipo_tercero = 'CL'
		ORDER BY S_V.id_solicitud ASC;

		SET @countpage = @@rowcount;



			SELECT  id_pk,
					S_V.id_solicitud id, 
					S_V.consecutivo, 
					CONVERT(VARCHAR(10), S_V.fecha,120) fecha, 
					P.identificacion,
					P.primernombre+' '+P.primerapellido cliente,
					S_V.asesor, 
					S_V.estacion, 
					L.nombre estado, 
					P.id id_persona
				FROM [CRE].[VW_Solicitudes] S_V
				INNER JOIN [CRE].[Personas] P ON P.id = S_V.id_persona
				INNER JOIN [DBO].[Usuarios] A ON A.id = S_V.id_asesor
				INNER JOIN [dbo].[MOVCotizacion] C ON C.id = S_V.id_cotizacion
				INNER JOIN [DBO].[ST_Listados] L ON L.iden = S_V.iden
				INNER JOIN @temp tl ON tl.id_pk = S_V.id_solicitud 
				WHERE P.tipo_tercero = 'CL'
				ORDER BY S_V.consecutivo ASC
			
			

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
