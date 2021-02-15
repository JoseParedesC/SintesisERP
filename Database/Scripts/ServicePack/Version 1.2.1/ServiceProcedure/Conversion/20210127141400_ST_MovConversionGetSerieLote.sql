--liquibase formatted sql
--changeset ,CZULBARAN:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_MovConversionGetSerieLote]') and OBJECTPROPERTY(id, N'IsProcedure') = 1) 
DROP PROCEDURE dbo.ST_MovConversionGetSerieLote
GO
CREATE PROCEDURE [dbo].[ST_MovConversionGetSerieLote]
	@page INT = 1,
	@numpage INT = 10,
	@countpage INT = 0 OUTPUT,
	@filter VARCHAR(50) = NULL,
	@id_user		[INT],
	@id_articulo	[INT],
	@factura		VARCHAR(255),
	@op				CHAR(1)
AS
DECLARE @error VARCHAR(MAX), @starpage INT = 1, @endpage INT = 1, @id_item BIGINT = 0;
DECLARE @temp TABLE(id_record INT IDENTITY(1,1) ,id_pk INT )
BEGIN TRY
		SET @numpage = ISNULL(@numpage,10);
		SELECT @id_item = id_articulo FROM MOVEntradasItemsTemp WHERE id = @id_articulo
		SET @starpage = (@page * @numpage) - @numpage +1;
		SET @endpage = @numpage * @page;


		IF(@op='T')
		BEGIN
			INSERT INTO @temp(id_pk)
			SELECT  T.id	
			FROM MOVFacturaItemsTemp T
			WHERE id_factura = @factura AND id_itemfac = @id_item

			ORDER BY id DESC;

			SET @countpage = @@rowcount;		
		
			SELECT  T.id, P.nombre, T.cantidad cantidad, CASE WHEN P.serie != 0 THEN DBO.ST_FNSeriesProductoConversion(T.id,@op) ELSE '' END series, T.serie
			FROM @temp Tm
					INNER JOIN MOVFacturaItemsTemp T on Tm.id_pk = T.id
					INNER JOIN DBO.Productos  P ON T.id_articulo = P.id
			ORDER  BY T.id DESC;
		END
		ELSE
		BEGIN
				INSERT INTO @temp(id_pk)
				SELECT  T.id	
				FROM MOVConversionesItemsForm T
				WHERE id_conversion = @factura AND id_articulofac = @id_articulo

				ORDER BY id DESC;

		
				SET @countpage = @@rowcount;		
		
				SELECT  T.id, P.nombre, T.cantidad cantidad, CASE WHEN P.serie != 0 THEN DBO.ST_FNSeriesProductoConversion(T.id,@op) ELSE '' END series, T.serie
				FROM @temp Tm
						INNER JOIN MOVConversionesItemsForm T on Tm.id_pk = T.id
						INNER JOIN DBO.Productos  P ON T.id_articulo = P.id
				ORDER  BY T.id DESC;
		END
END TRY
BEGIN CATCH
    --Getting the error description
	    Select @error   =  ERROR_PROCEDURE() + 
					';  ' + convert(varchar,ERROR_LINE()) + 
					'; ' + ERROR_MESSAGE()
	    -- save the error in a Log file
	    RaisError(@error,16,1)
	    Return  
END CATCH