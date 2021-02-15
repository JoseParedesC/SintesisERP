--liquibase formatted sql
--changeset ,kmartinez:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_MOVFacturarRecurrenteDelArticulo]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [dbo].[ST_MOVFacturarRecurrenteDelArticulo] 
GO

CREATE PROCEDURE [dbo].[ST_MOVFacturarRecurrenteDelArticulo]
    @id_articulo [INT],	
	@idToken	 [VARCHAR] (255),		
	@id_anticipo [BIGINT] = 0
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[dbo].[ST_MOVFacturarRecurrenteDelArticulo]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		09/05/2017
*Desarrollador: (Kmartinez)Kevin Jose Martinez Teheran
***************************************/
DECLARE @error VARCHAR(MAX);
BEGIN TRY
BEGIN TRAN
	 DELETE [dbo].[MOVFacturaRecurrentesItems] Where id = @id_articulo AND id_factura = @idToken

	SELECT iva Tiva, precio Tprecio, descuentoart Tdctoart, 0 Tdesc, total Ttotal 
	FROM  [dbo].[ST_FnCalTotalFacturaRecurrente](@idToken);	

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