--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_TurnosSave]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_TurnosSave]
GO
CREATE PROCEDURE dbo.ST_TurnosSave
@id BIGINT = null,
@horainicio VARCHAR(5),
@horafin VARCHAR(5),
@id_user int

WITH ENCRYPTION
AS

/***************************************
*Nombre:		[dbo].[ST_TurnosSave]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		27/03/17
*Desarrollador: (JTOUS)
***************************************/

BEGIN TRANSACTION
BEGIN TRY

	DECLARE @id_return INT, @error VARCHAR(MAX);
	
	IF EXISTS (SELECT 1 FROM dbo.Turnos A WHERE A.horainicio = @horainicio AND A.horafin = @horafin)
	BEGIN
		RAISERROR('Ya existe horario con este rango...', 16,0);
	END

	IF(Isnull(@id,0) = 0)
	BEGIN
		INSERT INTO dbo.Turnos (horainicio, horafin, id_user)
		VALUES(@horainicio, @horafin, @id_user)						
				
		SET @id_return = SCOPE_IDENTITY();
	END
	ELSE
	BEGIN
		UPDATE dbo.Turnos 
		SET 
			horainicio		= @horainicio,
			horafin			= @horafin,
			id_user			= @id_user,
			updated			= GETDATE()
		WHERE id = @id;;
			
		set @id_return = @id
	END	

	COMMIT TRANSACTION;
END TRY
BEGIN CATCH
	SET @error = 'Error: '+ERROR_MESSAGE();
	RAISERROR(@error,16,0);		
	ROLLBACK TRANSACTION;
END CATCH

SELECT @id_return;
GO
