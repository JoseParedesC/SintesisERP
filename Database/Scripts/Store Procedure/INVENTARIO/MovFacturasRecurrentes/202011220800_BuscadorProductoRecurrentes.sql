--liquibase formatted sql
--changeset ,kmartinez:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[BuscadorProductoRecurrentes]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [dbo].[BuscadorProductoRecurrentes] 
GO
CREATE PROCEDURE [dbo].[BuscadorProductoRecurrentes]
	@filtro		[VARCHAR] (50),
	@id_articulo BIGINT = 0,
	@opcion		[CHAR] (1),
	@op			VARCHAR(2) = NULL,
	@formulado	BIT		= NULL,
	@id_prod	BIGINT	= NULL,
	@id_bodega	BIGINT	= NULL,
	@id_factura VARCHAR(255) = ''
--WITH ENCRYPTION
AS
BEGIN
 
	
Declare @ds_error varchar(max), @id_articuloT BIGINT = 0, @count DECIMAL(18,2)
	
Begin Try
	IF (@opcion = 'A')
	BEGIN
		SELECT DISTINCT TOP 15  (A.id) id, 
		CASE WHEN A.codigobarra Like '%'+@filtro+'%' THEN A.codigobarra
			 WHEN A.codigo Like '%'+@filtro+'%' THEN A.codigo + ' - ' + A.presentacion
			 ELSE A.Nombre + ' ('+codigo+')' + ' - ' + A.presentacion End  name, 
		inventario inventarial
		FROM Dbo.VW_Productos A
		WHERE A.estado = 1 AND A.facturable = 1 AND A.tipoproducto = dbo.[ST_FnGetIdList]('SERVICIOS') AND (A.Codigo like '%'+@filtro+'%' OR A.Nombre like '%'+@filtro+'%');
	END
	ELSE IF (@opcion = 'P')
	BEGIN
		IF(@op='PR')
		BEGIN
			SET @id_articuloT = @id_prod;
			SET @count = (SELECT SUM(existencia) FROM Existencia WHERE id_articulo = @id_articuloT AND id_bodega = @id_bodega);

			SELECT A.Id id, nombre, lote, codigobarra, serie, inventario, impuesto, A.id_iva, A.id_inc, A.inventario,Isnull(E.costo,0) costo ,precio,  porcendescto pordcto, ISNULL(@count, 0) existencia
			FROM DBo.VW_Productos A left JOIN DBO.Existencia E ON A.id=E.id_articulo AND E.id_bodega=@id_bodega 
			WHERE A.id = @id_articuloT;

			IF EXISTS( SELECT 1 FROM VW_Productos WHERE id = @id_articuloT AND serie != 0)
			BEGIN
				EXECUTE [dbo].[ST_MOVFacturaBuscadorLoteSerie]
				@id_articulo = @id_articuloT,
				@id_bodega	 = @id_bodega,
				@opcion		 = 'SF',
				@op			 = 'T',
				@id_factura  = @id_factura				
			END
		END
		
	END
 
End Try
Begin Catch
	--Getting the error description
	Set @ds_error   =  ERROR_PROCEDURE() + 
					';  ' + convert(varchar,ERROR_LINE()) + 
					'; ' + ERROR_MESSAGE()
	-- save the error in a Log file
	RaisError(@ds_error,16,1)
	return
End Catch
END
GO


