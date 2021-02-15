--liquibase formatted sql
--changeset ,JTOUS:5 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_MovFacturasGet]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_MovFacturasGet]
GO

CREATE PROCEDURE [dbo].[ST_MovFacturasGet]
	@id [int],
	@id_temp VARCHAR(255),
	@op CHAR(1)
--WITH ENCRYPTION
AS
BEGIN
/***************************************
*Nombre:		[dbo].[ST_MovFacturasGet]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		27/03/17
*Desarrollador: (JTOUS)
***************************************/
	------------------------------------------------------------------------------
	-- Declaring variables Page_Nav
	------------------------------------------------------------------------------
	Declare @ds_error varchar(max), @id_fact int, @causacion BIT = 0, @pagoFinan BIGINT
	
	Begin Try
		SELECT Top 1 @id_fact = CASE WHEN Dbo.ST_FnGetIdList('REVON') = estado THEN id_reversion ELSE id END, @causacion = iscausacion
		FROM  Dbo.MOVFactura T Where T.id = @id;
		
		Select 			
			P.id, 
			P.fechadoc fechafac,
			isnull(P.iva,0) Tiva,
			isnull(P.inc,0) Tinc,
			isnull(P.descuento,0) Tdctoart,
			isnull(P.subtotal,0) Tprecio,
			isnull(P.total,0) Ttotal,
			P.cliente,
			P.id_cliente,
			P.estado,
			P.id_vendedor,
			P.vendedor,
			iif(@op='D',P.valoranticipo-ISNULL((Select SUM(D.valoranticipo) from MOVDevFactura D where D.id_factura= @id and D.id_ctaant=P.id_ctaant ),0),P.valoranticipo) valoranticipo,
			P.id_ctaant,
			P.cuentaant,
			P.id_tipodoc,
			P.id_centrocostos,
			P.centrocosto,
			P.isfe,
			P.formaPagoFinan FormaPago,
			'' id_bodega,
			P.pagoFinan,		   
			iif(@op='D',p.dsctoFinanciero-ISNULL((Select SUM(D.dsctoFinanciero) from MOVDevFactura D where D.id_factura= @id),0),p.dsctoFinanciero) dsctoFinanciero,
			p.CuentaDescuentoFin,
			CASE WHEN ISNULL(pagofinan,0) = 0 THEN 0 ELSE 1 END  financiera
		From 
			 Dbo.VW_MOVFacturas P
		Where 
			P.id = @id;

		SELECT 	@pagoFinan=P.pagoFinan FROM Dbo.VW_MOVFacturas P Where P.id = @id; -- Adicion 22/01/2021

		IF (@op = 'D')
		BEGIN
			DELETE [MovFacturaSeriesTemp] WHERE id_facturatemp=@id_temp-- Adicion 22/01/2021
			DELETE [MOVFacturaItemsTemp] WHERE id_factura = @id_temp;

			;WITH CTE (id_articulo,	id_bodega, serie, lote, cantidad, precio, descuentound,	pordescuento, descuento, poriva, iva, porinc, inc, total,
			 id_user, costo, preciodes, formulado, inventarial, id_itemfac,id_iva,id_inc)
			AS (
				SELECT
					C.id_producto, 
					ISNULL(C.id_bodega, 0),
					C.serie, 
					C.lote, 
					[dbo].[ST_FnCantidadArtMov] (C.id, @id, 'FA') cantidad,
					precio, 
					descuentound,
					pordescuento,
					descuento,
					poriva,
					iva,
					porinc,
					inc,
					total,
					1 id_user,
					costo,
					preciodesc,
					formulado,
					inventarial,
					C.id,
					C.id_iva,
					C.id_inc
				FROM [VW_MOVFacturaItems] AS C				
				WHERE C.id_factura = @id
			)
			INSERT INTO [dbo].[MOVFacturaItemsTemp] (id_factura, id_articulo, id_bodega, serie, lote ,cantidad, 
			precio, descuentound, pordescuento, descuento, id_iva, poriva, iva,  
			id_inc, porinc, inc, total, id_user,costo,  preciodes, formulado, inventarial, cantidaddev, selected, id_itemfac, iscausacion, isfinanciero)

			SELECT @id_temp, id_articulo, id_bodega, serie, lote, cantidad, precio, descuentound, pordescuento, descuento, id_iva, poriva,
			iva, id_inc, porinc, inc, total, id_user, costo, preciodes, formulado, inventarial, iif(@pagoFinan is null,0,cantidad), iif(@pagoFinan is null,0,1), id_itemfac, @causacion,iif(@pagoFinan is null,0,1)
			FROM CTE where cantidad>0;

			INSERT INTO MovFacturaSeriesTemp(id_itemstemp, id_facturatemp, serie,selected)
			SELECT T.id, @id_temp, S.serie,iif(@pagoFinan is null,0,1)		
			FROM [MOVFacturaItems] AS C
			INNER JOIN MovFacturaSeries S ON S.id_items = C.id
			INNER JOIN Existencia E ON E.id_articulo = C.id_producto AND E.id_bodega = C.id_bodega
			INNER JOIN ExistenciaLoteSerie L ON E.id = L.id_existencia  AND L.serie = S.serie
			INNER JOIN [MOVFacturaItemsTemp] T ON T.id_itemfac = C.id AND T.id_factura = @id_temp
			WHERE C.serie != 0 AND C.id_factura = @id and L.existencia=0;

			INSERT INTO MOVFacturaLotesTemp (id_itemtemp,id_factura,id_lote,cantidad,cantidaddev)-- Adicion 22/01/2021
			SELECT T.id,@id_temp,LO.id_lote,LO.cantidad-isnull((Select SUM(DL.cantidad) from MOVDevFacturaLotes DL inner JOIN MOVDevFactura D ON DL.id_devolucion=D.id where id_lote=Lo.id_lote and D.id_factura=@id),0) cantidad,
			iif(@pagoFinan is null,0,LO.cantidad-isnull((Select SUM(DL.cantidad) from MOVDevFacturaLotes DL inner JOIN MOVDevFactura D ON DL.id_devolucion=D.id where id_lote=Lo.id_lote and D.id_factura=@id),0)) FROM MOVFacturaItems AS C 
			INNER JOIN MOVFacturaLotes LO ON LO.id_item=C.id
			INNER JOIN [MOVFacturaItemsTemp] T ON T.id_itemfac = C.id AND T.id_factura=@id_temp
			WHERE C.lote!=0 AND C.id_factura=@id and lo.CANTIDAD>0


		END
	End Try
    Begin Catch
	--Getting the error description
	Set @ds_error   =  ERROR_PROCEDURE() + 
					';  ' + convert(varchar,ERROR_LINE()) + 
					'; ' + ERROR_MESSAGE()
	-- save the error in a Log file
	RaisError(@ds_error,16,1)
	return
	End Catch
END