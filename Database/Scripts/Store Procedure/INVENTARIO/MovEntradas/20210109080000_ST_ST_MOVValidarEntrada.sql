--liquibase formatted sql
--changeset ,jteheran:3 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_MOVValidarEntrada]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [dbo].[ST_MOVValidarEntrada]
GO
CREATE PROCEDURE [dbo].[ST_MOVValidarEntrada]
@fechadoc  SMALLDATETIME,
@id_entrada bigint,
@id_bodega BIGINT,
@prorratea BIT,
@tipoprorrat CHAR (1),
@numfac VARCHAR(50),
@id_proveedor BIGINT,
@id_user INT

--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[Dbo].[ST_MOVValidarEntrada]
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		19/05/2020
*Desarrollador:  Jose Luis Tous P�rez (jtous)
*Descripcion:	Se realizan EL PROCESO DE FACTURAR LAS ENTRADAS
***************************************/
Declare @idestado INT, @Cantidad int;
Declare @mensaje varchar(max), @id_articulo int, @serie VARCHAR(200) = '', @lote VARCHAR(200) = '';
BEGIN TRY

	
	--IF EXISTS (SELECT 1 FROM Usuarios WHERE id = @id_user AND id_perfil = 2)
	--	RAISERROR('No puede realizar esta operaci�n por su perfil.', 16,0);

	
	
	IF  EXISTS (SELECT 1 FROM Dbo.MOVEntradas WHERE id_proveedor = @id_proveedor AND numfactura = @numfac AND estado != DBO.ST_FnGetIdList('REVER'))
		RAISERROR('El numero de factura ya existe con este proveedor...', 16, 0);

	IF  EXISTS (SELECT TOP 1 1 FROM Dbo.MOVEntradas WHERE id_proveflete IS NOT NULL AND id_formapagoflete is NULL and numfactura= @numfac)
		RAISERROR('Debe seleccionar Forma pago de proveedor flete...', 16, 0);

	IF (@prorratea = 1 AND @tipoprorrat NOT IN ('C','V'))
		RAISERROR('No ha seleccionado tipo de prorrateo.', 16, 0);

	--Valida los articulos que manejan lote y no estan llenos
	SELECT @id_articulo = id_articulo FROM MOVEntradasItemsTemp WHERE lote != 0 AND id_entrada = @id_entrada AND REPLACE(id_lote, ' ', '') = ''
	IF (ISNULL(@id_articulo, 0) != 0)
	BEGIN
		SELECT TOP 1 @mensaje = 'El producto ' + nombre +' maneja lote, y no lo ha configurado.' 
		FROM Dbo.Productos WHERE id = @id_articulo; 
		RAISERROR(@mensaje, 16, 0)
	END

	--Valida vencimiento de articulos con lote
	SELECT @id_articulo = id_articulo FROM MOVEntradasItemsTemp WHERE lote != 0 AND id_entrada = @id_entrada AND REPLACE(id_lote, ' ', '') != '' AND CONVERT(VARCHAR(10), vencimientolote, 120) = '1900-01-01'
	IF (ISNULL(@id_articulo, 0) != 0)
	BEGIN
		SELECT TOP 1 @mensaje = 'El producto ' + nombre +' maneja lote, y no ha configurado el vencimiento.' 
		FROM Dbo.Productos WHERE id = @id_articulo; 
		RAISERROR(@mensaje, 16, 0)
	END

	;WITH CTELOTE (lote, vencimiento)
	AS (
		SELECT DISTINCT id_lote, CONVERT(VARCHAR(10), vencimientolote, 120) vencimmiento 
		FROM MOVEntradasItemsTemp WHERE id_entrada = @id_entrada AND REPLACE(id_lote, ' ' ,'') != ''
	)
	SELECT TOP 1 @lote = L.lote FROM CTELOTE C INNER JOIN 
	LotesProducto L ON L.lote = C.lote AND CONVERT(VARCHAR(10), L.vencimiento_lote, 120) != C.vencimiento
	
	IF(ISNULL(@lote, '' ) != '')
	BEGIN
		SELECT TOP 1 @mensaje = 'El lote (' + @lote +') ya existe con un vencimiento distinto' 
		FROM Dbo.LotesProducto WHERE lote = @lote; 
		RAISERROR(@mensaje, 16, 0)
	END	

	--Validar series de articulos temporales
	;WITH CTESERIE (id, id_articulo, cantidad, [count])
	AS(
		SELECT I.id, I.id_articulo, I.cantidad, SUM(CASE WHEN S.serie IS NULL THEN 0 ELSE 1 END) [count]
		FROM Dbo.MOVEntradasItemsTemp I LEFT JOIN 
			 Dbo.MovEntradasSeriesTemp S ON S.[id_itemstemp] = I.id 
		WHERE I.serie != 0 AND I.id_entrada = @id_entrada 
		GROUP BY I.id, I.id_articulo, I.cantidad
	) 
	SELECT TOP 1 @id_articulo = id_articulo FROM CTESERIE WHERE cantidad != [count]

	IF(ISNULL(@id_articulo, 0 ) != 0)
	BEGIN
		SELECT TOP 1 @mensaje = 'El producto ' + nombre +' no ha configurado todas las series' 
		FROM Dbo.Productos WHERE id = @id_articulo; 
		RAISERROR(@mensaje, 16, 0)
	END	


	--Validar series de articulos existencia
	SELECT TOP 1 @mensaje = 'El producto ' + P.nombre +' ya tiene existencia con esta (' + S.serie + ') serie' 
	FROM			Dbo.MOVEntradasItemsTemp  I
		 INNER JOIN Dbo.MovEntradasSeriesTemp S  ON S.[id_itemstemp] = I.id
		 INNER JOIN Dbo.Productos P ON P.id = I.id_articulo
		 LEFT JOIN Dbo.VW_ExistenciaLoteSerie E ON E.id_articulo = I.id_articulo AND E.id_bodega = @id_bodega AND E.serie = S.serie
	WHERE I.serie != 0 AND I.inventarial != 0 AND I.id_entrada = @id_entrada AND E.serie IS NOT NULL;

	IF(ISNULL(@mensaje, '' ) != '')
		RAISERROR(@mensaje, 16, 0);
END TRY
BEGIN CATCH	
	SET @mensaje = ERROR_MESSAGE();
	RAISERROR(@Mensaje,16,0);	
END CATCH