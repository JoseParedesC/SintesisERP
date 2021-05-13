--liquibase formatted sql
--changeset ,JPAREDES:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[ST_BancosSave]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [CNT].[ST_BancosSave]
GO
CREATE PROCEDURE [CNT].[ST_BancosSave]

@id BIGINT = NULL,  
@nombre VARCHAR(30),
@coidgo VARCHAR(30),
@id_user BIGINT 

AS

/***************************************
*Nombre:		[CNT].[ST_BancosSave]
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


	IF EXISTS(SELECT 1 FROM [CNT].[Bancos] WHERE nombre = @nombre AND id != @id)
		RAISERROR('El Nombre ya se encuentra registrado', 16, 0)


	IF EXISTS(SELECT 1 FROM [CNT].[Bancos] WHERE codigo_compensacion = @coidgo AND id != @id)
		RAISERROR('El Codigo ya se encuentra registrado', 16, 0)


	IF(Isnull(@id,0) = 0)
	BEGIN			   
		INSERT INTO [CNT].[Bancos] (nombre, codigo_compensacion, id_usercreated, id_userupdated)
		VALUES( @nombre, @coidgo, @id_user, @id_user)
		
		SET @id_return = SCOPE_IDENTITY();
	END
	ELSE
	BEGIN
				
		UPDATE  [CNT].[Bancos]
		SET nombre				= @nombre,
			codigo_compensacion = @coidgo,
			id_userupdated		= @id_user,
			updated				= GETDATE()
		WHERE id = @id;

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

