--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[ST_MOVRecalculoSaldo]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [CNT].[ST_MOVRecalculoSaldo]
GO



CREATE PROCEDURE [CNT].[ST_MOVRecalculoSaldo] 
	-- Add the parameters for the stored procedure here
	@saldo VARCHAR(10),
	@anomes VARCHAR(6)=NULL
AS
DECLARE @anomesinicial VARCHAR(6),@rows int,@count int=1,@ok int,@periodopos VARCHAR(6),@periodo VARCHAR(6),@ContPeriodoPos int,@ContPeriodoAnt int;
DECLARE @anomesFinal VARCHAR(6),@errorPeriodo VARCHAR(100);
DECLARE @table TABLE (id int identity(1,1), anomes VARCHAR(6))		
DECLARE @tableAnomesAnticipos TABLE (id int identity(1,1), anomes VARCHAR(6),id_cuenta BIGINT,id_tercero BIGINT,id_saldo bigint);
DECLARE @Balance_current TABLE (id int identity,anomes varchar(6), id_cuenta BIGINT, saldoanterior decimal(18,2), movDebito decimal(18,2), movCredito decimal(18,2), saldoActual decimal(18,2), id_user Bigint,changed bit,before bit)
DECLARE @Balance_currentTercero TABLE (id int identity,anomes varchar(6),id_tercero BIGINT ,id_cuenta BIGINT,fechaactual SMALLDATETIME ,saldoanterior decimal(18,2), movDebito decimal(18,2), movCredito decimal(18,2), saldoActual decimal(18,2), id_user Bigint,changed bit,before bit)
DECLARE @tableAnomesProveedor TABLE (id int identity(1,1), anomes VARCHAR(6),id_cuenta BIGINT,id_tercero BIGINT,id_documento BIGINT,id_saldo BIGINT);
DECLARE @Tpend TABLE(id int , id_cuenta bigint)

DECLARE  @mensaje varchar(max),@id_cuenta BIGINT;

SET @anomesinicial = IIF(@anomes is not null,@anomes, (CASE 
															WHEN @saldo='CUENTA' THEN (select top 1 anomes from cnt.SaldoCuenta order by anomes) 
															WHEN @saldo='TERCERO' THEN (select top 1 anomes from cnt.SaldoTercero order by anomes) 
															WHEN @saldo='PROVEEDOR' THEN (select top 1 anomes from cnt.SaldoProveedor order by anomes) 
															WHEN @saldo='ANTICIPO' THEN (select top 1 anomes from cnt.SaldoAnticipos order by anomes) 
															ELSE (select top 1 anomes from cnt.SaldoCliente order by anomes) END ) )
SET @anomesFinal =											(SELECT TOP 1 ANOMES FROM CNT.PERIODOS ORDER BY ANOMES DESC)


