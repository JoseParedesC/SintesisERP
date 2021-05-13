﻿--liquibase formatted sql
--changeset ,JARCINIEGAS:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[NOM].[ST_VacacionesDelete]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [NOM].[ST_VacacionesDelete]
GO
CREATE PROCEDURE [NOM].[ST_VacacionesDelete]

@id BIGINT,
@id_user int
 
AS
/*************************************************
*Nombre 		[CRE].[ST_VacacionesDelete]
--------------------------------------------------
*Tipo 			Procedimiento almacenado
*creaci�n 		19/12/2020
*Desarrollador  (JARCINIEGAS)
*DESCRIPCI�N 	Elimina la persona con tipo_tercero
				CO que est� seleccionado 
*************************************************/

DECLARE @id_return INT, @error VARCHAR(MAX), @id_solicitud BIGINT;
BEGIN TRANSACTION
BEGIN TRY
	
	IF EXISTS (SELECT 1 FROM [NOM].[Vacaciones] WHERE id = @id )
	BEGIN


		--IF NOT EXISTS (SELECT 1 FROM [NOM].[Contrato] WHERE cargo = @id)
		--BEGIN
				
			DELETE EPS FROM [NOM].[Vacaciones] EPS 
			WHERE EPS.id = @id;
				
		--END
		--ELSE
		--BEGIN
			--RAISERROR ('Esta caja de compensació ha sido utilizado, NO puede ser eliminado',16,0);
		--END

	END
	ELSE
		RAISERROR ('Ya este codeudor no esta en esta solicitud. Verifique!',16,0);
	COMMIT TRANSACTION;
END TRY
BEGIN CATCH
	SET @error = 'Error: '+ERROR_MESSAGE();
	RAISERROR(@error,16,0);		
	ROLLBACK TRANSACTION;
END CATCH
