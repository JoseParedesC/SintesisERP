--liquibase formatted sql
--changeset ,CZULBARAN:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_MovConversionDelArticulo]') and OBJECTPROPERTY(id, N'IsProcedure') = 1) 
DROP PROCEDURE dbo.ST_MovConversionDelArticulo
GO
CREATE PROCEDURE [dbo].[ST_MovConversionDelArticulo]
    @id_articulo [INT],
	@id_entrada		[int],
	@factura	VARCHAR(255)
AS
/***************************************
*Nombre:		[Dbo].[ST_MovConversionDelArticulo]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		09/05/2017
*Desarrollador: (JTOUS)
***************************************/
DECLARE @error VARCHAR(MAX), @id int, @id_itemfac BIGINT;
BEGIN TRY
BEGIN TRAN
	SELECT @id_itemfac = id_articulo FROM [MOVEntradasItemsTemp] WHERE id = @id_articulo

	DELETE MovEntradasSeriesTemp WHERE id_entradatemp = id_entradatemp AND id_itemstemp = @id_articulo;
	DELETE [dbo].[MOVEntradasItemsTemp] Where id = @id_articulo;

	DELETE S FROM MovFacturaSeriesTemp S INNER JOIN MOVFacturaItemsTemp T ON T.id = S.id_itemstemp AND S.id_facturatemp = @factura;
	DELETE MOVFacturaItemsTemp WHERE id_itemfac = @id_itemfac AND id_factura = @factura

	SELECT 		
		R.total Ttotal
	FROM 
		Dbo.ST_FnCalRetenciones(0, @id_entrada, 0, 'EN',@id_entrada,0,0,0,0) R;	

COMMIT TRAN;
END TRY
BEGIN CATCH
		ROLLBACK TRAN;
	    --Getting the error description
	    SELECT @error   =  ERROR_PROCEDURE() + 
					';  ' + convert(varchar,ERROR_LINE()) + 
					'; ' + ERROR_MESSAGE()
	    -- save the error in a Log file
	    RAISERROR(@error,16,1);
	    RETURN  
END CATCH
