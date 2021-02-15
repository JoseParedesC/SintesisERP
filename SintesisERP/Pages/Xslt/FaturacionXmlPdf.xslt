<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.5" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output method="xml" omit-xml-declaration="yes" indent="yes"/>
  <xsl:template match="/">
    <NWindDataSet>
      <xsl:for-each select="/NWindDataSet/CabeceraCompany">
        <CabeceraCompany Nombre="{@Nombre}" Nit="{@Nit}" Ciudad="{@Ciudad}" Telefono="{@Telefono}" Direccion="{@Direccion}" cufeimp="{@cufeimp}" email="{@email}" fechares="{@fechares}" horares="{@horares}"/>
      </xsl:for-each>
      <xsl:for-each select="/NWindDataSet/DataInfo">
        <DataInfo id="{@id}" estado="{@estado}" prefijo="{@prefijo}" consecutivo="{@consecutivo}" resolucion="{@resolucion}" cufe="{@cufe}" leyenda="{@leyenda}" fechadoc="{@fechadoc}" fechavence="{@fechavence}" cnombre="{@cnombre}" cliente="{@cliente}" direccion="{@direccion}" telefono="{@telefono}" ciudad="{@ciudad}" ssubtotal="{@ssubtotal}" subtotal="{@subtotal}" descuento="{@descuento}" iva="{@iva}" inc="{@inc}" total="{@total}" moneda="{@moneda}" relacionado="{@relacionado}" modalidad="{@modalidad}" usuario="{@usuario}" detalle="{@detalle}" totalletra="{@totalletra}" cufefac="{@cufefac}" correo="{@correo}" anticipo="{@anticipo}" descuentogen="{@descuentogen}" vendedor="{@vendedor}" subtotalfac="{@subtotalfac}"/>
      </xsl:for-each>
      <xsl:for-each select="/NWindDataSet/DataItems">
        <DataItems codigo="{@codigo}" detalleconcepto="{@detalleconcepto}" cantidad="{@cantidad}" valor="{@valor}" porinc="{@porinc}" poriva="{@poriva}" descuento="{@descuento}" total="{@total}" />
      </xsl:for-each>
    </NWindDataSet>
  </xsl:template>
</xsl:stylesheet>
