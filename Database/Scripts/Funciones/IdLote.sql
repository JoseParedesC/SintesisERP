--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[IdLote]') and OBJECTPROPERTY(id, N'IsScalarFunction') = 1)
DROP FUNCTION [dbo].[IdLote]
GO
-- =============================================
-- Author:		Jeteme
-- Create date: 
-- Description:	
-- =============================================
CREATE FUNCTION [dbo].[IdLote] 
(
	-- Add the parameters for the function here
	@lote varchar(30)
)
RETURNS int
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result int

	-- Add the T-SQL statements to compute the return value here
	SELECT @Result = (select id from dbo.LotesProducto where lote=@lote)

	-- Return the result of the function
	RETURN @Result

END

GO


