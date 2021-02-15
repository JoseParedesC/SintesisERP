<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.5" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output method="xml" omit-xml-declaration="yes" indent="yes"/>
  <xsl:template match="/">
    <CreditNote xmlns:ds="http://www.w3.org/2000/09/xmldsig#" xmlns:xades="http://uri.etsi.org/01903/v1.3.2#" xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2" xmlns:ext="urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2" xmlns:xades141="http://uri.etsi.org/01903/v1.4.1#" xmlns:sts="dian:gov:co:facturaelectronica:Structures-2-1" xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="urn:oasis:names:specification:ubl:schema:xsd:Invoice-2     http://docs.oasis-open.org/ubl/os-UBL-2.1/xsd/maindoc/UBL-Invoice-2.1.xsd" xmlns="urn:oasis:names:specification:ubl:schema:xsd:Invoice-2">      
      <ext:UBLExtensions>
        <ext:UBLExtension>
          <ext:ExtensionContent>
            <sts:DianExtensions>              
              <sts:InvoiceSource>
                <cbc:IdentificationCode listAgencyID="6" listAgencyName="United Nations Economic Commission for Europe" listSchemeURI="urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode-2.1">CO</cbc:IdentificationCode>
              </sts:InvoiceSource>
              <sts:SoftwareProvider>
                <sts:ProviderID schemeAgencyID="195" schemeAgencyName="CO, DIAN (Dirección de Impuestos y Aduanas Nacionales)" schemeID="{/top/Empresa/digveri}" schemeName="{/top/Empresa/tipoid}" >
                  <xsl:value-of select="/top/Empresa/nit"/>
                </sts:ProviderID>
                <sts:SoftwareID schemeAgencyID="195" schemeAgencyName="CO, DIAN (Dirección de Impuestos y Aduanas Nacionales)">
                  <xsl:value-of select="/top/Empresa/softid"/>
                </sts:SoftwareID>
              </sts:SoftwareProvider>
              <sts:SoftwareSecurityCode schemeAgencyID="195" schemeAgencyName="CO, DIAN (Dirección de Impuestos y Aduanas Nacionales)">
                <xsl:value-of select="/top/codesecurity"/>
              </sts:SoftwareSecurityCode>
              <sts:AuthorizationProvider>
                <sts:AuthorizationProviderID schemeID="4" schemeName="31" schemeAgencyID="195" schemeAgencyName="CO, DIAN (Dirección de Impuestos y Aduanas Nacionales)">800197268</sts:AuthorizationProviderID>
              </sts:AuthorizationProvider>
              <sts:QRCode>https://muisca.dian.gov.co/WebFacturaelectronica/paginas/VerificarFacturaElectronicaExterno.faces</sts:QRCode>
            </sts:DianExtensions>
          </ext:ExtensionContent>
        </ext:UBLExtension>
        <ext:UBLExtension><ext:ExtensionContent/></ext:UBLExtension>
      </ext:UBLExtensions>
      <cbc:UBLVersionID>UBL 2.1</cbc:UBLVersionID>
      <cbc:CustomizationID>10</cbc:CustomizationID>
      <cbc:ProfileID>DIAN 2.1</cbc:ProfileID>
      <cbc:ProfileExecutionID><xsl:value-of select="/top/Empresa/tipoamb"/></cbc:ProfileExecutionID>
      <cbc:ID><xsl:value-of select="/top/resolucion/precon"/></cbc:ID>
      <cbc:UUID schemeID="{/top/Empresa/tipoamb}" schemeName="CUDE-SHA384"><xsl:value-of select="/top/cufe"/></cbc:UUID>
      <cbc:IssueDate><xsl:value-of select="/top/factura/fecha"/></cbc:IssueDate>
      <cbc:IssueTime><xsl:value-of select="/top/factura/hora"/>-05:00</cbc:IssueTime>
      <cbc:CreditNoteTypeCode>91</cbc:CreditNoteTypeCode>
      <cbc:Note>Nota Credito relacionada con: &#160;<xsl:value-of select="/top/consefacnot"/></cbc:Note>
      <cbc:DocumentCurrencyCode>COP</cbc:DocumentCurrencyCode>
      <cbc:LineCountNumeric><xsl:value-of select="count(/top/items/item)"/></cbc:LineCountNumeric>      
      <cac:DiscrepancyResponse>
        <cbc:ReferenceID><xsl:value-of select="/top/consefacnot"/></cbc:ReferenceID>
        <cbc:ResponseCode>1</cbc:ResponseCode>
        <cbc:Description>Nota Credito de Factura</cbc:Description>
      </cac:DiscrepancyResponse>
      <cac:BillingReference>
        <cac:InvoiceDocumentReference>
          <cbc:ID><xsl:value-of select="/top/consefacnot"/></cbc:ID>
          <cbc:UUID schemeName="CUFE-SHA384"><xsl:value-of select="/top/cufedoc"/></cbc:UUID>
          <cbc:IssueDate><xsl:value-of select="/top/fechafacnot"/></cbc:IssueDate>
          <cbc:DocumentTypeCode>01</cbc:DocumentTypeCode>
        </cac:InvoiceDocumentReference>
      </cac:BillingReference>
      <cac:AccountingSupplierParty>
        <cbc:AdditionalAccountID schemeAgencyID="195">1</cbc:AdditionalAccountID>
        <cac:Party>
          <cac:PartyName>
            <cbc:Name>
              <xsl:value-of select="/top/Empresa/razon"/>
            </cbc:Name>
          </cac:PartyName>
          <cac:PhysicalLocation>
            <cac:Address>
              <cbc:ID><xsl:value-of select="/top/Empresa/codciudad"/></cbc:ID>
              <cbc:CityName><xsl:value-of select="/top/Empresa/ciudad"/></cbc:CityName>
              <cbc:CountrySubentity><xsl:value-of select="/top/Empresa/departamento"/></cbc:CountrySubentity>
              <cbc:CountrySubentityCode><xsl:value-of select="/top/Empresa/coddepartamento"/></cbc:CountrySubentityCode>
              <cac:AddressLine>
                <cbc:Line><xsl:value-of select="/top/Empresa/direccion"/></cbc:Line>
              </cac:AddressLine>
              <cac:Country>
                <cbc:IdentificationCode>CO</cbc:IdentificationCode>
                <cbc:Name languageID="es">Colombia</cbc:Name>
              </cac:Country>
            </cac:Address>
          </cac:PhysicalLocation>
          <cac:PartyTaxScheme>
            <cbc:RegistrationName><xsl:value-of select="/top/Empresa/razon"/></cbc:RegistrationName>
            <cbc:CompanyID schemeID="{/top/Empresa/digveri}" schemeName="{/top/Empresa/tipoid}" schemeAgencyName="CO, DIAN (Dirección de Impuestos y Aduanas Nacionales)" schemeAgencyID="195"><xsl:value-of select="/top/Empresa/nit"/></cbc:CompanyID>
            <cbc:TaxLevelCode listName="05">O-99</cbc:TaxLevelCode>
            <cac:RegistrationAddress>
              <cbc:ID><xsl:value-of select="/top/Empresa/codciudad"/></cbc:ID>
              <cbc:CityName><xsl:value-of select="/top/Empresa/ciudad"/></cbc:CityName>
              <cbc:CountrySubentity><xsl:value-of select="/top/Empresa/departamento"/></cbc:CountrySubentity>
              <cbc:CountrySubentityCode><xsl:value-of select="/top/Empresa/coddepartamento"/></cbc:CountrySubentityCode>
              <cac:AddressLine>
                <cbc:Line><xsl:value-of select="/top/Empresa/direccion"/></cbc:Line>
              </cac:AddressLine>
              <cac:Country>
                <cbc:IdentificationCode>CO</cbc:IdentificationCode>
                <cbc:Name languageID="es">Colombia</cbc:Name>
              </cac:Country>
            </cac:RegistrationAddress>
            <cac:TaxScheme>
              <cbc:ID>01</cbc:ID>
              <cbc:Name>IVA</cbc:Name>
            </cac:TaxScheme>
          </cac:PartyTaxScheme>
          <cac:PartyLegalEntity>
            <cbc:RegistrationName>
              <xsl:value-of select="/top/Empresa/razon"/>
            </cbc:RegistrationName>
            <cbc:CompanyID schemeID="{/top/Empresa/digveri}" schemeName="{/top/Empresa/tipoid}" schemeAgencyName="CO, DIAN (Dirección de Impuestos y Aduanas Nacionales)" schemeAgencyID="195"><xsl:value-of select="/top/Empresa/nit"/></cbc:CompanyID>
            <cac:CorporateRegistrationScheme>
              <cbc:ID>
                <xsl:value-of select="/top/resolucion/prefijo"/>
              </cbc:ID>
              <cbc:Name>
                <xsl:value-of select="/top/resolucion/consecutivo"/>
              </cbc:Name>
            </cac:CorporateRegistrationScheme>
          </cac:PartyLegalEntity>
          <cac:Contact>
            <cbc:Telephone><xsl:value-of select="/top/Empresa/telefono"/></cbc:Telephone>
            <cbc:ElectronicMail><xsl:value-of select="/top/Empresa/email"/></cbc:ElectronicMail>
          </cac:Contact>
        </cac:Party>
      </cac:AccountingSupplierParty>      
      <cac:AccountingCustomerParty>
        <cbc:AdditionalAccountID schemeAgencyID="195">1</cbc:AdditionalAccountID>
        <cac:Party>
          <cac:PartyName>
            <cbc:Name>
              <xsl:value-of select="/top/cliente/firstname"/> &#160; <xsl:value-of select="/top/cliente/lastname"/>
            </cbc:Name>
          </cac:PartyName>         
          <cac:PhysicalLocation>
            <cac:Address>
              <cbc:ID><xsl:value-of select="/top/cliente/codciudad"/></cbc:ID>
              <cbc:CityName><xsl:value-of select="/top/cliente/ciudad"/></cbc:CityName>
              <cbc:CountrySubentity><xsl:value-of select="/top/cliente/departamento"/></cbc:CountrySubentity>
              <cbc:CountrySubentityCode><xsl:value-of select="/top/cliente/coddepartamento"/></cbc:CountrySubentityCode>
              <cac:AddressLine>
                <cbc:Line><xsl:value-of select="/top/cliente/direccion"/></cbc:Line>
              </cac:AddressLine>
              <cac:Country>
                <cbc:IdentificationCode>CO</cbc:IdentificationCode>
                <cbc:Name languageID="es">Colombia</cbc:Name>
              </cac:Country>
            </cac:Address>
          </cac:PhysicalLocation>
          <cac:PartyTaxScheme>
            <cbc:RegistrationName><xsl:value-of select="/top/cliente/firstname"/> &#160; <xsl:value-of select="/top/cliente/lastname"/></cbc:RegistrationName>
            <cbc:CompanyID  schemeName="{/top/cliente/tipoid}" schemeID="{/top/cliente/digic}" schemeAgencyName="CO, DIAN (Dirección de Impuestos y Aduanas Nacionales)" schemeAgencyID="195"><xsl:value-of select="/top/cliente/iden"/></cbc:CompanyID>
            <cbc:TaxLevelCode listName="05">O-99</cbc:TaxLevelCode>
            <cac:TaxScheme>
              <cbc:ID>01</cbc:ID>
              <cbc:Name>IVA</cbc:Name>
            </cac:TaxScheme>
          </cac:PartyTaxScheme>
          <cac:PartyLegalEntity>
            <cbc:RegistrationName><xsl:value-of select="/top/cliente/firstname"/> &#160; <xsl:value-of select="/top/cliente/lastname"/></cbc:RegistrationName>
            <cbc:CompanyID  schemeName="{/top/cliente/tipoid}" schemeID="{/top/cliente/digic}" schemeAgencyName="CO, DIAN (Dirección de Impuestos y Aduanas Nacionales)" schemeAgencyID="195"><xsl:value-of select="/top/cliente/iden"/></cbc:CompanyID>
            <cac:CorporateRegistrationScheme>
              <cbc:Name>00000</cbc:Name>
            </cac:CorporateRegistrationScheme>
          </cac:PartyLegalEntity>
          <cac:Contact>
            <cbc:Telephone><xsl:value-of select="/top/cliente/telefono"/></cbc:Telephone>
            <cbc:ElectronicMail><xsl:value-of select="/top/cliente/email"/></cbc:ElectronicMail>
          </cac:Contact>
        </cac:Party>
      </cac:AccountingCustomerParty>    
      <cac:PaymentMeans>
        <cbc:ID>1</cbc:ID>
        <cbc:PaymentMeansCode>10</cbc:PaymentMeansCode>
        <cbc:PaymentDueDate><xsl:value-of select="/top/factura/fechavence"/></cbc:PaymentDueDate>
        <cbc:PaymentID><xsl:value-of select="/top/paymentid"/></cbc:PaymentID>
      </cac:PaymentMeans>
      <cac:PrepaidPayment>
        <cbc:ID>1</cbc:ID>
        <cbc:PaidAmount currencyID="COP"><xsl:value-of select="/top/factura/anticipo"/></cbc:PaidAmount>
        <cbc:ReceivedDate><xsl:value-of select="/top/factura/fecha"/></cbc:ReceivedDate>
      </cac:PrepaidPayment>
      <cac:AllowanceCharge>
        <cbc:ID>1</cbc:ID>
        <cbc:ChargeIndicator>false</cbc:ChargeIndicator>
        <cbc:AllowanceChargeReasonCode>11</cbc:AllowanceChargeReasonCode>
        <cbc:AllowanceChargeReason>DESCUENTO FINANCIERO</cbc:AllowanceChargeReason>
        <cbc:MultiplierFactorNumeric>0.00</cbc:MultiplierFactorNumeric>
        <cbc:Amount currencyID="COP"><xsl:value-of select="/top/factura/descuentogen"/></cbc:Amount>
        <cbc:BaseAmount currencyID="COP"><xsl:value-of select="/top/factura/subtotal"/></cbc:BaseAmount>
      </cac:AllowanceCharge>
      <cac:TaxTotal>
        <cbc:TaxAmount currencyID="COP"><xsl:value-of select="/top/factura/iva"/></cbc:TaxAmount>        
        <xsl:for-each select="/top/items/item">
          <cac:TaxSubtotal>
            <cbc:TaxableAmount currencyID="COP"><xsl:value-of select="valorDcto"/></cbc:TaxableAmount>
            <cbc:TaxAmount currencyID="COP"><xsl:value-of select="iva"/></cbc:TaxAmount>
            <cac:TaxCategory>              
              <cbc:Percent><xsl:value-of select="poriva"/></cbc:Percent>
              <cac:TaxScheme>
                <cbc:ID>01</cbc:ID>
                <cbc:Name>IVA</cbc:Name>
              </cac:TaxScheme>
            </cac:TaxCategory>
          </cac:TaxSubtotal>
        </xsl:for-each>
      </cac:TaxTotal>
      <cac:TaxTotal>
        <cbc:TaxAmount currencyID="COP"><xsl:value-of select="/top/factura/inc"/></cbc:TaxAmount>        
        <xsl:for-each select="/top/items/item">
          <cac:TaxSubtotal>
            <cbc:TaxableAmount currencyID="COP"><xsl:choose><xsl:when test="inc = 0">0.00</xsl:when><xsl:otherwise><xsl:value-of select="valorDcto"/></xsl:otherwise></xsl:choose></cbc:TaxableAmount>
            <cbc:TaxAmount currencyID="COP"><xsl:value-of select="inc"/></cbc:TaxAmount>            
            <cac:TaxCategory>
              <cbc:Percent><xsl:value-of select="porinc"/></cbc:Percent>
              <cac:TaxScheme>
                <cbc:ID>04</cbc:ID>
                <cbc:Name>INC</cbc:Name>
              </cac:TaxScheme>
            </cac:TaxCategory>
          </cac:TaxSubtotal>
        </xsl:for-each>
      </cac:TaxTotal>
	  <cac:TaxTotal>
        <cbc:TaxAmount currencyID="COP"><xsl:value-of select="/top/factura/ica"/></cbc:TaxAmount>        
        <xsl:for-each select="/top/items/item">
          <cac:TaxSubtotal>
            <cbc:TaxableAmount currencyID="COP">0.00</cbc:TaxableAmount>
            <cbc:TaxAmount currencyID="COP"><xsl:value-of select="ica"/></cbc:TaxAmount>            
            <cac:TaxCategory>
              <cbc:Percent><xsl:value-of select="porica"/></cbc:Percent>
              <cac:TaxScheme>
                <cbc:ID>03</cbc:ID>
                <cbc:Name>ICA</cbc:Name>
              </cac:TaxScheme>
            </cac:TaxCategory>
          </cac:TaxSubtotal>
        </xsl:for-each>
      </cac:TaxTotal>  
	  <cac:LegalMonetaryTotal>
        <cbc:LineExtensionAmount currencyID="COP"><xsl:value-of select="/top/factura/subtotaldcto"/></cbc:LineExtensionAmount>
        <cbc:TaxExclusiveAmount currencyID="COP"><xsl:value-of select="/top/factura/subtotaldcto"/></cbc:TaxExclusiveAmount>        
        <cbc:TaxInclusiveAmount currencyID="COP"><xsl:value-of select="/top/factura/total"/></cbc:TaxInclusiveAmount>
        <cbc:AllowanceTotalAmount currencyID="COP"><xsl:value-of select="/top/factura/descuentogen"/></cbc:AllowanceTotalAmount>
        <cbc:ChargeTotalAmount currencyID="COP">0.00</cbc:ChargeTotalAmount>
        <cbc:PrepaidAmount currencyID="COP"><xsl:value-of select="/top/factura/anticipo"/></cbc:PrepaidAmount>
        <cbc:PayableAmount currencyID="COP"><xsl:value-of select="/top/factura/retotal"/></cbc:PayableAmount>
      </cac:LegalMonetaryTotal>       
      <xsl:for-each select="/top/items/item">
        <cac:CreditNoteLine>
          <cbc:ID><xsl:value-of select="id"/></cbc:ID>
          <cbc:CreditedQuantity><xsl:value-of select="cant"/></cbc:CreditedQuantity>
          <cbc:LineExtensionAmount currencyID="COP"><xsl:value-of select="valorDcto"/></cbc:LineExtensionAmount>		   
          <cac:TaxTotal>
            <cbc:TaxAmount currencyID="COP"><xsl:value-of select="iva"/></cbc:TaxAmount>
            <cac:TaxSubtotal>
              <cbc:TaxableAmount currencyID="COP"><xsl:value-of select="valorDcto"/></cbc:TaxableAmount>
              <cbc:TaxAmount currencyID="COP"><xsl:value-of select="iva"/></cbc:TaxAmount>
              <cac:TaxCategory>
                <cbc:Percent><xsl:value-of select="poriva"/></cbc:Percent>
                <cac:TaxScheme>
                  <cbc:ID>01</cbc:ID>
                  <cbc:Name>IVA</cbc:Name>
                </cac:TaxScheme>
              </cac:TaxCategory>
            </cac:TaxSubtotal>
          </cac:TaxTotal>
		  <xsl:if test="inc != 0">
            <cac:TaxTotal>
              <cbc:TaxAmount currencyID="COP"><xsl:value-of select="inc"/></cbc:TaxAmount>
                <cac:TaxSubtotal>
                  <cbc:TaxableAmount currencyID="COP"><xsl:value-of select="valorDcto"/></cbc:TaxableAmount>
                  <cbc:TaxAmount currencyID="COP"><xsl:value-of select="inc"/></cbc:TaxAmount>            
                  <cac:TaxCategory>
                    <cbc:Percent><xsl:value-of select="porinc"/></cbc:Percent>
                    <cac:TaxScheme>
                      <cbc:ID>04</cbc:ID>
                      <cbc:Name>INC</cbc:Name>
                    </cac:TaxScheme>
                  </cac:TaxCategory>
                </cac:TaxSubtotal>
            </cac:TaxTotal>
          </xsl:if>
          <cac:Item>
            <cbc:Description><xsl:value-of select="descrip"/></cbc:Description>
			 <cac:StandardItemIdentification>
              <cbc:ID schemeID="999"><xsl:value-of select="codigo"/></cbc:ID>
            </cac:StandardItemIdentification>
          </cac:Item>
          <cac:Price>
            <cbc:PriceAmount currencyID="COP"><xsl:value-of select="valorUND"/></cbc:PriceAmount>
            <cbc:BaseQuantity unitCode="EA"><xsl:value-of select="cant"/></cbc:BaseQuantity>
          </cac:Price>
        </cac:CreditNoteLine>
      </xsl:for-each>
    </CreditNote>
  </xsl:template>
</xsl:stylesheet>
