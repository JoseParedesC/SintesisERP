--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[GETParametrosValor]') and OBJECTPROPERTY(id, N'IsScalarFunction') = 1)
DROP FUNCTION [dbo].[GETParametrosValor]
GO
-- =============================================
-- Author:		Jeteme
-- Create date: 
-- Description:	
-- =============================================
CREATE FUNCTION [dbo].[GETParametrosValor] 
(
	-- Add the parameters for the function here
	@Codigo varchar(30)
)
RETURNS VARCHAR(30)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result VARCHAR(30)

	-- Add the T-SQL statements to compute the return value here
	SELECT @Result = (select Valor from dbo.Parametros where codigo=@Codigo)

	-- Return the result of the function
	RETURN @Result

END
GO


