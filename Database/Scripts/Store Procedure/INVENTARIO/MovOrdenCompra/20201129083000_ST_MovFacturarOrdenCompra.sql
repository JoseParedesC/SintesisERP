--liquibase formatted sql
--changeset ,jteheran:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_MovFacturarOrdenCompra]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [dbo].[ST_MovFacturarOrdenCompra]
GO
CREATE PROCEDURE [dbo].[ST_MovFacturarOrdenCompra]
@id					BIGINT = 0, 
@fechadoc			VARCHAR(10),
@id_tipodoc			BIGINT,
@id_centrocostos	BIGINT,
@id_ordentemp		BIGINT,
@id_proveedor		BIGINT,
@id_bodega			BIGINT,
@id_user			INT

--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[Dbo].[ST_MovFacturarOrdenCompra]
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		2/056/2020
*Desarrollador:  Jose Luis Tous P�rez (jtous)
*Descripcion:	SE REALIZA EL PROCESO DE FACTURAR LAS ORDEN DE COMPRA
***************************************/
Declare @id_return INT, @idestado INT,@id_catFiscal BIGINT,@id_cat INT, @retiene BIT;;
BEGIN TRY
BEGIN TRAN
		
		SET @idestado = Dbo.ST_FnGetIdList('PROCE');
		SET @id_catFiscal = (SELECT id_catfiscal FROM CNT.Terceros T WHERE T.id = @id_proveedor);
		SELECT @id_cat = F.id, @retiene =  F.retiene FROM  CNTCategoriaFiscal F WHERE F.id = @id_catFiscal AND F.retiene != 0
		INSERT INTO [dbo].[MovOrdenCompras] (id_tipodoc, id_centrocostos, fechadocument, estado, id_proveedor, bodega, costo, id_usercreated, id_userupdated)
		SELECT @id_tipodoc,	@id_centrocostos,	@fechadoc,	@idestado,	@id_proveedor,	@id_bodega, costo,	@id_user,	@id_user
		FROM Dbo.ST_FnCalRetenciones(0, @id_ordentemp, 0, 'EN',0, 0,@id_catfiscal,@id_cat,@retiene) R
					
					
		SET @id_return = SCOPE_IDENTITY();

		IF ISNULL(@id_return, 0) <> 0
		BEGIN
			INSERT INTO [dbo].[MOVOrdenComprasItem] (id_ordencompra, id_producto, id_bodega, cantidad, costo, costototal, id_usercreated, id_userupdated)						
			SELECT @id_return, id_articulo, id_bodega, cantidad, costo, costototal, @id_user, @id_user
			FROM [dbo].[MOVEntradasItemsTemp] WHERE id_entrada = @id_ordentemp;

			
			Delete [dbo].[MOVEntradasItemsTemp]	 WHERE id_entrada	= @id_ordentemp;
			Delete [dbo].[MOVEntradasTemp]		 WHERE id			= @id_ordentemp;
						
			SELECT @id_return id, 'PROCESADO' estado
		END
		ELSE
		BEGIN
			RAISERROR('Error al guardar order de compra, No se pudo guardar la cabecera de la orden.', 16,0);
		END
COMMIT TRAN
END TRY
BEGIN CATCH	
	ROLLBACK TRAN;
	Declare @Mensaje varchar(max) = 'Error: '+ERROR_MESSAGE();
	RAISERROR(@Mensaje,16,0);	
END CATCH
GO


