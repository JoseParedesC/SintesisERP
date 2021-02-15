--liquibase formatted sql
--changeset ,jteheran:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[ST_MOVSaldoTercero]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [CNT].[ST_MOVSaldoTercero]
GO




CREATE PROCEDURE [CNT].[ST_MOVSaldoTercero]
@Opcion VARCHAR(5),
@id_tercero BIGINT,
@id_cuenta BIGINT,
@fecha VARCHAR(10),
@valor NUMERIC (18,2),
@id_user INT,
@anomes VARCHAR(6)
--WITH ENCRYPTION

/***************************************
*Nombre:		[CNT].[ST_MOVSaldoTercero]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		24/10/2020
*Desarrollador: (Jeteme)

SP actualiza saldo de tercero 
***************************************/
AS	
Declare @id_saldo BIGINT;
BEGIN TRY
	
	IF @Opcion = 'I'
	BEGIN

		IF NOT EXISTS(SELECT 1 FROM CNT.SaldoTercero WHERE id_tercero=@id_tercero and id_cuenta=@id_cuenta and  anomes=@anomes)
		BEGIN	
			INSERT INTO CNT.SaldoTercero (anomes,id_tercero,fechaactual,saldoanterior,movDebito,movCredito,saldoActual,id_cuenta,id_user)
			(SELECT  @anomes,
					 @id_tercero,
					 @fecha,
					 0,
					 IIF(@valor>0,@valor,0), 
					 IIF(@valor>0,0,@valor*-1),
					 IIF(@valor>0,@valor,0)-(IIF(@valor>0,0,@valor*-1)),
					 @id_cuenta,
					 @id_user)
		END
		ELSE
		BEGIN 
			SET @id_saldo=(SELECT id from CNT.SaldoTercero where id_tercero=@id_tercero and id_cuenta=@id_cuenta and  anomes=@anomes)
			UPDATE CNT.SaldoTercero   SET
						updated	= GETDATE(),
						movDebito=   movDebito + (IIF(@valor>0,@valor,0)),
						movCredito=  movCredito+(IIF(@valor>0,0,@valor)*-1),
						saldoActual= (movDebito+IIF(@valor>0,@valor,0))-(movCredito+(IIF(@valor>0,0,@valor)*-1)),
						id_user	=  @id_user,
						before	=  changed,
						changed =  0
			WHERE id=@id_saldo
		END
	END
	 ELSE IF @Opcion = 'R' --Opcion para revertir un comprobante de Contable
	  BEGIN	
	  SET @id_saldo=(SELECT id from CNT.SaldoTercero where id_tercero=@id_tercero and id_cuenta=@id_cuenta and  anomes=@anomes)
		UPDATE E SET
								E.updated	  = GETDATE(),
								E.movDebito   =E.movDebito - (IIF(@valor>0,@valor,0)),
								E.movCredito  =E.movCredito - (IIF(@valor>0,0,@valor)*-1),
								E.saldoActual =E.saldoActual - @valor,
								E.id_user	=  @id_user,
								E.changed	 =E.before
					FROM CNT.SaldoTercero E  
					WHERE E.id=@id_saldo
	END															
	
END TRY
BEGIN CATCH
	DECLARE @Mensajee varchar(max) = (select ERROR_MESSAGE())
	RAISERROR(@Mensajee,16,0);
END CATCH






GO


