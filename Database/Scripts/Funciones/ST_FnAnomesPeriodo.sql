--liquibase formatted sql
--changeset ,jtous:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[ST_FnAnomesPeriodo]') and OBJECTPROPERTY(id, N'IsTableFunction') = 1)
	DROP FUNCTION [dbo].[ST_FnAnomesPeriodo]
GO
-- =============================================
-- Author:		Jeteme
-- Create date: getdate()
-- Description:	
-- =============================================
create Function  [dbo].[ST_FnAnomesPeriodo] (@ano VARCHAR(5))
RETURNS @TblResultante  TABLE (Id Int Identity (1,1) Not Null, anomes VARCHAR(10))

--With Encryption 
As
BEGIN
		
	Insert Into @TblResultante (anomes)
	SELECT @ano+'01'
	UNION
	SELECT @ano+'02'
	UNION
	SELECT @ano+'03'
	UNION
	SELECT @ano+'04'
	UNION
	SELECT @ano+'05'
	UNION
	SELECT @ano+'06'
	UNION
	SELECT @ano+'07'
	UNION
	SELECT @ano+'08'
	UNION
	SELECT @ano+'09'
	UNION
	SELECT @ano+'10'
	UNION
	SELECT @ano+'11'
	UNION
	SELECT @ano+'12'
	
	RETURN
End


GO


