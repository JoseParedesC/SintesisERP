--liquibase formatted sql
--changeset ,jteheran:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[ST_MOVReajusteCuotas]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [CNT].[ST_MOVReajusteCuotas]
GO

CREATE PROCEDURE [CNT].[ST_MOVReajusteCuotas]
@id_cliente BIGINT,
@id_cuenta BIGINT,
@nrofactura VARCHAR(50),
@id_nota bigint,
@anomes VARCHAR(6),
@totaldevolucion NUMERIC(18,2),
@id_user BIGINT


--WITH ENCRYPTION
/***************************************
*Nombre:		[CNT].[ST_MOVReajusteCuotas]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		20/07/2020
*Desarrollador: (Jeteme)

SP actualiza saldo de clientes 
***************************************/
AS	

DECLARE @miCTE table(id BIGINT,id_saldocuota BIGINT ,cuota NUMERIC(18,2),  saldo NUMERIC(18,2))
Declare @total numeric(18,2),@valcuota Numeric(18,2),@valor Numeric(18,2),@numcuotas Numeric(18,2),@id_saldocuota INT,@id_saldo BIGINT,@id_documento BIGINT;
BEGIN TRY	
	

	Select @valor=saldoActual,@id_saldo=id_saldonota,@id_cliente=id_cliente,@id_documento=id_documento from CNT.SaldoCliente where id_cliente=@id_cliente and id_cuenta=@id_cuenta and nrofactura=@nrofactura and id_nota is null and anomes=@anomes
	
	
			Select @numcuotas= count(*) from CNT.SaldoCliente_Cuotas C where C.id_cliente=@id_cliente and id_cuenta=@id_cuenta and nrofactura=@nrofactura and C.cancelada=0 and C.id_devolucion is null and c.anomes=@anomes and C.id_nota is NULL
			Set @id_saldocuota = (SELECT TOP 1 cuota from CNT.SaldoCliente_Cuotas C  where C.id_cliente=@id_cliente and id_cuenta=@id_cuenta and nrofactura=@nrofactura and C.cancelada=0 and C.id_devolucion is null and C.anomes=@anomes AND C.id_nota is NULL order by C.id)
			SET @valcuota	= CASE WHEN (@numcuotas>1) THEN (CONVERT(DECIMAL(18,0),ROUND(@valor / @numcuotas, -2))) ELSE @valor END;
			SET @total		= @valor;
			
			

			;WITH miCTE (id,id_saldocuota ,cuota,  saldo) AS(
			   SELECT 1,@id_saldocuota ,CONVERT(DECIMAL(18,0),@valcuota), 
					CONVERT(DECIMAL(18,0), @total - @valcuota) saldo
					
			   UNION ALL
			   SELECT 
					id + 1,
					id_saldocuota+1 			
					,CONVERT(DECIMAL(18,0), CASE WHEN id+1 < @numcuotas THEN @valcuota ELSE CONVERT(DECIMAL(18,0), @total - (@valcuota * (id))) END),
					CASE WHEN @total - @valcuota * (id+1) < @valcuota AND id+1 = @numcuotas  THEN 0 ELSE 
					CONVERT(DECIMAL(18,0), @total - @valcuota * (id+1)) END
			   FROM miCTE
			   WHERE id +1 <= @numcuotas
			)
			INSERT INTO @miCTE
			Select * from miCTE
			
			IF(@totaldevolucion<@valor)
				UPDATE S SET S.id_devolucion=@id_nota  FROM @miCTE C INNER JOIN CNT.SaldoCliente_Cuotas S ON C.id_saldocuota=S.cuota AND S.id_cliente=@id_cliente and nrofactura=@nrofactura and id_cuenta=@id_cuenta and id_devolucion is null and id_nota is null and cancelada=0 and anomes=@anomes
			ELSE
				UPDATE S SET S.id_devolucion=@id_nota FROM CNT.SaldoCliente_Cuotas S WHERE S.id_cliente=@id_cliente and nrofactura=@nrofactura and id_cuenta=@id_cuenta and id_devolucion is null and id_nota is null and anomes=@anomes

		IF(@valor>0)
		BEGIN
			INSERT INTO [CNT].[SaldoCliente_Cuotas](anomes,id_cliente,id_cuenta,nrofactura, cuota,saldoAnterior ,movdebito,  movCredito,saldoActual,vencimiento_cuota, fechapagointeres,id_user)
			Select S.anomes,@id_cliente,@id_cuenta,@nrofactura,C.id,0,C.cuota,0,C.cuota,S.vencimiento_cuota,S.fechapagointeres,@id_user  FROM @miCTE C INNER JOIN CNT.SaldoCliente_Cuotas S ON C.id_saldocuota=S.cuota AND S.id_cliente=@id_cliente and nrofactura=@nrofactura and id_cuenta=@id_cuenta and id_devolucion=@id_nota and id_nota is null and cancelada=0 and @anomes=anomes
		END
END TRY
BEGIN CATCH
	DECLARE @Mensajee varchar(max) = (select ERROR_MESSAGE())
	RAISERROR(@Mensajee,16,0);
END CATCH

GO


