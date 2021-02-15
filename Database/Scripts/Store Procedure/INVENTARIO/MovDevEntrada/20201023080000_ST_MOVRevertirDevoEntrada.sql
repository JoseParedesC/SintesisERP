--liquibase formatted sql
--changeset ,jteheran:3 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_MOVRevertirDevoEntrada]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_MOVRevertirDevoEntrada]
GO

CREATE PROCEDURE [dbo].[ST_MOVRevertirDevoEntrada]
@id BIGINT = 0,
@id_user INT

--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[Dbo].[ST_MOVRevertirDevoEntrada]
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		23/10/2020
*Desarrollador:  Jose Luis Tous Pérez (jtous)
*Descripcion:	Se realizan EL PROCESO DE FACTURAR LAS ENTRADAS
***************************************/
Declare @tablePago Table (id_pk int identity, id_pag bigint);
Declare @id_return INT, @Contabilizar BIT,@id_entrada BIGINT=NULL,@id_proveedor BIGINT,@pago NUMERIC(18,2),@fechadoc VARCHAR(10),@anomes BIGINT,@fecha Smalldatetime;
Declare @rows int = 0, @count int = 1, @id_pago int,@Mensaje varchar(max);
BEGIN TRANSACTION
BEGIN TRY

		SELECT @fecha=fechadocumen FROM dbo.MOVDevEntradas WHERE id=@id;
		SET @anomes=CONVERT(VARCHAR(6),@fecha, 112);
		SET @fechadoc=CONVERT(VARCHAR(10), @fecha, 120);	
	
		EXECUTE [Dbo].ST_ValidarPeriodo
				@fecha			= @fechadoc,
				@anomes			= @anomes,
				@mod			= 'I'

		
		IF NOT EXISTS (SELECT 1 FROM Dbo.MOVDevEntradas WHERE id = @id AND (estado = Dbo.ST_FnGetIdList('REVER') OR estado =  Dbo.ST_FnGetIdList('REVON')))
		BEGIN
			
			SET @id_entrada=(Select id_entrada From MOVDevEntradas where id=@id)
			SET @id_proveedor=(Select id_proveedor From MOVEntradas where id=@id_entrada)
			SET @pago = (Select valor From MOVDevEntradas where id=@id)

			

			INSERT INTO [dbo].[MOVDevEntradas] (id_tipodoc,id_centrocostos,id_entrada,fechadocumen, id_bodega, estado,costo, iva, inc, descuento, valor , reteiva, retefuente, reteica,id_ctaant,valoranticipo ,id_reversion, id_user)
			SELECT id_tipodoc,id_centrocostos,id_entrada,fechadocumen, id_bodega,  Dbo.ST_FnGetIdList('REVON'), costo, iva,inc ,descuento, valor,  reteiva, retefuente, reteica,id_ctaant,valoranticipo ,@id, @id_user
			FROM [dbo].[MOVDevEntradas] WHERE id = @id;

			SET @id_return = SCOPE_IDENTITY();
		
			IF ISNULL(@id_return, 0) <> 0
			BEGIN
		
				UPDATE [dbo].[MOVDevEntradas] SET id_reversion = @id_return, estado = Dbo.ST_FnGetIdList('REVER') Where id = @id;
			
				EXEC Dbo.ST_MOVCargarExistencia @Opcion = 'RDI', @id = @id, @id_user = @id_user;
			
			SELECT @id_return id, 'PROCESADO' estado,'CNT.VW_TRANSACIONES_DEVENTRADAS' nombreview,@fechadoc fecha,@anomes anomes,@id_user id_user,@id idrev;
			END
			ELSE
			BEGIN
				SET @Mensaje = 'No se genero el documento de reversión';
				RAISERROR(@Mensaje,16,0);
			END
		END
		ELSE
			RAISERROR('Esta Devolucion ya ha sido revertida, verifique...',16,0);
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH	
		ROLLBACK TRANSACTION;
		--DELETE PV.TempArticulos_SpId WHERE SpId =  @@SpId;
		SET @Mensaje = 'Error: '+ERROR_MESSAGE();
		RAISERROR(@Mensaje,16,0);	
	END CATCH


GO


