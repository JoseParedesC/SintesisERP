--liquibase formatted sql
--changeset ,apuello:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id =
OBJECT_ID(N'[CNT].[ST_MOVSaldoCuenta]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [CNT].[ST_MOVSaldoCuenta]
GO
CREATE PROCEDURE [CNT].[ST_MOVSaldoCuenta]
@Opcion VARCHAR(5),
@id BIGINT,
@id_user INT,
@nombreView varchar(50),
@tipodocumento varchar(2)=null,
@anomes VARCHAR(6)=null 
--WITH ENCRYPTION

/***************************************
*Nombre:		[CNT].[ST_MOVSaldoCuenta]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		24/10/2020
*Desarrollador: (Jeteme)

SP actualiza saldo de cuentas 
***************************************/
AS	
DECLARE @tablacuentanew TABLE(ANOMES VARCHAR(6) ,ID_CUENTA BIGINT)
Declare @tableTrans Table (id_pk int identity, ANOMES VARCHAR(6) ,ID_CUENTA BIGINT, MOVDEBITO NUMERIC(18,2),MOVCREDITO NUMERIC(18,2), cierre BIT);
DECLARE @rows int = 0, @count int = 1
Declare @cuentasnew nvarchar(max),@cuentasTransa nvarchar(max);




BEGIN TRY	
	IF @Opcion = 'I'
	BEGIN
		SET @cuentasTransa ='SELECT ANOMES,       CUENTA      ,IIF(VALOR>0,VALOR,0)      ,IIF(VALOR<0,VALOR*-1,0), CIERRE from '+@nombreview+ N' WHERE id=@id_transa';

		SET @cuentasnew = 'SELECT DISTINCT ANOMES,       CUENTA       FROM ' + @nombreview+N' AS V where NOT EXISTS
						   (SELECT 1 FROM CNT.Saldocuenta WHERE id_Cuenta = cuenta AND anomes=V.anomes) AND id=@id_transa ';

		--Alimentamos una tabla temporal con los movimientos realizados en la vista transaccional que recibe como parametro
		INSERT INTO @tableTrans
		EXEC sp_executesql @cuentastransa,N'@id_transa BIGINT',@id_transa=@id

		SET @rows = @@ROWCOUNT;

		--Insertamos en una tabla temporal los registros que vienen en la vista que no se encuentran en la tabla saldocliente en ese periodo
		INSERT INTO @tablacuentanew
		EXEC sp_executesql @cuentasnew,N'@id_transa BIGINT',@id_transa=@id
      
		--Insertamos en la tabla saldocuenta aquellos registro de la tabla temporal
		INSERT INTO Cnt.SaldoCuenta(ANOMES, id_cuenta,saldoanterior, movDebito,movCredito,saldoActual, id_user)
				SELECT	
						ANOMES,
						ID_CUENTA,
						0,
						0,
						0, 
						0,
						@id_user
				FROM @tablacuentanew

		WHILE(@rows >= @count)-- Recorremos la tabla de los registros de la primera tabla temporal para actualizar los registros en la tabla saldocuenta con los datos nuevos
		BEGIN 

				UPDATE S SET
				 S.MOVDEBITO		+=t.MOVDEBITO,
				 S.movCredito       +=t.MOVCREDITO,
				 S.saldoActual      +=(T.MOVDEBITO-T.MOVCREDITO),
				 S.before			 =S.changed,	
				 S.changed           =0
				FROM cnt.saldocuenta s INNER JOIN @tableTrans t ON s.id_cuenta=t.id_cuenta and S.anomes=t.ANOMES AND s.cierre = t.cierre WHERE t.id_pk=@count

			 	SET @count += 1;
		END
	END ELSE IF(@Opcion='R')--Opcion de reversion de documentos
	BEGIN
		
		INSERT INTO @tableTrans--Insertamos en la tabla temporal los registros de la tabla transacciones del documento que se va a revertir recibe como parametro el tipo de documento y el numero de documento
		SELECT ANOMES,       ID_CUENTA      ,IIF(VALOR>0,VALOR,0)      ,IIF(VALOR<0,VALOR*-1,0),IIF(tipodocumento='CR' AND descripcion LIKE 'CIERRE CUENTA%',1,0) from CNT.transacciones  WHERE nrodocumento=@id and tipodocumento=@tipodocumento and anomes=@anomes
		
		SET @rows = @@ROWCOUNT;
		WHILE(@rows >= @count)
		BEGIN 

				update S SET
				 S.MOVDEBITO		-=t.MOVDEBITO,
				 S.movCredito       -=t.MOVCREDITO,
				 S.saldoActual      -=(T.MOVDEBITO-T.MOVCREDITO),
				 S.changed			=S.before
				 from cnt.saldocuenta s inner join @tableTrans t on s.id_cuenta=t.id_cuenta and S.anomes=T.ANOMES  AND s.cierre = t.cierre where t.id_pk=@count

			 		SET @count += 1;
		END
		
	END
	EXEC [CNT].[ST_MOVRecalculoSaldo] @saldo='CUENTA',@anomes=@anomes;
END TRY
BEGIN CATCH
	DECLARE @Mensajee varchar(max) = (select ERROR_MESSAGE())
	RAISERROR(@Mensajee,16,0);
END CATCH