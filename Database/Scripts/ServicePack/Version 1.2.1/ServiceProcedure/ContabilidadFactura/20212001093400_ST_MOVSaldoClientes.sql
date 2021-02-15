--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[ST_MOVSaldoClientes]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [CNT].[ST_MOVSaldoClientes]
GO
CREATE PROCEDURE [CNT].[ST_MOVSaldoClientes]
@Opcion VARCHAR(5),
@id BIGINT,
@id_user INT,
@nombreView varchar(50),
@tipodocumento varchar(2)=null,
@anomes VARCHAR(6)=null 
--WITH ENCRYPTION

/***************************************
*Nombre:		[CNT].[ST_MOVSaldoClientes]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		24/10/2020
*Desarrollador: (Jeteme)

SP actualiza saldo de cuentas 
***************************************/
AS	
DECLARE @tablacuentanew TABLE(ANOMES VARCHAR(6) ,NRODOCUMENTO BIGINT,NROFACTURA VARCHAR(50),ID_CUENTA BIGINT,ID_CLIENTE BIGINT,FECHAVCTO VARCHAR(12),CUOTA INT )
DECLARE @tablacuentaGeneralnew TABLE(ANOMES VARCHAR(6) ,NRODOCUMENTO BIGINT,NROFACTURA VARCHAR(50),ID_CUENTA BIGINT,ID_CLIENTE BIGINT,FECHADCTO SMALLDATETIME )
Declare @tableTrans   Table (id_pk int identity, ANOMES VARCHAR(6) ,ID_DOC BIGINT,NROFACTURA VARCHAR(50),ID_CUENTA BIGINT,ID_CLIENTE BIGINT,FECHAVCTO smalldatetime, MOVDEBITO NUMERIC(18,2),MOVCREDITO NUMERIC(18,2),CUOTA INT);
Declare @tableTransGeneral   Table (id_pk int identity, ANOMES VARCHAR(6) ,ID_DOC BIGINT,NROFACTURA VARCHAR(50),ID_CUENTA BIGINT,ID_CLIENTE BIGINT, MOVDEBITO NUMERIC(18,2),MOVCREDITO NUMERIC(18,2));
DECLARE @rows int = 0, @count int = 1
Declare @cuentasnew nvarchar(max),@cuentasTransa nvarchar(max),@cuentasTransaGeneral nvarchar(max),@cuentasGeneralnew nvarchar(max);




