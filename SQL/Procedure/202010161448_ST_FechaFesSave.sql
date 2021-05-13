--liquibase formatted sql
--changeset ,jarciniegas:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[NOM].[ST_FechaFesSave]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [NOM].[ST_FechaFesSave]
GO
CREATE PROCEDURE [NOM].[ST_FechaFesSave]

@id BIGINT = null,  
@fecha DATE,
@tipo VARCHAR(1) = 'F',
@id_user BIGINT 

AS

/***************************************
*Nombre:		[NOM].[ST_FechaFesSave]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		16/10/2020
*Desarrollador: (JARCINIEGAS)
*DESCRIPCIÓN:	Guarda la información re-
				cogida de la vista en la
				tabla [dbo].[FechaFes]
***************************************/

BEGIN TRANSACTION
BEGIN TRY

	DECLARE  @id_return INT, @error VARCHAR(MAX);

	IF EXISTS (SELECT 1 FROM [NOM].[FechaFes] A WHERE A.fecha = @fecha AND (A.tipo != @tipo))
	BEGIN
	SET @id = (SELECT id FROM [NOM].[FechaFes] WHERE fecha = @fecha)
	END
	
	IF EXISTS (SELECT 1 FROM [NOM].[FechaFes] A WHERE A.fecha = @fecha AND A.Id != ISNULL(@id,0) AND (A.tipo = @tipo))
		RAISERROR('Verifique ID, ya existe esta relación...', 16,0);

	IF(Isnull(@id,0) = 0)
	BEGIN			   
		INSERT INTO [NOM].[FechaFes] (fecha,tipo,id_usercreated, id_userupdated)
		VALUES( @fecha,@tipo, @id_user, @id_user)
		
		SET @id_return = SCOPE_IDENTITY();
	END
	ELSE
	BEGIN
				
		UPDATE  [NOM].[FechaFes]
		SET fecha			= @fecha,
			tipo			= @tipo,
			id_userupdated	= @id_user,
			updated			= GETDATE()
		WHERE id = @id;;

		SET @id_return = @id;

			

	END

	COMMIT TRANSACTION;
END TRY
BEGIN CATCH
	SET @error = 'Error: '+ERROR_MESSAGE();
	RAISERROR(@error,16,0);		
	ROLLBACK TRANSACTION;
END CATCH

SELECT @id_return id ;

