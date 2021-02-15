--liquibase formatted sql
--changeset ,jteheran:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_MOVRevertirAjuste]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [dbo].[ST_MOVRevertirAjuste]
GO

CREATE PROCEDURE [dbo].[ST_MOVRevertirAjuste]
@id BIGINT = 0,
@id_user INT

--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[Dbo].[ST_MOVRevertirAjuste]
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		20/06/2020
*Desarrollador:  Jesid Teheran Meza
*Descripcion:	Se realizan EL PROCESO DE REVERTIR ENTRADAS
***************************************/
Declare @tablePago Table (id_pk int identity, id_pag bigint);
Declare @id_return INT, @Contabilizar BIT, @id_orden INT=NULL;
Declare @rows int = 0, @count int = 1, @id_pago int, @Mensaje varchar(max), @id_articulo BIGINT,@fechadoc VARCHAR(10),@anomes varchar(6),@fecha SMALLDATETIME;
BEGIN TRANSACTION
BEGIN TRY		
		
		SET @fecha =(SELECT  fecha FROM MOVAjustes where id=@id)
		SET @fechadoc=CONVERT(VARCHAR(10), @fecha, 120);
		SET @anomes=CONVERT(VARCHAR(6), @fecha, 112);	

		EXECUTE [Dbo].ST_ValidarPeriodo
				@fecha			= @fechadoc,
				@anomes			= @anomes,
				@mod			= 'I'
		


			IF NOT EXISTS (SELECT 1 FROM Dbo.MOVAjustes WHERE id = @id AND (estado = Dbo.ST_FnGetIdList('REVER') OR estado =  Dbo.ST_FnGetIdList('REVON')))
			BEGIN
				EXEC Dbo.ST_MOVCargarExistencia @Opcion = 'AR', @id = @id, @id_user = @id_user, @id_bodega = 0;

												 
				INSERT INTO [dbo].[MOVAjustes] (id_tipodoc, id_centrocosto, fecha,id_concepto ,detalle,estado, costototal, id_reversion, id_user)
				SELECT	id_tipodoc, 
						id_centrocosto, 
						GETDATE(), 
						id_concepto,
						detalle,
						Dbo.ST_FnGetIdList('REVON'), 
						costototal,
						@id id_reversion,
						@id_user
				FROM [dbo].[MOVAjustes] WHERE id = @id;

				SET @id_return = SCOPE_IDENTITY();
		
				IF ISNULL(@id_return, 0) <> 0
				BEGIN
		
					UPDATE [dbo].[MOVAjustes] SET id_reversion = @id_return, estado = Dbo.ST_FnGetIdList('REVER') Where id = @id;

					
			
					SELECT @id_return id, 'PROCESADO' estado,'CNT.VW_TRANSACIONES_AJUSTES' nombreview,@fechadoc fecha,@anomes anomes,@id_user id_user,@id idrev;

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

