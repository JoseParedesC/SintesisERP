--liquibase formatted sql
--changeset ,jteheran:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_MovOrdenCompraToEntrada]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [dbo].[ST_MovOrdenCompraToEntrada]
GO
CREATE PROCEDURE [dbo].[ST_MovOrdenCompraToEntrada]
@idOrden BIGINT = 0, 
@id_user INT

--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[Dbo].[ST_MovOrdenCompraToEntrada]
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		20/05/2020
*Desarrollador:  JTOUS
*Descripcion:	Traslado de Orden de compra a Entradas
***************************************/
Declare @id_return INT;
BEGIN TRANSACTION
BEGIN TRY

		IF NOT EXISTS(SELECT 1 FROM MovOrdenCompras WHERE id = @idOrden AND estado = Dbo.ST_FnGetIdList('PROCE'))
			RAISERROR('La orden de compra que intenta importar no esta en estado procesado.', 16, 0);
						
		INSERT  INTO [dbo].[MOVEntradasTemp] (id_bodega, id_proveedor, id_user, id_orden)
		SELECT M.bodega, M.id_proveedor, @id_user, @idOrden
		FROM Dbo.MovOrdenCompras M WHERE id = @idOrden;
					
		SET @id_return = SCOPE_IDENTITY();
					
		IF ISNULL(@id_return, 0) <> 0
		BEGIN
			INSERT INTO [dbo].[MOVEntradasItemsTemp] (id_entrada, id_articulo, serie, lote, id_lote, vencimientolote, id_bodega, cantidad, costo, precio, id_iva, porceniva, iva, id_inc, 
													 porceninc, inc, descuentound, pordescuento, descuento, costototal, flete, inventarial, id_user)
			
			SELECT  @id_return, I.id_producto, P.serie, P.lote, '' idlote, '' vencimiento, I.id_bodega, I.cantidad, I.costo, P.precio, M2.id id_iva, ISNULL(M2.valor,0) poriva, 
			F.iva,	M.id id_inc, ISNULL(M.valor,0) inc, F.inc, 0, 0, 0, (I.costo * I.cantidad) costototal, 0, 1, @id_user 					
			FROM [dbo].[MOVOrdenComprasItem] I
			INNER JOIN VW_Productos P ON P.id = I.id_producto
			LEFT JOIN CNT.VW_Impuestos M ON P.id_inc = M.id
			LEFT JOIN CNT.VW_Impuestos M2 ON P.id_iva = M2.id
			CROSS APPLY Dbo.ST_FnCostoArticulo(I.id_producto, I.costo, I.cantidad, 0, ISNULL(M.valor, 0), ISNULL(M2.valor, 0), 0,0,0,0,0) F
			WHERE id_ordencompra = @idOrden;
					
		END
		
		SELECT T.id, T.id_proveedor, E.tercero  proveedor, T.id_bodega, R.porfuente, R.retfuente, R.poriva, R.retiva, R.porica, R.retica, R.costo Tcosto, R.iva Tiva,R.tinc Tinc, R.descuento Tdesc, R.total Ttotal
		FROM  [MOVEntradasTemp] T CROSS APPLY Dbo.ST_FnCalRetenciones(T.id_proveedor, T.id, 0,'EN', 0, 0,0,0,0) R
		INNER JOIN CNT.VW_Terceros E ON E.id = T.id_proveedor
		WHERE T.id = @id_return;

COMMIT TRANSACTION;
END TRY
BEGIN CATCH	
	ROLLBACK TRANSACTION;
	Declare @Mensaje varchar(max) = 'Error: '+ERROR_MESSAGE();
	RAISERROR(@Mensaje,16,0);	
END CATCH