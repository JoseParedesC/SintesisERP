--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[CierreContable]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [CNT].[CierreContable]
GO

CREATE PROCEDURE [CNT].[CierreContable]
/***************************************
*Nombre: [CNT].[CierreContable]
----------------------------------------
*Tipo: Procedimiento almacenado
*creación: 23/12/20
*Desarrollador: APUELLO
*Descripcion: Este SP realiza el cierre contable en la empresa que usa el sistema
***************************************/

	@id_cierre BIGINT=null,
	@id_cancel BIGINT=null,
	@id_centro BIGINT=null,
	@ano varchar(6)=null,
	@fecha SMALLDATETIME=null,
	@descripcion VARCHAR(MAX)=null,
	@id_user BIGINT,
	@id BIGINT
AS

DECLARE @error VARCHAR(MAX), @id_tercero BIGINT, @id_return BIGINT, @documento BIGINT, @anomes VARCHAR(4)
DECLARE @temp TABLE (id BIGINT)
BEGIN TRANSACTION;
BEGIN TRY
	SET @documento = (SELECT id FROM [CNT].[TipoDocumentos] WHERE nombre = 'CIERRE CONTABLE')
	SET @id_tercero = (SELECT T.id FROM [dbo].[Empresas] E INNER JOIN [CNT].[Terceros] T ON T.iden = E.nit)
	SET @anomes = (SELECT CONVERT(VARCHAR(4), valor, 112) FROM dbo.Parametros WHERE codigo = 'ANOMESSTAR')
	

	
	--IF(CONVERT(VARCHAR(4), @ano, 112) < @anomes)
	--	RAISERROR('La empresa no puede realizar el cierre contable en el año seleccionado', 16, 0) ELSE
	 IF(((SELECT COUNT(id_cuenta) FROM [CNT].[ST_ListaCuentasCierre]('TERCERO',@ano)) <= 0) OR ((SELECT COUNT(id_cuenta) FROM [CNT].[ST_ListaCuentasCierre]('CUENTA',@ano)) <= 0))
		RAISERROR('En el sistema no se encontró saldo en las cuentas para el año que ingreso', 16, 0)
	
	IF(@id = 0)
	BEGIN

	IF EXISTS(SELECT 1 FROM CNT.MOVCierreContable WHERE anomes = (CONVERT(VARCHAR(4), DATEADD(YEAR, -1, GETDATE()), 112) + '12') AND estado = [dbo].[ST_FnGetIdList]('PROCE'))
		RAISERROR('El año actual se encuentra contablemente cerrado', 16, 0)

	ELSE IF EXISTS(SELECT 1 FROM CNT.MOVCierreContable WHERE SUBSTRING(anomes, 0, 4) = CONVERT(VARCHAR(4), DATEADD(YEAR, -1, GETDATE()), 112) AND estado = [dbo].[ST_FnGetIdList]('PROCE'))
		RAISERROR('El año anterior se encuentra abierto', 16, 0)


		INSERT INTO [CNT].[MOVCierreContable] (
				fecha,
				id_centrocosto, 
				id_cuentacierre, 
				id_cuentacancelacion, 
				id_tercero,
				tipodocumento,
				anomes,
				user_created, 
				user_updated,
				descripcion,
				estado)
			VALUES (
				GETDATE(),
				@id_centro,
				@id_cierre, 
				@id_cancel,
				@id_tercero,
				@documento,
				@ano,
				@id_user,
				@id_user,
				@descripcion,
				[dbo].[ST_FnGetIdList]('PROCE'))

		SET @id_return = SCOPE_IDENTITY();

		INSERT INTO [CNT].[MOVCierreContableItems](
				id_cierrecontable,
				id_cuenta,
				id_tercero,
				valor,
				debito,
				credito,
				user_created,
				user_updated)
			SELECT
				@id_return,
				C.id_cuenta,
				C.id_tercero,
				C.saldoActual*-1,
				C.debito,
				C.credito,
				@id_user,
				@id_user
			FROM [CNT].[ST_ListaCuentasCierre]('TERCERO',@ano) C

		INSERT INTO [CNT].[SaldoCuenta] 
				(anomes, 
				id_cuenta, 
				saldoanterior, 
				movDebito, 
				movCredito, 
				saldoActual, 
				cierre, 
				id_user)
			SELECT 
				@ano,
				C.id_cuenta,
				S.saldoanterior,
				S.movDebito,
				S.movCredito,
				C.saldoActual,
				1,
				@id_user
		FROM [CNT].[ST_ListaCuentasCierre]('CUENTA',@ano) C
		INNER JOIN [CNT].[SaldoCuenta] S ON S.id_cuenta = C.id_cuenta and S.anomes= @ano


		INSERT INTO [CNT].[SaldoTercero](
				anomes,
				id_tercero,
				id_cuenta,
				fechaactual, 
				saldoanterior,
				movDebito,
				movCredito,
				saldoActual,
				cierre,
				id_user)
			SELECT 
				@ano,
				S.id_tercero,
				C.id_cuenta,
				S.fechaactual,
				S.saldoanterior,
				S.movDebito,
				S.movCredito,
				C.saldoActual,
				1,
				@id_user
		FROM [CNT].[ST_ListaCuentasCierre]('TERCERO',@ano) C		
		INNER JOIN [CNT].[SaldoTercero] S ON S.id_cuenta = C.id_cuenta and S.id_tercero=C.id_tercero and S.anomes=@ano

		
		/*JETEHERAN 01/21/2021*/
	   INSERT INTO [CNT].[MOVCierreContableSaldoCosto](Anomes,id_cierrecontable,id_centrocosto,id_cuenta,valor,user_created,user_updated)
		SELECT ANOMES, @id_return   ,ID_CENTROCOSTO,   ID_CUENTA,  saldoactual,@id_user,@id_user from CNT.saldocentrocosto S JOIN CNTCUENTAS C ON S.ID_CUENTA=C.ID
		WHERE SUBSTRING(C.CODIGO,1,1)  in(4,5,6) and anomes=@ano
	
		UPDATE S SET S.movdebito     += IIF(VALOR<0,VALOR*-1,0),
					 S.movcredito    +=IIF(VALOR>0,VALOR,0),
					 S.Saldoactual   =(SALDOANTERIOR+MOVDEBITO+IIF(VALOR<0,VALOR*-1,0))-(MOVCREDITO+IIF(VALOR>0,VALOR,0))			  
					 FROM cnt.saldocentrocosto S JOIN 
					 [CNT].[MOVCierreContableSaldoCosto] C ON S.anomes=C.anomes and S.id_centrocosto=C.id_centrocosto and S.id_cuenta=C.id_cuenta and C.id_cierrecontable=@id_return

		/*END JTEHERAN*/

		EXEC CNT.ST_MOVTransacciones                @id=@id_return,@id_user= @id_user,@nombreView='[CNT].[VW_TRANSACIONES_CIERRECONTABLE]';--Se alimenta la tabla transacciones
		
		EXEC CNT.ST_MOVSaldoCuenta      @opcion='I',@id=@id_return,@id_user= @id_user,@nombreView='[CNT].[VW_TRANSACIONES_CIERRECONTABLE]'--Se alimenta la tabla saldocuentas cada una tiene su recalculo
		
		EXEC CNT.ST_MOVSaldoTerceronew  @opcion='I',@id=@id_return,@id_user= @id_user,@nombreView='[CNT].[VW_TRANSACIONES_CIERRECONTABLE]'-- Se alimenta la tabla saldoterceros cada una tiene su recalculo 
		
		SELECT @id_return as id
	END
	ELSE 
	BEGIN
		INSERT INTO [CNT].[MOVCierreContable] (
						fecha_revertido,
						anomes,
						id_revertido, 
						id_centrocosto, 
						id_cuentacierre, 
						id_cuentacancelacion, 
						id_tercero, 
						tipodocumento, 
						estado)
				SELECT 
						GETDATE(),
						M.anomes,
						@id,
						M.id_centrocosto,
						M.id_cuentacierre,
						M.id_cuentacancelacion,
						M.id_tercero,
						M.tipodocumento,
						[dbo].[ST_FnGetIdList]('REVER')
			FROM [CNT].[MOVCierreContable] M
			WHERE id = @id
			
			SET @id_return = SCOPE_IDENTITY();

			UPDATE [CNT].[MOVCierreContable]
				SET
					id_revertido	=	@id_return,
					estado			=	[dbo].[ST_FnGetIdList]('REVON')
				WHERE id = @id
			
			UPDATE S SET S.movdebito    -= IIF(VALOR<0,VALOR*-1,0),
					 S.movcredito		-=IIF(VALOR>0,VALOR,0),
					 S.Saldoactual		-=VALOR			  
					 FROM cnt.saldocentrocosto S JOIN 
					 [CNT].[MOVCierreContableSaldoCosto] C ON S.anomes=C.anomes and S.id_centrocosto=C.id_centrocosto and S.id_cuenta=C.id_cuenta and C.id_cierrecontable=@id
		   
		   /*JTEHERAN START*/
		   UPDATE [CNT].[TRANSACCIONES] SET ESTADO=Dbo.ST_FnGetIdList('REVER') WHERE nrodocumento=@id and tipodocumento='CR' and anomes=@anomes
		   EXEC CNT.ST_MOVSaldoCuenta  @opcion='R',@id=@id,@id_user=@id_user,@nombreView='[CNT].[VW_TRANSACIONES_CIERRECONTABLE]', @tipodocumento = 'CR',@anomes=@ano
		   EXEC CNT.ST_MOVSaldoTerceronew  @opcion='R',@id=@id,@id_user=@id_user,@nombreView='[CNT].[VW_TRANSACIONES_CIERRECONTABLE]', @tipodocumento = 'CR',@anomes=@ano

			/*JTEHERAN END*/
		
			DELETE FROM [CNT].[SaldoCuenta] WHERE cierre = 1
			DELETE FROM [CNT].[SaldoTercero] WHERE cierre = 1



		SELECT @id_return as id
	END
	
	COMMIT TRANSACTION;
END TRY
BEGIN CATCH
	SET @error = 'Error: '+ERROR_MESSAGE();
	RAISERROR(@error,16,0);
ROLLBACK TRANSACTION;
END CATCH
