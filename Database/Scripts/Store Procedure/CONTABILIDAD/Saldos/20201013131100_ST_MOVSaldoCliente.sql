--liquibase formatted sql
--changeset ,jteheran:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[ST_MOVSaldoCliente]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [CNT].[ST_MOVSaldoCliente]   
GO
CREATE PROCEDURE [CNT].[ST_MOVSaldoCliente]
@Opcion VARCHAR(5),
@id BIGINT,
@anomes VARCHAR(6),
@id_cliente BIGINT,
@pago NUMERIC (18,2),
@totalcredito NUMERIC(18,2),
@id_user INT,
@consecutivo VARCHAR(50)=NULL,
@id_saldocli BIGINT =NULL OUTPUT,
@nroFactura VARCHAR(50)=NULL OUTPUT,
@id_cuenta BIGINT =NULL OUTPUT
--WITH ENCRYPTION
/***************************************
*Nombre:		[CNT].[ST_MOVSaldoCliente]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		20/07/2020
*Desarrollador: (Jeteme)

SP actualiza saldo de clientes 
***************************************/
AS	
Declare @saldoActual Numeric(18,2),@valortotal NUMERIC(18,2);
BEGIN TRY
		
		
	IF @Opcion = 'I'
	BEGIN
	SET @nroFactura=(select  prefijo+'-'+CONVERT(VARCHAR,consecutivo) from dbo.MOVFactura where id=@id)

	SET @valortotal=IIF((@totalcredito=0),(SELECT total FROM [dbo].[MOVFactura] AT WHERE  AT.id = @id ),@totalcredito)
		
	IF(@consecutivo IS NOT NULL)
	SET @id=(SELECT id_documento from CNT.SaldoCliente WHERE id_cliente=@id_cliente AND nrofactura=@consecutivo and anomes=@anomes and id_nota is null and saldoActual!=0)

	SELECT @id_cuenta =FP.codcuenta from FormaPagos F inner join ST_Listados S ON F.id_tipo=S.id INNER JOIN movfacturaFormapago FP ON F.id=FP.id_formapago and FP.id_factura=@id  where S.nombre='Cartera cliente'
	
	IF NOT EXISTS(SELECT 1 FROM CNT.SaldoCliente WHERE id_cliente=@id_cliente and id_documento=@id and anomes=@anomes and id_nota is null)
	BEGIN	
		INSERT INTO CNT.SaldoCliente (anomes,id_cliente,id_documento,fechaactual,fechavencimiento,nrofactura,saldoanterior,movDebito,movCredito,saldoActual,id_cuenta,id_user)
		(SELECT  @anomes,
				 @id_cliente,
				 @id,
				 AT.fechafac,
				 AT.fechafac,
				 @nroFactura,
				 0,
				 @valortotal, 
				 0,
				 @valortotal,
				 @id_cuenta,
				 @id_user
		FROM [dbo].[MOVFactura] AT WHERE  AT.id = @id ) ;
		SET @id_saldocli = SCOPE_IDENTITY();
		END
		ELSE
		Begin 
		
			SET @id_saldocli=(SELECT id from CNT.SaldoCliente where nrofactura=@consecutivo and id_cliente=@id_cliente and anomes=@anomes and id_nota is null and saldoActual !=0)

			IF((select saldoactual from CNT.SaldoCliente where id=@id_saldocli)<@pago)
			RAISERROR('Valor a pagar es mayor a la deuda',16,0);

			UPDATE E SET
						E.updated	= GETDATE(),
						E.movCredito= E.movCredito+@pago,
						E.saldoActual= ((E.saldoAnterior+E.movdebito)-(E.movCredito+@pago)),
						E.id_user	=  @id_user,
						E.before	= E.changed,
						E.changed   = 0
			FROM CNT.SaldoCliente E 
			WHERE id=@id_saldocli

			UPDATE M SET M.estado=Dbo.ST_FnGetIdList('CANCELADO')

			FROM dbo.MOVFactura M LEFT join Cnt.SaldoCliente S on S.id_documento=M.id
			Where S.saldoActual=0 and S.nrofactura=@consecutivo
			 
			
		End
		
	END
	 ELSE IF @Opcion = 'R'--Revertir recibo de cajas
	  BEGIN	
	  
					
	  SET @id_saldocli=(SELECT id from CNT.SaldoCliente where nrofactura=@consecutivo and id_cliente=@id_cliente and anomes=@anomes and id_nota is null )
	  SET @saldoActual =(SELECT saldoActual FROM CNT.SaldoCliente WHERE ID=@id_saldocli)

		UPDATE E SET
								E.updated	= GETDATE(),
								E.movCredito= E.movCredito-@pago,
								E.saldoActual= E.saldoActual+@pago,
								E.id_user	=  @id_user,
								E.changed   = E.before
					FROM CNT.saldocliente E 
					WHERE id=@id_saldocli
	IF(@saldoActual=0)
	UPDATE M SET M.estado=Dbo.ST_FnGetIdList('PROCE')
			FROM dbo.MOVFactura M Inner join Cnt.SaldoCliente S on S.id_documento=M.id
			Where S.nrofactura=@consecutivo

	END
	ELSE IF @Opcion = 'DV'
	BEGIN
		 SET @id_saldocli=(SELECT id from CNT.Saldocliente where id_documento=@id and id_cliente=@id_cliente and anomes=@anomes and id_nota is null and saldoActual !=0)
		 SET @saldoActual =(SELECT saldoActual FROM CNT.Saldocliente WHERE ID=@id_saldocli)
		
		 UPDATE E SET
								E.updated	= GETDATE(),
								E.movCredito= E.movCredito+@pago,
								E.saldoActual= E.saldoActual-@pago,
								E.id_user	=  @id_user
					FROM CNT.saldoCliente E 
					WHERE id=@id_saldocli
		
		
	END
	ELSE IF @Opcion = 'RDV'
	BEGIN
		 SET @id_saldocli=(SELECT id from CNT.Saldocliente where id_documento=@id and id_cliente=@id_cliente and anomes=@anomes and id_nota is null and saldoActual !=0)
		 SET @saldoActual =(SELECT saldoActual FROM CNT.Saldocliente WHERE ID=@id_saldocli)
		 
		 UPDATE E SET
								E.updated	= GETDATE(),
								E.movCredito= E.movCredito-@pago,
								E.saldoActual= E.saldoActual+@pago,
								E.id_user	=  @id_user
					FROM CNT.Saldocliente E 
					WHERE id=@id_saldocli
		
		
	END
END TRY
BEGIN CATCH
	DECLARE @Mensajee varchar(max) = (select ERROR_MESSAGE())
	RAISERROR(@Mensajee,16,0);
END CATCH
