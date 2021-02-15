--liquibase formatted sql
--changeset ,jteheran:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_MOVRevertirTraslado]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [dbo].[ST_MOVRevertirTraslado] 
GO

CREATE PROCEDURE [dbo].[ST_MOVRevertirTraslado]
@id BIGINT = 0,
@id_user INT

--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[Dbo].[ST_MOVRevertirTraslado]
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		23/10/2020
*Desarrollador:  Jesid Teheran Meza
*Descripcion:	Se realizan EL PROCESO DE REVERTIR Traslados
***************************************/
Declare @tablePago Table (id_pk int identity, id_pag bigint);
Declare @id_return INT, @Contabilizar BIT, @id_orden INT=NULL;
Declare @rows int = 0, @count int = 1, @id_pago int, @Mensaje varchar(max), @id_articulo BIGINT,@fechadoc VARCHAR(10),@anomes varchar(6);
BEGIN TRANSACTION
BEGIN TRY		
		
		
			SET @fechadoc=CONVERT(VARCHAR(10), GETDATE(), 120);
			SET @anomes=CONVERT(VARCHAR(6), GETDATE(), 112);	

			EXECUTE [Dbo].ST_ValidarPeriodo
					@fecha			= @fechadoc,
					@anomes			= @anomes,
					@mod			= 'I'
		

			IF NOT EXISTS (SELECT 1 FROM Dbo.MOVTraslados WHERE id = @id AND (estado = Dbo.ST_FnGetIdList('REVER') OR estado =  Dbo.ST_FnGetIdList('REVON')))
			BEGIN
				EXEC Dbo.ST_MOVCargarExistencia @Opcion = 'RTL', @id = @id, @id_user = @id_user, @id_bodega = 0;

												 
				INSERT INTO [dbo].[MOVTraslados] (id_tipodoc, id_centrocosto, fecha,descripcion,estado, costototal, id_reversion, id_user)
				SELECT	id_tipodoc, 
						id_centrocosto, 
						GETDATE(), 
						descripcion,
						Dbo.ST_FnGetIdList('REVON'), 
						costototal,
						@id id_reversion,
						@id_user
				FROM [dbo].[MOVTraslados] WHERE id = @id;

				SET @id_return = SCOPE_IDENTITY();
		
				IF ISNULL(@id_return, 0) <> 0
				BEGIN
		
					UPDATE [dbo].[MOVTraslados] SET id_reversion = @id_return, estado = Dbo.ST_FnGetIdList('REVER') Where id = @id;

	
			
					SELECT @id_return id, 'PROCESADO' estado,'CNT.VW_TRANSACIONES_TRASLADOS' nombreview,@fechadoc fecha,@anomes anomes,@id_user id_user,@id idrev;
				END
				ELSE
				BEGIN
					SET @Mensaje = 'No se genero el documento de reversi�n';
					RAISERROR(@Mensaje,16,0);
				END
			END
			ELSE
				RAISERROR('El documento de compra ya ha sido revertido, verifique...',16,0);
		--END
		--ELSE		
		--BEGIN
		--	SELECT TOP 1 @mensaje = 'El producto ' + nombre +' no tiene existencias para revertir.' 
		--	FROM Dbo.Productos WHERE id = @id_articulo; 
		--	RAISERROR(@mensaje, 16, 0)
		--END	

COMMIT TRANSACTION;
END TRY
BEGIN CATCH	
	ROLLBACK TRANSACTION;
	
	SET @Mensaje = 'Error: '+ERROR_MESSAGE();
	RAISERROR(@Mensaje,16,0);	
END CATCH
GO


