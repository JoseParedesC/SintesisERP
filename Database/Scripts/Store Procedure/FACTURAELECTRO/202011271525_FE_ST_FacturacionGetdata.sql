--liquibase formatted sql
--changeset ,JTOUS:3 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[FE].[ST_FacturacionGetdata]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	DROP PROCEDURE [FE].[ST_FacturacionGetdata]
GO
CREATE PROCEDURE [FE].[ST_FacturacionGetdata]	
	@nit VARCHAR(50),
	@id_empresa INT = 0,
	@origen VARCHAR(20),
	@key VARCHAR(250) 
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[FE].[ST_FacturacionGetdata]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		28/11/20
*Desarrollador: (JTOUS)
*Procedimiento de facturación electronica que devuelve el xml de
***************************************/

DECLARE @error VARCHAR(MAX), @xmlresolucion VARCHAR(max) = '', @xmlcliente VARCHAR(max) = '', @xmlfactura VARCHAR(max) = '', 
@xmlitems VARCHAR(max) = '', @cufe VARCHAR(MAX), @correo VARCHAR(250) = '', @xmlreten VARCHAR(max) = '';
DECLARE @cufeimp	VARCHAR (1000)
DECLARE @cufenota VARCHAR(MAX) = ''
DECLARE @tipodoc INT, @iddocfac BIGINT;
BEGIN TRY
	
	SELECT @tipodoc = CASE WHEN @origen = 'FACTURA' THEN 1 ELSE 3 END

	SET @correo = (SELECT top 1 email FROM  [FE].[VW_FacturaFE] AS resolucion WHERE keyid = @key and TipoDocumento = @tipodoc);
		
	SET @xmlresolucion = (
	SELECT TOP 1 Resolucion codigo, CONVERT(VARCHAR(10), FechaInicioR, 120) fechaini, CONVERT(VARCHAR(10), FechaFinalR, 120) fechafin, prefijo, 
				RangoInicial conini, RangoFinal confin, ConsecutivoFacturacion consecutivo,  prefijo + CAST(ConsecutivoFacturacion AS VARCHAR(20)) precon
	FROM [FE].[VW_FacturaFE] AS resolucion WHERE keyid = @key and TipoDocumento = @tipodoc
	FOR XML AUTO, ELEMENTS)
	
	SET @xmlcliente = (
	SELECT TOP 1 
	TipoIdentificacionT tipoid, 
	identficacionC iden, 
	digic,
	REPLACE(NombreDepartamentoC, ' ','') departamento, 
	REPLACE(NombreCiudadC, ' ','') ciudad, 
	REPLACE(CodigoCiudadC, ' ','') codciudad,
	REPLACE(CodigoDepartamentoC, ' ','') coddepartamento,
	DireccionC [direccion], Razoncial_NombresC firstname, ApellidosC lastname,
	email,
	telefono,
	TipoTerceroC
	FROM [FE].[VW_FacturaFE] AS cliente WHERE keyid = @key and TipoDocumento = @tipodoc
	FOR XML AUTO, ELEMENTS)
	
	SET @xmlfactura = (
	SELECT TOP 1 
			'Consecutivo:' +'-'+ CAST(consecutivo AS VARCHAR)		numdocumento, 
			CAST(SUM(TotalA * cantidadA) AS DECIMAL(18,2))			total, 
			CAST(SUM(valorunitario * cantidada) AS DECIMAL(18,2))	subtotal, 
			CAST(SUM((valorunitario - ValordesctoA) * cantidada) AS DECIMAL(18,2)) subtotaldcto, 
			CAST(SUM(IVAA * CantidadA) AS DECIMAL(18,2))			iva, 
			CAST(SUM(ValordesctoA * CantidadA) AS DECIMAL(18,2))  descuento, 
			0														ica, 
			0														ipc, 
			CAST(SUM(INCA * CantidadA) AS DECIMAL(18,2))			inc, 
			CONVERT(VARCHAR(10), FechaFacturacion, 120)				fecha,
			CAST(SUM(IVAA * CantidadA) AS DECIMAL(18,2)) + CAST(SUM(INCA * CantidadA) AS DECIMAL(18,2)) timpuestos, 
			HoraFactura hora,
			anticipo,
			descuentogen,
			CAST((SUM(TotalA * cantidadA) - anticipo - descuentogen) AS DECIMAL(18,2))	retotal,
			fechavence
	FROM [FE].[VW_FacturaFE] AS factura 
	WHERE keyid = @key and TipoDocumento = @tipodoc
	GROUP BY consecutivo, FechaFacturacion, HoraFactura, anticipo, descuentogen, fechavence
	FOR XML AUTO, ELEMENTS)
 
	SET @xmlitems = (
	SELECT ROW_NUMBER() OVER(PARTITION BY consecutivo, prefijo ORDER BY FechaFacturacion, HoraFactura ASC ) AS id,  
		 CAST(CantidadA AS DECIMAL(18,2)) cant,
		 CAST(ValorUnitario AS DECIMAL(18,2)) valorUND,
		 CAST(ValorUnitarioADscto AS DECIMAL(18,2)) valorUDcto,
		 CAST((ValordesctoA * cantidada) AS DECIMAL(18,2)) totaldcto,
		 CAST(ValordesctoA AS DECIMAL(18,2)) dctoA,
		 CAST((ValorUnitario) * cantidada AS DECIMAL(18,2)) valor,
		 CAST((ValorUnitarioADscto) * cantidada AS DECIMAL(18,2)) valorDcto,
		 CAST((TotalA) * cantidada AS DECIMAL(18,2)) total, 
		 CAST(IVAA AS DECIMAL(18,2)) ivaUND,
		 CAST(IVAA * cantidada AS DECIMAL(18,2))  iva,
		 CAST(IVAPOR AS DECIMAL(18,2)) poriva, 
		 0.00 ipc, 
		 0.00 poripc, 
		 0.00 ica, 
		 0.00 porica, 			 
		 CAST(DSCTPOR AS DECIMAL(18,2)) pordcto,		 
		 inca inc,
		 incpor porinc, 
		 DescripcionA descrip
	FROM [FE].[VW_FacturaFE] AS item WHERE keyid = @key and TipoDocumento = @tipodoc
	FOR XML AUTO, ELEMENTS)
	
	SET @cufe = (
		SELECT  prefijo
				+ CAST(ConsecutivoFacturacion AS VARCHAR)
				+ CONVERT(VARCHAR(10), FechaFacturacion, 120)
				+ HoraFactura + '-05:00'
				+ CAST (CAST(SUM(ValorUnitarioADscto * cantidada) AS DECIMAL(18,2)) AS VARCHAR)
				+ '01'
				+ CAST(CAST(SUM(IVAA * CantidadA) AS DECIMAL(18,2)) AS VARCHAR)
				+ '04'
				+ CAST(CAST(SUM(INCA * CantidadA) AS DECIMAL(18,2)) AS VARCHAR)
				+ '03'
				+ '0.00'
				+ CAST(CAST(SUM(TotalA * CantidadA) - anticipo - descuentogen AS DECIMAL(18,2)) AS VARCHAR)
				+ @nit
				+ identficacionC
		FROM [FE].[VW_FacturaFE] AS factura 
		WHERE keyid = @key and TipoDocumento = @tipodoc
		GROUP BY prefijo, ConsecutivoFacturacion, FechaFacturacion, HoraFactura, identficacionC, anticipo, descuentogen	
	);
		
	SET @cufeimp = (
			SELECT  'NumeFac: '+prefijo+ CAST(ConsecutivoFacturacion AS VARCHAR)	+ CHAR(13) + CHAR(10)
					+'Fecfac: '+ CONVERT(VARCHAR(10), FechaFacturacion, 120)		+ CHAR(13) + CHAR(10)
					+'HorFac: '+ HoraFactura + '-05:00'								+ CHAR(13) + CHAR(10)
					+'NicFac: '+ @nit												+ CHAR(13) + CHAR(10)
					+'DocAdq: ' +identficacionc										+ CHAR(13) + CHAR(10)
					+'ValFac: ' + CAST (CAST(SUM(ValorUnitarioADscto * cantidada) AS DECIMAL(18,2)) AS VARCHAR)	+ CHAR(13) + CHAR(10)
					+'ValIva: ' + CAST(CAST(SUM(IVAA * CantidadA) AS DECIMAL(18,2)) AS VARCHAR)				+ CHAR(13) + CHAR(10)
					+'ValOtroIm: '+CAST(CAST(SUM(INCA * CantidadA) AS DECIMAL(18,2)) AS VARCHAR)			+ CHAR(13) + CHAR(10)
					+'ValTolFac: ' + CAST(CAST((SUM(TotalA * CantidadA) - anticipo - descuentogen) AS DECIMAL(18,2)) AS VARCHAR)		+ CHAR(13) + CHAR(10)
					+'CUFE: '
			FROM [FE].[VW_FacturaFE] AS factura 
			WHERE keyid = @key and TipoDocumento = @tipodoc
			GROUP BY prefijo, ConsecutivoFacturacion, FechaFacturacion, HoraFactura, identficacionc, anticipo, descuentogen
			)	
	IF (@tipodoc IN (3))
	BEGIN
	
		SET @cufenota = (SELECT TOP 1 '<cufedoc>'+cufefac+'</cufedoc><consefacnot>'+ preconfac+'</consefacnot><fechafacnot>'+fechafac+'</fechafacnot>' 
		FROM [FE].[VW_FacturaFE] WHERE keyid = @key and TipoDocumento = @tipodoc );
	END
	
	SELECT @xmlresolucion + @xmlcliente + @xmlfactura + @cufenota + @xmlreten + '<items>'+@xmlitems+'</items>' [xml], @cufe cufe, @correo correo, @cufeimp cufeimp, @xmlcliente + @xmlresolucion xmlcliente;
	
END TRY
BEGIN CATCH

	    --Getting the error description
	    Select @error   =  ERROR_PROCEDURE() + 
					';  ' + convert(varchar,ERROR_LINE()) + 
					'; ' + ERROR_MESSAGE()
	    -- save the error in a Log file
	    RaisError(@error,16,1)
	    Return  
End Catch
