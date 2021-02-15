--liquibase formatted sql
--changeset ,jteheran:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_MOVFacturarAjuste]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_MOVFacturarAjuste]
GO

CREATE PROCEDURE [dbo].[ST_MOVFacturarAjuste] 
@id_tipodoc BIGINT,
@id_centrocosto BIGINT,
@fechadoc  SMALLDATETIME,
@id_entradatemp VARCHAR(255),
@id_concepto BIGINT,
@detalle VARCHAR(MAX),
@id_user INT


--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[Dbo].[ST_MOVFacturarAjuste]
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		19/06/2015
*Desarrollador:  Jose Luis Tous P�rez (jtous)
*Descripcion:	Se realizan EL PROCESO DE FACTURAR LOS AJUSTES
***************************************/
Declare @id_return INT, @Contabilizar BIT, @idestado INT,@anomes VARCHAR(6),@fecha VARCHAR(10);
Declare @table TABLE(id int identity(1,1), id_articulo int,serie VARCHAR(255),id_lote BIGINT ,id_bodega int);
Declare @tableent Table (id_pk int identity, id_art bigint);
Declare @rows int = 0, @count int = 1, @id_ent int;
BEGIN TRANSACTION
BEGIN TRY
	SET @anomes = CONVERT(VARCHAR(6), @fechadoc, 112);
	SET @fecha = CONVERT(VARCHAR(10), @fechadoc, 120);
			
	EXECUTE [Dbo].ST_ValidarPeriodo
			@fecha			= @fecha,
			@anomes			= @anomes,
			@mod			= 'I'
		
	EXECUTE [dbo].[ST_MOVValidarAjuste] 
			@fechadoc		= @fechadoc, 
			@id_entrada		= @id_entradatemp, 
			@id_user		= @id_user;

	IF (@id_centrocosto = 0) 
		SET @id_centrocosto = NULL 	

	SET @idestado = Dbo.ST_FnGetIdList('PROCE');

	EXEC Dbo.ST_MOVCargarExistencia 
			@Opcion		= 'A', 
			@id			= @id_entradatemp, 
			@id_user	= @id_user, 
			@id_bodega	= null;
				
			INSERT INTO Dbo.MOVAjustes (id_tipodoc,id_centrocosto,estado,detalle, fecha, id_concepto, costototal, id_user)
			VALUES(@id_tipodoc,@id_centrocosto,@idestado,@detalle, @fechadoc, @id_concepto, (SELECT SUM(costo * cantidad) FROM [dbo].[MOVEntradasItemsTemp] Where id_entrada = @id_entradatemp ), @id_user);

			SET @id_return = SCOPE_IDENTITY();
			IF ISNULL(@id_return, 0) <> 0
			BEGIN
				INSERT INTO Dbo.MOVAjustesItems(id_ajuste, id_articulo,serie,lote,id_lote, id_bodega, cantidad, costo, costoante, id_user,id_itemtemp)
				SELECT @id_return,
 				       id_articulo,
					   serie,
					   lote,
					   id_lote ,
					   id_bodega,
					   cantidad, 
					   costo, 
					   precio,
					    @id_user,
						T.id
				FROM [dbo].[MOVEntradasItemsTemp] T
				WHERE T.id_entrada = @id_entradatemp  AND id_user = @id_user;


				INSERT INTO [dbo].[MovAjustesSeries](id_items,	id_ajuste, serie)
				SELECT II.id, @id_return, S.serie 
				FROM [dbo].[MovEntradasSeriesTemp] S
				INNER JOIN [MOVEntradasItemsTemp] I ON I.id = S.id_itemstemp
				INNER JOIN [MOVAjustesItems] II ON I.id_articulo = II.id_articulo AND II.id_itemtemp = I.id
				WHERE I.id_entrada = @id_entradatemp AND II.serie != 0;

				INSERT INTO Dbo.MOVAjustesLotes (id_item, id_lote, id_ajuste, cantidad)
				SELECT I.id, LT.id_lote, @id_return, LT.cantidad
				FROM [dbo].[MOVEntradaLotesTemp] LT INNER JOIN 
					 Dbo.MOVEntradasItemsTemp IT ON LT.id_itemtemp = IT.id INNER JOIN
					 Dbo.MOVAjustesItems I ON I.id_articulo = IT.id_articulo AND I.id_bodega = IT.id_bodega AND IT.id = I.id_itemtemp
				WHERE IT.lote != 0 AND IT.id_entrada = @id_entradatemp AND IT.id_user = @id_user AND IT.inventarial != 0;


			END

			DELETE [dbo].[MOVEntradaLotesTemp] WHERE id_factura	        = @id_entradatemp;
			DELETE [dbo].[MovEntradasSeriesTemp] WHERE id_entradatemp	= @id_entradatemp;
			Delete [dbo].[MOVEntradasItemsTemp]	 WHERE id_entrada		= @id_entradatemp;
			Delete [dbo].[MOVEntradasTemp]		 WHERE id				= @id_entradatemp;
			
			SELECT @id_return id, 'PROCESADO' estado,'CNT.VW_TRANSACIONES_AJUSTES' nombreview,@fecha fecha,@anomes anomes,@id_user id_user;


		--END
		--ELSE
		--	RAISERROR('Hay art�culos que ponen las existencias en negativo, y no se pueden ajustar.', 16, 0);
					
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH	
		ROLLBACK TRANSACTION;	
		Declare @Mensaje varchar(max) = 'Error: '+ERROR_MESSAGE();
		RAISERROR(@Mensaje,16,0);	
	END CATCH
GO