BEGIN TRY	
	IF @Opcion = 'I'
	BEGIN
		
		
		SET @cuentasTransa         ='SELECT ANOMES,      NRODOCUMENTO, NROFACTURA,CUENTA,IDEN_TERCERO,FECHAVENCIMIENTO,IIF(VALOR>0,VALOR,0)      ,IIF(VALOR<0,VALOR*-1,0),IIF(TIPODOC!=''CC'', REPLACE(SUBSTRING(DESCRIPCION,LEN(DESCRIPCION)-1,10),''.'',''''),'''') CUOTA from '+@nombreview+ N' AS T INNER JOIN CNTCUENTAS C ON C.id=T.CUENTA AND C.categoria=dbo.ST_FnGetIdList(''CCLIENTE'') WHERE T.id=@id_transa';
		SET @cuentasTransaGeneral  ='SELECT ANOMES,      NRODOCUMENTO, NROFACTURA,CUENTA,IDEN_TERCERO,SUM(IIF(VALOR>0,VALOR,0))      ,SUM(IIF(VALOR<0,VALOR*-1,0))  from '+@nombreview+ N' AS T INNER JOIN CNTCUENTAS C ON C.id=T.CUENTA AND C.categoria=dbo.ST_FnGetIdList(''CCLIENTE'') WHERE T.id=@id_transa GROUP BY ANOMES,NRODOCUMENTO, NROFACTURA,CUENTA,IDEN_TERCERO';
		


		SET @cuentasnew =         'SELECT DISTINCT ANOMES, NRODOCUMENTO ,NROFACTURA,CUENTA,IDEN_TERCERO,FECHAVENCIMIENTO,REPLACE(SUBSTRING(DESCRIPCION,LEN(DESCRIPCION)-1,10),''.'','''') CUOTA    FROM ' + @nombreview+N' AS V JOIN CNTCUENTAS C ON V.CUENTA=C.ID where NOT EXISTS
						          (SELECT 1 FROM CNT.SaldoCliente_Cuotas WHERE id_Cuenta=cuenta AND anomes=V.anomes AND id_cliente=V.IDEN_TERCERO AND nrofactura=V.nrofactura and vencimiento_cuota=V.FECHAVENCIMIENTO ) AND V.id=@id_transa AND C.categoria=dbo.ST_FnGetIdList(''CCLIENTE'') ';

		SET @cuentasGeneralnew = 'SELECT DISTINCT ANOMES, NRODOCUMENTO ,NROFACTURA,CUENTA,IDEN_TERCERO,convert(smalldatetime,replace(FECHADCTO,''/'',''''))    FROM ' + @nombreview+N' AS V JOIN CNTCUENTAS C ON V.CUENTA=C.ID where NOT EXISTS
								 (SELECT 1 FROM CNT.SaldoCliente WHERE id_Cuenta=cuenta AND anomes=V.anomes AND id_cliente=V.IDEN_TERCERO AND nrofactura=V.nrofactura) AND V.id=@id_transa AND C.categoria=dbo.ST_FnGetIdList(''CCLIENTE'') ';

	
			
		/*SALDOCLIENTE_CUOTAS START*/
		INSERT INTO @tableTrans
		EXEC sp_executesql @cuentastransa,N'@id_transa BIGINT',@id_transa=@id

		SET @rows = @@ROWCOUNT;
	
		
		INSERT INTO @tablacuentanew
		EXEC sp_executesql @cuentasnew,N'@id_transa BIGINT',@id_transa=@id
	
	

		INSERT INTO Cnt.SaldoCliente_Cuotas(ANOMES,nrofactura,id_cuenta,id_cliente,cuota,saldoanterior, movDebito,movCredito,saldoActual,vencimiento_cuota,fechapagointeres ,id_user)
				SELECT	
						ANOMES,
						NROFACTURA,
						ID_CUENTA,
						ID_CLIENTE,
						CUOTA,
						0,
						0,
						0, 
						0,
						FECHAVCTO,
						FECHAVCTO,
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
				FROM cnt.SaldoCliente_Cuotas s INNER JOIN @tableTrans t ON s.id_cuenta=t.id_cuenta and S.anomes=t.ANOMES and S.id_cliente=T.ID_CLIENTE AND S.vencimiento_cuota=t.FECHAVCTO and s.nrofactura=t.NROFACTURA WHERE t.id_pk=@count
			 	SET @count += 1;
		END
		/*SALDOCLIENTE_CUOTAS END*/

		/*SALDOCLIENTES START*/

		INSERT INTO @tableTransGeneral
		EXEC sp_executesql @cuentasTransaGeneral,N'@id_transa BIGINT',@id_transa=@id
		SET @count=1;
		SET @rows = @@ROWCOUNT;
		
		INSERT INTO @tablacuentaGeneralnew
		EXEC sp_executesql @cuentasGeneralnew,N'@id_transa BIGINT',@id_transa=@id
	
		INSERT INTO Cnt.SaldoCliente(ANOMES,nrofactura,id_documento,id_cuenta,id_cliente,fechaactual,fechavencimiento,saldoanterior, movDebito,movCredito,saldoActual,id_user)
				SELECT	
						ANOMES,
						NROFACTURA,
						NRODOCUMENTO,
						ID_CUENTA,
						ID_CLIENTE,
						FECHADCTO,
						FECHADCTO,
						0,
						0,
						0, 
						0,
						@id_user
				FROM @tablacuentaGeneralnew
		
		WHILE(@rows >= @count)
		BEGIN 
				UPDATE S SET
				 S.MOVDEBITO		+=t.MOVDEBITO,
				 S.movCredito       +=t.MOVCREDITO,
				 S.saldoActual      +=(T.MOVDEBITO-T.MOVCREDITO),
				 S.before			 =S.changed,	
				 S.changed           =0
				FROM cnt.SaldoCliente s INNER JOIN @tableTransGeneral t ON s.id_cuenta=t.id_cuenta and S.anomes=t.ANOMES and S.id_cliente=T.ID_CLIENTE AND s.nrofactura=t.NROFACTURA WHERE t.id_pk=@count
			 	SET @count += 1;
		END
		/*SALDOCLIENTE END*/
	END ELSE IF(@Opcion='R')
	BEGIN
		
		/*START SALDOCLIENTE_CUOTA */
		INSERT INTO @tableTrans
		SELECT ANOMES,      NRODOCUMENTO, NROFACTURA,ID_CUENTA,ID_TERCERO,FECHAVENCIMIENTO,IIF(VALOR>0,VALOR,0)      ,IIF(VALOR<0,VALOR*-1,0),IIF(TIPODOCUMENTO!='CC', REPLACE(SUBSTRING(DESCRIPCION,LEN(DESCRIPCION)-1,10),'.',''),'') CUOTA  from CNT.transacciones t INNER JOIN CNTCuentas C ON t.id_cuenta=C.id  WHERE nrodocumento=@id and tipodocumento=@tipodocumento and anomes=@anomes and  C.categoria=dbo.ST_FnGetIdList('CCLIENTE')
		SET @rows = @@ROWCOUNT;
		WHILE(@rows >= @count)
		BEGIN 
		
				UPDATE S SET
				 S.MOVDEBITO		-=t.MOVDEBITO,
				 S.MOVCREDITO       -=t.MOVCREDITO,
				 S.SALDOACTUAL      -=(T.MOVDEBITO-T.MOVCREDITO),
				 S.CHANGED			=0
 				FROM cnt.SaldoCliente_Cuotas s INNER JOIN @tableTrans t ON s.id_cuenta=t.id_cuenta and S.anomes=t.ANOMES and S.id_cliente=T.ID_CLIENTE AND S.vencimiento_cuota=t.FECHAVCTO  and t.NROFACTURA=s.nrofactura WHERE t.id_pk=@count

	 		SET @count += 1;
		END

		
		/*END SALDOCLIENTE_CUOTA */

		/*START SALDOCLIENTE */
		INSERT INTO @tableTransGeneral
		SELECT ANOMES,      NRODOCUMENTO, NROFACTURA,ID_CUENTA,ID_TERCERO,SUM(IIF(VALOR>0,VALOR,0))      ,SUM(IIF(VALOR<0,VALOR*-1,0)) from CNT.transacciones t INNER JOIN CNTCuentas C ON t.id_cuenta=C.id  WHERE nrodocumento=@id and tipodocumento=@tipodocumento and anomes=@anomes and  C.categoria=dbo.ST_FnGetIdList('CCLIENTE') group by ANOMES,      NRODOCUMENTO, NROFACTURA,ID_CUENTA,ID_TERCERO

		
		SET @rows = @@ROWCOUNT;
		WHILE(@rows >= @count)
		BEGIN 
				UPDATE S SET
				 S.MOVDEBITO		-=t.MOVDEBITO,
				 S.MOVCREDITO       -=t.MOVCREDITO,
				 S.SALDOACTUAL      -=(T.MOVDEBITO-T.MOVCREDITO),
				 S.CHANGED			=0
 				FROM cnt.SaldoCliente s INNER JOIN @tableTransGeneral t ON s.id_cuenta=t.id_cuenta and S.anomes=t.ANOMES and S.id_cliente=T.ID_CLIENTE  and t.NROFACTURA=s.nrofactura WHERE t.id_pk=@count

	 		SET @count += 1;
		END
		/*END SALDOCLIENTE */
	END
	EXEC [CNT].[ST_MOVRecalculoSaldo] @saldo='CLIENTE',@anomes=@anomes;
END TRY
BEGIN CATCH
	DECLARE @Mensajee varchar(max) = (select ERROR_MESSAGE())
	RAISERROR(@Mensajee,16,0);
END CATCH

