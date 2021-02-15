--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_MovDevFacturaDelArticulo]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_MovDevFacturaDelArticulo]
GO
CREATE PROCEDURE DBO.ST_MovDevFacturaDelArticulo
    @id_articulo [INT],	
	@idToken	 [VARCHAR] (255)
 
AS
/***************************************
*Nombre:		[Dbo].[ST_MovDevFacturaDelArticulo]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		09/05/2017
*Desarrollador: (JTOUS)
***************************************/
DECLARE @error VARCHAR(MAX), @id int, @descuentoc NUMERIC(18,4) = 0, @descuentoa NUMERIC(18,4) = 0;
BEGIN TRY
BEGIN TRAN

	DELETE [dbo].[MOVFacturaItemsTemp] Where id = @id_articulo AND id_factura = @idToken;
	
	SET @descuentoc = (SELECT SUM(total - (valordes - ivades) ) FROM [MOVFacturaConceptoTemp] WHERE id_factura = @idToken);
	SET @descuentoa = (SELECT SUM(total - ((preciodes + ivades) * (-1*cantidad))) FROM [MOVFacturaItemsTemp] WHERE id_factura = @idToken);

	SELECT iva Tiva, precio Tprecio, descuentoart Tdctoart, ((ISNULL(@descuentoc,0) *-1) + ISNULL(@descuentoa,0) + descuentoart) Tdesc, total Ttotal 
	FROM Dbo.ST_FnCalTotalFactura(@idToken, 0);	

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
