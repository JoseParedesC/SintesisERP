--liquibase formatted sql
--changeset ,kmartinez:3 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[FIN].[RevertirRecaudoCartera]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [FIN].[RevertirRecaudoCartera]
GO

CREATE PROCEDURE [FIN].[RevertirRecaudoCartera]
@id BIGINT = 0,
@id_user INT
 
AS
/***************************************
*Nombre:		[FIN].[MOVRevertirRecaudoCartera]
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		07/12/2020
*Desarrollador:  Kmartinez
*Descripcion:	Se realizan EL PROCESO DE Revertir los Recaudo Cartera
***************************************/
DECLARE @tabla TABLE(id int identity(1,1), factura varchar(30), valor NUMERIC(18,2), valorfin NUMERIC(18,2));
DECLARE @id_return INT, @Contabilizar BIT,@id_orden INT=NULL,@fechadoc VARCHAR(10),@anomes VARCHAR(6), @idfactura varchar(30);
DECLARE @rows int = 0,@countt INT=1, @pago NUMERIC(18,2), @pagofin NUMERIC(18,2), @id_cliente BIGINT, @id_factura VARCHAR(30),@Mensaje varchar(max);

BEGIN TRANSACTION
BEGIN TRY

	 SELECT  @fechadoc = CONVERT(VARCHAR(10), fecha, 120), @anomes=CONVERT(VARCHAR(10), fecha, 112) FROM FIN.Recaudocartera WHERE id = @id;

	 EXECUTE [Dbo].ST_ValidarPeriodo
	     	 @fecha			= @fechadoc,
			 @anomes		= @anomes,
			 @mod			= 'C';

	SELECT @idfactura = id_factura  FROM FIN.RecaudocarteraItems WHERE id_recibo = @id

	IF EXISTS(SELECT 1 FROM [FIN].[SaldoCliente_Cuotas] S INNER JOIN  [FIN].[RefinanciacionItems] R ON S.cuota = R.cuota AND S.numfactura = R.numfactura AND S.anomes = @anomes
				 WHERE R.new = 1  AND S.id_refinanciado is null AND S.estado = 0 AND S.cancelada > 0 AND S.abono != 0 AND  S.numfactura = @idfactura)
				   RAISERROR('No se puede realizar la reversion, esta factura fue refinanciada', 16,2)

		
	IF NOT EXISTS (SELECT 1 FROM FIN.Recaudocartera WHERE id = @id AND (estado = Dbo.ST_FnGetIdList('REVER') OR estado =  Dbo.ST_FnGetIdList('REVON')))
	BEGIN
		INSERT INTO FIN.Recaudocartera (id_tipodoc,id_centrocostos,fecha,id_cliente,valorcliente,valorconcepto,id_conceptoDescuento,valorDescuento,detalle,cambio,estado,id_reversion,id_usercreated,id_userupdated)
		SELECT id_tipodoc,id_centrocostos,GETDATE(),id_cliente, valorcliente,valorconcepto,id_conceptoDescuento,valorDescuento,detalle,cambio,Dbo.ST_FnGetIdList('REVON'),  @id, @id_user,@id_user
		FROM FIN.Recaudocartera WHERE id = @id;

		SET @id_return = SCOPE_IDENTITY();
		
		IF ISNULL(@id_return, 0) <> 0
		BEGIN
			UPDATE FIN.Recaudocartera SET id_reversion = @id_return, estado = Dbo.ST_FnGetIdList('REVER') Where id = @id;

			INSERT INTO @tabla(factura, valor, valorfin) 
			SELECT id_factura, SUM(PagoCuota -  ValorServicios), SUM(PagoCuota) 
			FROM FIN.RecaudocarteraItems WHERE id_recibo = @id
			GROUP BY id_factura

			SET @rows = @@rowcount;
			
			SELECT @id_cliente = RC.id_cliente FROM  FIN.RecaudocarteraItems I INNER JOIN FIN.Recaudocartera  RC ON I.id_recibo=RC.id  WHERE I.id_recibo = @id
		
			UPDATE S SET
					S.cancelada		= 0,
					S.abono			= S.abono - (R.pagoCuota - R.valorServicios),
					S.diasmora		= S.diasmora - R.dias_interes_pagadoMora,
					S.AbonoInteres	= S.AbonoInteres - R.interesCorriente,
					S.abonoFianza	= S.abonoFianza - R.valorServicios,
					S.AbonoIntMora	= S.AbonoIntMora - R.InteresMora
			FROM   [FIN].[SaldoCliente_Cuotas] S INNER JOIN 
					FIN.RecaudocarteraItems R ON S.cuota = R.cuota AND anomes = @anomes AND S.numfactura = R.id_factura AND S.id_tercero = @id_cliente
			WHERE R.id_recibo = @id  ;

			UPDATE S SET
					S.cancelada		= 0,
					S.movCredito	=  S.movCredito - (R.pagoCuota - R.valorServicios),
					S.saldoActual	= S.saldoAnterior + S.movdebito - (S.movCredito - (R.pagoCuota - R.valorServicios)),
					S.updated		= GETDATE()
			FROM   [CNT].[SaldoCliente_Cuotas] S INNER JOIN 
					FIN.RecaudocarteraItems R ON S.cuota = R.cuota AND anomes = @anomes AND S.nrofactura = R.id_factura AND S.id_cliente = @id_cliente
			WHERE R.id_recibo = @id  ;

			WHILE(@countt <= @rows)
			BEGIN
				SELECT @pago = valor, @id_factura = factura, @pagofin = valorfin FROM @tabla WHERE id = @countt;

				EXEC [FIN].[SaldoClientes] @Opcion='R', @id_cliente = @id_cliente, @pago = @pago, @id_user = @id_user, @numfactura = @id_factura, @anomes = @anomes, @pagofin = @pagofin;
				 					
				SET @countt += 1;
 
			END
		  
			UPDATE [CNT].[TRANSACCIONES] SET ESTADO = Dbo.ST_FnGetIdList('REVER') WHERE nrodocumento = @id AND tipodocumento = 'RF' AND anomes = @anomes
	   		    
			EXEC [CNT].[ST_MOVSaldoCuenta]     @opcion = 'R', @id = @id, @id_user = @id_user, @nombreView = '[CNT].[VW_TRANSACIONES_RECAUDOCARTERA]' , @tipodocumento = 'RC', @anomes=@anomes

	   		EXEC [CNT].[ST_MOVSaldoTerceronew] @opcion = 'R', @id = @id, @id_user = @id_user, @nombreView = '[CNT].[VW_TRANSACIONES_RECAUDOCARTERA]', @tipodocumento = 'RC', @anomes=@anomes

			SELECT @id_return id, 'REVERSION' estado, @id idrev
		END
		ELSE
			BEGIN
				SET @Mensaje = 'No se genero el documento de reversion';
				RAISERROR(@Mensaje,16,0);
			END
		END
	ELSE
		RAISERROR('Este recaudo cartera ya ha sido revertido, verifique...',16,0);
 COMMIT TRANSACTION;
END TRY
BEGIN CATCH	
	ROLLBACK TRANSACTION;
	SET @Mensaje = 'Error: '+ERROR_MESSAGE();
	RAISERROR(@Mensaje,16,0);	
END CATCH
