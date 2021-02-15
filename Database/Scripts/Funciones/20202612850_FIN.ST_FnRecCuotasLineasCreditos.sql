--liquibase formatted sql
--changeset ,kmartinez:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[FIN].[ST_FnRecCuotasLineasCreditos]') and OBJECTPROPERTY(id, N'IsTableFunction') = 1)
DROP FUNCTION [FIN].[ST_FnRecCuotasLineasCreditos]
GO

CREATE Function [FIN].[ST_FnRecCuotasLineasCreditos] (@SelectCredito BIGINT, @idToken varchar(255), @valor numeric(18,2), @numcuotas INT, @vencimiento INT, @venini varchar(10), @dias int)

RETURNS @TblResultante  TABLE (cuota int, saldo numeric(18,2), interes numeric(18,2), porcentaje numeric(18,2), FechaInicio varchar(10), vencimiento varchar(10), Valorcuota numeric(18,2), Acapital numeric(18,2),
SaldoAnterior numeric(18,2))
 
As
BEGIN

	DECLARE @Prestamo FLOAT, @Periodos INT, @Tasa FLOAT, @porcentaActual FLOAT;
	DECLARE @TasaMens FLOAT, @TasaT1 FLOAT, @CuotaC1 FLOAT, @CuotaC1mT1 FLOAT, @Amortizacion FLOAT, @UltAmortizado FLOAT, @TotAmortizado FLOAT,
	@Cuota FLOAT, @Total FLOAT, @Interes FLOAT, @Contador int = 1;
 
	DECLARE @error VARCHAR(MAX), @id int, @valcuota FLOAT,   @porcentajeCre FLOAT, @fecha varchar(10), @porivafin NUMERIC(18,2), @ivaincluido BIT;

	DECLARE @TblResulTemp TABLE(cuota int, saldo DECIMAL(18,2), interes DECIMAL(18,2), FechaInicio varchar(10), vencimiento varchar(10), Valorcuota DECIMAL(18,2), Acapital DECIMAL(18,2), SaldoAnterior DECIMAL(18,2));	 	  
 
	(SELECT top 1 @porcentajeCre = Porcentaje, @porivafin = porcenIva, @ivaincluido = ivaIncluido
	FROM [FIN].[LineasCreditos] WHERE id = @SelectCredito);  
	 
	SET @Prestamo = @valor
	SET @Periodos = @numcuotas
 
 	Set @TasaMens= ((@porcentajeCre / 100));
	Set @TasaT1=(@Prestamo*@TasaMens)
	Set @CuotaC1=@Prestamo*((power(1+@TasaMens,@Periodos)*@TasaMens)/(power(1+@TasaMens,@Periodos)-1))
	Set @CuotaC1mT1=(@CuotaC1-@TasaT1)
 

	Set @Amortizacion=(@CuotaC1-@TasaT1)
	Set @UltAmortizado=@CuotaC1-@TasaT1
	Set @Total=@Prestamo-@Amortizacion
	

    SET	@fecha = CONVERT(VARCHAR(10), DATEADD(m, -1 ,CAST(REPLACE(@venini,'-','')as date)), 120)
	While @Contador <= @Periodos
	Begin
		
		SET @TasaT1 = CASE WHEN @ivaincluido != 0 THEN @TasaT1 / (1 + (@porivafin / 100)) ELSE  @TasaT1 END
		SET @Interes = (@Prestamo-@CuotaC1mT1*(power(1+@TasaMens,@Contador)-1)/@TasaMens) * @TasaMens

		Set @Cuota = @Prestamo*((power(1+@TasaMens,@Periodos)*@TasaMens)/(power(1+@TasaMens,@Periodos)-1))
	 
		INSERT INTO @TblResulTemp (cuota, saldo, interes, FechaInicio, vencimiento, Valorcuota, Acapital, SaldoAnterior)
		VALUES(@Contador,
			CASE WHEN (select SUM(Acapital) FROM @TblResulTemp) - @Prestamo < 0 AND @Contador = @Periodos-1  THEN (@Amortizacion + ((select SUM(Acapital) FROM @TblResulTemp) - @Prestamo)) * -1 ELSE @total end,
			@TasaT1,
			@fecha,
		    DATEADD(m, @Contador-1 ,CAST(REPLACE(@venini,'-','')as date)),
			@Cuota, 
			CASE WHEN (select SUM(Acapital) FROM @TblResulTemp) - @Prestamo < 0 and @Contador = @Periodos THEN  ((select SUM(Acapital) FROM @TblResulTemp) - @Prestamo) * -1  ELSE 
			@Amortizacion END,
			CASE WHEN (select SUM(Acapital) FROM @TblResulTemp) - @Prestamo < 0 AND @Contador = @Periodos  THEN @total+@Amortizacion + (@Amortizacion + ((select SUM(Acapital) FROM @TblResulTemp) - @Prestamo)) * -1 ELSE @total+@Amortizacion end
			 )
			  
		SET	@fecha = (SELECT vencimiento FROM @TblResulTemp where cuota = @Contador);
		SET @Amortizacion = (@Cuota - @Interes)
		SET @Total = @Total-@Amortizacion
		SET @TasaT1 = @Interes
		SET @Contador=@Contador+1		

	end 
 
    Insert Into @TblResultante(cuota, saldo, interes, porcentaje, FechaInicio, vencimiento, valorcuota, Acapital, SaldoAnterior)
	SELECT cuota, saldo, interes, @porcentajeCre, FechaInicio , vencimiento, Valorcuota, Acapital, SaldoAnterior  FROM @TblResulTemp;
 
 RETURN
End