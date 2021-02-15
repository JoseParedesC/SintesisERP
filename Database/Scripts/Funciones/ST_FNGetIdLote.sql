--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_FNGetIdLote]') and OBJECTPROPERTY(id, N'IsScalarFunction') = 1)
DROP FUNCTION [dbo].[ST_FNGetIdLote]
GO

CREATE Function  [dbo].[ST_FNGetIdLote] (@iden varchar(200), @vencimiento SMALLDATETIME)
RETURNS BIGINT
 
As
BEGIN
	Declare @id INT = NULL;
	IF(REPLACE(@iden,' ','') = '')
		SELECT TOP 1 @id = id FROM dbo.LotesProducto WHERE [default] != 0
	ELSE
		SELECT TOP 1 @id = id FROM dbo.LotesProducto 
		WHERE lote = @iden AND CONVERT(VARCHAR(10), vencimiento_lote, 120) = CONVERT(VARCHAR(10), @vencimiento, 120);

	RETURN @id
End

GO


