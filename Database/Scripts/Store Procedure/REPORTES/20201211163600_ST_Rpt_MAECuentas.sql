--liquibase formatted sql
--changeset ,jtous:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_Rpt_MAECuentas]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [dbo].[ST_Rpt_MAECuentas] 
GO

CREATE PROCEDURE [dbo].[ST_Rpt_MAECuentas] 
@op CHAR(1) = 'C' 
AS
/***************************************
*Nombre:		[Dbo].[ST_Rpt_MAECuentas]
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		11/12/2020
*Desarrollador:  Jose Luis Tous Pérez (jtous)
*Descripcion:	
***************************************/
BEGIN
Declare @error varchar(max)
BEGIN TRY		
SET LANGUAGE Spanish
	IF(@op = 'C')
	BEGIN
		SELECT REPLICATE('   ', (indice-1))+'- '+codigo AS ccodigo, UPPER(nombre) AS nombre, tipo
		FROM CNTCuentas ORDER BY codigo ASC			
	END
END TRY
BEGIN Catch
	    --Getting the error description
	    Select @error   =  ERROR_PROCEDURE() + 
					';  ' + convert(varchar,ERROR_LINE()) + 
					'; ' + ERROR_MESSAGE()
	    -- save the error in a Log file
	    RaisError(@error,16,1)
	    Return  
	End Catch
END