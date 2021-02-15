----liquibase formatted sql
----changeset ,JTOUS:3 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[DBo].[VW_FacturaFE]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
	Drop View DBO.[VW_FacturaFE]
END
GO

If exists (select 1 from dbo.sysobjects where id = object_id(N'[FE].[VW_FacturaFE]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
	Drop View FE.[VW_FacturaFE]
END
GO

CREATE VIEW [FE].[VW_FacturaFE]
AS

	SELECT 
			F.id consecutivo
		,F.keyid
		,F.resolucion
		,R.fechainicio								FechaInicioR
		,R.fechafin									FechaFinalR
		,F.prefijo									Prefijo
		,CAST(R.rangoini AS VARCHAR)				RangoInicial
		,CAST(R.rangofin AS VARCHAR)				RangoFinal
		,CAST(F.consecutivo AS VARCHAR)				consecutivofacturacion
		,CONVERT(Varchar(10), F.fechafac, 120)		FechaFacturacion
		,CONVERT(Varchar(8), F.created, 108)		HoraFactura

		,C.codiden									TipoIdentificacionT
		,C.tipopersoneria							TipoTerceroC
		,C.iden										IdentficacionC
		,C.digitoverificacion						DigiC
		,CASE WHEN C.codiden = '31' THEN C.razonsocial ELSE C.nombres END	Razoncial_NombresC
		,C.apellidos								ApellidosC
		,C.direccion								DireccionC
		,C.email									Email
		,C.telefono									telefono

		,C.codigociudad								CodigoCiudadC
		,C.ciudad									NombreCiudadC
		,C.codigodepartamento						CodigoDepartamentoC
		,C.nombredepartamento						NombreDepartamentoC
		
		,(I.preciodesc + I.iva + I.inc)				TotalA
		,(I.preciodesc + I.descuentound)			ValorUnitario
		,I.descuentound								ValordesctoA
		,I.preciodesc								ValorUnitarioADscto
		,I.pordescuento								DSCTPOR
		,I.iva										IVAA
		,I.poriva									IVAPOR
		,I.inc										INCA
		,I.porinc									INCPOR
		,I.cantidad									CantidadA
		,I.codigo									CodigoA
		,I.Nombre									DescripcionA
		,1											TipoDocumento
		,'EFE'										Moneda
		,'EFECTIVO'									DescripcionMoneda
		,'Articulos'								DetModulo
		,0											idnotacre
		,''											documentoNota
		,''											fechacodumentoNotaa
		,F.cufe										cufe										
		,''											cufefac
		,''											fechafac
		,''											preconfac
		,F.valoranticipo							anticipo
		,0											descuentogen
		,CONVERT(Varchar(10), F.fechavence, 120)	fechavence
	FROM MovFactura F
	INNER JOIN [VW_MOVFacturaItems] I ON I.id_factura = F.id
	INNER JOIN [dbo].[VW_Resoluciones] R ON R.id = F.id_resolucion
	INNER JOIN CNT.VW_Terceros C ON C.id = F.id_tercero
	WHERE F.estado = Dbo.ST_FnGetIdList('PROCE') AND F.isFe != 0
 
	UNION ALL

 /*DEVOLUCIONES*/
	
	SELECT 
		F.id consecutivo
		,F.keyid
		,''											resolucion
		,''											FechaInicioR
		,''											FechaFinalR
		,'DV'										Prefijo
		,''											RangoInicial
		,''											RangoFinal
		,F.preconfac								consecutivofacturacion
		,CONVERT(Varchar(10), F.fecha, 120)			FechaFacturacion
		,CONVERT(Varchar(8), F.created, 108)		HoraFactura

		,C.codiden									TipoIdentificacionT
		,C.tipopersoneria							TipoTerceroC
		,C.iden										IdentficacionC
		,C.digitoverificacion						DigiC
		,C.nombres									Razoncial_NombresC
		,C.apellidos								ApellidosC
		,C.direccion								DireccionC
		,C.email									Email
		,C.telefono									telefono

		,C.codigociudad								CodigoCiudadC
		,C.ciudad									NombreCiudadC
		,C.codigodepartamento						CodigoDepartamentoC
		,C.nombredepartamento						NombreDepartamentoC
		,(I.preciodesc + I.iva + I.inc)				TotalA
		,(I.preciodesc + I.descuento)				ValorUnitario
		,I.descuento								ValordesctoA
		,I.preciodesc								ValorUnitarioADscto
		,I.pordsto									DSCTPOR
		,I.iva										IVAA
		,I.poriva									IVAPOR
		,I.inc										INCA
		,I.porinc									INCPOR
		,I.cantidad									CantidadA
		,I.codigo									CodigoA
		,I.nombre									DescripcionA
		,3											TipoDocumento
		,'EFE'										Moneda
		,'EFECTIVO'									DescripcionMoneda
		,'Articulos'								DetModulo
		,0											idnotacre
		,''											documentoNota
		,''											fechacodumentoNotaa
		,F.cufe
		,F.cufefac
		,F.fechafac
		,F.preconfac
		,F.valoranticipo							anticipo
		,0											descuentogen
		,CONVERT(VARCHAR(10), DATEADD(month, 1, REPLACE(F.fecha,'-','')), 120) fechavence
	FROM   
	dbo.VW_MOVDevFacturas	F 
	INNER JOIN [dbo].VW_MOVDevFacturaItems I ON I.id_devolucion = F.id
	INNER JOIN CNT.VW_terceros C ON C.id = F.id_cliente
	WHERE F.id_estado = Dbo.ST_FnGetIdList('PROCE') AND F.isfe != 0

GO


