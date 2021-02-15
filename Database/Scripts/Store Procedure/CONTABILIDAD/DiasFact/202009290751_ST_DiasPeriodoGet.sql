--liquibase formatted sql
--changeset ,jtous:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_DiasPeriodoGet]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[ST_DiasPeriodoGet]
GO

CREATE PROCEDURE [dbo].[ST_DiasPeriodoGet]
@anomes VARCHAR(10) = '202009'

--WITH ENCRYPTION
AS

/***************************************
*Nombre:		[Dbo].[ST_DiasPeriodoGet]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		09/04/17
*Desarrollador: (JTOUS)
***************************************/
DECLARE @error varchar(max), @id_return int, @fechas VARCHAR(MAX)
BEGIN TRANSACTION
BEGIN TRY
	
	SELECT @fechas= COALESCE(@fechas + ',', '') + CAST(DAY(fecha) AS VARCHAR) FROM DiasFac WHERE anomes = @anomes  and estado != 0

	SELECT ISNULL(@fechas,'') as fechas

	COMMIT TRANSACTION;
END TRY
BEGIN CATCH	
	ROLLBACK TRANSACTION;
	SET @error = 'Error: '+ERROR_MESSAGE();
	RAISERROR(@error,16,0);	
END CATCH

