--liquibase formatted sql
--changeset ,jteheran:3 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[ST_MOVSaldoProveedor]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [CNT].[ST_MOVSaldoProveedor]
GO



CREATE PROCEDURE [CNT].[ST_MOVSaldoProveedor]
@Opcion VARCHAR(5),
@id BIGINT,
@id_proveedor BIGINT,
@tipo CHAR,
@pago NUMERIC (18,2),
@id_Pagoprov INT,
@id_user INT,
@anomes VARCHAR(6),
@nroFactura VARCHAR(50) =NULL
--WITH ENCRYPTION

/***************************************
*Nombre:		[CNT].[ST_MOVSaldoProveedor]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		20/07/2020
*Desarrollador: (Jeteme)

SP actualiza saldo de Proveedor 
***************************************/
AS	
Declare @id_saldoprov BIGINT,@saldoActual Numeric(18,2),@id_cuenta BIGINT;
BEGIN TRY	
	IF @Opcion = 'I'
	BEGIN


	SET @id_cuenta= IIF(@tipo='E',(SELECT F.id_cuenta from MOVEntradas E INNER JOIN FormaPagos F ON E.id_formaPagos=F.id AND E.id=@id),(SELECT F.id_cuenta from MOVEntradas E INNER JOIN FormaPagos F ON E.id_formapagoflete=F.id AND E.id=@id))
	
	IF NOT EXISTS(SELECT 1 FROM CNT.SaldoProveedor WHERE id_proveedor=@id_proveedor and nrofactura=@nroFactura and anomes=@anomes and id_nota is NULL)
	BEGIN	
		INSERT INTO CNT.SaldoProveedor (anomes,id_proveedor,id_documento,fechaactual,fechavencimiento,nrofactura,saldoanterior,movDebito,movCredito,saldoActual,id_cuenta,id_user)
		(SELECT  @anomes,
				 @id_proveedor,
				 @id,
				 AT.fechadocumen,
				 AT.fechavence,
				 AT.numfactura,
				 0,
				 0,
				  CASE WHEN (@tipo='E' ) THEN IIF(AT.id_proveflete is NULL,AT.valor-AT.valoranticipo,AT.valor-AT.flete-AT.valoranticipo) ELSE (AT.flete) END,
				  (CASE WHEN (@tipo='E' ) THEN IIF(AT.id_proveflete is NULL,AT.valor-AT.valoranticipo,AT.valor-AT.flete-AT.valoranticipo) ELSE (AT.flete) END)*-1,
				 @id_cuenta,
				 @id_user
		FROM [dbo].[MOVEntradas] AT WHERE  AT.id = @id ) ;

		
		END
		
		ELSE
		Begin 
			SET @id_saldoprov=(SELECT id from CNT.SaldoProveedor where id_documento=@id and id_proveedor=@id_proveedor and anomes=@anomes and id_nota is NULL)
			IF((SELECT saldoactual*-1 FROM CNT.SaldoProveedor WHERE id=@id_saldoprov)<@pago)
			RAISERROR('Valor a pagar es mayor a la deuda',16,0);
			
			UPDATE E SET
						E.updated	= GETDATE(),
						E.movDebito= E.movDebito+@pago,
						E.saldoActual= E.saldoanterior+((E.movDebito+@pago)-E.movCredito),
						E.id_user	=  @id_user,
						E.before	= E.changed,
						E.changed=0
			FROM CNT.saldoProveedor E 
			WHERE id=@id_saldoprov

			UPDATE M SET M.estado=Dbo.ST_FnGetIdList('CANCELADO')

			FROM dbo.MOVEntradas M Inner join Cnt.SaldoProveedor S on S.id_documento=M.id
			Where S.saldoActual=0 and S.id_documento=@id and S.anomes=@anomes

		End
		
	END
	 ELSE IF @Opcion = 'R' --Opcion para revertir un comprobante de egresos
	  BEGIN	

	   SET @id_saldoprov=(SELECT id from CNT.SaldoProveedor where id_documento=@id and id_proveedor=@id_proveedor and anomes=@anomes and id_nota is NULL)
	   SET @saldoActual =(SELECT saldoActual FROM CNT.SaldoProveedor WHERE ID=@id_saldoprov)
	  
		UPDATE E SET
						E.updated	= GETDATE(),
						E.movDebito= E.movDebito-@pago,
						E.saldoActual= E.saldoanterior+((E.movDebito-@pago)-E.movCredito),
						E.id_user	=  @id_user,
						E.before	= E.changed,
						E.changed   = E.before
					FROM CNT.saldoProveedor E 
					WHERE id=@id_saldoprov

				IF(@saldoActual=0)
				UPDATE M SET M.estado=Dbo.ST_FnGetIdList('PROCE')
						FROM dbo.MOVEntradas M Inner join Cnt.SaldoProveedor S on S.id_documento=M.id
						Where S.id_documento=@id and anomes=@anomes


	END
	ELSE IF @Opcion = 'ER'--Actualizacion de saldo proveedor cuando se revierte una compra
	BEGIN
		 SET @id_saldoprov=(SELECT id from CNT.SaldoProveedor where id_documento=@id and id_proveedor=@id_proveedor and anomes=@anomes and id_nota is NULL)
		
	
		 UPDATE E SET
								E.updated	    =    GETDATE(),
								E.movCredito    =  E.movCredito-@pago,
								E.saldoActual   =  E.saldoanterior+E.movDebito-(E.movCredito-@pago),
								E.id_user	    =  @id_user,
								E.before        =  E.changed,
								E.changed       =  0
					FROM CNT.saldoProveedor E 
					WHERE id=@id_saldoprov
		
		
	END
	ELSE IF @Opcion = 'DI'--Actualizacion de saldo proveedor cuando se hace una devolucion de compras o se revierte una compra
	BEGIN
		 SET @id_saldoprov=(SELECT id from CNT.SaldoProveedor where id_documento=@id and id_proveedor=@id_proveedor and anomes=@anomes and id_nota is NULL)
		
	
		 UPDATE E SET
								E.updated	   =    GETDATE(),
								E.movDebito    =  E.movDebito+@pago,
								E.saldoActual  =  E.saldoanterior+(E.movDebito+@pago)-E.movCredito,
								E.id_user	   =  @id_user,
								E.before       =  E.changed,
								E.changed      =  0
					FROM CNT.saldoProveedor E 
					WHERE id=@id_saldoprov
		
		
	END
	ELSE IF @Opcion = 'RDI'--Actualizacion de saldo proveedor cuando se hace una reversion devolucion de compras
	BEGIN
		 SET @id_saldoprov=(SELECT id from CNT.SaldoProveedor where id_documento=@id and id_proveedor=@id_proveedor and anomes=@anomes and id_nota is NULL)
		 SET @saldoActual =(SELECT saldoActual FROM CNT.SaldoProveedor WHERE ID=@id_saldoprov)
		 
		 UPDATE E SET
								E.updated	= GETDATE(),
								E.movDebito= E.movDebito-@pago,
								E.saldoActual= E.saldoanterior+E.movDebito-@pago-E.movCredito,
								E.id_user	=  @id_user,
								E.changed   = E.before
					FROM CNT.saldoProveedor E 
					WHERE id=@id_saldoprov
		
		
	END
END TRY
BEGIN CATCH
	DECLARE @Mensajee varchar(max) = (select ERROR_MESSAGE())
	RAISERROR(@Mensajee,16,0);
END CATCH
GO


