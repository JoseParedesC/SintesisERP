--liquibase formatted sql
--changeset ,JARCINIEGAS:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CRE].[ST_SolicitudesListar]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [CRE].[ST_SolicitudesListar]
GO
CREATE PROCEDURE [CRE].[ST_SolicitudesListar]
	
	@page INT = 1,
	@numpage INT = 10,
	@countpage INT = 0 OUTPUT,
	@filter VARCHAR(50) = NULL,
	@id_asesor BIGINT = 0,
	@id_estacion BIGINT = 0

AS

/***************************************
*Nombre:		[CRE].[SolicitudesListar]
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
		SELECT S_V.id_solicitud FROM [CRE].[VW_Solicitudes] S_V 
		WHERE	((isnull(@filter,'')='' or S_V.asesor like '%' + @filter + '%') OR	
				(isnull(@filter,'')='' or S_V.identificacion like '%' + @filter + '%') OR	
				(isnull(@filter,'')='' or S_V.cliente like '%' + @filter + '%') or
				(isnull(@filter,'')='' or S_V.consecutivo like '%' + @filter + '%') OR
				(isnull(@filter,'')='' or CONVERT(VARCHAR(10),S_V.fecha,120) like '%' + @filter + '%') OR
				(isnull(@filter,'')='' or (SELECT TOP 1 P.nombre FROM [dbo].[Productos] P INNER JOIN [dbo].[MOVCotizacionItems] CI ON CI.id_articulo = P.id WHERE CI.id_Cotizacion = S_V.id_cotizacion) like '%' + @filter + '%') OR 
				(isnull(@filter,'')='' or (SELECT P.primernombre+' '+P.segundonombre+' '+primerapellido+' '+P.segundoapellido FROM [CRE].[Personas] P WHERE P.id = S_v.id_persona AND P.tipo_tercero = 'CO') like '%' + @filter + '%') OR	
				(isnull(@filter,'')='' or S_V.estacion like '%' + @filter + '%') OR
				(isnull(@filter,'')='' or S_V.estado like '%' + @filter + '%')) 
				AND S_V.iden IN ('SOLICIT', 'CREATED','REPROCES' )
		GROUP BY S_V.id_solicitud;

		SET @countpage = @@rowcount;



			SELECT  id_pk,
					S_V.id_solicitud id, 
					S.consecutivo, 
					CONVERT(VARCHAR(10), S.fechasolicitud,120) fecha, 
					P.identificacion,
					P.primernombre+' '+P.primerapellido cliente,
					S_V.asesor, 
					S_V.estacion, 
					L.nombre estado, 
					(SELECT TOP 1 P.nombre 
						   FROM [dbo].[Productos] P INNER JOIN 
								[dbo].[MOVCotizacionItems] CI ON CI.id_articulo = P.id 
						   WHERE CI.id_Cotizacion = S_V.id_cotizacion)producto,
					P.id id_persona
			FROM [CRE].[VW_Solicitudes] S_V
				INNER JOIN [CRE].[Personas] P ON P.id = S_V.id_persona
				INNER JOIN [DBO].[Usuarios] A ON A.id = S_V.id_asesor
				INNER JOIN [CRE].[Solicitudes] S ON S.id = S_V.id_solicitud
				INNER JOIN [DBO].[ST_Listados] L ON L.id = S.estado
				INNER JOIN @temp tl ON tl.id_pk = S_V.id_solicitud 
				WHERE L.iden IN ('SOLICIT', 'CREATED','REPROCES' ) AND P.tipo_tercero = 'CL'
			
			

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
