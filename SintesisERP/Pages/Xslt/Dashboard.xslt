<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.5" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output method="xml" omit-xml-declaration="yes" indent="yes"/>
  <xsl:template match="/">
    <style>
      .boxdata {
      border-radius: 10px;
      -webkit-box-shadow: 0 4px 20px 1px rgba(0,0,0,.06), 0 1px 4px rgba(0,0,0,.08);
      box-shadow: 0 4px 20px 1px rgba(0,0,0,.06), 0 1px 4px rgba(0,0,0,.08);
      border: 0;
      }
    </style>
    <div class="wrapper wrapper-content">
      <div class="row">
        <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12" style="padding: 0 2.5px; min-height: 130px !important;">
          <div class="col-lg-12 boxdata">
            <div class="float-e-margins">
              <div class="ibox-title">
                <span class="label label-primary pull-right">Mes</span>
                <h5>
                  <span class="fa fa-file-text-o fa-fw" style="font-size: 20px"></span>&#160;Ordenes
                </h5>
              </div>
              <div class="ibox-content">
                <h1 class="no-margins text-right">
                  <xsl:value-of select="/top/cabecera/ordenes"/>
                </h1>
              </div>
            </div>
          </div>
        </div>
        <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12" style="padding: 0 2.5px; min-height: 130px !important;">
          <div class="col-lg-12 boxdata">
            <div class="float-e-margins">
              <div class="ibox-title">
                <span class="label label-warning pull-right">Mes</span>
                <h5>
                  <span class="fa fa-money fa-fw" style="font-size: 20px"></span>&#160;Compras
                </h5>
              </div>
              <div class="ibox-content">
                <h1 class="no-margins text-right">
                  <xsl:value-of select="/top/cabecera/compras"/>
                </h1>
              </div>
            </div>
          </div>
        </div>
        <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12" style="padding: 0 2.5px; min-height: 130px !important;">
          <div class="col-lg-12 boxdata">
            <div class="float-e-margins">
              <div class="ibox-title">
                <span class="label label-success pull-right">Año</span>
                <h5>
                  <span class="fa fa-file-text-o fa-fw" style="font-size: 20px"></span>&#160;Facturas
                </h5>
              </div>
              <div class="ibox-content">
                <h1 class="no-margins text-right">
                  <xsl:value-of select="/top/cabecera/facturas"/>
                </h1>
              </div>
            </div>
          </div>
        </div>
        <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12" style="padding: 0 2.5px; min-height: 130px !important;">
          <div class="col-lg-12 boxdata">
            <div class="float-e-margins">
              <div class="ibox-title">
                <span class="label label-info pull-right">Año</span>
                <h5>
                  <span class="fa fa-money fa-fw" style="font-size: 20px"></span>&#160;Recaudos
                </h5>
              </div>
              <div class="ibox-content">
                <h1 class="no-margins text-right">
                  <xsl:value-of select="/top/cabecera/recaudos"/>
                </h1>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="wrapper wrapper-content ">
      <div class="row ">
        <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12 boxdata" style="margin-bottom: 8px;">
          <h5 style="width:100%;">
            <span  class="fa fa-line-chart fa-fw" style=" width:100%; font-size: 20px"></span> &#160;COMPRAS VS VENTAS (Año/Mes)
          </h5>
          <div style="width: 100%;">
            <canvas id="canvas" style="max-height:600px !important"></canvas>
          </div>
        </div>
        <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12 boxdata" style="margin-bottom: 8px;">
          <h5 style="width:100%;">
            <span  class="fa fa-line-chart fa-fw" style=" width:100%; font-size: 20px"></span> &#160;CARTERA VS RECAUDO (Año/Mes)
          </h5>
          <div style="width: 100%;">
            <canvas id="canvas2" style="max-height:600px !important"></canvas>
          </div>
        </div>
      </div>
    </div>
    <script>
      function createConfig(data) {
      return {
      type: 'line',
      data: {
      labels: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'],
      datasets: data
      },
      options: {
      plugins: {
      datalabels: {
      formatter: function(value, context) {
      return numeral(value).format('0,0');
      }
      }
      },
      responsive: true,
      title: {
      display: false,
      text: 'Chart.js Line Chart'
      },
      tooltips: {
      callbacks: {
      label: function(tooltipItem, data) {
      return numeral(data.datasets[tooltipItem.datasetIndex].data[tooltipItem.index]).format('0,0.00');
      }
      },
      mode: 'index',
      intersect: false
      },
      hover: {
      mode: 'nearest',
      intersect: true
      },
      scales: {
      xAxes: [{
      display: true,
      scaleLabel: {
      display: true,
      labelString: 'Meses'
      }
      }],
      yAxes: [{
      display: true,
      scaleLabel: {
      display: true,
      labelString: 'Valores'
      }
      }]
      }
      }
      };
      }


      var dataset1 = [
      {
      label: 'Total Ventas',
      backgroundColor: window.chartColors.green,
      borderColor: window.chartColors.green,
      data: [
      <xsl:for-each select="/top/ventas/Meses">
        <xsl:value-of select="enero"/>,
        <xsl:value-of select="febrero"/>,
        <xsl:value-of select="marzo"/>,
        <xsl:value-of select="abril"/>,
        <xsl:value-of select="mayo"/>,
        <xsl:value-of select="junio"/>,
        <xsl:value-of select="julio"/>,
        <xsl:value-of select="agosto"/>,
        <xsl:value-of select="septiembre"/>,
        <xsl:value-of select="octubre"/>,
        <xsl:value-of select="noviembre"/>,
        <xsl:value-of select="diciembre"/>
      </xsl:for-each>
      ],
      fill: false,
      borderDash: [4, 4],
      pointRadius: 5,
      pointHoverRadius: 5,
      },
      {
      label: 'Total Compras',
      backgroundColor: window.chartColors.red,
      borderColor: window.chartColors.red,
      data: [
      <xsl:for-each select="/top/compras/Meses">
        <xsl:value-of select="enero"/>,
        <xsl:value-of select="febrero"/>,
        <xsl:value-of select="marzo"/>,
        <xsl:value-of select="abril"/>,
        <xsl:value-of select="mayo"/>,
        <xsl:value-of select="junio"/>,
        <xsl:value-of select="julio"/>,
        <xsl:value-of select="agosto"/>,
        <xsl:value-of select="septiembre"/>,
        <xsl:value-of select="octubre"/>,
        <xsl:value-of select="noviembre"/>,
        <xsl:value-of select="diciembre"/>
      </xsl:for-each>
      ],
      fill: false,
      borderDash: [4, 4],
      pointRadius: 5,
      pointHoverRadius: 5
      }
      ];

      var dataset2 = [
      {
      label: 'Cartera',
      backgroundColor: window.chartColors.purple,
      borderColor: window.chartColors.purple,
      data: [
      <xsl:for-each select="/top/cartera/Meses">
        <xsl:value-of select="enero"/>,
        <xsl:value-of select="febrero"/>,
        <xsl:value-of select="marzo"/>,
        <xsl:value-of select="abril"/>,
        <xsl:value-of select="mayo"/>,
        <xsl:value-of select="junio"/>,
        <xsl:value-of select="julio"/>,
        <xsl:value-of select="agosto"/>,
        <xsl:value-of select="septiembre"/>,
        <xsl:value-of select="octubre"/>,
        <xsl:value-of select="noviembre"/>,
        <xsl:value-of select="diciembre"/>
      </xsl:for-each>
      ],
      fill: false,
      borderDash: [4, 4],
      pointRadius: 5,
      pointHoverRadius: 5
      },
      {
      label: 'Recaudado',
      backgroundColor: window.chartColors.orange,
      borderColor: window.chartColors.orange,
      data: [
      <xsl:for-each select="/top/recaudo/Meses">
        <xsl:value-of select="enero"/>,
        <xsl:value-of select="febrero"/>,
        <xsl:value-of select="marzo"/>,
        <xsl:value-of select="abril"/>,
        <xsl:value-of select="mayo"/>,
        <xsl:value-of select="junio"/>,
        <xsl:value-of select="julio"/>,
        <xsl:value-of select="agosto"/>,
        <xsl:value-of select="septiembre"/>,
        <xsl:value-of select="octubre"/>,
        <xsl:value-of select="noviembre"/>,
        <xsl:value-of select="diciembre"/>
      </xsl:for-each>
      ],
      fill: false,
      borderDash: [4, 4],
      pointRadius: 5,
      pointHoverRadius: 5
      }
      ]

      var config = createConfig(dataset1);
      var config2 = createConfig(dataset2);

      window.onload = function () {
      var ctx = document.getElementById('canvas').getContext('2d');
      ctx.height = 600;
      window.myLine = new Chart(ctx, config);

      var ctx2 = document.getElementById('canvas2').getContext('2d');
      ctx2.height = 600;
      window.myLine2 = new Chart(ctx2, config2);
      }
    </script>
  </xsl:template>
</xsl:stylesheet>
