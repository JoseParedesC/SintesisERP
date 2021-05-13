--liquibase formatted sql
--changeset ,jarciniegas:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[NOM].[ST_BancosSave]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [NOM].[ST_BancosSave]
GO
CREATE PROCEDURE [NOM].[ST_BancosSave]

@id BIGINT = NULL,  
@nombre VARCHAR(30),
@id_user BIGINT 

AS

/***************************************
*Nombre:		[NOM].[ST_BancosSave]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		16/10/2020
*Desarrollador: (JARCINIEGAS)
*DESCRIPCIÓN:	Guarda la información re-
				cogida de la vista en la
				tabla [dbo].[Bancos]
***************************************/

BEGIN TRANSACTION
BEGIN TRY

	DECLARE  @id_return INT, @error VARCHAR(MAX);

	

	IF(Isnull(@id,0) = 0)
	BEGIN			   
		INSERT INTO [NOM].[Bancos] (nombre,id_usercreated, id_userupdated)
		VALUES( @nombre, @id_user, @id_user)
		
		SET @id_return = SCOPE_IDENTITY();
	END
	ELSE
	BEGIN
				
		UPDATE  [NOM].[Bancos]
		SET nombre			= @nombre,
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

