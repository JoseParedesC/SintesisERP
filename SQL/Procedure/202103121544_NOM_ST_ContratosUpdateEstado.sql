--liquibase formatted sql
--changeset ,JARCINIEGAS:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id =
OBJECT_ID(N'[NOM].[ContratosUpdateEstado]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [NOM].[ContratosUpdateEstado]
GO
CREATE PROCEDURE [NOM].[ContratosUpdateEstado]

/***************************************
*Nombre: [NOM].[ContratosUpdateEstado]
----------------------------------------
*Tipo: Procedimiento almacenado
*creación: 22/02/21
*Desarrollador: APUELLO
*Descripcion: Guarda o actuliza la información de un tickets dependiendo de si existe o no
***************************************/
	@id BIGINT,
	@id_opcion VARCHAR(30) = NULL,
	@empresa BIGINT = null,
	@sistema BIGINT = null,
	@version BIGINT = null,
	@asunto VARCHAR(50) = null,
	@descripcion VARCHAR(MAX) = null,
	@opcion VARCHAR(30) = null,
	@url XML = NULL,
	@id_user BIGINT
AS
BEGIN TRANSACTION
	BEGIN TRY
		DECLARE @error VARCHAR(MAX), @id_return BIGINT, @xmlEmail VARCHAR(255), @email VARCHAR(MAX), @idper INT, @profile VARCHAR(30)
		DECLARE @temp TABLE (image VARCHAR(MAX), nombre VARCHAR(50))
		SET @profile = (SELECT LoweredRoleName FROM aspnet_Roles WHERE id = (SELECT id_perfil FROM Usuarios WHERE id = @id_user))
		
		--EXEC sp_xml_preparedocument @idper OUTPUT, @url

		--INSERT INTO @temp (image, nombre)
		--SELECT
		--	relatiurl,
		--	name
		--FROM OPENXML(@idper, N'root/item')
		--WITH (relatiurl VARCHAR(MAX) '@relatiurl', name VARCHAR(50) '@name') as P

		IF (@id != 0)
			BEGIN
				IF @id_opcion = (SELECT id FROM ST_Listados WHERE nombre = 'Finalizado' and iden = 'FIN')
					BEGIN
						UPDATE [NOM].[Contrato]
							SET
								estado	=	@id_opcion
							WHERE id = @id

					END
				ELSE IF @id_opcion = (SELECT id FROM ST_Listados WHERE nombre = 'Cancelado' AND iden = 'CAN')
					BEGIN
						--IF ((SELECT email FROM dbo.Tickets WHERE id = @id) = 0)
						--	BEGIN
						--		SET @xmlEmail = 
						--			(SELECT '<top>'+'<time>'+ (SELECT codigogen FROM dbo.ST_Listados WHERE id = @id_opcion) +'</time>'+
						--			'<cod>' + num_ticket + '</cod>'+
						--			'<descrip>Descripcion: ' + descripcion + '</descrip>' +
						--			'<asunto>' + asunto +'</asunto>' + '</top>' FROM Tickets WHERE id = @id)
						--		SET @email = (SELECT email FROM dbo.Usuarios WHERE id = (SELECT id_user FROM dbo.Tickets WHERE id = @id))
						--	END
						UPDATE [NOM].[Contrato]
							SET
								estado	=	@id_opcion
								--email		=	1
							WHERE id = @id
					END
			--ELSE IF @opcion = 'edit'
			--	BEGIN
			--		UPDATE dbo.Tickets
			--			SET
			--				empresa		=	@empresa,
			--				asunto		=	@asunto, 
			--				version		=	@version,
			--				descripcion	=	@descripcion
			--			WHERE id = @id

			--			INSERT INTO dbo.TicketsImg (id_ticket, url_img, nombre, token) SELECT @id, image, nombre, CAST(NEWID() AS VARCHAR(255)) FROM @temp
			--	END

				--SELECT	IIF(@xmlEmail IS NULL, '', @xmlEmail) AS xml,
				--		IIF(@email IS NULL, '', @email) AS email,
				--		(SELECT asunto FROM Tickets WHERE id = @id) estado,
				--		servermail,
				--		usermail,
				--		usertitlemail,
				--		passmail,
				--		portmail,
				--		sslmail
				--FROM [dbo].[aspnet_MailConfig]

		END
		--ELSE
		--	BEGIN
		--		IF (((SELECT color FROM Usuarios WHERE id = @id_user) IS NULL OR 
		--		(SELECT color FROM Usuarios WHERE id = @id_user) = '') AND UPPER(@profile) = UPPER('Cliente'))
		--			UPDATE Usuarios
		--				SET
		--					color = '#E74C3C'
		--			WHERE id = @id_user

		--		INSERT INTO dbo.Tickets (
		--						empresa, 
		--						asunto,
		--						sistema, 
		--						version, 
		--						descripcion,
		--						estado,
		--						id_user)
		--					VALUES(
		--						@empresa,
		--						@asunto,
		--						@sistema,
		--						@version,
		--						@descripcion,
		--						[dbo].[ST_FnGetIdList] ('ABIERTO'),
		--						@id_user)
		--		SET @id_return = SCOPE_IDENTITY();

		--		UPDATE dbo.Tickets
		--			SET
		--				num_ticket = CONCAT(REPLICATE('0', (10 - LEN(CAST(@id_return AS VARCHAR)))), CAST(@id_return AS VARCHAR))
		--			WHERE id = @id_return
			
		--		INSERT INTO dbo.TicketsImg 
		--						(id_ticket, 
		--						nombre,
		--						url_img,
		--						token)
		--				SELECT 
		--					@id_return,
		--					nombre,
		--					image,
		--					CAST(NEWID() AS VARCHAR(255))
		--				FROM @temp

		--END

		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		SET @error = ERROR_MESSAGE();
		RAISERROR(@error,16,0);		
		ROLLBACK TRANSACTION;	
	END CATCH