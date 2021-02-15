--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[ST_MOVSaldoProveedores]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [CNT].[ST_MOVSaldoProveedores]
GO
CREATE PROCEDURE [CNT].[ST_MOVSaldoProveedores]
@Opcion VARCHAR(5),
@id BIGINT,
@id_user INT,
@nombreView varchar(50),
@tipodocumento varchar(2)=null,
@anomes VARCHAR(6)=null 
--WITH ENCRYPTION

/***************************************
*Nombre:		[CNT].[ST_MOVSaldoProveedores]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		08/02/2021
*Desarrollador: (Jeteme)

SP actualiza saldo de cuentas 
***************************************/
AS	
DECLARE @tablacuentanew TABLE(ANOMES VARCHAR(6) ,NRODOCUMENTO BIGINT,FECHADOCUMENTO SMALLDATETIME,NROFACTURA VARCHAR(50),ID_CUENTA BIGINT,ID_PROVEEDOR BIGINT,FECHAVCTO smalldatetime )
Declare @tableTrans   Table (id_pk int identity, ANOMES VARCHAR(6) ,ID_DOC BIGINT,NROFACTURA VARCHAR(50),ID_CUENTA BIGINT,ID_PROVEEDOR BIGINT,FECHAVCTO smalldatetime, MOVDEBITO NUMERIC(18,2),MOVCREDITO NUMERIC(18,2));
DECLARE @rows int = 0, @count int = 1
Declare @cuentasnew nvarchar(max),@cuentasTransa nvarchar(max),@cuentasTransaGeneral nvarchar(max),@cuentasGeneralnew nvarchar(max);




BEGIN TRY	
	IF @Opcion = 'I'
	BEGIN
		
			
		SET @cuentasTransa         ='SELECT ANOMES,      NRODOCUMENTO,NROFACTURA,CUENTA,IDEN_TERCERO,FECHAVENCIMIENTO,IIF(VALOR>0,VALOR,0)      ,IIF(VALOR<0,VALOR*-1,0) from '+@nombreview+ N' AS T INNER JOIN CNTCUENTAS C ON C.id=T.CUENTA AND C.categoria=dbo.ST_FnGetIdList(''CPROVE'') WHERE T.id=@id_transa';
		


		SET @cuentasnew =         'SELECT DISTINCT ANOMES,IIF(TIPODOC=''EN'',NRODOCUMENTO,NULL) ,CONVERT(smalldatetime,FECHADCTO,120),NROFACTURA,CUENTA,IDEN_TERCERO,FECHAVENCIMIENTO   FROM ' + @nombreview+N' AS V JOIN CNTCUENTAS C ON V.CUENTA=C.ID where NOT EXISTS
						          (SELECT 1 FROM CNT.SaldoProveedor WHERE id_Cuenta=cuenta AND anomes=V.anomes AND id_proveedor=V.IDEN_TERCERO AND nrofactura=V.nrofactura and fechavencimiento=V.FECHAVENCIMIENTO ) AND V.id=@id_transa AND C.categoria=dbo.ST_FnGetIdList(''CPROVE'') ';

		

	
	
		INSERT INTO @tableTrans
		EXEC sp_executesql @cuentastransa,N'@id_transa BIGINT',@id_transa=@id
		
		SET @rows = @@ROWCOUNT;
	

		
		INSERT INTO @tablacuentanew
		EXEC sp_executesql @cuentasnew,N'@id_transa BIGINT',@id_transa=@id
		
	
		INSERT INTO Cnt.SaldoProveedor(ANOMES,nrofactura,id_documento,fechaactual,id_cuenta,id_proveedor,saldoanterior, movDebito,movCredito,saldoActual,fechavencimiento ,id_user)
				SELECT	
						ANOMES,
						NROFACTURA,
						NRODOCUMENTO,
						FECHADOCUMENTO,
						ID_CUENTA,
						ID_PROVEEDOR,
						0,
						0,
						0, 
						0,
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
				FROM cnt.SaldoProveedor s INNER JOIN @tableTrans t ON s.id_cuenta=t.id_cuenta and S.anomes=t.ANOMES and S.id_proveedor=T.ID_PROVEEDOR AND S.fechavencimiento=t.FECHAVCTO and s.nrofactura=t.NROFACTURA WHERE t.id_pk=@count
			 	SET @count += 1;
		END
		
	END ELSE IF(@Opcion='R')
	BEGIN
		
		INSERT INTO @tableTrans
		SELECT ANOMES,      NRODOCUMENTO, NROFACTURA,ID_CUENTA,ID_TERCERO,FECHAVENCIMIENTO,IIF(VALOR>0,VALOR,0)      ,IIF(VALOR<0,VALOR*-1,0)  from CNT.transacciones t INNER JOIN CNTCuentas C ON t.id_cuenta=C.id  WHERE nrodocumento=@id and tipodocumento=@tipodocumento and anomes=@anomes and  C.categoria=dbo.ST_FnGetIdList('CPROVE')
		SET @rows = @@ROWCOUNT;
		WHILE(@rows >= @count)
		BEGIN 
		
				UPDATE S SET
				 S.MOVDEBITO		-=t.MOVDEBITO,
				 S.MOVCREDITO       -=t.MOVCREDITO,
				 S.SALDOACTUAL      -=(T.MOVDEBITO-T.MOVCREDITO),
				 S.CHANGED			=0
 				FROM cnt.SaldoProveedor s INNER JOIN @tableTrans t ON s.id_cuenta=t.id_cuenta and S.anomes=t.ANOMES and S.id_proveedor=T.ID_PROVEEDOR AND S.fechavencimiento=t.FECHAVCTO  and t.NROFACTURA=s.nrofactura WHERE t.id_pk=@count

	 		SET @count += 1;
		END
	END
	EXEC [CNT].[ST_MOVRecalculoSaldo] @saldo='PROVEEDOR',@anomes=@anomes;
END TRY
BEGIN CATCH
	DECLARE @Mensajee varchar(max) = (select ERROR_MESSAGE())
	RAISERROR(@Mensajee,16,0);
END CATCH


