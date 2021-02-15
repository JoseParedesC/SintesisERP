--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[MovOrdenCompraItemList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[MovOrdenCompraItemList]
GO
CREATE PROCEDURE [dbo].[MovOrdenCompraItemList]
	@page INT = 1,
	@numpage INT = 10,
	@countpage INT = 0 OUTPUT,
	@filter VARCHAR(50) = NULL,
	@id_orden BIGINT,
	@op CHAR(1)
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[dbo].[MovOrdenCompraItemTempList]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		22/11/19
*Desarrollador: (Jeteme)
***************************************/
DECLARE @error VARCHAR(MAX), @starpage INT = 1, @endpage INT = 1;
DECLARE @temp TABLE(id_record INT IDENTITY(1,1) ,id_pk INT,id_ordencompra BIGINT ,id_producto BIGINT,presentacion VARCHAR(25),nombre VARCHAR(50),cantidad numeric(18,2) )
BEGIN TRY
		
		SET @numpage = ISNULL(@numpage,10);

		SET @starpage = (@page * @numpage) - @numpage +1;
		SET @endpage = @numpage * @page;
		IF(@op='T')
		BEGIN
			INSERT INTO @temp(id_pk,id_ordencompra,id_producto,presentacion,nombre,cantidad)
			SELECT  i.id,i.id_ordencompra,i.id_producto,p.presentacion,p.nombre,i.cantidad
			FROM dbo.MOVOrdenComprasItemTemp i left join dbo.productos p on i.id_producto=p.id
			WHERE	((isnull(@filter,'')='' or p.nombre like '%' + @filter + '%')) and i.id_ordencompra=@id_orden
				
			ORDER BY i.id ASC;

			SET @countpage = @@rowcount;		
		
			SELECT Tm.id_record, tm.id_ordencompra, tm.id_producto,p.codigo,tm.nombre ,tm.presentacion,tm.cantidad
			FROM @temp Tm
					Inner join dbo.MOVOrdenComprasItemTemp i on Tm.id_pk = i.id inner join dbo.Productos p on p.id=tm.id_producto
			WHERE id_record between @starpage AND @endpage
			ORDER BY p.id ASC;
		END
		ELSE
		BEGIN
			INSERT INTO @temp(id_pk,id_ordencompra,id_producto,presentacion,nombre,cantidad)
			SELECT  i.id,i.id_ordencompra,i.id_producto,p.presentacion,p.nombre,i.cantidad
			FROM dbo.MOVOrdenComprasItem i left join dbo.productos p on i.id_producto=p.id
			WHERE	((isnull(@filter,'')='' or p.nombre like '%' + @filter + '%')) and i.id_ordencompra=@id_orden
				
			ORDER BY i.id ASC;

			SET @countpage = @@rowcount;		
		
			SELECT Tm.id_record, tm.id_ordencompra, tm.id_producto,p.codigo,Tm.nombre ,tm.presentacion,tm.cantidad
			FROM @temp Tm
					Inner join dbo.MOVOrdenComprasItem i on Tm.id_pk = i.id inner join dbo.Productos p on p.id=tm.id_producto
			WHERE id_record between @starpage AND @endpage
			ORDER BY p.id ASC;
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
