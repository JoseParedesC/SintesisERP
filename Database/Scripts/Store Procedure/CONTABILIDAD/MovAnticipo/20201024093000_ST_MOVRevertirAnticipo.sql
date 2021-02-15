--liquibase formatted sql
--changeset ,jteheran:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_MOVRevertirAnticipo]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_MOVRevertirAnticipo]
GO
CREATE PROCEDURE [dbo].[ST_MOVRevertirAnticipo]
@id BIGINT = 0,
@id_user INT

--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[Dbo].[ST_MOVRevertirAnticipo]
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		24/10/2020
*Desarrollador:  Jeteheran
*Descripcion:	Se realizan EL PROCESO DE REVERTIR EL ANTICIPO.
***************************************/
Declare @id_return INT;
Declare @Mensaje varchar(max), @valor NUMERIC(18,2) = 0, @id_cliente BIGINT, @anomes VARCHAR(6), @id_saldo BIGINT = 0,@fechadoc VARCHAR(10),@fecha SMALLDATETIME;

BEGIN TRANSACTION
BEGIN TRY
			SELECT @fecha=fecha FROM dbo.MOVAnticipos WHERE id=@id;
			SET @fechadoc = CONVERT(VARCHAR(10),   @fecha, 120);
			SET @anomes   = CONVERT(VARCHAR(6),    @fecha, 112);	

		EXECUTE [Dbo].ST_ValidarPeriodo
					@fecha			= @fechadoc,
					@anomes			= @anomes,
					@mod			= 'C'



		SELECT TOP 1 @id_saldo = S.id FROM CNT.SaldoTercero S INNER JOIN MOvanticipos A ON A.id_tercero = S.id_tercero AND A.id_cuenta = S.id_cuenta
		WHERE S.anomes = @anomes  AND A.id = @id;

		IF (ISNULL(@id_saldo, 0) = 0)
			RAISERROR('El cliente no tiene saldo de anticipo en el periodo actual', 16, 0);

		IF NOT EXISTS (SELECT 1 FROM Dbo.[MOVAnticipos] WHERE id = @id AND (estado = Dbo.ST_FnGetIdList('REVER') OR estado =  Dbo.ST_FnGetIdList('REVON')))
		BEGIN			

			SELECT @valor = valor FROM Dbo.[MOVAnticipos] WHERE id = @id
			
			IF (ISNULL(@valor, 0) = 0)
				RAISERROR('Verifique el valor del anticipo a revertir.', 16, 0);

			INSERT INTO [dbo].[MOVAnticipos](id_tipodoc, id_centrocostos, fecha, id_tercero, id_cuenta, descripcion, valor, id_formapago,id_tipoanticipo ,id_reversion,estado, id_user, voucher)				
			SELECT id_tipodoc, id_centrocostos, GETDATE(), id_tercero, id_cuenta, 'REVERSI�N: '+ CHAR(13)+ CHAR(10) +descripcion, valor, id_formapago,id_tipoanticipo ,@id, Dbo.ST_FnGetIdList('REVON'), @id_user, voucher 
			FROM [dbo].[MOVAnticipos] Where id = @id;				

			SET @id_return =  SCOPE_IDENTITY();

			--UPDATE CNT.SaldoTercero SET Movdebito -= @valor, saldoactual -= @valor,changed=0  WHERE id = @id_saldo and anomes=@anomes;

			UPDATE [dbo].[MOVAnticipos] SET estado = Dbo.ST_FnGetIdList('REVER'), updated = GETDATE(), id_reversion = @id_return WHERE id = @id;
								
			UPDATE [CNT].[TRANSACCIONES] SET ESTADO=Dbo.ST_FnGetIdList('REVER') WHERE nrodocumento=@id and tipodocumento='AN' AND anomes=@anomes
			EXEC CNT.ST_MOVSaldoCuenta @opcion='R',@id=@id,@id_user=@id_user,@nombreView='CNT.VW_TRANSACIONES_ANTICIPOS',@tipodocumento='AN',@anomes=@anomes
		    EXEC CNT.ST_MOVSaldoCuenta @opcion='R',@id=@id,@id_user=@id_user,@nombreView='CNT.VW_TRANSACIONES_ANTICIPOS',@tipodocumento='AN'
			EXEC [CNT].[ST_MOVRecalculoSaldo] @saldo='TERCERO',@anomes=@anomes;

			SELECT @id_return id, 'REVERSION' estado
		END
		ELSE
			RAISERROR('Este anticipo ya esta revertido, verifique...',16,0);

		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH	
		ROLLBACK TRANSACTION;
		SET @Mensaje = 'Error: '+ERROR_MESSAGE();
		RAISERROR(@Mensaje,16,0);	
	END CATCH
GO


