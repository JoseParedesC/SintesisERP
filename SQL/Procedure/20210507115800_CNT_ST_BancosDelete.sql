--liquibase formatted sql
--changeset ,JPAREDES:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[ST_BancosDelete]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [CNT].[ST_BancosDelete]
GO
CREATE PROCEDURE [CNT].[ST_BancosDelete]

@id INT

AS

/****************************************
*Nombre:		[CNT].[ST_BancosDelete]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		16/10/2020
*Desarrollador: (JARCINIEGAS)
*DESCRIPCIÓN:	Recoge el id que envia la 
				función BancosDelete y
				elimina el registro que 
				coincide con el id
****************************************/


DECLARE @ds_error VARCHAR(MAX)
	
BEGIN TRY

	DELETE  FROM  [CNT].[Bancos] WHERE id = @id;		
		
END TRY
BEGIN CATCH
	IF (ERROR_NUMBER() = 547)
		SET @ds_error =  'Error: No se puede eliminar porque hay una referencia hacia él.'
	ELSE
		SET @ds_error   =  ERROR_PROCEDURE() + 
						';  ' + CONVERT(VARCHAR,ERROR_LINE()) + 
						'; ' + ERROR_MESSAGE()
		-- save the error in a Log file
		RAISERROR(@ds_error,16,1)
	RETURN
END CATCH


