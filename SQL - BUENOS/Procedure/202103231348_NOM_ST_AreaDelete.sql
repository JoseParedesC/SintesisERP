--liquibase formatted sql
--changeset ,JARCINIEGAS:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[NOM].[ST_AreaDelete]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [NOM].[ST_AreaDelete]
GO
CREATE PROCEDURE [NOM].[ST_AreaDelete]

@id BIGINT,
@id_user int
 
AS
/*************************************************
*Nombre 		[CRE].[ST_AreaDelete]
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
	
	IF EXISTS (SELECT 1 FROM [NOM].[Area] WHERE id = @id )
	BEGIN


		IF NOT EXISTS (SELECT 1 FROM [NOM].[Contrato] WHERE area = @id)
		BEGIN
				
			DELETE A FROM [NOM].[Area] A 
			WHERE A.id = @id;
				
		END
		ELSE
		BEGIN
			RAISERROR ('Esta area ha sido utilizado, NO puede ser eliminado',16,0);
		END

	END
	ELSE
		RAISERROR ('Esta Area ha sido Eliminada. Verifique!',16,0);
	COMMIT TRANSACTION;
END TRY
BEGIN CATCH
	SET @error = 'Error: '+ERROR_MESSAGE();
	RAISERROR(@error,16,0);		
	ROLLBACK TRANSACTION;
END CATCH
