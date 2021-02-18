--liquibase formatted sql
--changeset ,JPAREDES:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[BuscadorProducto]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[BuscadorProducto]
GO
CREATE PROCEDURE [dbo].[BuscadorProducto]
		 @filtro        [VARCHAR] (50),
		 @id_articulo BIGINT = 0,
		 @opcion        [CHAR] (1),
		 @op            VARCHAR(2) = NULL,
		 @formulado    BIT        = NULL,
		 @id_prod    BIGINT    = NULL,
		 @id_bodega    BIGINT    = NULL,
		 @id_factura VARCHAR(255) = '',
		 @tipo VARCHAR (10) =''
	--WITH ENCRYPTION
	AS
	BEGIN
	/***************************************
	*Nombre:        [Dbo].[BuscadorProducto]
	----------------------------------------
	*Tipo:            Procedimiento almacenado
	*creaci�n:        17/11/19
	*Desarrollador: (JETEHERAN)
	***************************************/

	Declare @ds_error varchar(max), @id_articuloT BIGINT = 0, @count DECIMAL(18,2), @anomes VARCHAR(6) = REPLACE(@tipo, '-',''), @porcentaje NUMERIC(18,2)

	Begin Try
		 IF(@opcion = 'C') -- lista los productos por filtro en Compras
		 BEGIN
			 SELECT Distinct(A.id) id,
					CASE WHEN A.codigobarra Like '%'+@filtro+'%' THEN A.codigobarra
						 WHEN A.codigo Like '%'+@filtro+'%' THEN A.codigo + ' - ' + A.presentacion
						 ELSE A.Nombre + ' ('+codigo+')' + ' - ' + A.presentacion End  name
			 FROM Dbo.VW_Productos A
			 WHERE A.estado = 1 AND A.formulado = 0 AND 
			 (A.codigobarra like '%'+@filtro+'%' OR A.Codigo like '%'+@filtro+'%' OR A.Nombre like '%'+@filtro+'%') AND
			 (A.tipoproducto IN (SELECT Dbo.ST_FnGetIdList(item) FROM [dbo].[ST_FnTextToTable]('PRODUCTO,CONSUMO',',')) OR (tipoproducto= dbo.ST_FnGetIdList('SERVICIOS') 
			 AND id_tipodocu=dbo.ST_FnGetIdList('COMPRAS')))  ;
		 END
		 ELSE IF(@opcion = 'O')
		 BEGIN
			 SELECT Distinct(A.id) id,
			 CASE WHEN A.codigobarra Like '%'+@filtro+'%' THEN A.codigobarra
				  WHEN A.codigo Like '%'+@filtro+'%' THEN A.codigo + ' - ' + A.presentacion
				  ELSE A.Nombre + ' ('+codigo+')' + ' - ' + A.presentacion End  name
			 FROM Dbo.VW_Productos A
			 WHERE A.estado = 1 AND A.inventario != 0 AND formulado = 0 AND (A.Codigo like '%'+@filtro+'%' OR A.Nombre like '%'+@filtro+'%');
		 END
		 --CZULBARAN
		 ELSE IF(@opcion = 'F') -- lista los centros de costo
		 BEGIN
			 SELECT DISTINCT(CC.id) id,
					CASE WHEN CC.codigo Like '%'+@filtro+'%' THEN CC.codigo + ' - ' + CC.nombre
				         WHEN CC.nombre Like '%'+@filtro+'%' THEN CC.codigo + ' - ' + CC.nombre END  name
			 FROM CNT.VW_CentroCosto CC
			 WHERE CC.detalle != 0  AND (CC.codigo  like '%'+@filtro+'%' OR CC.nombre like'%'+@filtro+'%' );
		 END
		 ELSE IF (@opcion = 'V')    -- lista los vendedores
		 BEGIN
			 SELECT DISTINCT (V.id) id,
					CASE WHEN V.codigo like '%' +@filtro+ '%' THEN V.codigo + '  -  ' + V.nombre
					     WHEN V.nombre like '%' +@filtro+ '%' THEN V.codigo +'  -  ' + V.nombre END name
			 FROM dbo.Vendedores V
			 WHERE v.codigo  like '%'+@filtro+'%' OR V.nombre like'%'+@filtro+'%'
		 END
		 ELSE IF (@opcion = 'T')     --lista los clientes
		 BEGIN
			 SELECT DISTINCT (TER.id) id, TER.iden+' - '+Ter.tercero name
			 FROM CNT.VW_Terceros TER
			 INNER JOIN CNT.VW_TercerosTipo T ON TER.id = T.id_tercero
			 WHERE T.codigo = @op AND (TER.iden like '%'+@filtro+'%' OR Ter.tercero like'%'+@filtro+'%')
		 END
		 ELSE IF (@opcion = 'K')     --lista las cuentas de anticipo
		 BEGIN
			 SELECT DISTINCT (CU.id) id, CU.codigo + ' - ' + CU.nombre name
			 FROM dbo.VW_CNTCuentas CU
			 WHERE tipo != 0 and estado !=0 AND (CU.codigo like @filtro+'%' OR CU.nombre like @filtro+'%') AND id_tipocta = DBO.ST_FnGetIdList(@tipo)
		 END
		 ELSE IF (@opcion = 'L')     --lista las cuentas de obsequios (JPAREDES)
		 BEGIN
			 SELECT DISTINCT (CU.id) id, CU.codigo + ' - ' + CU.nombre name
			 FROM dbo.VW_CNTCuentas CU
			 WHERE tipo != 0 AND estado !=0 AND (CU.codigo like '%'+@filtro+'%' OR CU.nombre like'%'+@filtro+'%') 
					AND id_tipocta = DBO.ST_FnGetIdList(@tipo) AND SUBSTRING(codigo,1,4) = 5235
			 ORDER BY id ASC;
		 END
		 ELSE IF (@opcion = 'Z' )-- lista las bodegas
		 BEGIN
				 SELECT DISTINCT  id, codigo + ' - ' + nombre name
				 FROM Dbo.Bodegas
				 WHERE estado = 1 AND (codigo like '%'+@filtro+'%' OR nombre like'%'+@filtro+'%')
		 END
		 ELSE IF (@opcion = 'W') ---lista las facturas en estado procesado
		 BEGIN
				 SELECT  DISTINCT A.id,
				 CASE WHEN A.rptconsecutivo like '%' + @filtro+ '%' THEN A.rptconsecutivo +'  - '+A.cliente
					  WHEN A.cliente like '%'+ @filtro + '%' THEN A.rptconsecutivo +'  - '+A.cliente END name
				 FROM dbo.VW_MOVFacturas A
				 WHERE estado = 'PROCESADO' AND (A.rptconsecutivo like'%'+@filtro+'%' OR A.cliente like'%'+@filtro+'%')
		 END
		 ELSE IF (@opcion = 'Y') -- lista los productos tipo servicios
		 BEGIN
				 SELECT DISTINCT id,
						CASE WHEN codigo like '%' + @filtro + '%' THEN codigo + ' -  ' + presentacion + '  -  ' + nombre
							 WHEN codigobarra like '%' + @filtro + '%' THEN codigo + '  -  ' + presentacion + '  -  ' + nombre
							 WHEN nombre  like '%' + @filtro + '%' THEN codigo + ' -  ' + presentacion + '  -  ' + nombre END name
				 FROM  dbo.VW_Productos
				 WHERE tipoproducto = Dbo.ST_FnGetIdList('SERVICIOS') AND inventario = 0 AND 
				 esDescuento = @formulado AND (codigo like '%'+@filtro+'%' OR codigobarra like'%'+@filtro+'%' OR nombre like '%' + @filtro + '%')
		 END
		 ELSE IF (@opcion = 'Q') -- lista los productos tipo servicios
		 BEGIN
				 SELECT DISTINCT id,
						CASE WHEN codigo like '%' + @filtro + '%' THEN codigo + ' -  ' + presentacion + '  -  ' + nombre
					         WHEN codigobarra like '%' + @filtro + '%' THEN codigo+ '  -  ' + presentacion + '  -  ' + nombre
							 WHEN nombre  like '%' + @filtro + '%' THEN codigo + ' -  ' + presentacion + '  -  ' + nombre END name
				 FROM  dbo.VW_Productos
				 WHERE tipoproducto = Dbo.ST_FnGetIdList('SERVICIOS') AND id_naturaleza = Dbo.ST_FnGetIdList('CREDITO') AND inventario = 0 
				 AND id_tipodocu = Dbo.ST_FnGetIdList(@tipo) AND esDescuento = @formulado AND
				 (codigo like '%'+@filtro+'%' OR codigobarra like'%'+@filtro+'%' OR nombre like '%' + @filtro + '%')
		 END
		 ELSE IF (@opcion = 'X') ---- lista las facturas que tienen elestado de procesado
		 BEGIN
				 SELECT DISTINCT id,
						CASE WHEN numfactura like '%' + @filtro + '%' THEN numfactura + '  -  ' + '  -  '+proveedor +'  -  '+ CAST(valor AS VARCHAR)
							 WHEN proveedor  like '%' + @filtro + '%' THEN numfactura + '  -  ' + '  -  '+proveedor +'  -  '+ CAST(valor AS VARCHAR)  END name
				 FROM dbo.VW_MOVEntradas
				 WHERE estado = 'PROCESADO' and (numfactura like '%'+@filtro+'%' OR proveedor like '%'+@filtro+'%' )
		 END
		 ELSE IF (@opcion = 'B') --lista todas las cuentas
		 BEGIN
			 SELECT DISTINCT (CU.id) id,
					CASE WHEN CU.codigo like '%' +@filtro+ '%' THEN CU.codigo + ' - ' + CU.nombre
						 WHEN CU.nombre like '%' +@filtro+ '%' THEN CU.codigo+'- '+ CU.nombre END name
			 FROM dbo.VW_CNTCuentas CU
			 WHERE tipo != 0 and estado !=0 AND (CU.codigo like '%'+@filtro+'%' OR CU.nombre like'%'+@filtro+'%')
			 ORDER BY id ASC;
		 END
		 ELSE IF(@opcion = 'M')
		 BEGIN
			 SELECT TER.id,
					CASE WHEN TER.tercero like '%' +@filtro+ '%' THEN TER.iden + ' - ' + TER.tercero
					     WHEN TER.iden like '%' +@filtro+ '%' THEN TER.iden + ' - ' + TER.tercero END name
			 FROM   CNT.VW_Terceros TER INNER JOIN CNT.VW_TercerosTipo T ON TER.id = T.id_tercero
			 WHERE T.codigo ='TC'
		 END
		 ELSE IF(@opcion = 'H') -- BUSCADOR DE PRODUCTOS INVENTARIALES
		 BEGIN
			SELECT DISTINCT P.id,
					P.codigobarra + ' - ' + P.presentacion + '  -  ' +P.nombre [name]
			FROM Dbo.VW_Productos P 
			WHERE P.tipoproducto = dbo.ST_FnGetIdList('PRODUCTO') AND  inventario = 1 AND 
			( P.nombre like '%' + @filtro + '%' OR  P.id like '%' + @filtro + '%' OR P.codigo like '%' + @filtro + '%' OR P.codigobarra like '%' +@filtro + '%')
		 END
		 ELSE IF (@opcion = 'R')--- BUSCADOR DE UNIDADES
		 BEGIN 
			SELECT DISTINCT P.id,
					P.codigo + ' - ' + P.presentacion + '  -  ' +P.nombre [name]
			FROM Dbo.VW_Productos P 
			WHERE ( P.presentacion like '%' + @filtro + '%' OR  P.id like '%' + @filtro + '%')
		 END
		 ELSE IF (@opcion = 'G') --BUSCADOR DE SERIES DEPENDIENDO EL ARTICULO
		 BEGIN
				SELECT S.id, 
						S.serie [name]
				FROM MovEntradasSeries S
				INNER JOIN MOVEntradas  E ON  E.id = S.id_entrada
				INNER JOIN MOVEntradasItems I ON I.id_entrada = E.id
				INNER JOIN Productos P ON P.id = I.id_articulo
				WHERE I.id_articulo = @op  AND ( s.serie like '%' + @filtro + '%' OR  s.id like '%' + @filtro + '%')
		 END
		 ELSE IF (@opcion = 'E')
		 BEGIN
			 SELECT DISTINCT TOP 15  (A.id) id,
			 CASE WHEN A.codigobarra Like '%'+@filtro+'%' THEN  A.Nombre + ' ('+codigobarra+')' + ' - ' + A.presentacion
				  WHEN A.codigo Like '%'+@filtro+'%' THEN A.Nombre + ' ('+codigo+')' + ' - ' + A.presentacion
				  ELSE A.Nombre + ' ('+codigo+')' + ' - ' + A.presentacion End  name,
					 inventario inventarial
			 FROM Dbo.VW_Productos A
			 WHERE A.estado = 1  AND A.formulado=1 AND (A.codigobarra like
			'%'+@filtro+'%' OR A.Codigo like '%'+@filtro+'%' OR A.Nombre like
			'%'+@filtro+'%') AND (A.tipoproducto= dbo.ST_FnGetIdList('PRODUCTO') OR
			(tipoproducto= dbo.ST_FnGetIdList('SERVICIOS') AND
			id_tipodocu=dbo.ST_FnGetIdList('VENTAS')) );
		 END
		 
		 --FIN CZULBARAN

		 ELSE IF(@opcion = 'S')
		 BEGIN
			 SELECT TOP 15  A.Codigo id,
			 CASE WHEN A.codigobarra Like '%'+@filtro+'%' THEN A.codigobarra
				  WHEN A.codigo Like '%'+@filtro+'%' THEN A.codigo + ' - ' + A.presentacion
				  ELSE A.Nombre + ' ('+codigo+')' + ' - ' + A.presentacion End  name
			 FROM Dbo.VW_Productos A
			 WHERE A.estado = 1 AND A.formulado = 1 AND A.stock = 1 AND (A.Codigo like '%'+@filtro+'%' OR A.Nombre like '%'+@filtro+'%');
		 END
		 ELSE IF (@opcion = 'A')
		 BEGIN
			 SELECT DISTINCT TOP 15  (A.id) id,
			 CASE WHEN A.codigobarra Like '%'+@filtro+'%' THEN  A.Nombre + ' ('+codigobarra+')' + ' - ' + A.presentacion
				  WHEN A.codigo Like '%'+@filtro+'%' THEN A.Nombre + ' ('+codigo+')' + ' - ' + A.presentacion
				  ELSE A.Nombre + ' ('+codigo+')' + ' - ' + A.presentacion End  name,
			 inventario inventarial
			 FROM Dbo.VW_Productos A
			 WHERE A.estado = 1 AND A.facturable = 1 AND (A.codigobarra like '%'+@filtro+'%' OR A.Codigo like '%'+@filtro+'%' OR A.Nombre like
			'%'+@filtro+'%') AND (A.tipoproducto= dbo.ST_FnGetIdList('PRODUCTO') OR (tipoproducto= dbo.ST_FnGetIdList('SERVICIOS') AND id_tipodocu=dbo.ST_FnGetIdList('VENTAS')));
		 END
		 ELSE IF (@opcion = 'P')
		 BEGIN
			 IF(@op='PR')
			 BEGIN
				 SET @id_articuloT = @id_prod;
				 SET @count = (SELECT SUM(existencia) FROM Existencia WHERE id_articulo = @id_articuloT AND id_bodega = @id_bodega);

				 SELECT A.Id id, nombre, lote, codigobarra, serie, inventario, impuesto, A.id_iva, A.id_inc, A.inventario,Isnull(E.costo,0) costo ,precio,  
				 porcendescto pordcto, ISNULL(@count, 0) existencia
				 FROM DBo.VW_Productos A left JOIN DBO.Existencia E ON A.id=E.id_articulo AND E.id_bodega=@id_bodega  left join
					  CNTCategoriaFiscalServicios C ON C.id_servicio=A.id
				 WHERE A.id = @id_articuloT;

				 IF EXISTS( SELECT 1 FROM VW_Productos WHERE id = @id_articuloT AND serie != 0)
				 BEGIN
					 EXECUTE [dbo].[ST_MOVFacturaBuscadorLoteSerie]
					 @id_articulo = @id_articuloT,
					 @id_bodega     = @id_bodega,
					 @opcion         = 'SF',
					 @op             = 'T',
					 @id_factura  = @id_factura
				 END
			 END

		 END
		 ELSE IF (@opcion = 'D') -- Opcion para la busqueda en operaciones como Ajuste de inventario y Traslado entre bodegas
		 BEGIN
			 SELECT DISTINCT TOP 15  (A.id) id,
			 CASE WHEN A.codigobarra Like '%'+@filtro+'%' THEN A.codigobarra
				  WHEN A.codigo Like '%'+@filtro+'%' THEN A.codigo + ' - ' +A.presentacion
				  ELSE A.Nombre + ' ('+codigo+')' + ' - ' + A.presentacion End  name,
			 inventario inventarial
			 FROM Dbo.VW_Productos A
			 WHERE A.estado = 1 AND A.inventario = 1 AND (A.Codigo like '%'+@filtro+'%' OR A.Nombre like '%'+@filtro+'%');
		 END
		 ELSE IF (@opcion = 'J')
		 BEGIN
			 SELECT A.id, A.codigo +' - '+A.nombre as name
			 FROM dbo.VW_CNTCuentas A WHERE tipo != 0 AND estado != 0 AND (Isnull(@tipo,'') = '' OR id_tipocta = DBO.ST_FnGetIdList(@tipo)) 
			 AND (A.codigo like '%'+@filtro+'%' OR A.nombre like'%'+@filtro+'%')
			 ORDER BY id ASC;
		 END
		 ELSE IF (@opcion = 'I')
		 BEGIN
			 IF(@op='CL')
			 BEGIN
				 SELECT
					 S.id,  S.nrofactura  name
				 FROM CNT.SaldoCliente S
				 LEFT JOIN Dbo.MOVFactura C ON S.id_documento = C.id
				 WHERE  ((isnull(@filtro,'')='' or CAST(S.id AS Varchar) like '%' + @filtro + '%')    OR (isnull(@filtro,'')='' or S.nrofactura like '%' + @filtro + '%')) AND 
				 S.id_cliente = @id_bodega and S.anomes = CAST(@tipo AS VARCHAR(6)) AND S.saldoactual != 0

			 END
			 ELSE IF(@op='SE')
			 BEGIN
				 SELECT S.serie FROM ExistenciaLoteSerie S
				 INNER JOIN Existencia E ON E.id = S.id_existencia
				 LEFT JOIN MovFacturaSeriesTemp F ON S.serie = F.serie AND F.id_facturatemp = @id_factura
				 WHERE E.id_articulo = @id_articulo AND E.id_bodega = @id_bodega AND S.existencia > 0 AND F.serie IS NULL;
			 END
		 END
		 ELSE IF(@opcion='U')
         BEGIN 
			SET @porcentaje = (SELECT TOP 1 valor FROM [dbo].[Parametros] WHERE codigo = 'PORCEINTERESMORA');

            SELECT C.nrofactura id, 
					CASE WHEN C.nrofactura like '%' + @filtro+ '%' THEN concat(C.nrofactura, '-', T.razonsocial)
						 WHEN T.razonsocial like '%'+ @filtro + '%' THEN C.nrofactura +'  - '+T.razonsocial END name,
					SUM(C.saldoActual) saldoActual,
					COUNT(1) cuotas,
					SUM(CASE WHEN DATEDIFF(DD,C.vencimiento_cuota,getdate()) - diasmora < 0 OR C.cancelada != 0
						THEN 0 
						ELSE case when ((((SC.CuotaFianza - (SC.abono + SC.AbonoFianza))* (@porcentaje/100))/30)* (DATEDIFF(DD,SC.vencimiento_cuota,getdate()) - SC.diasmora)) < 0 then 0
						else ((((SC.CuotaFianza - (SC.abono + SC.AbonoFianza))* (@porcentaje/100))/30)* (DATEDIFF(DD,SC.vencimiento_cuota,getdate()) - SC.diasmora))  end 
						END) interesmora
			FROM  CNT.VW_Terceros T
			INNER JOIN CNT.SaldoCliente_Cuotas C ON  T.id = C.id_cliente
			INNER JOIN FIN.SaldoCliente_Cuotas SC ON  SC.id_tercero = C.id_cliente AND SC.cuota = C.cuota AND SC.anomes = C.anomes AND SC.numfactura = C.nrofactura AND SC.estado != 0
			WHERE T.id = @id_prod AND C.saldoActual != 0 AND C.anomes = @anomes AND  (C.nrofactura like '%'+@filtro+'%' OR T.razonsocial like'%'+@filtro+'%') 
			GROUP BY C.nrofactura, T.razonsocial

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
