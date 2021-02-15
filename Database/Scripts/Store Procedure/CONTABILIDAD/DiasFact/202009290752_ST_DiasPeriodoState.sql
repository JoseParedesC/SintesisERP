--liquibase formatted sql
--changeset ,jtous:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_DiasPeriodoState]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[ST_DiasPeriodoState]
GO

CREATE PROCEDURE [dbo].[ST_DiasPeriodoState]
@id BIGINT,
@anomes VARCHAR(10),
@mod	CHAR(1),
@id_user INT
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[Dbo].[ST_DiasPeriodoState]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		09/04/17
*Desarrollador: (JTOUS)
***************************************/
Declare @ds_error Varchar(Max), @periodoant VARCHAR(10) = '', @periodopos VARCHAR(10) = ''
BEGIN TRANSACTION
BEGIN TRY 
	
	SET @periodoant = (SELECT CONVERT(VARCHAR(6), dateadd(month,-1, @anomes+'01'), 112));
	SET @periodopos = (SELECT CONVERT(VARCHAR(6), dateadd(month,1, @anomes+'01'), 112));
	
	IF EXISTS(SELECT TOP 1 1 FROM CNT.Periodos)
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM CNT.Periodos WHERE anomes = @periodoant) AND NOT EXISTS (SELECT 1 FROM CNT.Periodos WHERE anomes = @anomes)
			RAISERROR('No se puede abrir este periodo porque el periodo anterior no existe.', 16, 0);
	END

	IF (@mod = 'C')
	BEGIN		
		IF NOT EXISTS (SELECT 1 FROM CNT.Periodos WHERE anomes = @anomes)
		BEGIN
			INSERT INTO CNT.Periodos (anomes, contabilidad, inventario, id_usercreated, id_userupdated, reapertura)
			VALUES(@anomes, 1, 0, @id_user, @id_user, 0);

			EXECUTE ST_TranspasarSaldosPeriodo @periodoant = @periodoant, @periodoactual = @anomes, @modulo = 'C', @id_user = @id_user;;
		END
		ELSE
		BEGIN
			UPDATE CNT.Periodos
			SET contabilidad = CASE contabilidad WHEN 0 THEN 1 ELSE 0 END,
			id_userupdated = @id_user, 
			updated = GETDATE() 
			WHERE id = @id;
		END

	END
	ELSE IF (@mod = 'I')
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM CNT.Periodos WHERE anomes = @anomes)
		BEGIN
			INSERT INTO CNT.Periodos (anomes, contabilidad, inventario, id_usercreated, id_userupdated)
			VALUES(@anomes, 0, 1, @id_user, @id_user);
		END
		ELSE
		BEGIN

			IF EXISTS (SELECT TOP 1 1 FROM CNT.Periodos WHERE inventario != 0 AND anomes != @anomes)
				RAISERROR('Ya existe periodo de inventario abierto.', 16, 0);
			
			IF EXISTS(SELECT TOP 1 1 FROM [CNT].[Transacciones] WHERE anomes = @periodopos AND estado = Dbo.ST_FnGetIdList('PROCE') AND tipodocumento IN ('AJ', 'FV', 'TR', 'EN', 'FP', 'DF', 'DC'))
				RAISERROR('No se puede abrir el periodo, puesto que hay movimientos en periodos posteriores', 16, 0);

			--IF EXISTS (SELECT 1 FROM CNT.Periodos WHERE anomes = @anomes AND inventario = 0 and reapertura = 0)
				--EXECUTE ST_TranspasarSaldosPeriodo @peridoant = @periodoant, @periodoactual = @anomes, @modulo = 'I';

			--	RAISERROR('Ya existe saldo inicial de este periodo ', 16, 0);

			--IF NOT EXISTS (SELECT 1 FROM CNT.SaldoCosto WHERE anomes = @nomes)
			--	RAISERROR('Ya existe saldo inicial de este periodo ', 16, 0);

			UPDATE CNT.Periodos
			SET inventario = CASE inventario WHEN 0 THEN 1 ELSE 0 END,
				reapertura = 1,
			id_userupdated = @id_user, 
			updated = GETDATE() 
			WHERE id = @id;
		END

		IF NOT EXISTS (SELECT 1 FROM CNT.Periodos WHERE anomes = @anomes) OR EXISTS(SELECT 1 FROM CNT.Periodos WHERE anomes = @anomes AND reapertura = 0)
		BEGIN
			EXECUTE ST_TranspasarSaldosPeriodo @periodoant = @periodoant, @periodoactual = @anomes, @modulo = 'I', @id_user = @id_user;
		END
	END	
	
COMMIT TRANSACTION;
END TRY
BEGIN CATCH
		ROLLBACK TRANSACTION;
	    SELECT @ds_error = ERROR_MESSAGE()
	    RAISERROR(@ds_error,16,1)
	    RETURN
END CATCH

