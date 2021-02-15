--liquibase formatted sql
--changeset ,jtous:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_DiasFactSave]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[ST_DiasFactSave]
GO

CREATE PROCEDURE [dbo].[ST_DiasFactSave]
@id BIGINT = null,
@fechas varchar(MAX),
@anomes VARCHAR(10),
@id_user int

--WITH ENCRYPTION
AS

/***************************************
*Nombre:		[Dbo].[ST_DiasFactSave]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		09/04/17
*Desarrollador: (JTOUS)
***************************************/
DECLARE @error varchar(max), @id_return int
DECLARE @table TABLE (id int identity(1,1), fecha smalldatetime)
DECLARE @tableP TABLE (id int identity(1,1), anomes VARCHAR(10))
BEGIN TRANSACTION
BEGIN TRY

	IF(@fechas != '')
	BEGIN
		INSERT INTO @table (fecha)
		SELECT REPLACE(item,'-','') FROM [dbo].[ST_FnTextToTable](@fechas, ',');

		UPDATE Dbo.DiasFac SET estado = 0 WHERE anomes = @anomes AND CONVERT(VARCHAR(10), fecha, 120) NOT IN (SELECT CONVERT(VARCHAR(10), fecha, 120) FROM  @table)
		UPDATE Dbo.DiasFac SET estado = 1 WHERE anomes = @anomes AND CONVERT(VARCHAR(10), fecha, 120) IN (SELECT CONVERT(VARCHAR(10), fecha, 120) FROM  @table)
		
		INSERT INTO @tableP (anomes)
		SELECT DISTINCT CONVERT(VARCHAR(6), fecha, 112) FROM @table 

		IF EXISTS (SELECT 1 FROM CNT.Periodos WHERE anomes IN (SELECT anomes FROM @tableP) AND (contabilidad = 0 AND inventario = 0)) OR NOT EXISTS (SELECT 1 FROM CNT.Periodos WHERE anomes IN (SELECT anomes FROM @tableP))
			RAISERROR('Intenta abrir dia facturable en periodo que esta cerrado.', 16,0)

	
		INSERT INTO Dbo.DiasFac(fecha, anomes, id_user)
		SELECT CONVERT(VARCHAR(10), fecha, 112), CONVERT(VARCHAR(6), fecha, 112), @id_user 
		FROM @table
		WHERE CONVERT(VARCHAR(10), fecha, 120)
		NOT IN (SELECT CONVERT(VARCHAR(10), fecha, 120) FROM  DiasFac WHERE anomes = @anomes)
	
	END
	ELSE
	BEGIN
		UPDATE Dbo.DiasFac SET estado = 0 WHERE  anomes = @anomes;
	END

	COMMIT TRANSACTION;
END TRY
BEGIN CATCH	
	ROLLBACK TRANSACTION;
	SET @error = 'Error: '+ERROR_MESSAGE();
	RAISERROR(@error,16,0);	
END CATCH

SELECT @anomes;
