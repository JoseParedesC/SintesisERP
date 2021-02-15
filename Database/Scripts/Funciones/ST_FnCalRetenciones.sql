--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_FnCalRetenciones]') and OBJECTPROPERTY(id, N'IsTableFunction') = 1)
DROP FUNCTION [dbo].[ST_FnCalRetenciones]
GO



CREATE Function  [dbo].[ST_FnCalRetenciones] (
@id_proveedor INT, 
@id_entra INT, 
@flete NUMERIC(18,2),
@opcion VARCHAR(3), 
@id_entrada BIGINT = null,
@id_proveedorfle BIGINT,
@id_catfiscal INT,
@id_cat  INT,
@retiene BIT
)
RETURNS @TblResultante  TABLE (Id Int Identity (1,1) Not Null, porfuente  NUMERIC(5,2), retfuente  NUMERIC(18,2), 
															   poriva  NUMERIC(5,2),	retiva  NUMERIC(18,2), 
															   porica NUMERIC(5,2),		retica  NUMERIC(18,2), 
															   descuento NUMERIC(18,2), costo NUMERIC(18,2), 
															   iva NUMERIC(18,2), total NUMERIC(18,2),
															   tinc NUMERIC(18,2), flete NUMERIC(18,2),ivaFlete NUMERIC(18,2)															   )

