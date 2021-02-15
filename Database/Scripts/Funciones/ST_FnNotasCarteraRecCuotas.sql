--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[ST_FnNotasCarteraRecCuotas]') and OBJECTPROPERTY(id, N'IsTableFunction') = 1)
DROP FUNCTION [CNT].[ST_FnNotasCarteraRecCuotas]
GO


CREATE Function  [CNT].[ST_FnNotasCarteraRecCuotas] (@cuotaNro INT, @valor NUMERIC(18,2), @numcuotas INT, @vencimiento INT, @venini varchar(10), @dias int)
RETURNS @TblResultante  TABLE ( id int identity(1,1),cuotanro int ,valorcuota decimal(18,0), vencimiento varchar(10), saldo decimal(18,0))

--With Encryption 
As
BEGIN
	DECLARE @error VARCHAR(MAX), @id int, @total decimal(18,4), @valcuota decimal(18,4), @optven int;

	SELECT @optven = CASE WHEN iden = 'UMV' THEN 2 WHEN iden = 'XDV' THEN 1 WHEN iden = 'EDV' THEN 3 ELSE 0 END 
	FROM ST_Listados WHERE id = @vencimiento;	
		
	SET @valcuota	= CASE WHEN (@numcuotas>1) THEN (CONVERT(DECIMAL(18,0),ROUND(@valor / @numcuotas, -2))) ELSE @valor END;
	SET @total		= @valor;
			
	;WITH miCTE (id,nrocuota, cuota, vencimiento, saldo) AS(
	   SELECT 1, @cuotaNro,CONVERT(DECIMAL(18,0),@valcuota), 
			CASE WHEN @optven = 2 THEN EOMONTH(CAST(REPLACE(@venini,'-','') AS DATE)) 
				 ELSE CAST(REPLACE(@venini,'-','') AS DATE) END,
			CONVERT(DECIMAL(18,0), @total - @valcuota) saldo
	   UNION ALL
	   SELECT 
			id + 1 			
			,nrocuota+1,CONVERT(DECIMAL(18,0), CASE WHEN id+1 < @numcuotas THEN @valcuota ELSE CONVERT(DECIMAL(18,0), @total - (@valcuota * (id))) END),
			CASE 
				WHEN @optven = 1 THEN DATEADD(d , @dias , vencimiento)
				WHEN @optven = 2 THEN EOMONTH(DATEADD(m , 1 , vencimiento))
				WHEN @optven = 3 THEN DATEADD(m , id , CAST(REPLACE(@venini,'-','') AS DATE))
				ELSE CAST(REPLACE(@venini,'-','') AS DATE) END,
			CASE WHEN @total - @valcuota * (id+1) < @valcuota AND id+1 = @numcuotas  THEN 0 ELSE 
			CONVERT(DECIMAL(18,0), @total - @valcuota * (id+1)) END
	   FROM miCTE
	   WHERE id +1 <= @numcuotas
	)

	Insert Into @TblResultante(cuotanro,valorcuota, saldo, vencimiento)
	SELECT nrocuota,cuota, saldo, CONVERT(VARCHAR(10), vencimiento, 112) vencimiento  FROM miCTE;

	RETURN
End
GO


