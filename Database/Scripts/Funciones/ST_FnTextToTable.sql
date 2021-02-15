--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_FnTextToTable]') and OBJECTPROPERTY(id, N'IsTableFunction') = 1)
DROP FUNCTION [dbo].[ST_FnTextToTable]
GO

CREATE FUNCTION [dbo].[ST_FnTextToTable](@text [varchar](max), @caracter [varchar](10) = ',')
RETURNS @List TABLE (
	[id_record] [int] IDENTITY(1,1),
	[item] [varchar](max) NULL
)-- WITH ENCRYPTION
AS 
BEGIN
	-----------------------------------------------
	--Declare variables
	-----------------------------------------------
	DECLARE @sItem VARCHAR(max)
	-----------------------------------------------
	--Execute Logic
	-----------------------------------------------
	WHILE CHARINDEX(@caracter,@text,0) <> 0 
	BEGIN 
	SELECT  @sItem=RTRIM(LTRIM(SUBSTRING(@text,1,CHARINDEX(@caracter,@text,0)-1))),  
			@text=RTRIM(LTRIM(SUBSTRING(@text,CHARINDEX(@caracter,@text,0)+LEN(@caracter),LEN(@text))))  
		IF LEN(@sItem) > 0  INSERT INTO @List SELECT @sItem 
	END
	-----------------------------------------------
	--Validacion de Tama�os
	-----------------------------------------------
	IF LEN(@text) > 0 
		INSERT INTO @List 
		SELECT @text  
	RETURN
END
