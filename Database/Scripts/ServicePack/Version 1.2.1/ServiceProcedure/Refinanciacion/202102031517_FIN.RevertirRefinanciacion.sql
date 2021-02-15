--liquibase formatted sql
--changeset ,kmartinez:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[FIN].[RevertirRefinanciacion]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [FIN].[RevertirRefinanciacion]
GO

CREATE PROCEDURE [FIN].[RevertirRefinanciacion]
@id BIGINT = 0,
@id_user INT
 
AS
/***************************************
*Nombre:		[FIN].[RevertirRefinanciacion]
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		26/01/2021
*Desarrollador:  Kmartinez
*Descripcion:	Se realizan EL PROCESO DE Revertir la refinanciacion
***************************************/
DECLARE @tabla TABLE(id int identity(1,1), factura varchar(30), valor NUMERIC(18,2), valorfin NUMERIC(18,2));
DECLARE @id_return INT, @Contabilizar BIT, @id_orden INT=NULL, @fechadoc VARCHAR(10), @anomes VARCHAR(6), @numfactura varchar(50) , @id_sald BIGINT, @totalcredito NUMERIC(18,2);
DECLARE @rows int = 0,@countt INT=1, @pago NUMERIC(18,2), @pagofin NUMERIC(18,2), @id_cliente BIGINT, @id_factura VARCHAR(30),@Mensaje varchar(max);

BEGIN TRANSACTION
BEGIN TRY

	 SELECT @id_cliente = I.id_cliente, @numfactura = I.numfactura, @id_factura = id_factura, @totalcredito=totalcredito FROM  [FIN].[RefinanciacionFact] I where id = @id;
	 SELECT @id_sald = id FROM [FIN].[SaldoCliente] WHERE id_cliente=@id_cliente and id_documento=@id_factura AND nrofactura = @numfactura
	 SELECT  @fechadoc = CONVERT(VARCHAR(10), fechadoc, 120), @anomes=CONVERT(VARCHAR(10), fechaDOC, 112) FROM FIN.RefinanciacionFact WHERE id = @id;
 

	 EXECUTE [Dbo].ST_ValidarPeriodo
	     	 @fecha			= @fechadoc,
			 @anomes		= @anomes,
			 @mod			= 'C';
		
	IF EXISTS(SELECT 1 FROM [FIN].[SaldoCliente_Cuotas] S INNER JOIN  [FIN].[RefinanciacionItems] R ON S.cuota = R.cuota AND S.numfactura = R.numfactura AND S.anomes = @anomes
				 WHERE S.id_saldo = @id_sald AND  R.new = 0  AND S.id_refinanciado != 0 AND S.estado != 0 AND S.cancelada > 0 AND S.abono != 0)
				  RAISERROR('No se genero el documento de reversion. esta factura presenta cuotas pagadas', 16,2)

	IF NOT EXISTS (SELECT 1 FROM [FIN].[RefinanciacionFact] WHERE id = @id AND (estado = Dbo.ST_FnGetIdList('REVER') OR estado =  Dbo.ST_FnGetIdList('REVON')))
	BEGIN
		INSERT INTO [FIN].[RefinanciacionFact] (id_tipodoc, id_centrocostos, fechadoc, id_cliente,  id_factura, numfactura, totalcredito, cuotas, formapago, estado, id_reversion, id_user)
		SELECT id_tipodoc, id_centrocostos, GETDATE(), id_cliente, id_factura, numfactura, totalcredito, cuotas, formapago, Dbo.ST_FnGetIdList('REVON'), @id, @id_user
		FROM [FIN].[RefinanciacionFact] WHERE id = @id;

		SET @id_return = SCOPE_IDENTITY();
		
		IF ISNULL(@id_return, 0) <> 0
		BEGIN
			UPDATE [FIN].[RefinanciacionFact] SET id_reversion = @id_return, estado = Dbo.ST_FnGetIdList('REVER') Where id = @id;
			
		
		
			 
			DELETE  S FROM [FIN].[SaldoCliente_Cuotas] S INNER JOIN 
						 [FIN].[RefinanciacionItems] R ON S.cuota = R.cuota AND S.cuota = R.cuota AND S.numfactura = R.numfactura AND S.id_tercero = R.id_cliente
						WHERE	R.new = 0 AND S.cancelada=0 AND R.id_refinan = @id 

			 UPDATE	 S SET 
					 S.cancelada = 0,
					 S.estado = 1
			 FROM [FIN].[SaldoCliente_Cuotas] S INNER JOIN 
				   [FIN].[RefinanciacionItems] R ON S.cuota = R.cuota AND S.cuota = R.cuota AND S.numfactura = R.numfactura AND S.id_tercero = R.id_cliente
						WHERE	R.new = 1 AND S.cancelada=1 AND R.id_refinan = @id 

		 
			 UPDATE	E SET
					E.updated			=   GETDATE(),
					E.fechavencimiento	=   E.fechaactual,
					E.movCredito		=	E.movCredito - E.saldoActual,
					E.movDebito			=	m.totalcredito,
					E.id_user=@id_user 
			 FROM FIN.SaldoCliente E INNER JOIN 
				  MOVFactura m ON E.id_documento=m.id AND E.id_cliente=m.id_tercero AND E.nrofactura = concat(m.prefijo, '-', m.consecutivo)
						WHERE E.id=@id_sald

			 UPDATE	 S SET 
						 S.cancelada = 1
			 FROM [FIN].[SaldoCliente_Cuotas] S INNER JOIN 
				  [FIN].[RefinanciacionItems] R ON S.cuota = R.cuota AND S.cuota = R.cuota AND S.numfactura = R.numfactura AND S.id_tercero = R.id_cliente
						WHERE S.abono > 0 AND R.new = 1 AND S.id_tercero=@id_cliente AND S.numfactura = @numfactura  AND S.id_saldo=@id_sald AND S.cuota = R.cuota
				
			
			UPDATE [CNT].[TRANSACCIONES] SET estado = Dbo.ST_FnGetIdList('REVER') WHERE nrodocumento = @id AND tipodocumento = 'FF' AND anomes = @anomes
			EXEC CNT.ST_MOVSaldos  @opcion='R',@id=@id,@id_user=@id_user,@nombreView='[CNT].[VW_TRANSACIONES_REFINANCIACION]', @tipodocumento = 'FF',@anomes=@anomes
	   		    
			 

			SELECT @id_return id, 'REVERSION' estado, @id idrev
			END ELSE
				BEGIN
					SET @Mensaje = 'No se genero el documento de reversion';
					RAISERROR(@Mensaje,16,0);
				END
		END ELSE
			RAISERROR('Este recaudo cartera ya ha sido revertido, verifique...',16,0);
	
 COMMIT TRANSACTION;
END TRY
BEGIN CATCH	
	ROLLBACK TRANSACTION;
	SET @Mensaje = 'Error: '+ERROR_MESSAGE();
	RAISERROR(@Mensaje,16,0);	
END CATCH
