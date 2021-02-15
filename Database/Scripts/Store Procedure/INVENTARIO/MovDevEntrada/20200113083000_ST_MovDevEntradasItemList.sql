--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_MovDevEntradasItemList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_MovDevEntradasItemList]
GO


CREATE PROCEDURE [dbo].[ST_MovDevEntradasItemList]
	@page INT = 1,
	@numpage INT = 10,
	@countpage INT = 0 OUTPUT,
	@filter VARCHAR(50) = NULL,
	@id_devolucion BIGINT,
	@op CHAR(1)
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[dbo].[ST_MovDevEntradasItemList]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		13/01/20
*Desarrollador: (Jeteme)
***************************************/
DECLARE @error VARCHAR(MAX), @starpage INT = 1, @endpage INT = 1;
DECLARE @temp TABLE(id_record INT IDENTITY(1,1) ,id_pk INT,id_entrada BIGINT ,id_articulo BIGINT,codigo VARCHAR(50),presentacion VARCHAR(25),nombre VARCHAR(50),cantidad numeric(18,2),costo numeric(18,4),iva numeric(18,4),inc NUMERIC(18,4),descuento numeric(18,4),costototal numeric(18,4) )
BEGIN TRY
		
		SET @numpage = ISNULL(@numpage,10);

		SET @starpage = (@page * @numpage) - @numpage +1;
		SET @endpage = @numpage * @page;
		IF(@op = 'T')
		BEGIN		
			INSERT INTO @temp(id_pk,id_entrada,id_articulo,codigo,presentacion,nombre,cantidad,costo,iva,inc,descuento,costototal	)
			SELECT  i.id,i.id_entrada,i.id_articulo,p.codigo,p.presentacion,p.nombre,i.cantidad,i.costo, i.iva,i.inc, i.descuento, i.costototal
			FROM dbo.MOVEntradasItemsTemp i left join dbo.productos p on i.id_articulo=p.id
			WHERE	((isnull(@filter,'')='' or p.nombre like '%' + @filter + '%')) and i.id_entrada=@id_devolucion
				
			ORDER BY i.id ASC;

			SET @countpage = @@rowcount;		
		
			SELECT Tm.id_record,tm.id_pk as id ,tm.id_entrada, tm.id_articulo,tm.codigo,tm.nombre nombre,tm.presentacion,tm.cantidad,tm.costo ,tm.iva,tm.inc, tm.descuento, tm.costototal
			FROM @temp Tm
					WHERE id_record between @starpage AND @endpage
			ORDER BY tm.id_pk ASC;

			END
		ELSE
		BEGIN
		INSERT INTO @temp(id_pk,id_entrada,id_articulo,codigo,presentacion,nombre,cantidad,costo,iva,inc,descuento,costototal	)
			select i.id ,i.id_entrada,i.id_articulo,p.codigo,p.presentacion,p.nombre,i.cantidad,i.costo, i.iva,i.inc ,i.descuento, i.costototal from dbo.VW_MOVDevEntradaItems  i left join dbo.productos p on i.id_articulo=p.id 
		
			WHERE	((isnull(@filter,'')='' or p.nombre like '%' + @filter + '%')) and i.id_devolucion=@id_devolucion
				
			ORDER BY i.id ASC;

			SET @countpage = @@rowcount;		
		
			SELECT Tm.id_record,tm.id_pk as id ,tm.id_entrada, tm.id_articulo,tm.codigo,tm.nombre nombre,tm.presentacion,tm.cantidad,tm.costo ,tm.iva,tm.inc, tm.descuento, tm.costototal
			FROM @temp Tm
					
			WHERE id_record between @starpage AND @endpage
			ORDER BY tm.id_pk ASC;

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
End Catch

GO


