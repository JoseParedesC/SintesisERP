--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[ST_MOVSaldoCentroCosto]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [CNT].[ST_MOVSaldoCentroCosto]
GO

CREATE PROCEDURE [CNT].[ST_MOVSaldoCentroCosto]
@Opcion VARCHAR(5),
@id BIGINT,
@id_user INT,
@nombreView varchar(50),
@tipodocumento varchar(2)=null,
@anomes VARCHAR(6)=null 
--WITH ENCRYPTION

/***************************************
*Nombre:		[CNT].[ST_MOVSaldoCentroCosto]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creacion:		16/01/2021
*Desarrollador: (Jeteme)

SP actualiza saldo centrocosto
***************************************/
AS	
DECLARE @tablacuentanew TABLE(ANOMES VARCHAR(6) ,ID_CENTROCOSTO BIGINT,ID_CUENTA BIGINT )
Declare @tableTrans Table (id_pk int identity, ANOMES VARCHAR(6) ,ID_CENTROCOSTO BIGINT,ID_CUENTA BIGINT, MOVDEBITO NUMERIC(18,2),MOVCREDITO NUMERIC(18,2), cierre BIT);
DECLARE @rows int = 0, @count int = 1
Declare @cuentasnew nvarchar(max),@cuentasTransa nvarchar(max);




BEGIN TRY	
	IF @Opcion = 'I'
	BEGIN
		SET @cuentasTransa ='SELECT ANOMES,  CENTROCOSTO    , CUENTA      ,IIF(VALOR>0,VALOR,0)      ,IIF(VALOR<0,VALOR*-1,0), CIERRE from '+@nombreview+ N' AS T INNER JOIN CNTCUENTAS C ON C.id=T.CUENTA  WHERE T.id=@id_transa';

		SET @cuentasnew = 'SELECT DISTINCT ANOMES,  CENTROCOSTO    , CUENTA    FROM ' + @nombreview+N' AS V JOIN CNTCUENTAS C ON V.CUENTA=C.ID where NOT EXISTS
						   (SELECT 1 FROM CNT.SaldoCentroCosto WHERE id_centrocosto=V.centrocosto and id_Cuenta = cuenta AND anomes=V.anomes) AND V.id=@id_transa  ';

		INSERT INTO @tableTrans
		EXEC sp_executesql @cuentastransa,N'@id_transa BIGINT',@id_transa=@id

		SET @rows = @@ROWCOUNT;
		
		INSERT INTO @tablacuentanew
		EXEC sp_executesql @cuentasnew,N'@id_transa BIGINT',@id_transa=@id
	
		INSERT INTO Cnt.SaldoCentrocosto(ANOMES, id_cuenta,id_centrocosto,saldoanterior, movDebito,movCredito,saldoActual, id_user)
				SELECT	
						ANOMES,
						ID_CUENTA,
						ID_CENTROCOSTO,
						0,
						0,
						0, 
						0,
						@id_user
				FROM @tablacuentanew
		
		WHILE(@rows >= @count)
		BEGIN 
				UPDATE S SET
				 S.MOVDEBITO		+=t.MOVDEBITO,
				 S.movCredito       +=t.MOVCREDITO,
				 S.saldoActual      +=(T.MOVDEBITO-T.MOVCREDITO),
				 S.before			 =S.changed,	
				 S.changed           =0
				FROM cnt.SaldoCentroCosto s INNER JOIN @tableTrans t ON s.id_cuenta=t.id_cuenta and S.anomes=t.ANOMES and S.id_centrocosto=T.ID_CENTROCOSTO and s.cierre = t.cierre WHERE t.id_pk=@count
			 	SET @count += 1;
		END
	END ELSE IF(@Opcion='R')
	BEGIN
		
		INSERT INTO @tableTrans
		SELECT  ANOMES,id_centrocosto,id_cuenta ,IIF(VALOR>0,VALOR,0),IIF(VALOR<0,VALOR*-1,0),IIF(tipodocumento='CR' AND descripcion LIKE 'CIERRE CUENTA%',1,0)  from CNT.transacciones t INNER JOIN CNTCuentas C ON t.id_cuenta=C.id  WHERE nrodocumento=@id and tipodocumento=@tipodocumento and anomes=@anomes and  C.categoria=dbo.ST_FnGetIdList('CTERCE')
		
		SET @rows = @@ROWCOUNT;
		WHILE(@rows >= @count)
		BEGIN 
				UPDATE S SET
				 S.MOVDEBITO		-=t.MOVDEBITO,
				 S.MOVCREDITO       -=t.MOVCREDITO,
				 S.SALDOACTUAL      -=(T.MOVDEBITO-T.MOVCREDITO),
				 S.CHANGED			=S.before
				 FROM cnt.SaldoCentrocosto s JOIN @tableTrans t ON s.id_cuenta=t.id_cuenta AND S.anomes=T.ANOMES AND S.id_centrocosto=T.ID_CENTROCOSTO where t.id_pk=@count
	 		SET @count += 1;
		END
	END
	EXEC [CNT].[ST_MOVRecalculoSaldo] @saldo='CENTROCOSTO',@anomes=@anomes;
END TRY
BEGIN CATCH
	DECLARE @Mensajee varchar(max) = (select ERROR_MESSAGE())
	RAISERROR(@Mensajee,16,0);
END CATCH

GO


