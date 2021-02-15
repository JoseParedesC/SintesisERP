--liquibase formatted sql
--changeset ,JARCINIEGAS:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CRE].[ST_Historial_Solicitud_Producto]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [CRE].[ST_Historial_Solicitud_Producto]
GO
CREATE PROCEDURE [CRE].[ST_Historial_Solicitud_Producto]
	
	@id_cotizacion INT,
	@page INT = 1,
	@numpage INT = 10,
	@countpage INT = 0 OUTPUT,
	@filter VARCHAR(50) = NULL

AS

/*********************************************
*Nombre:		[CRE].[ST_Historial_Solicitud_Producto]
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
		SELECT CI.id FROM [dbo].[MOVCotizacionItems] CI 
		INNER JOIN [dbo].[MOVCotizacion] C ON C.id= CI.id_Cotizacion
		INNER JOIN [dbo].[Productos] P ON P.id = CI.id_articulo
		WHERE	((isnull(@filter,'')='' or P.nombre like '%' + @filter + '%') OR	
				(isnull(@filter,'')='' or P.codigo like '%' + @filter + '%') OR	
				(isnull(@filter,'')='' or CI.cantidad like '%' + @filter + '%'))
				ORDER BY CI.id ASC;

		SET @countpage = @@rowcount;



			SELECT  --tl.id_pk,
					CI.id id_producto, 
					P.nombre, 
					CI.cantidad, 
					CONVERT(VARCHAR, CONVERT(VARCHAR, CAST(CI.precio  AS MONEY), 1)) precio,
					CI.iva,
					CONVERT(VARCHAR, CONVERT(VARCHAR, CAST(CI.descuento  AS MONEY), 1)) descuento, 
					CONVERT(VARCHAR, CONVERT(VARCHAR, CAST(CI.total  AS MONEY), 1)) total, 
					C.id_bodega,
					P.codigo 
				FROM [dbo].[MOVCotizacionItems] CI
				INNER JOIN [dbo].[Productos] P ON P.id = CI.id_articulo
				INNER JOIN [dbo].[MOVCotizacion] C ON C.id = CI.id_Cotizacion
				INNER JOIN @temp tl ON tl.id_pk = CI.id 
				where C.id = @id_cotizacion
			
			

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
