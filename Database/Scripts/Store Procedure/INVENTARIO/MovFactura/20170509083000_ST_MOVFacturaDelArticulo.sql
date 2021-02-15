--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_MOVFacturaDelArticulo]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_MOVFacturaDelArticulo]
GO

CREATE PROCEDURE [dbo].[ST_MOVFacturaDelArticulo]
    @id_articulo [INT],	
	@idToken	 [VARCHAR] (255),		
	@id_anticipo [BIGINT] = 0
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[Dbo].[ST_MovFacturaDelArticulo]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		09/05/2017
*Desarrollador: (JTOUS)
***************************************/
DECLARE @error VARCHAR(MAX);
BEGIN TRY
BEGIN TRAN
	
	DELETE [dbo].MOVFacturaLotesTemp WHERE id_itemtemp = @id_articulo AND id_factura = @idToken;
	DELETE [dbo].MovFacturaSeriesTemp WHERE id_itemstemp = @id_articulo AND id_facturatemp = @idToken;
	DELETE [dbo].[MOVFacturaItemsTemp] Where id = @id_articulo AND id_factura = @idToken

	SELECT iva Tiva, precio Tprecio, descuentoart Tdctoart, 0 Tdesc, total Ttotal 
	FROM Dbo.ST_FnCalTotalFactura(@idToken, @id_anticipo);	

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

GO


