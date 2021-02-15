--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ProductosSave]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.ProductosSave
GO

CREATE PROCEDURE [dbo].[ProductosSave]
@id				BIGINT,
@codigo			VARCHAR(20),
@codigobarra	VARCHAR(100),
@presentacion	VARCHAR(50),
@nombre			VARCHAR(100),
@modelo			VARCHAR(100),
@color			VARCHAR(50),
@categoria		BIGINT,
@marca			BIGINT,
@impuesto		BIT,
@ivaincluido	BIT,
@id_iva			BIGINT,
@id_inc			BIGINT,
@porcendescto	NUMERIC(5,2),
@formulado		BIT,
@stock			BIT,
@serie			BIT,
@facturable		BIT,
@precio			NUMERIC(18,4),
@lote			BIT,
@tipoProducto	BIGINT,
@inventario		BIT,
@id_cuenta		BIGINT,
@id_tipodoc		BIGINT,
@id_naturaleza	BIGINT,
@esDescuento	BIT,
@urlimg			VARCHAR(MAX),
@xmlFormulado	XML,--VARCHAR(MAX),
@id_user		INT

--WITH ENCRYPTION
AS

/***************************************
*Nombre:		[dbo].[ProductosSave]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		16/11/19
*Desarrollador: (Jeteheran)
***************************************/

BEGIN TRANSACTION
BEGIN TRY

	DECLARE @Datos INT,  @PrepareXmlStatus INT , @id_return INT, @error VARCHAR(MAX), @fileimg varchar(max) = '';
	DECLARE @ArticulosBodega TABLE (id INT Identity(1,1), cod VARCHAR(20), mini NUMERIC (18,2), maxi NUMERIC (18,2));
	--EXEC @PrepareXmlStatus= sp_xml_preparedocument @Datos OUTPUT, @XmlArticulo	
	IF EXISTS (SELECT 1 FROM dbo.productos A WHERE A.codigo = @codigo AND A.presentacion = @presentacion AND A.id != ISNULL(@id,0))
		RAISERROR('Verifique Código y presentación, ya existe esta relación...', 16,0);
	
	IF(@categoria	= 0) SET @categoria	= NULL
	IF(@marca		= 0) SET @marca		= NULL   
	IF(@id_cuenta	= 0) SET @id_cuenta = NULL
	IF(@id_tipodoc	= 0) SET @id_tipodoc= NULL
	IF(@id_iva		= 0) SET @id_iva	= NULL
	IF(@id_inc		= 0) SET @id_inc	= NULL

	IF(Isnull(@id,0) = 0)
	BEGIN			
	
		INSERT INTO dbo.productos (codigo, codigobarra, nombre, presentacion, modelo, color, categoria, marca, impuesto, ivaincluido, id_iva, id_inc, 
		porcendescto, precio, serie, formulado, stock, id_usercreated,id_userupdated, urlimg, facturable, lote, tipoproducto, inventario, id_ctacontable, 
		id_tipodocu, id_naturaleza, esDescuento)
		VALUES(@codigo, @codigobarra, @nombre, @presentacion, @modelo, @color, @categoria, @marca, @impuesto, @ivaincluido, @id_iva, @id_inc, @porcendescto,
		@precio, @serie, @formulado, @stock, @id_user, @id_user, @urlimg, @facturable, @lote, @tipoProducto, @inventario, @id_cuenta, @id_tipodoc, 
		@id_naturaleza, @esDescuento)
		
		SET @id_return = SCOPE_IDENTITY();
	END
	ELSE
	BEGIN
		Set @fileimg  = (SELECT TOP 1CASE WHEN urlimg != @urlimg AND @urlimg = '' THEN urlimg ELSE '' END From Dbo.Productos Where id = @id );		
		UPDATE dbo.productos 
		SET nombre			= @nombre,
			codigobarra		= @codigobarra,
			presentacion	= @presentacion,
			tipoproducto	= @tipoProducto,
			modelo			= @modelo,
			color			= @color,
			categoria		= @categoria, 
			marca			= @marca, 
			impuesto		= @impuesto, 
			ivaincluido		= @ivaincluido, 
			id_iva			= @id_iva, 
			id_inc			= @id_inc, 
			porcendescto	= @porcendescto, 
			precio			= @precio, 
			serie			= @serie, 
			formulado		= @formulado, 
			stock			= @stock, 
			id_userupdated	= @id_user,
			urlimg			= @urlimg,
			facturable		= @facturable,
			lote			= @lote,
			inventario		= @inventario,
			id_ctacontable	= @id_cuenta,
			id_tipodocu		= @id_tipodoc,
			id_naturaleza	= @id_naturaleza,
			esDescuento		= @esDescuento,
			updated			= GETDATE()
		WHERE id = @id;
					
		SET @id_return = @id;		

	END

	DELETE [dbo].[ArticulosFormula] WHERE id_articuloformu = @id_return;

	IF (@formulado = 1)
	BEGIN
		
		EXEC @PrepareXmlStatus= sp_xml_preparedocument @Datos OUTPUT, @xmlFormulado
		
		INSERT INTO [ArticulosFormula](id_articuloformu, id_articulo, serie, id_lote, cantidad, id_user)
		SELECT  @id_return, idarticulo, serie, id_lote, cantidad, @id_user	
		FROM  OPENXML(@Datos, 'items/item', 2)  	
		WITH 
		(	idarticulo  [bigint]		'@idarticulo',
	  	    serie		[VARCHAR](50)	'@serie',
			id_lote		[bigint]		'@id_lote',
			cantidad	[numeric](18,4) '@cantidad'
		) 

		EXEC sp_xml_preparedocument @Datos OUTPUT, @xmlFormulado; 	
	END
	
	COMMIT TRANSACTION;
END TRY
BEGIN CATCH
	SET @error = 'Error: '+ERROR_MESSAGE();
	RAISERROR(@error,16,0);		
	ROLLBACK TRANSACTION;
END CATCH

SELECT @id_return id, @fileimg url;

GO


