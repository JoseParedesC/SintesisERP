--liquibase formatted sql
--changeset ,kmartinez:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_MovServicioSetRecurrenteItem] ') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [dbo].[ST_MovServicioSetRecurrenteItem] 
GO

CREATE PROCEDURE [dbo].[ST_MovServicioSetRecurrenteItem] 
	@id				BIGINT,
	@valor			DECIMAL(18,2),	
	@column			VARCHAR(20)
  
--WITH ENCRYPTION
AS
BEGIN
 
DECLARE @ds_error VARCHAR(MAX), @id_return INT, @id_factura bigint;
Begin Try
		
	IF(@column = 'CANTIDAD')
	BEGIN		
		  UPDATE T
				 SET T.cantidad = @valor, 
				 T.iva = PA.iva,
				 T.inc = PA.inc,
				 T.descuento =  PA.descuento,
				 T.descuentound =  PA.descuentound,
				 T.precio = PA.precio,
				 T.total = PA.total,
				 T.preciodesc = PA.preciodes,
				 T.updated	= GETDATE()
				 FROM [dbo].[MOVFacturaRecurrentesItems]  T CROSS APPLY [dbo].[ST_FnPrecioArticulo](T.id_producto, T.precio, @valor, T.pordescuento) PA WHERE T.id = @id
			
			SET @id_return = @id;		
 
	

		END
	ELSE IF (@column = 'PRECIO')
	BEGIN
		 UPDATE T
				 SET T.precio = @valor, 
					 T.iva = PA.iva,
					 T.inc = PA.inc,
					 T.descuento = PA.descuento,
					 T.descuentound = PA.descuentound,
				     T.total = PA.total,
					 T.preciodesc = PA.preciodes,
					 T.updated	= GETDATE()
					 FROM [dbo].[MOVFacturaRecurrentesItems]  T CROSS APPLY [dbo].[ST_FnPrecioArticulo](T.id_producto, @valor, T.cantidad, T.pordescuento) PA WHERE T.id = @id
			
			SET @id_return = @id;		
	END

	SELECT @id_factura = ff.id_factura from [MOVFacturaRecurrentesItems] ff where  ff.id = @id

	SELECT  @id_return id, 'PROCESADO' estado, R.precio Tprecio, R.iva Tiva, isnull(R.inc,0) Tinc ,R.descuentoart Tdctoart, R.total Ttotal, (R.descuentoart) Tdesc
	FROM [dbo].[ST_FnCalTotalFacturaRecurrente](@id_factura) R
			
End Try
Begin Catch
 
Set @ds_error   =  ERROR_PROCEDURE() + 
				';  ' + convert(varchar,ERROR_LINE()) + 
				'; ' + ERROR_MESSAGE()
 
RaisError(@ds_error,16,1)
return
End Catch
END