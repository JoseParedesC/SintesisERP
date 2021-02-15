--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_FnValorConcepto]') and OBJECTPROPERTY(id, N'IsTableFunction') = 1)
DROP FUNCTION [dbo].[ST_FnValorConcepto]
GO
CREATE Function  Dbo.ST_FnValorConcepto (@id_concepto INT, @valor NUMERIC(18,2))
RETURNS @TblResultante  TABLE (Id Int Identity (1,1) Not Null, valor  NUMERIC(18,2), iva  NUMERIC(18,2), total NUMERIC(18,2), poriva numeric(18,2))
--With Encryption 
As
BEGIN
	Declare  @valvalor NUMERIC(18,2),
			 @valiva NUMERIC(18,2),
			 @iva BIt,
			 @ivaincluido BIT,
			 @porceniva NUMERIC(18,2);

	SELECT TOP 1 @iva = iva, @ivaincluido = ivaincluido, @porceniva = A.porceniva
	From Dbo.Conceptos A Where id = @id_concepto;
	
	SET @valvalor = CASE WHEN @iva = 0 or (@iva = 1 And @ivaincluido = 0) 
						 Then @valor 
						 Else @valor / (1 +(@porceniva / 100)) End;
						 	
	SET @valiva = @valvalor * (@porceniva / 100);
	
	Insert Into @TblResultante (valor, iva, total, poriva)
	Values(@valvalor, @valiva, (@valvalor + @valiva), @porceniva);	
	
	RETURN
End
GO
