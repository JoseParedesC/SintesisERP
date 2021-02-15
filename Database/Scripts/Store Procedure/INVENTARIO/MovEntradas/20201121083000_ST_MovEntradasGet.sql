--liquibase formatted sql
--changeset ,jteheran:3 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_MovEntradasGet]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_MovEntradasGet]
GO

CREATE PROCEDURE [dbo].[ST_MovEntradasGet] 
	@id [BIGINT],
	@id_temp BIGINT,
	@op CHAR(1)
--WITH ENCRYPTION
AS
BEGIN
/***************************************
*Nombre:		[dbo].[ST_MovEntradasGet]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		27/03/17
*Desarrollador: (JTOUS)
***************************************/
	------------------------------------------------------------------------------
	-- Declaring variables Page_Nav
	------------------------------------------------------------------------------
	Declare @ds_error varchar(max), @id_entra int
	
	Begin Try
	
		SET @id_entra = (SELECT Top 1 CASE WHEN Dbo.ST_FnGetIdList('REVON') = estado THEN id_reversion ELSE id END FROM Dbo.MOVEntradas T Where T.id = @id);
		
		SELECT 
			M.id, 
			M.centrocosto,
			M.id_tipodoc,
			M.fechadocumen,
			M.fechafactura,
			M.fechavence,
			M.numfactura,
			M.diasvence,
			M.estado,
			M.id_bodega,
			M.nombrebodega,
			M.id_proveedor,
			M.proveedor,
			M.id_formaPagos,
			M.FormaPago,
			M.flete,
			M.porfuente, 
			M.poriva, 
			M.porica,
			M.costo			 [Tcosto],
			M.iva+M.ivaflete [Tiva],
			M.inc			 [Tinc],	
			M.descuento		 [Tdesc],
			M.valor			[Ttotal],
			M.reteiva		[retiva],
			M.reteica		[retica],
			M.retefuente	[retfuente],
			M.id_pedido,
			ISNULL(iif(@op='D',M.valoranticipo -ISNULL((Select SUM(D.valoranticipo) from MOVDevEntradas D where D.id_Entrada= @id and D.id_ctaant=M.id_ctaant ),0),M.valoranticipo),0) valoranticipo,
			M.id_ctaant,
			M.ctaanticipo,
			M.id_centro
		FROM
			Dbo.VW_MOVEntradas M
		WHERE 
			id = @id;

		IF (@op = 'D')
		BEGIN
			DELETE [MOVEntradasItemsTemp] WHERE id_entrada = @id_temp;	
								
			;WITH CTE (id_articulo,	serie,	lote,	id_lote,	vencimiento,	id_bodega,	cantidad,	costo,	precio,	porceniva,	iva, porceninc,	inc,	descuentound,	pordescuento,	descuento,	costototal,	fleteund,	flete,	inventarial,	id_user,	iditem, multiplo,id_iva,id_inc,id_retefuente,porcenrefuente,retefuente,id_reteiva,porcenreiva,reteiva,id_reteica,porcenreica,reteica)
			AS (
				SELECT
					id_articulo, 
					serie, 
					C.lote, 
					L.lote id_lote, 
					CONVERT(VARCHAR(10), L.vencimiento_lote, 112) vencimiento,
					id_bodega, 
					[dbo].[ST_FnCantidadArtMov] (C.id, @id, 'EN') cantidad, 
					costo, 
					precio, 
					porceniva, iva, 
					porceninc, inc,  
					descuentound, 
					pordescuento,
					descuento, 
					costototal, 
					fleteund, 
					flete, 
					inventarial, 
					id_user, 
					C.id,
					CASE WHEN C.serie != 0 THEN 0 ELSE 1 END multiplo,
					C.id_iva,
					C.id_inc,
					C.id_retefuente,
					C.porcerefuente,
					C.retefuente,
					C.id_reteiva,
					C.porcereiva,
					C.reteiva,
					C.id_reteica,
					C.porcereica,
					C.reteica
				FROM [MOVEntradasItems] AS C
				INNER JOIN LotesProducto L ON C.id_lote = L.id 				
				WHERE C.id_entrada = @id
			)
			Insert into [dbo].[moventradasitemstemp] (id_entrada, id_articulo, serie, lote, id_lote, vencimientolote, id_bodega, 
			cantidad, costo, precio, id_iva, porceniva, iva, id_inc, porceninc, inc, id_retefuente,porcerefuente,retefuente,id_reteiva,porcereiva,reteiva,id_reteica,porcereica,reteica,descuentound, pordescuento, descuento, 
			costototal, fleteund, flete, inventarial, id_user, selected, cantidaddev, id_itementra)
			
			SELECT @id_temp, id_articulo,	serie,	lote,	id_lote,	vencimiento,	id_bodega,	cantidad,	
			C.costo,	C.precio,	C.id_iva , porceniva,	CA.iva,  C.id_inc	id_inc, porceninc,	CA.inc,C.id_retefuente,C.porcenrefuente,CA.retefuente,C.id_reteiva,C.porcenreiva,CA.reteiva,C.id_reteica,C.porcenreica,CA.reteica,	CA.descuentound,	pordescuento, CAST(C.costo * C.pordescuento/100 * (C.cantidad * C.multiplo) as decimal(18,2)) descuento,	
			CA.costototal,	fleteund,	flete,	inventarial,	id_user, 0 selected, (C.cantidad * C.multiplo) cantidaddev,	iditem
			FROM CTE C
			CROSS APPLY Dbo.ST_FnCostoArticulo(C.id_articulo, C.costo, (C.cantidad * C.multiplo), CAST((C.costo * C.pordescuento/100)* (C.cantidad * C.multiplo) as decimal(18,2)), C.porceninc, C.porceniva, C.pordescuento,ISNULL(C.porcenrefuente,0),ISNULL(C.porcenreiva,0),ISNULL(C.porcenreica,0),IIF(ISNULL(C.porcenrefuente,0)+ISNULL(C.porcenreiva,0)+ISNULL(C.porcenreica,0)>0,1,0)) CA
			WHERE cantidad > 0

			
			INSERT INTO MovEntradasSeriesTemp(id_itemstemp, id_entradatemp, serie)
			SELECT T.id, @id_temp, S.serie				
			FROM [MOVEntradasItems] AS C
			INNER JOIN MovEntradasSeries S ON S.id_items = C.id
			INNER JOIN Existencia E ON E.id_articulo = C.id_articulo AND E.id_bodega = C.id_bodega
			INNER JOIN ExistenciaLoteSerie L ON E.id = L.id_existencia AND L.id_lote = C.id_lote AND L.serie = S.serie
			INNER JOIN [MOVEntradasItemsTemp] T ON T.id_itementra = C.id AND T.id_entrada = @id_temp
			WHERE C.serie != 0 AND C.id_entrada = @id AND L.existencia > 0;
 
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
 GO
