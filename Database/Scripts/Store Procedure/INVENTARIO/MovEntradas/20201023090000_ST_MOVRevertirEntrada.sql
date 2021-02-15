--liquibase formatted sql
--changeset ,jteheran:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_MOVRevertirEntrada]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_MOVRevertirEntrada]
GO
CREATE PROCEDURE [dbo].[ST_MOVRevertirEntrada]
@id BIGINT = 0,
@id_user INT

--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[Dbo].[ST_MOVRevertirEntrada]
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		23/10/2020
*Desarrollador:  Jose Luis Tous P�rez (jtous)
*Descripcion:	Se realizan EL PROCESO DE REVERTIR  ENTRADAS
***************************************/
Declare @tablePago Table (id_pk int identity, id_pag bigint);
Declare @id_return INT, @Contabilizar BIT, @id_orden INT=NULL,@id_proveedor BIGINT,@pago NUMERIC(18,2),@anomes VARCHAR(6),@fechadoc VARCHAR(10),@fecha SMALLDATETIME;
Declare @rows int = 0, @count int = 1, @id_pago int, @Mensaje varchar(max), @id_articulo BIGINT;
BEGIN TRANSACTION
BEGIN TRY	
	
		SELECT @fecha=fechadocumen FROM dbo.MOVEntradas WHERE id=@id;
		SET @anomes=CONVERT(VARCHAR(6),@fecha, 112);
		SET @fechadoc=CONVERT(VARCHAR(10), @fecha, 120);	


		EXECUTE [Dbo].ST_ValidarPeriodo
				@fecha			= @fechadoc,
				@anomes			= @anomes,
				@mod			= 'I'
		
		IF  EXISTS (SELECT 1 FROM CNT.SaldoProveedor S INNER JOIN dbo.MOVEntradas E ON E.id=S.id_documento AND E.id_proveedor=S.id_proveedor WHERE id_documento=@id AND movDebito>0 and anomes=CONVERT(VARCHAR(6), @fecha, 112))
			RAISERROR('Entrada no puede ser revertida ya presenta movimiento....',16,0)

		SELECT TOP 1 @id_articulo = I.id_articulo  FROM ExistenciaLoteSerie EL INNER JOIN 
			MovAjustesSeries ES ON ES.serie = EL.serie INNER JOIN
			MOVAjustesItems I ON I.id = ES.id_items
		WHERE I.id_ajuste = @id AND EL.existencia = 0; 
		
		IF (ISNULL(@id_articulo, 0) = 0)
		BEGIN
			SELECT TOP 1 @id_articulo = E.id_articulo 
			FROM [dbo].[ExistenciaLoteSerie] S
			INNER JOIN Dbo.Existencia E  ON S.id_existencia = E.id 
			INNER JOIN [dbo].[MOVEntradasItems] AT ON AT.id_articulo = E.id_articulo AND E.id_bodega = AT.id_bodega AND S.id_lote = AT.id_lote
			WHERE AT.id_entrada = @id AND AT.serie = 0 AND (S.existencia - AT.cantidad) < 0;
		END		

		IF (ISNULL(@id_articulo, 0) = 0)
		BEGIN

			IF NOT EXISTS (SELECT 1 FROM Dbo.MOVEntradas WHERE id = @id AND (estado = Dbo.ST_FnGetIdList('REVER') OR estado =  Dbo.ST_FnGetIdList('REVON')))
			BEGIN

				EXEC Dbo.ST_MOVCargarExistencia @Opcion = 'R', @id = @id, @id_user = @id_user, @id_bodega = 0;
												 
				INSERT INTO [dbo].[MOVEntradas] (id_tipodoc, id_centrocostos,id_bodega ,fechadocumen,id_formaPagos ,id_proveedor,fechafactura,fechavence,numfactura,diasvence,estado, costo,iva,inc,descuento,flete,valor,id_pedido,poriva,reteiva,porica,reteica,porfuente,retefuente,id_proveflete,prorratea,tipoprorrateo,id_orden,id_formapagoflete,id_ctaant,valoranticipo, id_reversion, id_user)
				SELECT	id_tipodoc, 
						id_centrocostos, 
						id_bodega,
						GETDATE(), 
						id_formaPagos,
						id_proveedor,
						fechafactura,
						fechavence,
						numfactura,
						diasvence,
						Dbo.ST_FnGetIdList('REVON'), 
						costo,
						iva,
						inc,
						descuento,
						flete,
						valor,
						id_pedido,
						poriva,
						reteiva,
						porica,
						reteica,
						porfuente,
						retefuente,
						id_proveflete,
						prorratea,
						tipoprorrateo,
						id_orden,
						id_formapagoflete,
						id_ctaant,
						valoranticipo,					
						@id id_reversion,
						@id_user
				FROM [dbo].[MOVEntradas] WHERE id = @id;

				SET @id_return = SCOPE_IDENTITY();
		
				IF ISNULL(@id_return, 0) <> 0
				BEGIN
		
					UPDATE [dbo].[MOVEntradas] SET id_reversion = @id_return, estado = Dbo.ST_FnGetIdList('REVER') Where id = @id;

			
					SELECT @id_return id, 'PROCESADO' estado,'CNT.VW_TRANSACIONES_ENTRADAS' nombreview,@fechadoc fecha,@anomes anomes,@id_user id_user,@id idrev;
					
				END
				ELSE
				BEGIN
					SET @Mensaje = 'No se genero el documento de reversi�n';
					RAISERROR(@Mensaje,16,0);
				END
			END
			ELSE
				RAISERROR('El documento de compra ya ha sido revertido, verifique...',16,0);
		END
		ELSE		
		BEGIN
			SELECT TOP 1 @mensaje = 'El producto ' + nombre +' no tiene existencias para revertir.' 
			FROM Dbo.Productos WHERE id = @id_articulo; 
			RAISERROR(@mensaje, 16, 0)
		END	

COMMIT TRANSACTION;
END TRY
BEGIN CATCH	
	ROLLBACK TRANSACTION;
	
	SET @Mensaje = 'Error: '+ERROR_MESSAGE();
	RAISERROR(@Mensaje,16,0);	
END CATCH
GO
