--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[FnTipoTerceros]') and OBJECTPROPERTY(id, N'IsScalarFunction') = 1)
DROP FUNCTION [CNT].[FnTipoTerceros]
GO
-- =============================================
-- Author:		Jeteme
-- Create date: getdate()
-- Description:	
-- =============================================
CREATE FUNCTION [CNT].[FnTipoTerceros] 
(
	-- Add the parameters for the function here
	@idtercero int
)
RETURNS varchar(100)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result varchar(100)

	-- Add the T-SQL statements to compute the return value here
	SELECT @Result = (select (SELECT ''+concat(id_tipotercero,',') FROM CNT.TipoTerceros WHERE id_tercero=@idtercero 
					for xml path ('')) id_tipotercero)

	-- Return the result of the function
	RETURN @Result

END
