--liquibase formatted sql
--changeset ,kmartinez:4 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[FIN].[DatosCuotasFacturaFinan]') and OBJECTPROPERTY(id, N'IsTableFunction') = 1)
DROP FUNCTION [FIN].[DatosCuotasFacturaFinan]
GO

CREATE FUNCTION  [FIN].[DatosCuotasFacturaFinan] (@id_saldo VARCHAR(30), @fecha VARCHAR(10))
RETURNS @TblResultante  TABLE ( Id Int Identity (1,1) Not Null, Capital NUMERIC(18,2), DiasAnticipado INT, creditointeres NUMERIC(18,2), fechavencimiento VARCHAR(10), 
								valorcuota NUMERIC(18,2),saldocuota Numeric(18,2),cuotapendiente int,diasvencido int,interesabono NUMERIC(18,2), valorIva NUMERIC(18,2))

As
BEGIN
	Declare  @vencimiento VARCHAR(10), @Vlrcuota NUMERIC(18,2) = 0, @abono NUMERIC(18,2) = 0, @salCuota NUMERIC(18,2) = 0, @cuotaPend INT, @dias NUMERIC(18,2) = 0, @valorIva NUMERIC(18,2), @porcenIva NUMERIC(18,2),  
			 @id_cuota BIGINT, @AbonoInMora NUMERIC(18,2), @AbonoInCorriente NUMERIC(18,2), @fecha_inicial varchar(10), @interes NUMERIC(18,2),
			 @interes_cre NUMERIC(18,2),  @porcentaje float, @saldo NUMERIC(18,2),  @diasInteres INT,  @TotalFac  NUMERIC(18,2), @diasInterespaagos INT=0,
			 @diasCorrientePagado NUMERIC(18,2), @AbonoInMo NUMERIC(18,2), @pagoTotal_InCorriente NUMERIC(18,2), @anomes VARCHAR(6) = @fecha, @diasmora NUMERIC(18,2) = 0;

		SELECT TOP 1	@id_cuota	= id,
						@vencimiento = IIF(fechapagointeres = vencimiento_cuota,  IIF((CAST(@fecha as date) > CAST(vencimiento_cuota as date)),
						convert(varchar, CAST(vencimiento_cuota as date), 23) ,''), 
						convert(varchar, CAST(fechapagointeres as date), 23)),
						@Vlrcuota =  CuotaFianza,
						@interes = interes,
						@abono = abono, 
						@cuotaPend = cuota,
						@fecha_inicial = convert(varchar, CAST(fecha_inicial as date), 23),
						@porcentaje = porcentaje,
						@saldo = acapital - (abono - AbonoInteres),
						@porcenIva = porcenIva,
						@TotalFac = saldo_anterior,
						@diasmora = s.diasmora,
						@diasCorrientePagado = diasintcorpagados,
						@AbonoInCorriente = AbonoInteres
		FROM [FIN].[SaldoCliente_Cuotas] s 
		WHERE numfactura = @id_saldo AND anomes = CONVERT(VARCHAR(6), @fecha) and cancelada=0 and devolucion=0 AND anomes = @anomes order by id
	 	
		SET @salCuota		=   @Vlrcuota-@abono;
		SET @dias			=  CASE WHEN @vencimiento='' THEN 0 ELSE DATEDIFF(DD, @vencimiento,@fecha) END - @diasmora
		SET @diasInteres	=  CASE WHEN @vencimiento='' THEN DATEDIFF(day, @fecha_inicial,@fecha)  ELSE  0 END
	
		SET @interes_cre =  (CASE WHEN @dias = 0 THEN (@TotalFac *( @porcentaje/30) * @diasInteres/ 100) ELSE  @interes  END)

		SET @AbonoInMo = 0
 	
		SET @valorIva = 0
	
		SELECT @diasInterespaagos = 0

		SELECT @pagoTotal_InCorriente= 0
	
		Insert Into @TblResultante (Capital, DiasAnticipado, creditointeres, fechavencimiento, valorcuota, saldocuota, cuotapendiente, diasvencido, interesabono, valorIva)
		Values(@saldo, CASE WHEN @diasInteres < 0 THEN 0 ELSE @diasInteres END,
		CASE WHEN @interes_cre < 0 THEN 0 ELSE CASE WHEN @AbonoInCorriente > 0 THEN case when (@interes_cre - @AbonoInCorriente) < 0 then 0 else (@interes_cre - @AbonoInCorriente) end  ELSE CASE WHEN @AbonoInCorriente!=0 THEN 0 ELSE CASE WHEN  @pagoTotal_InCorriente != 0 THEN 0 ELSE @interes_cre END END END END , 
		@vencimiento , @Vlrcuota,  @salCuota,  @cuotaPend, CASE WHEN @dias-@diasInterespaagos < 0 THEN 0 ELSE @dias-@diasInterespaagos END,  @AbonoInMo,  CASE WHEN @valorIva > 0 THEN @valorIva ELSE 0 END);	
	RETURN
End
