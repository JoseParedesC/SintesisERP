--liquibase formatted sql
--changeset ,jteheran:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[ST_MOVRevertirReciboCajas]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [CNT].[ST_MOVRevertirReciboCajas]
GO
CREATE PROCEDURE [CNT].[ST_MOVRevertirReciboCajas]
@id BIGINT = 0,
@id_user INT

--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[CNT].[ST_MOVRevertirReciboCajas]
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		24/10/2020
*Desarrollador:  Jeteme
*Descripcion:	Se realizan EL PROCESO DE Revertir los Recibo cajas
***************************************/
DECLARE @tabla TABLE(id int identity(1,1), cuota int,factura varchar(50),id_cliente bigint,pagoCuota NUMERIC(18,2),diasInpagados bit,id_reciboitems bigint);
Declare @id_return INT, @Contabilizar BIT,@id_orden INT=NULL,@fechadoc VARCHAR(10),@anomes VARCHAR(6),@diasInteresPagado int=0,@id_reciboitems bigint;
Declare @rows int = 0,@count INT=1, @cuota BIGINT,@fechainteres smalldatetime,@pagoCuota  NUMERIC(18,2),@id_cliente BIGINT,@id_factura VARCHAR(50),@Mensaje varchar(max);

BEGIN TRANSACTION
BEGIN TRY
		
		SELECT  @fechadoc=CONVERT(VARCHAR(10), fecha, 120),@anomes=CONVERT(VARCHAR(10), fecha, 112) FROM CNT.MOVReciboCajas WHERE id=@id

		EXECUTE [Dbo].ST_ValidarPeriodo
				@fecha			= @fechadoc,
				@anomes			= @anomes,
				@mod			= 'C'
		
		IF NOT EXISTS (SELECT 1 FROM Cnt.MOVReciboCajas WHERE id = @id AND (estado = Dbo.ST_FnGetIdList('REVER') OR estado =  Dbo.ST_FnGetIdList('REVON')))
		BEGIN
			 

			INSERT INTO [CNT].[MOVReciboCajas] (id_tipodoc,id_centrocostos,fecha,id_cliente,valorcliente,valorconcepto,id_conceptoDescuento,valorDescuento,detalle,cambio,estado,id_reversion,id_usercreated,id_userupdated)
			SELECT id_tipodoc,id_centrocostos,GETDATE(),id_cliente, valorcliente,valorconcepto,id_conceptoDescuento,valorDescuento,detalle,cambio,Dbo.ST_FnGetIdList('REVON'),  @id, @id_user,@id_user
			FROM [CNT].MOVReciboCajas WHERE id = @id;

			SET @id_return = SCOPE_IDENTITY();
		
			IF ISNULL(@id_return, 0) <> 0
			BEGIN

				UPDATE [CNT].[MOVReciboCajas] SET id_reversion = @id_return, estado = Dbo.ST_FnGetIdList('REVER') Where id = @id;
		
				INSERT INTO @tabla(cuota,factura,id_cliente,pagoCuota,diasInpagados,id_reciboitems) SELECT cuota,id_factura,id_cliente,I.pagoCuota,I.diasinterespagados,I.id FROM CNT.MOVReciboCajasItems I join cnt.MOVReciboCajas R ON R.id=i.id_recibo WHERE id_recibo=@id
				
				
				SET @rows = @@rowcount;

				WHILE(@rows >= @count)
				BEGIN
					SELECT @cuota     =   cuota, @id_factura=factura,@id_cliente=id_cliente,@pagoCuota=pagoCuota,@diasInteresPagado=diasInpagados,@id_reciboitems=id_reciboitems   FROM  @tabla WHERE id=@count

					
					UPDATE S SET			S.movCredito  -=@pagoCuota,
											S.saldoActual=(S.saldoActual+(@pagoCuota)),
											S.cancelada=0,
											S.changed=S.before
					FROM                   [CNT].[SaldoCliente_Cuotas] S
					WHERE                  S.nrofactura = @id_factura and S.cuota=@cuota and S.anomes=@anomes and S.id_nota is null and S.id_devolucion is null 
				
					EXEC CNT.ST_MOVSaldoCliente  @Opcion='R', @id = 0, @id_cliente = @id_cliente, @pago = @pagoCuota, @totalcredito = 0, @id_user = @id_user,@consecutivo=@id_factura,@anomes=@anomes
					
					if(@diasInteresPagado>0)
						update cnt.MOVReciboCajasItems set pagototalinteres=0 where id_factura=@id_factura and cuota=@cuota and id<@id_reciboitems and id>(SELECT TOP 1 I.id FROM CNT.MOVReciboCajasItems I JOIN CNT.MOVReciboCajas R ON R.id=I.id_recibo  WHERE id_factura=@id_factura and cuota=@cuota AND I.ID<@id_reciboitems AND diasinterespagados>0 and r.estado=dbo.ST_FnGetIdList('PROCE') ORDER BY I.id DESC) and diasinterespagados=0

		
					SET @count += 1;
 
			END
				UPDATE [CNT].[TRANSACCIONES] SET ESTADO=Dbo.ST_FnGetIdList('REVER') WHERE nrodocumento=@id and tipodocumento='RC' and anomes=@anomes
	   		    EXEC [CNT].[ST_MOVSaldoCuenta]     @opcion = 'R', @id = @id, @id_user = @id_user, @nombreView = 'CNT.VW_TRANSACIONES_RECIBOCAJA', @tipodocumento = 'RC', @anomes=@anomes
	   		    EXEC [CNT].[ST_MOVSaldoTerceronew] @opcion = 'R', @id = @id, @id_user = @id_user, @nombreView = 'CNT.VW_TRANSACIONES_RECIBOCAJA', @tipodocumento = 'RC', @anomes=@anomes


				SELECT @id_return id, 'REVERSION' estado, @id idrev
				END
				ELSE
				BEGIN
					SET @Mensaje = 'No se genero el documento de reversi�n';
					RAISERROR(@Mensaje,16,0);
				END
			END
			ELSE
				RAISERROR('Este Recibo de caja ya ha sido revertido, verifique...',16,0);
			COMMIT TRANSACTION;
			END TRY
			BEGIN CATCH	
				ROLLBACK TRANSACTION;
				--DELETE PV.TempArticulos_SpId WHERE SpId =  @@SpId;
				SET @Mensaje = 'Error: '+ERROR_MESSAGE();
				RAISERROR(@Mensaje,16,0);	
			END CATCH