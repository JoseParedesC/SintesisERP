--liquibase formatted sql
--changeset ,jteheran:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_MOVRevertirDevAnticipo]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [dbo].[ST_MOVRevertirDevAnticipo]
GO
CREATE PROCEDURE [dbo].[ST_MOVRevertirDevAnticipo]
@id BIGINT = 0,
@id_user INT

--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[Dbo].[ST_MOVRevertirDevAnticipo]
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		24/10/2020
*Desarrollador:  JeTeheran
*Descripcion:	Se realizan EL PROCESO DE REVERTIR EL TRASLADO.
***************************************/
Declare @id_return INT;
Declare @Mensaje varchar(max);
Declare @valor NUMERIC(18,2) = 0, @anomes VARCHAR(6), @id_cliente BIGINT,@id_cta BIGINT,@fechadoc VARCHAR(10),@fecha SMALLDATETIME;
BEGIN TRANSACTION
BEGIN TRY
			SET @fecha    = (SELECT fecha FROM MOVDevAnticipos WHERE id=@id)
			SET @fechadoc = CONVERT(VARCHAR(10), @fecha, 120);
			SET @anomes   = CONVERT(VARCHAR(6), @fecha, 112);	

		EXECUTE [Dbo].ST_ValidarPeriodo
					@fecha			= @fechadoc,
					@anomes			= @anomes,
					@mod			= 'C'

		IF NOT EXISTS (SELECT 1 FROM Dbo.[MOVDevAnticipos] WHERE id = @id AND (estado = Dbo.ST_FnGetIdList('REVER') OR estado =  Dbo.ST_FnGetIdList('REVON')))
		BEGIN

			SELECT @valor = valor,  @id_cliente = id_tercero,@id_cta=id_cta FROM Dbo.[VW_MOVDevAnticipos] WHERE id = @id
			
			IF @valor IS NULL
				RAISERROR('Verifique el valor del anticipo a revertir.', 16, 0);

			
			INSERT INTO [dbo].[MOVDevAnticipos](estado, fecha, descripcion, valor, id_cliente,  id_user, id_reversion,id_tipodoc,id_centrocostos,id_cta,id_formapago)
			SELECT Dbo.ST_FnGetIdList('REVON'), fecha, 'Reversi�n: '+descripcion, valor, id_cliente,  @id_user, @id,id_tipodoc,id_centrocostos,id_cta,id_formapago
			FROM [dbo].[MOVDevAnticipos] Where id = @id;
				
			SET @id_return =  SCOPE_IDENTITY();

			UPDATE [dbo].[MOVDevAnticipos] SET estado = Dbo.ST_FnGetIdList('REVER'), updated = GETDATE(), id_reversion = @id_return WHERE id = @id;
				
			UPDATE CNT.SaldoTercero
			SET movcredito   = movcredito - @valor,
				 saldoactual = saldoanterior+movdebito-(movcredito-@valor),
				 updated = GETDATE(),
				 changed = 0 
			WHERE 
				id_tercero = @id_cliente AND anomes = @anomes AND id_cuenta=@id_cta;


			UPDATE [CNT].[TRANSACCIONES] SET ESTADO=Dbo.ST_FnGetIdList('REVER') WHERE nrodocumento=@id and tipodocumento='DA' and anomes=@anomes
		    EXEC CNT.ST_MOVSaldoCuenta @opcion='R',@id=@id,@id_user=@id_user,@nombreView='CNT.VW_TRANSACIONES_DEVANTICIPOS',@tipodocumento='DA'
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
