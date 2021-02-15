--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[ST_FnCalTotalComprobante]') and OBJECTPROPERTY(id, N'IsTableFunction') = 1)
DROP FUNCTION [CNT].[ST_FnCalTotalComprobante]
GO



CREATE Function  [CNT].[ST_FnCalTotalComprobante] (@id_comprobante BIGINT,@op CHAR(1))
RETURNS @TblResultante  TABLE ( Id Int Identity (1,1) Not Null, Tdebito NUMERIC(18,2), 
								Tcredito NUMERIC(18,2), Diferencia NUMERIC(18,2))

--With Encryption 
As
BEGIN
	Declare  @debito		NUMERIC(18,2) = 0,
			 @credito   	NUMERIC(18,2) = 0,
			 @diferencia	NUMERIC(18,2) = 0
			
			 
	SET @debito         = CASE WHEN(@op='T') THEN  ISNULL((SELECT sum(valor) FROM cnt.MOVComprobantesItemsTemp WHERE id_comprobante = @id_comprobante and valor>0), 0) ELSE ISNULL((SELECT sum(valor) FROM cnt.MOVComprobantesContablesItems WHERE id_comprobante = @id_comprobante and valor>0), 0) END;
	SET @credito		= CASE WHEN (@op='T') THEN ISNULL((SELECT sum(valor) FROM cnt.MOVComprobantesItemsTemp WHERE id_comprobante = @id_comprobante and valor<0), 0) ELSE ISNULL((SELECT sum(valor) FROM cnt.MOVComprobantesContablesItems WHERE id_comprobante = @id_comprobante and valor<0), 0) END ;
	SET @diferencia		= @debito+@credito

	Insert Into @TblResultante (Tdebito, Tcredito, Diferencia)
	Values	(@debito,(@credito*-1),  @diferencia);	
	RETURN
End


GO


