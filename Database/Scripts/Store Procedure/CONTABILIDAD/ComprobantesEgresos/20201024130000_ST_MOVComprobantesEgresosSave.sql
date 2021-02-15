--liquibase formatted sql
--changeset ,jteheran:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[ST_MOVComprobantesEgresosSave]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [CNT].[ST_MOVComprobantesEgresosSave]
GO

CREATE PROCEDURE [CNT].[ST_MOVComprobantesEgresosSave]
@id BIGINT = null,
@id_tipodoc BIGINT,
@id_centrocosto BIGINT,
@fecha smalldatetime,
@id_proveedor BIGINT,
@valorprov NUMERIC(18,2),
@valorconcepto NUMERIC(18,2),
@id_ctaant BIGINT,
@valoranticipo NUMERIC(18,2),
@cambio NUMERIC(18,2),
@pagosXml VARCHAR(MAX),
@detalle VARCHAR(MAX),
@conceptosxml VARCHAR(MAX),
@formapago XML,
@id_user BIGINT

--WITH ENCRYPTION
AS

/***************************************
*Nombre:		[CNT].[ST_MOVComprobantesEgresosSave]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		31/12/19
*Desarrollador: (Jeteme)

SP para insertar Comprobantes de egresos
***************************************/

BEGIN TRANSACTION
BEGIN TRY

	DECLARE  @id_return INT,@numeropagos INT, @error VARCHAR(MAX),@numfactura VARCHAR(50),@identrada BIGINT,@manejador int,@idoc INT,@cdoc INT,@mydoc xml,@conxml xml,@valortotal numeric (18,2),@valorTransa NUMERIC(18,2),@anomes VARCHAR(6),@fechadoc VARCHAR(10),@Valor NUMERIC(18,2);
	DECLARE @tabla TABLE(id_record INT IDENTITY(1,1) ,id_pk INT );
	DECLARE @tableforma TABLE (id int identity (1,1), id_forma BIGINT, valor numeric(18,2), voucher varchar(200));

	SET @anomes   = CONVERT(VARCHAR(6), @fecha, 112);
	SET @fechadoc = CONVERT(VARCHAR(10), @fecha, 120);

			EXECUTE [Dbo].ST_ValidarPeriodo
					@fecha			= @fechadoc,
					@anomes			= @anomes,
					@mod			= 'C'
	
	SET @mydoc=@pagosXml
	IF(Isnull(@id,0) = 0)
	BEGIN		
	

		INSERT INTO [CNT].[MOVComprobantesEgresos]([id_tipodoc],[id_centrocosto],[fecha],[id_proveedor], [cambio], [valorpagado], [valorconcepto],[id_ctaant],[valoranticipo],[estado] ,[detalle],[id_usercreated],[id_userupdated])
		VALUES (@id_tipodoc,@id_centrocosto,@fecha,@id_proveedor, @cambio,@valorprov,@valorconcepto,@id_ctaant,@valoranticipo,Dbo.ST_FnGetIdList('PROCE'),@detalle,@id_user,@id_user);
		SET @id = SCOPE_IDENTITY();
	END

	EXEC sp_xml_preparedocument @idoc OUTPUT, @mydoc
	INSERT INTO [CNT].[MOVComprobantesEgresosItems]( [id_documento], [valor],[nrofactura],[id_Comprobante],[id_usercreated])
	SELECT *,@id,@id_user FROM OPENXML(@idoc,'/root/pago') WITH (identrada INT, valor NUMERIC (18,2),factura Varchar(50))

	INSERT INTO @tabla(id_pk) SELECT id FROM CNT.MOVComprobantesEgresosItems WHERE id_comprobante=@id
	
	DECLARE @count INT = (SELECT COUNT(1) FROM @tabla)
	
	SET @valortotal=0

	WHILE @count > 0
	BEGIN
		SELECT TOP 1 @identrada =  S.id_documento,@Valor=p.valor,@numfactura=p.nrofactura FROM @tabla t INNER JOIN cnt.MOVComprobantesEgresosItems p ON t.id_pk=p.id INNER JOIN CNT.SaldoProveedor S ON p.id_documento=S.id ORDER BY id_record
		DECLARE @ide INT = (SELECT TOP(1) id_record FROM @tabla ORDER BY id_record)
		
		
		EXEC CNT.[ST_MOVSaldoProveedor] @Opcion='I',@id=@identrada,@id_proveedor=@id_proveedor,@tipo='',@pago=@Valor,@id_Pagoprov=@id,@id_user=@id_user,@anomes=@anomes,@nroFactura=@numfactura;
		
		SET @valortotal=@valortotal+@Valor
		
		DELETE @tabla WHERE id_record=@ide
		
		SET @count = (SELECT COUNT(1) FROM @tabla)
	END
		
     IF(@conceptosxml!='')--Con esta condicion valido si este comprobante de egreso tiene movimiento con conceptos
			BEGIN
			 SET @conxml=@conceptosxml
			 EXEC sp_xml_preparedocument @cdoc OUTPUT, @conxml
			 INSERT INTO CNT.MOVComprobantesEgresosConcepto(id_comprobante,id_concepto,valor,id_usercreated)
			 SELECT @id,id_concepto,valor,@id_user FROM OPENXML(@cdoc,'/items/item') WITH (id_concepto INT,valor NUMERIC (18,2))
			 END

			EXEC sp_xml_preparedocument @manejador OUTPUT, @formapago; 	

			INSERT INTO @tableforma (id_forma, valor, voucher)
			SELECT idforma, SUM(valor) val, vouch
			FROM OPENXML(@manejador, N'Formas/item') 
			WITH (  idforma		[int]			'@idforma',
					valor		[NUMERIC](18,2) '@valor',
					vouch		[varchar](200)	'@vouch'
					) AS P
			INNER JOIN [FormaPagos] FP ON FP.id = P.idforma
			GROUP BY P.idforma, vouch
								
			EXEC sp_xml_removedocument @manejador;

			INSERT INTO CNT.MOVComprobanteEgresoFormaPago(id_comprobante, id_formapago, voucher, valor, codcuenta, id_user)
			SELECT @id, T.id_forma, T.voucher, T.valor, F.id_cuenta, @id_user
			FROM @tableforma T INNER JOIN FormaPagos F ON F.id = T.id_forma
		
			EXEC CNT.ST_MOVTransacciones                @id=@id,@id_user= @id_user,@nombreView='CNT.VW_TRANSACIONES_COMPROBANTESEGRESO';--Se alimenta la tabla transacciones
			EXEC CNT.ST_MOVSaldoCuenta      @opcion='I',@id=@id,@id_user= @id_user,@nombreView='CNT.VW_TRANSACIONES_COMPROBANTESEGRESO'--Se alimenta la tabla saldocuentas cada una tiene su recalculo
			EXEC CNT.ST_MOVSaldoTerceronew  @opcion='I',@id=@id,@id_user= @id_user,@nombreView='CNT.VW_TRANSACIONES_COMPROBANTESEGRESO'-- Se alimenta la tabla saldoterceros cada una tiene su recalculo
		
			SET @valorTransa=(SELECT SUM(VALOR) FROM CNT.Transacciones WHERE tipodocumento='CE' AND nrodocumento=@id)

			IF(@valorTransa!=0)
			RAISERROR('Movimiento Descuadrado ',16,0);
			--Recalculo de tabla SaldoProveedor
			EXEC [CNT].[ST_MOVRecalculoSaldo] @saldo='PROVEEDOR',@anomes=@anomes;
		    SELECT @id id_pagoprov,@valortotal Valortotal

COMMIT TRANSACTION;
END TRY
BEGIN CATCH
	SET @error = 'Error: '+ERROR_MESSAGE();
	RAISERROR(@error,16,0);		
	ROLLBACK TRANSACTION;
END CATCH

SELECT @id_return;
GO