BEGIN TRY
BEGIN TRANSACTION
IF(@saldo='CUENTA')--recalculo de saldocuentas
BEGIN

		INSERT INTO @table
		SELECT DISTINCT anomes ano
				FROM (
					SELECT  distinct CR.anomes
					FROM CNT.SaldoCuenta CR 
					WHERE SUBSTRING(@anomesinicial, 1, 4) = SUBSTRING(anomes, 1, 4)
					UNION ALL
					SELECT  F.anomes
					FROM [ST_FnAnomesPeriodo](SUBSTRING(@anomesinicial, 1, 4)) F LEFT JOIN CNT.SaldoCuenta CR ON CR.anomes = F.anomes
					WHERE CR.id IS NULL

				) AS T
				WHERE  anomes between @anomesinicial and  @anomesFinal
				ORDER BY anomes ASC;
				SET @rows = @@ROWCOUNT;
			WHILE(@rows >= @count)
				BEGIN 
				SET @periodo 		= (SELECT anomes FROM @table where id=@count)
				SET @periodopos     = (SELECT CONVERT(VARCHAR(6), dateadd(month,1, @periodo+'01'), 112));
					IF EXISTS(select 1 from cnt.Periodos where anomes=@periodopos and contabilidad=1)
					BEGIN
					delete from @Balance_current
					INSERT INTO @Balance_current(anomes, id_cuenta, saldoanterior, movDebito, movCredito, saldoActual, id_user,changed,before)
													SELECT anomes, id_cuenta, saldoanterior, movDebito debito, movCredito credito, saldoActual,1,0,1
													FROM CNT.SaldoCuenta WHERE anomes = @periodo 




						MERGE CNT.SaldoCuenta AS TARGET
						USING @Balance_current AS SOURCE 
						   ON (TARGET.id_cuenta = SOURCE.id_cuenta and TARGET.anomes=@periodopos) 
						--Cuandos los registros concuerdan con por la llave
						--se actualizan los registros si tienen alguna variación
						 WHEN MATCHED  THEN 
						   UPDATE SET TARGET.saldoanterior = SOURCE.saldoactual, 
									  TARGET.saldoActual=SOURCE.saldoActual+(TARGET.movDebito-TARGET.movCredito),
									  TARGET.changed=0,
									  TARGET.before=1
						--Cuando los registros no concuerdan por la llave
						--indica que es un dato nuevo, se inserta el registro
						--en la tabla TARGET proveniente de la tabla SOURCE
						 WHEN NOT MATCHED BY TARGET THEN 
						   INSERT (anomes,id_cuenta, saldoanterior, movDebito, movCredito, saldoActual, id_user,changed,before) 
						   VALUES (@periodopos,SOURCE.id_cuenta, SOURCE.saldoactual, 0,0, SOURCE.saldoActual,SOURCE.id_user,0,1);
						END ELSE BREAK;

				SET @count += 1;
				END


		END ELSE IF (@saldo='TERCERO')-- Recalculo de saldos terceros
		BEGIN
		INSERT INTO @table
		SELECT DISTINCT anomes ano
		FROM (
			SELECT  distinct CR.anomes
			FROM CNT.SaldoTercero CR 
			WHERE SUBSTRING(@anomesinicial, 1, 4) = SUBSTRING(anomes, 1, 4)
			UNION ALL
			SELECT  F.anomes
			FROM [ST_FnAnomesPeriodo](SUBSTRING(@anomesinicial, 1, 4)) F LEFT JOIN CNT.SaldoTercero CR ON CR.anomes = F.anomes
			WHERE CR.id IS NULL

		) AS T
		WHERE  anomes between @anomesinicial and  @anomesFinal
		ORDER BY anomes ASC;

		
		
		SET @rows = @@ROWCOUNT;
		WHILE(@rows >= @count)
				BEGIN 
				SET @periodo 		= (SELECT anomes FROM @table where id=@count)
				SET @periodopos     = (SELECT CONVERT(VARCHAR(6), dateadd(month,1, @periodo+'01'), 112));
					IF EXISTS(select 1 from cnt.Periodos where anomes=@periodopos and contabilidad=1)
					BEGIN
					delete from @Balance_currentTercero
					INSERT INTO @Balance_currentTercero(anomes,id_tercero ,id_cuenta,fechaactual ,saldoanterior, movDebito, movCredito, saldoActual, id_user,changed,before)
													SELECT anomes,id_tercero ,id_cuenta,fechaactual ,saldoanterior, movDebito debito, movCredito credito, saldoActual,1,0,1
													FROM CNT.SaldoTercero WHERE anomes = @periodo 




						MERGE CNT.SaldoTercero AS TARGET
						USING @Balance_currentTercero AS SOURCE 
						   ON (TARGET.id_cuenta = SOURCE.id_cuenta and TARGET.id_tercero=SOURCE.id_tercero and TARGET.anomes=@periodopos) 
						--Cuandos los registros concuerdan con por la llave
						--se actualizan los registros si tienen alguna variación
						 WHEN MATCHED  THEN 
						   UPDATE SET TARGET.saldoanterior = SOURCE.saldoactual, 
									  TARGET.saldoActual=SOURCE.saldoActual+(TARGET.movDebito-TARGET.movCredito),
									  TARGET.changed=0,
									  TARGET.before=1
						--Cuando los registros no concuerdan por la llave
						--indica que es un dato nuevo, se inserta el registro
						--en la tabla TARGET proveniente de la tabla SOURCE
						 WHEN NOT MATCHED BY TARGET THEN 
						   INSERT (anomes,id_tercero,id_cuenta,fechaactual ,saldoanterior, movDebito, movCredito, saldoActual, id_user,changed,before) 
						   VALUES (@periodopos,SOURCE.id_tercero,SOURCE.id_cuenta,SOURCE.fechaactual,SOURCE.saldoactual, 0,0, SOURCE.saldoActual,SOURCE.id_user,0,1);
						END ELSE BREAK;

				SET @count += 1;
				END
		UPDATE cnt.SaldoTercero SET changed=1,before=1 WHERE changed=0
		END ELSE IF(@saldo='PROVEEDOR')
		BEGIN
			INSERT INTO @table
			SELECT DISTINCT anomes ano
			FROM (
			SELECT  distinct CR.anomes
			FROM CNT.SaldoProveedor CR 
			WHERE SUBSTRING(@anomesinicial, 1, 4) = SUBSTRING(anomes, 1, 4)
			UNION ALL
			SELECT  F.anomes
			FROM [ST_FnAnomesPeriodo](SUBSTRING(@anomesinicial, 1, 4)) F LEFT JOIN CNT.SaldoProveedor CR ON CR.anomes = F.anomes
			WHERE CR.id IS NULL

		) AS T
		WHERE  anomes between @anomesinicial and  @anomesFinal
		ORDER BY anomes ASC;
		
		SET @rows = @@ROWCOUNT;
		
	WHILE(@rows >= @count)
		BEGIN 
			SET @periodo 		= (SELECT anomes FROM @table where id=@count)
			SET @periodopos     = (SELECT CONVERT(VARCHAR(6), dateadd(month,1, @periodo+'01'), 112));
			delete from @tableAnomesProveedor
			IF EXISTS(select 1 from cnt.Periodos where anomes=@periodopos and contabilidad=1)
			BEGIN
				IF NOT EXISTS (SELECT 1 FROM CNT.SaldoProveedor WHERE anomes = @periodopos)-- AND NOT EXISTS (SELECT 1 FROM CNT.Periodos WHERE anomes = @periodopos)
				BEGIN
							INSERT INTO [CNT].SaldoProveedor(anomes,id_proveedor ,id_cuenta,id_documento ,nrofactura,fechaactual,fechavencimiento,saldoanterior, movDebito, movCredito, saldoActual, id_user,changed)
							SELECT @periodopos,id_proveedor ,id_cuenta,id_documento ,nrofactura,fechaactual,fechavencimiento,saldoActual, 0 debito, 0 credito, saldoActual,1,0
							FROM CNT.SaldoProveedor WHERE anomes = @periodo and changed=0 AND saldoActual!=0 
				END ELSE
				BEGIN
					INSERT INTO @tableAnomesProveedor
					SELECT @periodopos,id_cuenta,id_proveedor,id_documento,id FROM CNT.SaldoProveedor WHERE anomes=@periodopos and id_nota is NULL
				
					UPDATE S set 
					S.saldoanterior=T.saldoActual,
					S.saldoActual=T.saldoActual+(S.movDebito-S.movCredito),
					S.changed=0
					FROM @tableAnomesProveedor c inner join (select id_cuenta,id_proveedor,id_documento,saldoActual from cnt.SaldoProveedor where anomes=@periodo and changed=0) T on c.id_cuenta=T.id_cuenta and c.id_tercero=T.id_proveedor and C.id_documento=T.id_documento inner join cnt.SaldoProveedor S on s.id=c.id_saldo

					INSERT INTO [CNT].[SaldoProveedor](anomes,id_proveedor ,id_cuenta,id_documento,nrofactura ,fechaactual,fechavencimiento,saldoanterior, movDebito, movCredito, saldoActual, id_user,changed)
					SELECT @periodopos,id_proveedor,id_cuenta,id_documento,nrofactura,fechaactual,fechavencimiento,saldoActual,0,0,saldoActual,1,0 FROM CNT.[SaldoProveedor] C where concat(id_proveedor,id_cuenta,id_documento) not in (select concat(id_tercero,id_cuenta,id_documento) from @tableAnomesProveedor) and anomes=@periodo and changed=0 AND saldoActual!=0

				END
			END ELSE BREAK;

			SET @count += 1;

			END
				UPDATE cnt.SaldoProveedor SET changed=1 WHERE changed=0

		END ELSE IF(@saldo='CLIENTE')
				BEGIN
					DECLARE @tableAnomesCliente TABLE (id int identity(1,1), anomes VARCHAR(6),id_cuenta BIGINT,id_tercero BIGINT,factura VARCHAR(50),id_saldo BIGINT);
					DECLARE @tableAnomesClienteCuotas TABLE (id int identity(1,1), anomes VARCHAR(6),id_cuenta BIGINT,id_tercero BIGINT,factura VARCHAR(50),cuota int,id_saldo BIGINT);
											INSERT INTO @table
					SELECT DISTINCT anomes ano
							FROM (
								SELECT  distinct CR.anomes
								FROM CNT.SaldoCliente CR 
								WHERE SUBSTRING(@anomesinicial, 1, 4) = SUBSTRING(anomes, 1, 4)
								UNION ALL
								SELECT  F.anomes
								FROM [ST_FnAnomesPeriodo](SUBSTRING(@anomesinicial, 1, 4)) F LEFT JOIN CNT.SaldoCliente CR ON CR.anomes = F.anomes
								WHERE CR.id IS NULL

							) AS T
							WHERE  anomes between @anomesinicial and  @anomesFinal
							ORDER BY anomes ASC;
					SET @rows = @@ROWCOUNT;
		
					WHILE(@rows >= @count)
						BEGIN 
							SET @periodo     = (SELECT anomes FROM @table where id=@count)
							SET @periodopos  = (SELECT CONVERT(VARCHAR(6), dateadd(month,1, @periodo+'01'), 112));
							DELETE FROM @tableAnomesCliente
							IF EXISTS(select 1 from cnt.Periodos where anomes=@periodopos and contabilidad=1)
									BEGIN
										IF NOT EXISTS (SELECT 1 FROM CNT.SaldoCliente WHERE anomes = @periodopos) 
										BEGIN
											INSERT INTO [CNT].SaldoCliente(anomes,id_cliente ,id_cuenta,id_documento ,nrofactura,fechaactual,fechavencimiento,saldoanterior, movDebito, movCredito, saldoActual, id_user,changed)
											SELECT @periodopos,id_cliente ,id_cuenta,id_documento ,nrofactura,fechaactual,fechavencimiento,saldoActual, 0 debito, 0 credito, saldoActual,1,0
											FROM CNT.SaldoCliente WHERE anomes = @periodo and changed=0 AND saldoActual!=0 

						
											INSERT INTO [CNT].SaldoCliente_Cuotas (anomes,id_cliente,id_cuenta,nrofactura,cuota,saldoAnterior,movdebito,movCredito,saldoActual,vencimiento_cuota,fechapagointeres,id_user)
											SELECT @periodopos,id_cliente ,id_cuenta ,nrofactura,cuota,saldoActual, 0 debito, 0 credito, saldoActual,vencimiento_cuota,vencimiento_cuota,1
											FROM CNT.SaldoCliente_Cuotas WHERE anomes = @periodo and changed=0 AND saldoActual!=0 and id_devolucion is null and id_nota is null
										END 
										ELSE
										BEGIN
											INSERT INTO @tableAnomesCliente
											SELECT @periodopos,id_cuenta,id_cliente,nrofactura,id FROM CNT.Saldocliente WHERE anomes=@periodopos and id_nota is NULL
				
				
											UPDATE S set 
											S.saldoanterior=T.saldoActual,
											S.saldoActual=T.saldoActual+(S.movDebito-S.movCredito),
											S.changed=0
											FROM @tableAnomesCliente c inner join (select id_cuenta,id_cliente,nrofactura,saldoActual from cnt.SaldoCliente where anomes=@periodo and changed=0) T on c.id_cuenta=T.id_cuenta and c.id_tercero=T.id_cliente and C.factura=T.nrofactura inner join cnt.SaldoCliente S on s.anomes=c.anomes and s.id_cuenta=c.id_cuenta and s.nrofactura=c.factura and s.id_cliente=c.id_tercero

											INSERT INTO [CNT].SaldoCliente(anomes,id_cliente ,id_cuenta,id_documento ,nrofactura,fechaactual,fechavencimiento,saldoanterior, movDebito, movCredito, saldoActual, id_user,changed)
											SELECT @periodopos,id_cliente,id_cuenta,c.id_documento,nrofactura,fechaactual,fechavencimiento,saldoActual,0,0,saldoActual,1,0 FROM CNT.[SaldoCliente] C where concat(id_cliente,id_cuenta,nrofactura) not in (select concat(id_tercero,id_cuenta,factura) from @tableAnomesCliente) and anomes=@periodo and changed=0 AND saldoActual!=0 and id_nota is null and id_devolucion is null
				
											DELETE FROM @tableAnomesClienteCuotas
											INSERT INTO @tableAnomesClienteCuotas
											SELECT @periodopos,id_cuenta,id_cliente,nrofactura,cuota,id FROM CNT.SaldoCliente_Cuotas WHERE anomes=@periodopos and id_nota is NULL and id_devolucion is null
				
											UPDATE S set 
											S.saldoanterior=T.saldoActual,
											S.saldoActual=T.saldoActual+(S.movDebito-S.movCredito),
											S.changed=0
											FROM @tableAnomesClienteCuotas c inner join (select id_cuenta,id_cliente,nrofactura,cuota,vencimiento_cuota,saldoActual from cnt.SaldoCliente_Cuotas where anomes=@periodo and changed=0 ) T on c.id_cuenta=T.id_cuenta and c.id_tercero=T.id_cliente and C.factura=T.nrofactura and c.cuota=T.cuota  inner join cnt.SaldoCliente_Cuotas S on s.anomes=c.anomes and s.id_cuenta=c.id_cuenta and s.nrofactura=c.factura and s.id_cliente=c.id_tercero and S.cuota=C.cuota --and S.id_nota is not null

											INSERT INTO [CNT].SaldoCliente_Cuotas (anomes,id_cliente,id_cuenta,nrofactura,cuota,saldoAnterior,movdebito,movCredito,saldoActual,vencimiento_cuota,fechapagointeres,changed,before,id_user)
											SELECT @periodopos,id_cliente,id_cuenta,nrofactura,cuota,saldoActual,0,0,saldoActual,vencimiento_cuota,vencimiento_cuota,0,0,1 FROM CNT.[SaldoCliente_Cuotas] C where concat(id_cliente,id_cuenta,nrofactura) not in (select concat(id_tercero,id_cuenta,factura) from @tableAnomesClienteCuotas) and anomes=@periodo and changed=0 AND saldoActual!=0 and id_nota is null and id_devolucion is null
				
										END
		        					END ELSE BREAK;
									
									SET @count += 1;

						END
						UPDATE cnt.SaldoCliente SET changed=1 WHERE changed=0
						UPDATE cnt.SaldoCliente_Cuotas SET changed=1 WHERE changed=0
				END ELSE IF(@saldo='ANTICIPO')
				BEGIN
					INSERT INTO @table
		SELECT DISTINCT anomes ano
		FROM (
			SELECT  distinct CR.anomes
			FROM CNT.SaldoAnticipos CR 
			WHERE SUBSTRING(@anomesinicial, 1, 4) = SUBSTRING(anomes, 1, 4)
			UNION ALL
			SELECT  F.anomes
			FROM [ST_FnAnomesPeriodo](SUBSTRING(@anomesinicial, 1, 4)) F LEFT JOIN CNT.SaldoAnticipos CR ON CR.anomes = F.anomes
			WHERE CR.id IS NULL

		) AS T
		WHERE  anomes between @anomesinicial and  @anomesFinal
		ORDER BY anomes ASC;

		
		
		SET @rows = @@ROWCOUNT;
		WHILE(@rows >= @count)
		BEGIN 
			SET @periodo 	 =(SELECT anomes FROM @table where id=@count)
			SET @periodopos  = (SELECT CONVERT(VARCHAR(6), dateadd(month,1, @periodo+'01'), 112));
			delete from @tableAnomesAnticipos
			IF EXISTS(select 1 from cnt.Periodos where anomes=@periodopos and contabilidad=1)
			BEGIN
				IF NOT EXISTS (SELECT 1 FROM CNT.SaldoAnticipos WHERE anomes = @periodopos)-- AND NOT EXISTS (SELECT 1 FROM CNT.Periodos WHERE anomes = @periodopos)
				BEGIN
							INSERT INTO [CNT].[SaldoAnticipos](anomes,id_tercero ,id_cuenta ,saldoanterior, movDebito, movCredito, saldoActual,changed,before)
							SELECT @periodopos,id_tercero ,id_cuenta ,saldoactual, 0 debito, 0 credito, saldoActual,0,1
							FROM CNT.SaldoAnticipos WHERE anomes = @periodo and changed=0 AND saldoActual!=0

			
				END ELSE
				BEGIN
					INSERT INTO @tableAnomesAnticipos
					SELECT @periodopos,id_cuenta,id_tercero,id FROM CNT.SaldoAnticipos WHERE anomes=@periodopos 
				
				
					UPDATE S set 
					S.saldoanterior=T.saldoActual,
					S.saldoActual=T.saldoActual+(S.movDebito-S.movCredito),
					S.changed=0,
					S.before=1
					FROM @tableAnomesAnticipos c inner join (select id_cuenta,id_tercero,saldoActual from cnt.SaldoAnticipos where anomes=@periodo and changed=0) T on c.id_cuenta=T.id_cuenta and c.id_tercero=T.id_tercero inner join cnt.SaldoAnticipos S on s.id=c.id_saldo
				
					INSERT INTO [CNT].[SaldoAnticipos](anomes,id_tercero ,id_cuenta,saldoanterior, movDebito, movCredito, saldoActual,changed,before)
					SELECT @periodopos,id_tercero,id_cuenta,saldoActual,0,0,saldoActual,0,1 FROM CNT.SaldoAnticipos C where concat(id_tercero,id_cuenta) not in (select concat(id_tercero,id_cuenta) from @tableAnomesAnticipos) and anomes=@periodo and changed=0 AND saldoActual!=0

				END
			END ELSE  BREAK;
		SET @count += 1;
		END
		UPDATE cnt.SaldoAnticipos SET changed=1,before=1 WHERE changed=0
				END
COMMIT TRANSACTION;
END TRY
BEGIN CATCH	
	ROLLBACK TRANSACTION;
	SET @mensaje = 'Error: '+ERROR_MESSAGE();
	RAISERROR(@Mensaje,16,0);	
END CATCH




