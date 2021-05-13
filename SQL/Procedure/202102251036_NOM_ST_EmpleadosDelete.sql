--liquibase formatted sql
--changeset ,JARCINIEGAS:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[NOM].[ST_EmpleadosDelete]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [NOM].[ST_EmpleadosDelete]
GO
CREATE PROCEDURE [NOM].[ST_EmpleadosDelete]

@id BIGINT,
@id_user int
 
AS
/*************************************************
*Nombre 		[CRE].[ST_EmpleadosDelete]
--------------------------------------------------
*Tipo 			Procedimiento almacenado
*creaci�n 		19/12/2020
*Desarrollador  (JARCINIEGAS)
*DESCRIPCI�N 	Elimina la persona con tipo_tercero
				CO que est� seleccionado 
*************************************************/

DECLARE @id_return INT, @error VARCHAR(MAX);
--DECLARE @TableFile Table(id int identity, rutaarchivo varchar(MAX));
BEGIN TRANSACTION
BEGIN TRY
	
	IF EXISTS (SELECT 1 FROM [CNT].[Terceros] WHERE id = @id )
	BEGIN


	IF NOT EXISTS (SELECT 1 FROM [NOM].[Contrato] WHERE id_empleado = @id)
	BEGIN
				
		DELETE TA FROM [CNT].[TerceroAdicionales] TA 
		WHERE TA.id_tercero = @id;

		DELETE TH FROM [CNT].[TercerosHijos] TH 
		WHERE TH.id_tercero = @id;


		EXEC [CNT].[TercerosDelete] @id = @id, @id_user = @id_user
				
	END
	ELSE
	BEGIN
		RAISERROR ('Este empleado tiene un contrato, NO puede ser eliminado',16,0);
	END
		--SELECT rutaarchivo FROM @TableFile;
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
