--liquibase formatted sql
--changeset ,jteheran:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_MOVFacturarCotizacion]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [dbo].[ST_MOVFacturarCotizacion]
GO
CREATE PROCEDURE [dbo].[ST_MOVFacturarCotizacion]
@id_cliente BIGINT,
@id_vendedor BIGINT,
@id_bodega BIGINT,
@idToken VARCHAR(255),
@id_user INT

--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[Dbo].[ST_MOVFacturarCotizacion]
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		19/06/2015
*Desarrollador:  Jose Luis Tous P�rez (jtous)
*Descripcion:	Se realizan EL PROCESO DE COTIZACION
***************************************/
Declare @id_return INT, @Contabilizar BIT, @idestado INT, @Cantidad int, @id_turno int;
Declare  @mensaje varchar(max);
BEGIN TRY
BEGIN TRANSACTION

	SET @idestado = Dbo.ST_FnGetIdList('PROCE');
	
	
		IF EXISTS (SELECT  1 FROM CNT.VW_Terceros C  WHERE C.id = @id_cliente) OR ISNULL(@id_cliente, 0) = 0
		BEGIN		
					
			SELECT  @Cantidad = COUNT(1)  FROM Dbo.MOVFacturaItemsTemp Where id_factura = @idToken AND id_user = @id_user;
										 
			IF(ISNULL(@Cantidad,0) > 0)
			BEGIN						
						
				INSERT INTO Dbo.MOVCotizacion(fechacot, estado, id_cliente, id_vendedor,id_bodega,iva,inc ,descuento, subtotal, total,  id_user)
				SELECT GETDATE(), @idestado, @id_cliente, @id_vendedor,@id_bodega,T.iva,T.inc ,(T.descuentoart + 0), T.precio, T.total,  @id_user
				FROM Dbo.ST_FnCalTotalFactura(@idToken, 0) T

				SET @id_return = SCOPE_IDENTITY();																	

				INSERT INTO [dbo].[MOVCotizacionItems] (id_cotizacion, id_articulo, cantidad, precio, descuento, total, iva,inc, id_user,id_bodega)
				SELECT @id_return, T.id_articulo, T.cantidad, T.precio, T.descuento, T.total, T.iva,T.inc, @id_user,id_bodega
				FROM [dbo].[MOVFacturaItemsTemp] T
				WHERE id_factura = @idToken AND T.id_user = @id_user;

				DELETE [dbo].[MOVFacturaItemsTemp] WHERE id_factura = @idToken AND id_user = @id_user;

				SELECT @id_return id, 'PROCESADO' estado
														
			END
			ELSE
				RAISERROR('No se cargaron ni art�culos ni conceptos, verifique..',16,0);
		END
		ELSE
			RAISERROR('Cliente no existe.',16,0);	
		
COMMIT TRANSACTION;
END TRY
BEGIN CATCH	
	ROLLBACK TRANSACTION;
	SET @mensaje = 'Error: '+ERROR_MESSAGE();
	RAISERROR(@Mensaje,16,0);	
END CATCH