﻿--liquibase formatted sql
--changeset ,JPAREDES:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[NOM].[ST_DiagnosticoDelete]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [NOM].[ST_DiagnosticoDelete]
GO
CREATE PROCEDURE [NOM].[ST_DiagnosticoDelete]

@id BIGINT, 
@id_user BIGINT

AS

/***************************************
*Nombre:		[NOM].[ST_DiagnosticoDelete]
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		30/03/2021
*Desarrollador:  JPAREDES
*Descripcion:	Elimina el Diagnostico
***************************************/

DECLARE @error VARCHAR(MAX)
BEGIN TRY

	IF(ISNULL(@id,0) = 0)
		RAISERROR('No se ha seleccionado ningun Diagnostico', 16, 0)

	DELETE FROM [NOM].[Diagnostico] WHERE id = @id
	

END TRY
BEGIN CATCH	
	IF (ERROR_NUMBER() = 3726)
		SET @error =  'Error: No se puede eliminar porque hay una referencia hacia él.'
	ELSE
		SET @error =  'Error: '+ERROR_MESSAGE();

	RAISERROR(@error,16,0);	
END CATCH
