<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.5" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output method="xml" omit-xml-declaration="yes" indent="yes"/>
  <xsl:template match="/">
    <div align="center">
      <table class="m_7466074051077933342MsoNormalTable" border="1" cellspacing="0" cellpadding="0" width="600" style="width:450.0pt;background:white;border-collapse:collapse;border:none">
        <tbody>
          <tr style="height:60.0pt">
            <td width="480" colspan="2" style="width:360.0pt;border-top:solid #dddddd 1.0pt;border-left:solid #dddddd 1.0pt;border-bottom:solid #00000021 1pt;border-right:none;padding:7.5pt 7.5pt 7.5pt 7.5pt;height:60.0pt">
              <p class="MsoNormal" align="center" style="text-align:center">
                <b>
                  <span style="font-size:18.0pt;font-family:&quot;Trebuchet MS&quot;,sans-serif;color:#000">
                    Notificación de Documentos <u></u><u></u>
                  </span>
                </b>
              </p>
            </td>
            <td width="120" style="width:90.0pt;border-top:solid #dddddd 1.0pt;border-left:none;border-bottom:none;border-right:solid #000 1.0pt;background:#004bb0;padding:7.5pt 15.0pt 7.5pt 15.0pt;height:60.0pt">
              <p class="MsoNormal" align="center" style="text-align:center">
                <img width="60" height="70" style="width:.625in;height:.7291in" id="m_7466074051077933342_x0000_i1025" src="http://jw.dynalias.org/SintesisPOS/Imgarticulos/Transfac.png" alt="icono" class="CToWUd"/>
              </p>
            </td>
          </tr>
          <tr style="height:75.0pt">
            <td width="600" colspan="3" valign="top" style="width:450.0pt;border-top:none;border-left:solid #dddddd 1.0pt;border-bottom:none;border-right:solid #dddddd 1.0pt;padding:7.5pt 15.0pt 7.5pt 15.0pt;height:75.0pt">
              <p style="text-align:justify;line-height:19.5pt">
                <font color="#000000" style="font-size: 13.5px;" face="Arial, Helvetica, sans-serif">
                  Estimado(a)
                  <b>
                    <xsl:value-of select="NWindDataSet/DataInfo/@cliente"/>
                  </b>,
                  <br/><br/>
                  La empresa <strong>
                    <span style="font-family:&quot;Segoe UI&quot;,sans-serif">
                      <xsl:value-of select="NWindDataSet/CabeceraCompany/@Nombre"/>
                    </span>
                  </strong> identificada con N° <xsl:value-of select="NWindDataSet/CabeceraCompany/@Nit"/>, ha generado un nuevo <strong>
                    <span style="font-family:&quot;Segoe UI&quot;,sans-serif">Documento Electronico </span>
                  </strong> por servicios y/o productos adquiridos por usted el <xsl:value-of select="NWindDataSet/DataInfo/@fechadoc"/>. <u></u><u></u>
                </font>
              </p>
            </td>
          </tr>
          <tr>
            <td colspan="3" style="text-align:center">
              <p style="font-family:Roboto,sans-serif;font-size:13px;margin-top:10px;color:#787878">Gracias por aportar un granito de arena en la lucha contra la contaminación.</p>
            </td>
          </tr>
          <tr>
            <td colspan="3" bgcolor="#0074bcb0" style="padding:10px 30px; text-align:center;color:#707682">
              <p style="margin:2px 0">
                <font color="#ffffff" size="1" face="Arial, Helvetica, sans-serif">
                  Copyright © Sintesis Cloud S.A.S. Todos los derechos reservados.
                </font>
              </p>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
    <br/>
    <br/>
    <br/>
    <br/>
    <br/>
  </xsl:template>
</xsl:stylesheet>

