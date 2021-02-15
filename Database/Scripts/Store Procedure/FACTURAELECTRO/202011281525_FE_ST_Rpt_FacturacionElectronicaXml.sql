--liquibase formatted sql
--changeset ,jtous:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[FE].[ST_Rpt_FacturacionElectronicaXml]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	DROP PROCEDURE [FE].ST_Rpt_FacturacionElectronicaXml
GO
CREATE PROCEDURE [FE].ST_Rpt_FacturacionElectronicaXml 
@key VARCHAR(255),
@tipodocumento INT
WITH ENCRYPTION
AS
/***************************************
*Nombre:		[FE].[ST_Rpt_FacturacionElectronicaXml]
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		29/11/2020
*Desarrollador:  Jose Luis Tous Pérez (jtous)
*Descripcion:	Se realizan la consulta de la informacion del reporte de factura de pago caja tirilla
***************************************/
BEGIN
Declare @error varchar(max), @id INT, @prefijo  varchar(50), @consecutivo int, @id_empresa int, @cabecera VARCHAR(MAX), @items VARCHAR(MAX), 
@empresa VARCHAR(MAX), @fechaautorizacion smalldatetime, @cufeimp VARCHAR(MAX) = '';
DECLARE @table TABLE (usuario VARCHAR(200), Nombre varchar(100), Nit Varchar(50), Ciudad varchar(50), 
Telefono varchar(50), Direccion varchar(200), urlimgrpt  varchar(500), cufeimp varchar(1000), email varchar(200), urlfirma varchar(500), nitemp VARCHAR(20));
DECLARE @nit VARCHAR(20) = ''
BEGIN TRY		
SET LANGUAGE Spanish				

		IF @tipodocumento = 1
		BEGIN
			SELECT TOP 1 @id = id, @fechaautorizacion = fechaautorizacion FROM VW_MOVFacturas WHERE [keyid] = @key;
		
			SET @cabecera = (
				SELECT 
					id
					,estado	
					,prefijo	
					,CAST (consecutivo	 AS VARCHAR) consecutivo	
					,resolucion	
					,leyenda	
					,fechadoc
					,fechavence
					,(iden +' ' + cliente)cliente
					,direccion	
					,telefono	
					,ciudad	
					,ssubtotal	
					,subtotal	
					,descuento
					,iva	
					,inc	
					,(total - valoranticipo)	 total
					,moneda	
					,relacionado
					,vendedor usuario
					,ISNULL(observaciones,'') detalle				
					,[dbo].ST_FNCantidadConLetra(total) totalletra
					,(subtotal + iva + inc -descuento) subtotalfac
					,correo
					,ISNULL(cufe, '') cufe
					,vendedor
					,valoranticipo anticipo
					,dsctoFinanciero descuentogen
					,keyid
			FROM VW_MOVFacturas  DataInfo
			WHERE keyid = @key
			FOR XML AUTO);
			
			SET @items = (SELECT codigo, detalleconcepto, cantidad, valor, porinc, poriva, descuento, total FROM (
					SELECT 
						 I.codigo
						,I.nombre detalleconcepto
						,I.cantidad
						,I.preciodesc valor
						,I.descuento
						,I.porinc
						,I.poriva
						,I.total
					FROM [dbo].VW_MOVFacturaItems I
					WHERE id_factura = @id			
				) AS DataItems 
			FOR XML AUTO);

			SET @cufeimp = (
			SELECT  'NumeFac: '+prefijo+ CAST(ConsecutivoFacturacion AS VARCHAR)	+ CHAR(13) + CHAR(10)
					+'Fecfac: '+ CONVERT(VARCHAR(10), FechaFacturacion, 120)		+ CHAR(13) + CHAR(10)
					+'HorFac: '+ HoraFactura + '-05:00'								+ CHAR(13) + CHAR(10)
					+'NicFac: '+ @Nit												+ CHAR(13) + CHAR(10)
					+'DocAdq: ' +IdentficacionC									+ CHAR(13) + CHAR(10)
					+'ValFac: ' + CAST (CAST(SUM(valorunitario * cantidada) AS DECIMAL(18,2)) AS VARCHAR)	+ CHAR(13) + CHAR(10)
					+'ValIva: ' + CAST(CAST(SUM(IVAA * CantidadA) AS DECIMAL(18,2)) AS VARCHAR)				+ CHAR(13) + CHAR(10)
					+'ValOtroIm: '+CAST(CAST(SUM(INCA * CantidadA) AS DECIMAL(18,2)) AS VARCHAR)			+ CHAR(13) + CHAR(10)
					+'ValTolFac: ' + CAST(CAST(SUM(TotalA * CantidadA)  - anticipo - descuentogen AS DECIMAL(18,2)) AS VARCHAR)		+ CHAR(13) + CHAR(10)
					+'CUFE: '+ cufe
			FROM [FE].[VW_FacturaFE] AS factura 
			WHERE [keyid] = @key AND tipodocumento = @tipodocumento
			GROUP BY prefijo, ConsecutivoFacturacion, FechaFacturacion, HoraFactura, IdentficacionC, cufe, anticipo, descuentogen)
		END		
		ELSE IF @tipodocumento = 3
		BEGIN
			SELECT TOP 1 @id = id FROM VW_MOVDevFacturas WHERE [keyid] = @key;
			SET @cabecera = (
				SELECT 
					 id
					,estado	
					,'DV' prefijo	
					,preconfac consecutivo
					,fechafac fechadoc	
					,cliente	
					,direccion	
					,telefono	
					,ciudad	
					,ssubtotal	
					,subtotal	
					,descuento
					,iva	
					,inc	
					,total	
					,moneda	
					,modalidad	
					,username usuario
					,vendedor
					,'' detalle				
					,[dbo].ST_FNCantidadConLetra(total) totalletra
					,cufefac
					,cufe
					,preconfac +'('+ CAST(id_factura AS VARCHAR) +')' relacionado
					,correo
					,descuentogen
					,valoranticipo anticipo
				FROM VW_MOVDevFacturas AS DataInfo			
				WHERE keyid = @key
				FOR XML AUTO);
		
			SET @items = (
				SELECT codigo, detalleconcepto, cantidad, valor, porinc, poriva, descuento, total FROM (
					SELECT 
						 I.codigo
						,I.nombre detalleconcepto
						,I.cantidad
						,I.precio valor
						,I.porinc
						,I.poriva
						,I.pordsto descuento
						,I.total
					FROM [dbo].VW_MOVDevFacturaItems I
					WHERE id_devolucion = @id
				) AS DataItems
			FOR XML AUTO);
		END		

		INSERT INTO @table (Usuario, Nombre, Nit, Ciudad, Telefono, Direccion, urlimgrpt, email, urlfirma, nitemp)
		EXECUTE [dbo].[ST_Rpt_CabeceraCompania] 

		SET @Nit = (SELECT TOP 1 Nit FROM @table);

		SET @empresa = (SELECT TOP 1 Nombre, Nit, Ciudad, Telefono, Direccion, email,
		CONVERT(VARCHAR(10), @fechaautorizacion, 120) fechares, CONVERT(VARCHAR(8), @fechaautorizacion, 108) horares, ISNULL(@cufeimp, '') cufeimp 
		FROM @table AS CabeceraCompany FOR XML AUTO);
		
		SELECT  @empresa +@cabecera + @items [xml]

END TRY
BEGIN Catch
	    --Getting the error description
	    Select @error   =  ERROR_PROCEDURE() + 
					';  ' + convert(varchar,ERROR_LINE()) + 
					'; ' + ERROR_MESSAGE()
	    -- save the error in a Log file
	    RaisError(@error,16,1)
	    Return  
	End Catch
END
GO
