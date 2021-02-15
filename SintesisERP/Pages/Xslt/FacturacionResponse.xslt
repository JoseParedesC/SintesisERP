<?xml version="1.0" encoding="utf-8" standalone="no"?>
<xsl:stylesheet version="1.5" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output method="xml" omit-xml-declaration="yes" indent="yes" />
  <xsl:template match="/">
    <AttachedDocument xmlns="urn:oasis:names:specification:ubl:schema:xsd:AttachedDocument-2" xmlns:ds="http://www.w3.org/2000/09/xmldsig#" xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2" xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2" xmlns:ccts="urn:un:unece:uncefact:data:specification:CoreComponentTypeSchemaModule:2" xmlns:ext="urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2" xmlns:xades="http://uri.etsi.org/01903/v1.3.2#" xmlns:xades141="http://uri.etsi.org/01903/v1.4.1#">
      <cbc:UBLVersionID>UBL 2.1</cbc:UBLVersionID>
      <cbc:CustomizationID>Documentos adjuntos</cbc:CustomizationID>
      <cbc:ProfileID>DIAN 2.1</cbc:ProfileID>
      <cbc:ProfileExecutionID>1</cbc:ProfileExecutionID>
      <cbc:ID><xsl:value-of select="/send/resolucion/precon"/></cbc:ID>
      <cbc:IssueDate><xsl:value-of select="/send/response/fechares"/></cbc:IssueDate>
      <cbc:IssueTime><xsl:value-of select="/send/response/horares"/>-05:00</cbc:IssueTime>
      <cbc:DocumentType>Contenedor de Factura Electrónica</cbc:DocumentType>
      <cbc:ParentDocumentID><xsl:value-of select="/send/resolucion/precon"/></cbc:ParentDocumentID>
      <cac:SenderParty>
        <cac:PartyTaxScheme>
          <cbc:RegistrationName><xsl:value-of select="/send/Empresa/razon"/></cbc:RegistrationName>
          <cbc:CompanyID schemeAgencyID="195" schemeID="{/send/Empresa/digveri}" schemeName="{/send/Empresa/tipoid}"><xsl:value-of select="/send/Empresa/nit"/></cbc:CompanyID>
          <cbc:TaxLevelCode listName="05">O-99</cbc:TaxLevelCode>
          <cac:TaxScheme>
            <cbc:ID>01</cbc:ID>
            <cbc:Name>IVA</cbc:Name>
          </cac:TaxScheme>
        </cac:PartyTaxScheme>
      </cac:SenderParty>
      <cac:ReceiverParty>
        <cac:PartyTaxScheme>
          <cbc:RegistrationName><xsl:value-of select="/send/cliente/firstname"/> &#160; <xsl:value-of select="/send/cliente/lastname"/></cbc:RegistrationName>
          <cbc:CompanyID schemeAgencyID="195" schemeName="{/send/cliente/tipoid}" schemeID="{/send/cliente/digic}"><xsl:value-of select="/send/cliente/iden"/></cbc:CompanyID>
          <cbc:TaxLevelCode listName="05">O-99</cbc:TaxLevelCode>
          <cac:TaxScheme>
            <cbc:ID>01</cbc:ID>
            <cbc:Name>IVA</cbc:Name>
          </cac:TaxScheme>
        </cac:PartyTaxScheme>
      </cac:ReceiverParty>
      <cac:Attachment>
        <cac:ExternalReference>
          <cbc:MimeCode>text/xml</cbc:MimeCode>
          <cbc:EncodingCode>UTF-8</cbc:EncodingCode>
          <cbc:Description><xsl:text disable-output-escaping="yes">&lt;![CDATA[</xsl:text><xsl:value-of select="/send/invoice" disable-output-escaping="yes"/><xsl:text disable-output-escaping="yes">]]&gt;</xsl:text></cbc:Description>
        </cac:ExternalReference>
      </cac:Attachment>
      <cac:ParentDocumentLineReference>
        <cbc:LineID>1</cbc:LineID>
        <cac:DocumentReference>
          <cbc:ID><xsl:value-of select="/send/resolucion/precon"/></cbc:ID>
          <cbc:UUID schemeName="CUFE-SHA384"><xsl:value-of select="/send/cufe"/></cbc:UUID>
          <cbc:IssueDate><xsl:value-of select="/send/response/fechares"/></cbc:IssueDate>
          <cbc:DocumentType>ApplicationResponse</cbc:DocumentType>
          <cac:Attachment>
            <cac:ExternalReference>
              <cbc:MimeCode>text/xml</cbc:MimeCode>
              <cbc:EncodingCode>UTF-8</cbc:EncodingCode>
              <cbc:Description><xsl:text disable-output-escaping="yes">&lt;![CDATA[</xsl:text><xsl:value-of select="/send/reply" disable-output-escaping="yes"/><xsl:text disable-output-escaping="yes">]]&gt;</xsl:text></cbc:Description>
        </cac:ExternalReference>
      </cac:Attachment>
      <cac:ResultOfVerification>
        <cbc:ValidatorID>Unidad Especial Dirección de Impuestos y Aduanas Nacionales</cbc:ValidatorID>
        <cbc:ValidationResultCode>02</cbc:ValidationResultCode>
        <cbc:ValidationDate><xsl:value-of select="/send/response/fechares"/></cbc:ValidationDate>
        <cbc:ValidationTime><xsl:value-of select="/send/response/horares"/>-05:00</cbc:ValidationTime>
      </cac:ResultOfVerification>
    </cac:DocumentReference>
  </cac:ParentDocumentLineReference>
</AttachedDocument>
  </xsl:template>
</xsl:stylesheet>
