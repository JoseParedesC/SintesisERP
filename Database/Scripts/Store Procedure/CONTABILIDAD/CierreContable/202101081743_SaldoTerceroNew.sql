--liquibase formatted sql
--changeset ,apuello:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id =
OBJECT_ID(N'[CNT].[ST_MOVSaldoTercero]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [CNT].[ST_MOVSaldoTercero]
GO 

If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id =
OBJECT_ID(N'[CNT].[ST_MOVSaldoTerceronew]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [CNT].[ST_MOVSaldoTerceronew]
GO 
CREATE PROCEDURE [CNT].[ST_MOVSaldoTerceronew]
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
*creacion:		24/10/2020
*Desarrollador: (Jeteme)

SP actualiza saldo de cuentas 
***************************************/
AS	
DECLARE @tablacuentanew TABLE(ANOMES VARCHAR(6) ,ID_CUENTA BIGINT,ID_TERCERO BIGINT,FECHADCTO VARCHAR(12) )
Declare @tableTrans Table (id_pk int identity, ANOMES VARCHAR(6) ,ID_CUENTA BIGINT,ID_TERCERO BIGINT, MOVDEBITO NUMERIC(18,2),MOVCREDITO NUMERIC(18,2), cierre BIT);
DECLARE @rows int = 0, @count int = 1
Declare @cuentasnew nvarchar(max),@cuentasTransa nvarchar(max);




BEGIN TRY	
	IF @Opcion = 'I'
	BEGIN
		SET @cuentasTransa ='SELECT ANOMES,       CUENTA      ,IDEN_TERCERO,IIF(VALOR>0,VALOR,0)      ,IIF(VALOR<0,VALOR*-1,0), CIERRE from '+@nombreview+ N' AS T INNER JOIN CNTCUENTAS C ON C.id=T.CUENTA AND C.categoria=dbo.ST_FnGetIdList(''CTERCE'') WHERE T.id=@id_transa';

		SET @cuentasnew = 'SELECT DISTINCT ANOMES,       CUENTA,IDEN_TERCERO,FECHADCTO       FROM ' + @nombreview+N' AS V JOIN CNTCUENTAS C ON V.CUENTA=C.ID where NOT EXISTS
						   (SELECT 1 FROM CNT.SaldoTercero WHERE id_Cuenta = cuenta AND anomes=V.anomes AND id_tercero=V.IDEN_TERCERO) AND V.id=@id_transa AND C.categoria=dbo.ST_FnGetIdList(''CTERCE'') ';

		INSERT INTO @tableTrans
		EXEC sp_executesql @cuentastransa,N'@id_transa BIGINT',@id_transa=@id

		SET @rows = @@ROWCOUNT;
		
		INSERT INTO @tablacuentanew
		EXEC sp_executesql @cuentasnew,N'@id_transa BIGINT',@id_transa=@id
	
		INSERT INTO Cnt.SaldoTercero(ANOMES, id_cuenta,id_tercero,fechaactual,saldoanterior, movDebito,movCredito,saldoActual, id_user)
				SELECT	
						ANOMES,
						ID_CUENTA,
						ID_TERCERO,
						CONVERT(smalldatetime,FECHADCTO,120),
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
				FROM cnt.SaldoTercero s INNER JOIN @tableTrans t ON s.id_cuenta=t.id_cuenta and S.anomes=t.ANOMES and S.id_tercero=T.ID_TERCERO and s.cierre = t.cierre WHERE t.id_pk=@count
			 	SET @count += 1;
		END
	END ELSE IF(@Opcion='R')
	BEGIN
		
		INSERT INTO @tableTrans
		SELECT  ANOMES,id_cuenta ,id_tercero,IIF(VALOR>0,VALOR,0),IIF(VALOR<0,VALOR*-1,0),IIF(tipodocumento='CR' AND descripcion LIKE 'CIERRE CUENTA%',1,0)  from CNT.transacciones t INNER JOIN CNTCuentas C ON t.id_cuenta=C.id  WHERE nrodocumento=@id and tipodocumento=@tipodocumento and anomes=@anomes and  C.categoria=dbo.ST_FnGetIdList('CTERCE')
		
		SET @rows = @@ROWCOUNT;
		WHILE(@rows >= @count)
		BEGIN 
				UPDATE S SET
				 S.MOVDEBITO		-=t.MOVDEBITO,
				 S.MOVCREDITO       -=t.MOVCREDITO,
				 S.SALDOACTUAL      -=(T.MOVDEBITO-T.MOVCREDITO),
				 S.CHANGED			=S.before
				 FROM cnt.SaldoTercero s JOIN @tableTrans t ON s.id_cuenta=t.id_cuenta AND S.anomes=T.ANOMES AND S.id_tercero=T.ID_TERCERO where t.id_pk=@count
	 		SET @count += 1;
		END
	END
	EXEC [CNT].[ST_MOVRecalculoSaldo] @saldo='TERCERO',@anomes=@anomes;
END TRY
BEGIN CATCH
	DECLARE @Mensajee varchar(max) = (select ERROR_MESSAGE())
	RAISERROR(@Mensajee,16,0);
END CATCH