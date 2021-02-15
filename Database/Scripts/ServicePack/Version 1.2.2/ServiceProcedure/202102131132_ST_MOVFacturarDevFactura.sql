--liquibase formatted sql
--changeset ,JTOUS:3 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_MOVFacturarDevFactura]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[ST_MOVFacturarDevFactura] 
GO
CREATE PROCEDURE [dbo].[ST_MOVFacturarDevFactura]
@id_factura			BIGINT, 
@fechadoc			SMALLDATETIME,
@id_devoluciontemp	VARCHAR(255),
@id_user INT
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[Dbo].[ST_MOVFacturarDevFactura]
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		19/06/2015
*Desarrollador:  Jeteheran 
*Descripcion:	Se realizan EL PROCESO DE FACTURAR LAS devoluciones de factura
***************************************/
Declare @id_return INT, @idestado INT,@id_cliente BIGINT,@totaldevant  NUMERIC(18,2), @numfactura varchar(30), @id_ctaant BIGINT, @id_articulo BIGINT, @mensaje VARCHAR(MAX),@id_forma BIGINT,@totaldevol NUMERIC(18,2),@totalfactura NUMERIC(18,2),@totaldevolcredito NUMERIC(18,2),@id_saldoanticipo BIGINT,@anomes VARCHAR(6),@valoranticipo NUMERIC(18,2),@fecha VARCHAR(10),@valoranticipodevant numeric(18,2),@isFinan BIT,@valordesctofinanciero NUMERIC(18,2);
Declare @table TABLE(id int identity(1,1), id_articulo int, id_bodega int,id_lote Bigint,serie VARCHAR(50));
DECLARE @iscausada BIT = 0
BEGIN TRANSACTION
BEGIN TRY

		SELECT @iscausada = iscausacion FROM MOVFactura WHERE id = @id_factura;

		SET @idestado = Dbo.ST_FnGetIdList('PROCE');
		SET @anomes = CONVERT(VARCHAR(6), @fechadoc, 112);
		SET @fecha  = CONVERT(VARCHAR(10), @fechadoc, 120);
		SELECT  @numfactura=numfactura FROM [FIN].[RefinanciacionItems]  where id_factura = @id_factura
		
		EXECUTE [Dbo].ST_ValidarPeriodo
			@fecha			= @fecha,
			@anomes			= @anomes,
			@mod			= 'I'

		IF EXISTS (SELECT 1 FROM Dbo.MovFactura WHERE id = @id_factura AND estado != @idestado)
			RAISERROR('No puede realizar devolución de una factura revertida, verifique..!', 16, 0);


		IF NOT EXISTS (SELECT 1 FROM MOVFacturaItemsTemp WHERE id_factura = @id_devoluciontemp AND selected != 0)
			RAISERROR ('No tiene productos seleccionados para devolver',16,0);


		IF EXISTS(SELECT 1 FROM [FIN].[SaldoCliente_Cuotas] S INNER JOIN  [FIN].[RefinanciacionItems] R ON S.cuota = R.cuota AND S.numfactura = R.numfactura AND S.anomes = @anomes
				 WHERE R.new = 0  AND S.id_refinanciado != 0 AND S.estado = 1 AND S.numfactura = @numfactura)
		   RAISERROR('No se puede realizar la devolucion, esta factura fue refinanciada', 16,2)
		
		;WITH CTESERIE (id, id_articulo, cantidad,cantidaddev)
		AS(
		   SELECT I.id, I.id_articulo,I.cantidad, I.cantidaddev
		   FROM Dbo.MOVFacturaItemsTemp I  
    	   WHERE  I.id_factura =  @id_devoluciontemp AND I.selected=1
		   GROUP BY I.id, I.id_articulo,I.cantidad, I.cantidaddev
		) 
		SELECT TOP 1 @id_articulo = id_articulo FROM CTESERIE WHERE cantidaddev = 0

		IF(ISNULL(@id_articulo, 0 ) != 0)
		BEGIN
			SELECT TOP 1 @mensaje = 'El producto ' + nombre +' no ha seleccionado las series a devolver.' 
			FROM Dbo.Productos WHERE id = @id_articulo; 
			RAISERROR(@mensaje, 16, 0)
		END	
		
		
		EXEC Dbo.ST_MOVCargarExistenciaFac @Opcion = 'D', @id = 0,@id_factura=@id_devoluciontemp, @id_user = @id_user;
		/*Actualizado 29/01/2021*/
		SELECT @valoranticipodevant=ISNULL(SUM(D.valoranticipo),0),@totaldevant=ISNULL(SUM(D.total),0),@valordesctofinanciero=ISNULL(SUM(D.dsctoFinanciero),0) from MOVDevFactura D join MOVFactura F on D.id_factura=F.id where id_factura= @id_factura and D.id_ctaant=F.id_ctaant 																																																																	   

		SELECT @valordesctofinanciero=ISNULL(SUM(D.dsctoFinanciero),0),@totaldevol=ISNULL(SUM(D.total),0) FROM MOVDevFactura D  join MOVFactura F on D.id_factura=F.id where id_factura= @id_factura --Actualizado 29/01/202
		
		INSERT INTO [dbo].[MOVDevFactura] (id_factura, id_tipodoc, id_centrocostos, fecha, id_caja,id_bodega, id_ctaant,valoranticipo,estado,  iva,inc,  
		descuento, subtotal, total,isPos , id_user, iscausacion, isFe, ctadescuento,dsctofinanciero)
		SELECT TOP 1	
				@id_factura id_factura, 
				E.id_tipodoc, 
				E.id_centrocostos, 
				@fechadoc fecha, 
				E.id_caja,
				(select id_bodega FROM dbo.Cajas Where id=E.id_caja), 
				E.id_ctaant,
				IIF(R.total+@totaldevant>=E.total-E.valoranticipo-@valoranticipodevant,R.total+@totaldevant-E.total+E.valoranticipo-@valoranticipodevant,0),--Actualizado 29/01/2021
				@idestado, 
				R.iva,
				R.inc,
				R.descuentoart,				 
				R.total-R.iva,
				R.total, 
				E.isPos,
				@id_user,
				E.iscausacion,
				E.isFe,
				E.ctadescuento,
				IIF(R.total+@totaldevol>E.total-E.dsctofinanciero,(R.total+@totaldevol)-(E.total-(E.dsctofinanciero-@valordesctofinanciero)),0)--Actualizado 29/01/2021
		FROM MOVFactura E CROSS APPLY Dbo.ST_FnCalDevTotalFactura(@id_devoluciontemp, 0) R where E.id=@id_factura
					
		SET @id_return = SCOPE_IDENTITY();
		
		IF ISNULL(@id_return, 0) <> 0
		BEGIN
			INSERT INTO [dbo].[MOVDevFacturaItems] (id_devolucion, id_articulo, id_itemfac, serie, lote, id_bodega, cantidad,costo,formulado,preciodesc,ivadesc ,precio, pordescuento, 
			 descuento, porceniva, iva, id_ctaiva,porceninc,inc,id_ctainc,total,inventarial, id_user,id_iva,id_inc)
			SELECT 
				@id_return id_dev, 
				T.id_articulo,
				I.id id_item,
				T.serie,
				I.lote,
				CASE WHEN T.id_bodega = 0 THEN NULL ELSE T.id_bodega END, 
				T.cantidaddev,
				T.costo,
				T.formulado,
				T.preciodes,
				T.ivades,
				T.precio,
				T.pordescuento,
				T.descuento,
				T.poriva,
				T.iva,
				I.id_ctaiva,
				T.porinc,
				T.inc,
				I.id_ctainc,
				T.total,
				T.inventarial,
				@id_user,
				T.id_iva,
				T.id_inc
			FROM [dbo].[MOVFacturaItemsTemp] T 
			INNER JOIN [MOVFacturaItems] I ON T.id_itemfac = I.id
			WHERE T.id_factura = @id_devoluciontemp AND T.selected != 0;					

			INSERT INTO MovDevFacturasSeries(id_items, id_devolucion, serie)
			SELECT II.id, @id_return, S.serie 
			FROM [dbo].[MovFacturaSeriesTemp] S
			INNER JOIN [MOVFacturaItemsTemp] I ON I.id = S.id_itemstemp AND S.id_facturatemp = I.id_factura
			INNER JOIN [MOVDevFacturaItems] II ON I.id_articulo = II.id_articulo AND I.descuento = II.descuento 
											AND I.serie = II.serie 
			WHERE I.id_factura = @id_devoluciontemp AND S.selected != 0;
			
			INSERT INTO Dbo.MOVDevFacturaLotes (id_item, id_lote, id_devolucion, cantidad)
			SELECT I.id, LT.id_lote, @id_return, LT.cantidaddev
			FROM [dbo].[MOVFacturaLotesTemp] LT INNER JOIN 
				dbo.MovFacturaItemsTemp IT ON LT.id_itemtemp = IT.id INNER JOIN
				Dbo.MOVDevFacturaItems I ON I.id_articulo = IT.id_articulo AND I.id_bodega = IT.id_bodega AND I.id_devolucion=@id_return
			WHERE IT.lote != 0 AND IT.id_factura = @id_devoluciontemp  AND IT.inventarial != 0;
						
			IF (ISNULL(@iscausada,0) = 0)
			BEGIN
				EXEC [dbo].[ST_MOVDevFacturaCuotas] @id_devolucion=@id_return,@id_user=@id_user,@isFinan=@isFinan OUTPUT --Actualizado 20/01/2021
			END

			IF(@isFinan = 1)
			BEGIN
				SELECT @totaldevol=D.total,@totalfactura=F.total FROM MOVDEVFACTURA D JOIN MOVFACTURA F ON D.id_factura=F.id WHERE D.ID=@id_return

				/*Actualizado 20/01/2021*/
				IF(@totaldevol = @totalfactura)
					begin
						UPDATE C set 
							   C.cancelada=1 
						FROM FIN.SALDOCLIENTE S INNER JOIN 
							 FIN.SALDOCLIENTE_CUOTAS C 
							 ON S.ID=C.ID_SALDO  AND S.ANOMES=C.ANOMES WHERE S.ANOMES=@anomes and S.id_documento=@id_factura
				
						UPDATE S set S.movcredito	= S.movcredito+@totaldevol,
							   S.saldoactual		= S.saldoactual-@totaldevol	
						FROM FIN.SALDOCLIENTE S 
							JOIN FIN.SALDOCLIENTE_CUOTAS C 
							ON S.ID=C.ID_SALDO  AND S.ANOMES=C.ANOMES WHERE S.ANOMES=@anomes and S.id_documento=@id_factura
					end else
					RAISERROR ('Seleccionar total items de la factura',16,0);
			END	

			IF (ISNULL(@iscausada,0) != 0)
			BEGIN
				
				UPDATE C SET 
					C.InteresCausado = (C.InteresCausado - I.total), [update] = GETDATE()
				FROM MOVFactura F INNER JOIN MOVFacturaItems I ON I.id_factura = F.id 
				INNER JOIN FIN.SaldoCliente_Cuotas C ON C.numfactura = F.nrofactura AND I.cuota = C.cuota AND C.id_tercero = F.id_tercero
				WHERE F.id = @id_factura AND C.anomes = @anomes
								
				UPDATE E SET
					E.updated		= GETDATE(),
					E.saldoActual	= ((E.saldoAnterior + E.movDebito - I.total - C.Valorfianza) - (E.movCredito)),
					E.movDebito		= (E.movDebito - F.total - F.valorFianza),
					E.id_user		=  @id_user
				FROM MOVFactura F INNER JOIN MOVFacturaItems I ON I.id_factura = F.id 
				INNER JOIN FIN.SaldoCliente_Cuotas C ON C.numfactura = F.nrofactura AND I.cuota = C.cuota AND C.id_tercero = F.id_tercero
				INNER JOIN FIN.SaldoCliente E ON E.nrofactura = F.nrofactura AND E.id_cliente = F.id_tercero AND C.anomes = E.anomes
				WHERE F.id = @id_factura AND E.anomes = @anomes

			END
													  
			DELETE [dbo].[MovFacturaSeriesTemp] WHERE id_facturatemp = @id_devoluciontemp
			DELETE [dbo].[MOVFacturaLotesTemp] WHERE id_factura = @id_devoluciontemp
			Delete [dbo].[MOVFacturaItemsTemp] WHERE id_factura = @id_devoluciontemp;
			
			SELECT 
				@id_return id, 
				'PROCESADO' estado,
				'CNT.VW_TRANSACIONES_DEVFACTURAS' nombreview, 
				@fecha fecha, 
				@anomes anomes,
				@id_user id_user,
				isfe,
				keyid [key]
			FROM VW_MOVDevFacturas WHERE id = @id_return;

		END
		ELSE
		BEGIN
			RAISERROR('Error al Guardar devolución de mercancia, No se pudo guardar la cabecera de la Devolución.', 16,0);
		END			
		

COMMIT TRANSACTION;
END TRY
BEGIN CATCH	
	ROLLBACK TRANSACTION;
	SET @mensaje = 'Error: '+ERROR_MESSAGE();
	RAISERROR(@Mensaje,16,0);	
END CATCH
