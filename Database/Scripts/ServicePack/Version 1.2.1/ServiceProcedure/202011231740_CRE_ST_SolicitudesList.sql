--liquibase formatted sql
--changeset ,JPAREDES:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CRE].[ST_SolicitudesList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [CRE].[ST_SolicitudesList]
GO
CREATE PROCEDURE [CRE].[ST_SolicitudesList]
	
	@page INT = 1,
	@numpage INT = 10,
	@countpage INT = 0 OUTPUT,
	@filter VARCHAR(50) = NULL,
	@id_asesor BIGINT = 0,
	@id_estacion BIGINT = 0,
	@id_user BIGINT = 0,
	@op VARCHAR(7) = ''

AS

/***************************************
*Nombre:		[CRE].[SolicitudesList]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		2020/11/25
*Desarrollador: JPAREDES
*Descripcion:	Listar las solicitudes del 
				cliente, en estaod de análsis, 
				el la informacion del producto, 
				de las personas y el seguimiento
***************************************/

DECLARE @error VARCHAR(MAX), @starpage INT = 1, @endpage INT = 1;
DECLARE @temp TABLE(id_record INT IDENTITY(1,1) ,id_pk INT)

BEGIN TRY
	

		SET @starpage = (@page * @numpage) - @numpage +1;
		SET @endpage = @numpage * @page;

		DECLARE @iden BIGINT = (SELECT R.id FROM dbo.aspnet_Roles R INNER JOIN dbo.Usuarios U ON U.id_perfil = R.id WHERE U.id = @id_user)

		IF(@id_asesor = 0 AND @id_estacion = 0)
			BEGIN 
				INSERT INTO @temp(id_pk)
					SELECT  S_V.id_solicitud
					FROM [CRE].[VW_Solicitudes] S_V 
					WHERE	(isnull(@filter,'')='' or S_V.consecutivo like '%' + @filter + '%') OR
							(isnull(@filter,'')='' or CONVERT(VARCHAR(10),S_V.fecha,120) like '%' + @filter + '%') OR
							(isnull(@filter,'')='' or S_V.identificacion like '%' + @filter + '%') OR
							(isnull(@filter,'')='' or S_V.cliente like '%' + @filter + '%') OR 
							(isnull(@filter,'')='' or (SELECT P.primernombre+' '+P.segundonombre+' '+primerapellido+' '+P.segundoapellido FROM [CRE].[Personas] P WHERE P.id = S_v.id_persona AND P.tipo_tercero = 'CO') like '%' + @filter + '%')
					GROUP BY S_V.id_solicitud;


					SELECT	V_S.consecutivo ,
							V_S.identificacion,
							V_S.cliente,
							V_S.fecha,
							V_S.estacion,
							V_S.asesor,
							V_S.estado,
							V_S.id_solicitud, 
							V_S.id_persona,
							V_S.estado,
						   (SELECT TOP 1 P.nombre 
						   FROM [dbo].[Productos] P INNER JOIN 
								[dbo].[MOVCotizacionItems] CI ON CI.id_articulo = P.id 
						   WHERE CI.id_Cotizacion = V_S.id_cotizacion) producto
					FROM [CRE].[VW_Solicitudes] V_S
						INNER JOIN @temp ON V_S.id_solicitud = id_pk
					WHERE iden = @op AND tipo_tercero = 'CL'
				
			END 

		ELSE IF(@id_asesor != 0 AND @id_estacion = 0)
			BEGIN
				SELECT V_S.consecutivo ,
							V_S.identificacion,
							V_S.cliente,
							V_S.fecha,
							V_S.estacion,
							V_S.asesor,
							V_S.estado,
							V_S.id_solicitud, 
							V_S.id_persona,
							V_S.estado,
						   (SELECT TOP 1 P.nombre 
						   FROM [dbo].[Productos] P INNER JOIN 
								[dbo].[MOVCotizacionItems] CI ON CI.id_articulo = P.id 
						   WHERE CI.id_Cotizacion = V_S.id_cotizacion) producto
			   FROM [CRE].[VW_Solicitudes] V_S
				WHERE (V_S.id_asesor = @id_asesor AND (iden = @op AND tipo_tercero = 'CL'))

			END
		ELSE IF(@id_asesor = 0 AND @id_estacion != 0)
		BEGIN
			
			SELECT V_S.consecutivo ,
							V_S.identificacion,
							V_S.cliente,
							V_S.fecha,
							V_S.estacion,
							V_S.asesor,
							V_S.estado,
							V_S.id_solicitud, 
							V_S.id_persona,
							V_S.estado,
						   (SELECT TOP 1 P.nombre 
						   FROM [dbo].[Productos] P INNER JOIN 
								[dbo].[MOVCotizacionItems] CI ON CI.id_articulo = P.id 
						   WHERE CI.id_Cotizacion = V_S.id_cotizacion) producto
			   FROM [CRE].[VW_Solicitudes] V_S
				WHERE (V_S.id_estacion = @id_estacion AND (iden = @op AND tipo_tercero = 'CL'))
		END
		ELSE
		BEGIN

			SELECT V_S.consecutivo ,
							V_S.identificacion,
							V_S.cliente,
							V_S.fecha,
							V_S.estacion,
							V_S.asesor,
							V_S.estado,
							V_S.id_solicitud, 
							V_S.id_persona,
							V_S.estado,
						   (SELECT TOP 1 P.nombre 
						   FROM [dbo].[Productos] P INNER JOIN 
								[dbo].[MOVCotizacionItems] CI ON CI.id_articulo = P.id 
						   WHERE CI.id_Cotizacion = V_S.id_cotizacion) producto
			    FROM [CRE].[VW_Solicitudes] V_S
				WHERE (V_S.id_asesor = @id_asesor AND V_S.id_estacion = @id_estacion AND (iden = @op AND tipo_tercero = 'CL'))
		END
		
		
		SET @countpage = @@ROWCOUNT;

END TRY
BEGIN CATCH
	--Getting the error description
	SELECT @error   =  ERROR_PROCEDURE() + 
				';  ' + CONVERT(VARCHAR,ERROR_LINE()) + 
				'; ' + ERROR_MESSAGE()
	-- save the error in a Log file
	RAISERROR(@error,16,1)
	RETURN  
END CATCH