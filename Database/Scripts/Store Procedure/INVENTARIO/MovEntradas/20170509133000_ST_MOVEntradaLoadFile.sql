--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_MOVEntradaLoadFile]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_MOVEntradaLoadFile]
GO

CREATE PROCEDURE [dbo].[ST_MOVEntradaLoadFile]
	@id_proveedor	[int] = null,
	@id_entrada		[int],   
	@flete			[NUMERIC] (18,2) = 0,
	@xmlart			[XML],
    @id_user		[INT]
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[Dbo].[ST_MOVEntradaLoadFile]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		09/05/2017
*Desarrollador: (JTOUS)
***************************************/

SET LANGUAGE spanish

DECLARE @error VARCHAR(MAX), @id int, @manejador int;
DECLARE @table Table(id_articulo bigint, codigo varchar(50), presentacion varchar(50), nombre varchar(150), cantidad numeric(18,2), costo numeric(18,2), descuento numeric(18,2),porceiva Numeric(18,2) ,iva numeric(18,2),porceinc numeric(18,2)	, id_bodega bigint, bodega varchar(20), precio numeric(18,2),lote VARCHAR(30),codBarra VARCHAR(100),vencimientolote VARCHAR(10));
BEGIN TRY
BEGIN TRAN

	DELETE [dbo].[MOVEntradasItemsTemp] WHERE id_entrada = @id_entrada;
	
	EXEC sp_xml_preparedocument @manejador OUTPUT, @xmlart; 	

	INSERT INTO @table (Codigo, Presentacion, Nombre, Cantidad, Costo,porceiva, Iva,porceinc ,Descuento, Bodega,lote,codBarra,vencimientolote)
	SELECT Codigo, Presentacion, Nombre, Cantidad, Costo,porceiva, Iva,porceinc, Descuento, Bodega, lote,codBarra ,vencimientolote
	FROM OPENXML(@manejador, N'items/item') 
	WITH (  Codigo [varchar](50) '@Codigo',
			Presentacion [varchar](50) '@Presentacion',
			Nombre [varchar](150) '@Nombre',
			Cantidad [NUMERIC](18,2) '@Cantidad',
			Costo [NUMERIC](18,2) '@Costo',
			porceiva [NUMERIC](18,2) '@porceiva',
			Iva [NUMERIC](18,2) '@Iva',
			porceinc [NUMERIC](18,2) '@porceinc',
			Descuento [NUMERIC](18,2) '@Descuento',
			Bodega [varchar](20) '@Bodega',
			lote [varchar](20) '@Lote',
			codBarra [varchar](100) '@codBarra',
			vencimientolote [varchar](10) '@Vencimientolote'
			) AS P;
	
	EXEC sp_xml_removedocument @manejador;

	UPDATE T SET
	 t.id_articulo =        A.id,
	 precio =               A.precio,
	 T.lote=                CASE WHEN A.lote=1 THEN t.lote ELSE 'SINTESIS01' END,
	 T.codBarra=            CASE WHEN A.lote=1 THEN t.codBarra ELSE A.codigobarra END,
	 T.vencimientolote=     CASE WHEN A.lote=1 THEN t.vencimientolote ELSE '' END
	 FROM @table T 
	LEFT join Dbo.Productos A ON T.codigo = A.codigo AND T.presentacion = A.presentacion;

	IF EXISTS (SELECT 1 FROM @table WHERE id_articulo is null)
	BEGIN
		SET @error = 'No existe este artículo (' + (SELECT TOP 1 Codigo +'-'+Presentacion FROM @table WHERE id_articulo is null) + ')que intenta subir'
		RAISERROR(@error, 16, 0);
	END

	IF EXISTS (SELECT 1 FROM @table t inner join dbo.Productos p on t.id_articulo=p.id WHERE t.lote='' and p.lote=1)
	BEGIN
		SET @error = 'Este Producto (' + (SELECT TOP 1 t.Codigo +'-'+t.Presentacion FROM @table t inner join dbo.Productos p on t.id_articulo=p.id WHERE t.lote='' and p.lote=1) + ')que intenta subir Maneja Lote'
		RAISERROR(@error, 16, 0);
	END


	UPDATE T SET t.id_bodega = B.id FROM @table T 
	LEFT join Dbo.Bodegas B ON T.bodega = B.codigo;
	
	IF EXISTS (SELECT 1 FROM @table WHERE id_bodega is null)
		RAISERROR('No existe uno de las bodegas que intenta subir.', 16, 0);

	
	INSERT INTO [dbo].[MOVEntradasItemsTemp] (id_entrada, id_articulo, id_bodega,id_lote,vencimientolote, cantidad, costo, precio,porceniva ,iva,porceninc,inc, descuento, costototal, flete, id_user)
	SELECT 
		@id_entrada, id_articulo, id_bodega, lote ,vencimientolote, cantidad, costo, precio,porceiva ,iva,porceinc,(costo*(porceinc/100)) ,(descuento * cantidad), (costo - descuento + iva) * cantidad, 0, @id_user
	FROM @table 

	
	SELECT R.retfuente, R.retiva, R.retica, R.costo Tcosto, R.iva Tiva,R.tinc Tinc, R.descuento Tdesc, R.total Ttotal
	FROM Dbo.ST_FnCalRetenciones(@id_proveedor, @id_entrada, @flete, '', 0, 0, 0, 0, 0) R

	SELECT 
		I.id, A.codigo, A.presentacion, A.nombre, B.nombre bodega, I.cantidad, I.costo,I.inc, I.iva, I.descuento, I.costototal
	FROM 
		Dbo.[MOVEntradasItemsTemp]  I
		INNER JOIN Dbo.Productos A ON A.id = I.id_articulo
		INNER JOIN Dbo.Bodegas B ON B.id = I.id_bodega
	WHERE 
		I.id_entrada = @id_entrada;	

COMMIT TRAN;
END TRY
BEGIN CATCH
		ROLLBACK TRAN;
	    --Getting the error description
	    SELECT @error   =   ERROR_MESSAGE()
	    -- save the error in a Log file
	    RAISERROR(@error,16,1);
END CATCH
