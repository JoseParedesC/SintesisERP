--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[Dbo].[ST_ValidarPeriodo]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE Dbo.[ST_ValidarPeriodo]
GO
CREATE PROCEDURE [dbo].[ST_ValidarPeriodo]
@fecha VARCHAR(10),
@anomes VARCHAR(10),
@mod	CHAR(1) --C: contabilidad, I:inventario
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[Dbo].[ST_DiasPeriodoState]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		09/04/17
*Desarrollador: (JTOUS)
***************************************/
Declare @ds_error Varchar(Max)
BEGIN TRY 
	
	IF NOT EXISTS(SELECT 1 FROM CNT.Periodos WHERE anomes = @anomes AND CASE WHEN @mod = 'C' THEN contabilidad ELSE inventario END != 0)
	BEGIN	
		SET @ds_error = 'El periodo en '+CASE WHEN @mod = 'C' THEN 'contabilidad' ELSE 'inventario' END+' esta cerrado.'
		RAISERROR(@ds_error, 16, 0);
	END
	ELSE
	BEGIN
		IF NOT EXISTS(SELECT 1 FROM DiasFac WHERE CONVERT(VARCHAR(10), fecha, 120) = @fecha AND estado != 0)
		BEGIN
			SET @ds_error = 'El dia '+@fecha+' en '+CASE WHEN @mod = 'C' THEN 'contabilidad' ELSE 'inventario' END+' esta cerrado.'
			RAISERROR(@ds_error, 16, 0);
		END
	END


END TRY
BEGIN CATCH
	    SELECT @ds_error = ERROR_MESSAGE()
	    RAISERROR(@ds_error,16,1);
END CATCH