--With Encryption 
As
BEGIN
	Declare  @retefuente	NUMERIC(18,2) = 0,
			 @retiva		NUMERIC(18,2) = 0,
			 @retica		NUMERIC(18,2) = 0,
			 @retefuenteSer	NUMERIC(18,2) = 0,
			 @retivaSer		NUMERIC(18,2) = 0,
			 @reticaSer		NUMERIC(18,2) = 0,
			 @costo			NUMERIC(18,2) = 0,
			 @inc           NUMERIC(18,2) = 0,
			 @iva			NUMERIC(18,2) = 0,
			 @descuento		NUMERIC(18,2) = 0,
			 @ivaflete		NUMERIC(18,2) = 0,
			 @totalflete	NUMERIC(18,2) = 0,
			 @costoprod		NUMERIC(18,2) = 0,
			 @ivaProd		NUMERIC(18,2) = 0,
			 @desctoProd	NUMERIC(18,2) = 0,
			 @porfuente		NUMERIC(5,2) = 0,	
			 @poriva		NUMERIC(18,2) = 0, 
	         @porica		NUMERIC(5,2) = 0,
			 @porivagen		NUMERIC(18,2) = 0;


	SET @porivagen	  = CONVERT(NUMERIC(18,2), ISNULL((SELECT TOP 1 valor FROM Parametros WHERE codigo = 'PORIVAGEN'), 0))
	SET @ivaflete	  = CASE WHEN @id_proveedorfle != 0  THEN 0 ELSE ROUND(@flete - (@flete/ (1 + (@porivagen/100) )),2) END;
	SET @totalflete	  = @flete - @ivaflete;

	IF(@opcion='EN')
	BEGIN
		SELECT 
			@costo		= ISNULL(SUM(costo * cantidad), 0),
			@iva		= ISNULL(SUM(iva * cantidad), 0),
			@inc		= ISNULL(SUM(inc * cantidad ), 0),
			@descuento	= ISNULL(SUM(descuento), 0),
			@retefuenteSer		= ISNULL(SUM(retefuente * cantidad), 0),
			@reticaSer			= ISNULL(SUM(reteica * cantidad), 0),
			@retivaSer			= ISNULL(SUM(reteiva * cantidad ), 0)
		FROM Dbo.MOVEntradasItemsTemp I 
		WHERE id_entrada = @id_entra;
		
		SELECT 
			@costoprod  = ISNULL(SUM(costo*cantidad),0),
			@ivaProd    = ISNULL(SUM(iva * cantidad),0),
			@desctoProd = ISNULL(SUM(descuento),0)
		FROM Dbo.MOVEntradasItemsTemp I JOIN dbo.Productos P ON I.id_articulo=P.id AND P.tipoproducto=dbo.ST_FnGetIdList('PRODUCTO')
		WHERE id_entrada = @id_entra;
		
		IF (ISNULL(@retiene,0) != 0)
		BEGIN
			SELECT 
				@porfuente	= F.retefuente,
				@poriva		= F.reteiva,
				@porica		= F.reteica,
				@retefuente = CASE WHEN @id_catFiscal<>0 THEN ( CASE WHEN @costoprod >= F.valorfuente THEN ROUND((@costoprod - @desctoProd) * (F.retefuente / 100),2) Else 0 END) ELSE 0 END,
				@retiva		= CASE WHEN @id_catFiscal<>0 THEN ( CASE WHEN @costoprod >= F.valoriva	THEN ROUND((@ivaProd + @ivaflete) * (F.reteiva	/ 100),2) Else 0 END)ELSE 0 END,
				@retica		= CASE WHEN @id_catFiscal<>0 THEN ( CASE WHEN @costoprod >= F.valorica	THEN ROUND((@costoprod - @desctoProd) * (F.reteica	/ 100),2) Else 0 END)ELSE 0 END
			FROM [CNT].[VW_CategoriaFiscal] F 
			WHERE F.id = @id_cat;
		END
	END
	ELSE IF(@opcion='DEV')
	BEGIN
		SELECT 
			@costo		= ISNULL(SUM(costo * cantidaddev), 0),
			@iva		= ISNULL(SUM(iva * cantidaddev), 0),
			@inc		= ISNULL(SUM(inc * cantidaddev ), 0),
			@descuento	= ISNULL(SUM(descuento), 0),
			@retefuenteSer		= ISNULL(SUM(retefuente * cantidad), 0),
			@reticaSer			= ISNULL(SUM(reteica * cantidad), 0),
			@retivaSer			= ISNULL(SUM(reteiva * cantidad ), 0)
		FROM Dbo.MOVEntradasItemsTemp 
		WHERE id_entrada = @id_entra ANd selected != 0;

		SELECT 
			@costoprod  = ISNULL(SUM(costo*cantidaddev),0),
			@ivaProd    = ISNULL(SUM(iva * cantidaddev),0),
			@desctoProd = ISNULL(SUM(descuento),0)
		FROM Dbo.MOVEntradasItemsTemp I JOIN dbo.Productos P ON I.id_articulo=P.id AND P.tipoproducto=dbo.ST_FnGetIdList('PRODUCTO')
		WHERE id_entrada = @id_entra ANd selected != 0;

		SELECT 
			@porfuente	= CASE WHEN F.retefuente > 0 THEN F.porfuente ELSE 0 END,
			@poriva		= CASE WHEN F.reteiva	 > 0 THEN F.poriva ELSE 0 END,
			@porica		= CASE WHEN F.reteica	 > 0 THEN F.porica ELSE 0 END,
			@retefuente = CASE WHEN F.retefuente > 0 THEN ROUND((@costoprod	- @desctoProd)	* (F.porfuente / 100),2) ELSE 0 END,
			@retiva		= CASE WHEN F.reteiva	 > 0 THEN ROUND((@ivaProd		+ @ivaflete)	* (F.poriva	/ 100),2) ELSE 0 END,
			@retica		= CASE WHEN F.reteica	 > 0 THEN ROUND((@costoprod	- @desctoProd)	* (F.porica	/ 100),2) ELSE 0 END
		FROM MOVEntradas F 
		WHERE F.id = @id_entrada;
	END


	Insert Into @TblResultante (porfuente, retfuente, poriva, retiva, porica, retica, costo, iva, tinc,descuento, total, flete,ivaFlete)
	Values	(@porfuente, @retefuente+@retefuenteSer, @poriva, @retiva+@retivaSer, @porica, @retica+@reticaSer, @costo, (@iva ), @inc, @descuento,
			(@costo - (@retefuente+@retefuenteSer + @retiva+@retivaSer + @retica+@reticaSer + @descuento) + @iva + @inc + @flete), @totalflete,@ivaflete);	


	RETURN
End
