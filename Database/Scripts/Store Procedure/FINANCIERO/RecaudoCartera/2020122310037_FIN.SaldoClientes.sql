--liquibase formatted sql
--changeset ,kmartinez:3 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[FIN].[SaldoClientes]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [FIN].[SaldoClientes]
GO

CREATE PROCEDURE [FIN].[SaldoClientes]
@Opcion CHAR(1),
@anomes VARCHAR(10) = null,
@numfactura VARCHAR(30) = '',
@id_cliente BIGINT,
@pago NUMERIC(18,2),
@pagofin NUMERIC(18,2),
@id_user INT
--WITH ENCRYPTION
/***************************************
*Nombre:		[FIN].[SaldoCliente]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		18/11/2020
*Desarrollador: (kmartinez)

SP actualiza saldo de clientes 
***************************************/
AS	
Declare @saldoActual Numeric(18,2),@valortotal NUMERIC(18,2), @id_saldocli BIGINT;
DECLARE @mensaje varchar(max) = '';
 
BEGIN TRY
BEGIN TRANSACTION
		
	IF @Opcion = 'I'
	 BEGIN
		IF NOT EXISTS(SELECT 1 FROM CNT.SaldoCliente WHERE id_cliente = @id_cliente AND nrofactura = @numfactura AND anomes = @anomes)
		BEGIN
			SET @mensaje = 'La factura Nro. '+ @numfactura +' no se ha contabilizado previamente.';
			RAISERROR(@mensaje,16,0)
		END 
		ELSE
		BEGIN 
			UPDATE FIN.SaldoCliente SET
				updated		= GETDATE(),
				movCredito	= (movCredito + @pagofin),
				saldoActual	= (saldoanterior + movDebito - (movCredito+@pago)),
				id_user		= @id_user 
			WHERE id_cliente = @id_cliente AND nrofactura = @numfactura AND anomes = @anomes

			UPDATE CNT.SaldoCliente SET
				updated		= GETDATE(),
				movCredito	= (movCredito + @pago),
				saldoActual	= (saldoanterior + movDebito - (movCredito+@pago)),
				id_user		= @id_user 
			WHERE id_cliente = @id_cliente AND nrofactura = @numfactura AND anomes = @anomes
		END
	END
	ELSE 
	IF @Opcion = 'R'
	BEGIN	

		SET @id_saldocli = (SELECT TOP 1 id FROM FIN.SaldoCliente WHERE nrofactura = @numfactura AND id_cliente = @id_cliente AND anomes = @anomes)	    

		UPDATE FIN.saldocliente SET
			updated		= GETDATE(),
			movCredito	= movCredito - @pagofin,
			saldoActual	= (saldoanterior + movDebito - (movCredito - @pagofin)),
			id_user		= @id_user 
		WHERE id = @id_saldocli

		UPDATE CNT.SaldoCliente SET
				updated		= GETDATE(),
				movCredito	= (movCredito - @pago),
				saldoActual	= (saldoanterior + movDebito - (movCredito - @pago)),
				id_user		= @id_user 
		WHERE id_cliente = @id_cliente AND nrofactura = @numfactura AND anomes = @anomes
	END
COMMIT TRANSACTION
END TRY
BEGIN CATCH
	set @mensaje = ERROR_MESSAGE();
	RAISERROR(@Mensaje,16,0);
	ROLLBACK TRANSACTION
END CATCH