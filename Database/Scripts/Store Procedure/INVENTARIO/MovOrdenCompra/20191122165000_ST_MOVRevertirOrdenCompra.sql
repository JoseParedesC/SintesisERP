--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_MOVRevertirOrdenCompra]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_MOVRevertirOrdenCompra]
GO
CREATE PROCEDURE [Dbo].[ST_MOVRevertirOrdenCompra]
@id BIGINT = 0,
@id_user INT

--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[Dbo].[[ST_MOVRevertirOrdenCompra]]
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		22/11/2019
*Desarrollador:  (jeteme)
*Descripcion:	Se realizan EL PROCESO DE FACTURAR LAS ENTRADAS
***************************************/
Declare @id_return INT;
Declare @Mensaje varchar(max);
BEGIN TRANSACTION
BEGIN TRY
		--SET @Contabilizar = (SELECT CAST(Valor AS BIT) FROM PV.Parametros WHERE Nombre = 'Contabilizar')
		IF EXISTS (SELECT 1 FROM Usuarios WHERE id = @id_user AND id_perfil = 4)
			RAISERROR('No puede realizar esta operación por su perfil.', 16,0);
		
	
		IF NOT EXISTS (SELECT 1 FROM Dbo.MovOrdenCompras WHERE id = @id AND (estado = Dbo.ST_FnGetIdList('REVER') OR estado =  Dbo.ST_FnGetIdList('REVON')))
		BEGIN

			INSERT INTO [dbo].[MovOrdenCompras] (id_tipodoc,id_centrocostos,fechadocument,  estado, id_proveedor, bodega,costo ,id_reversion, id_usercreated,id_userupdated)
			SELECT id_tipodoc,id_centrocostos,fechadocument,  Dbo.ST_FnGetIdList('REVON'), id_proveedor, bodega, costo,@id,@id_user ,@id_user
			FROM [dbo].[MovOrdenCompras] WHERE id = @id;

			SET @id_return = SCOPE_IDENTITY();
		
			IF ISNULL(@id_return, 0) <> 0
			BEGIN

				UPDATE [dbo].[MovOrdenCompras] SET id_reversion = @id_return, estado = Dbo.ST_FnGetIdList('REVER') Where id = @id;
				
				SELECT @id_return id, 'REVERSION' estado, @id idrev
			END
			ELSE
			BEGIN
				SET @Mensaje = 'No se genero el documento de reversión';
				RAISERROR(@Mensaje,16,0);
			END
		END
		ELSE
			RAISERROR('Esta Orden de compra ya ha sido revertida, verifique...',16,0);
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH	
		ROLLBACK TRANSACTION;
		--DELETE PV.TempArticulos_SpId WHERE SpId =  @@SpId;
		SET @Mensaje = 'Error: '+ERROR_MESSAGE();
		RAISERROR(@Mensaje,16,0);	
	END CATCH
GO
