<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Parametrosp.aspx.cs"
    Inherits="Parametrosp" MasterPageFile="~/Masters/SintesisMaster.Master" %>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPage" runat="server">
    <script type="text/javascript">
        window.appPath = "<%=Request.ApplicationPath%>";
    </script>
    
    <style>
        .card {
            height: auto !important;
            width: auto !important;
        }

        .ir-arriba {
            display: none;
            padding: 20px;
            background: #0074bcf0;
            font-size: 20px;
            color: #fff;
            cursor: pointer;
            position: fixed;
            bottom: 20px;
            right: 20px;
        }

        .boton {
            background: #0074bcf0;
            border-bottom: 5px solid #0045a6;
            border-radius: 12px;
            box-shadow: 6px 6px 6px #999;
            color: #fff;
            cursor: pointer;
            display: block;
            font-family: 'Raleway', Arial, Helvetica;
            font-size: 20px;
            /*margin: 80px auto;*/
            padding: 20px 20px;
            text-align: center;
            transition: all 0.2s ease 0s;
            width: 10px;
            /*position: fixed;*/
            height: 5px;
            margin-left: 2%;
            margin-top: 10%;
        }

            .boton:hover {
                background: #0096f7;
            }

            .boton:active {
                box-shadow: 2px 2px 2px #777, 0px 0px 35px 0px #00b7f8;
                border-bottom: 1px solid #0045A6;
                text-shadow: 0px 0px 5px #fff, 0px 0px 5px #fff;
                transform: translateY(4px);
                transition: all 0.1s ease 0s;
                /*margin: 80px auto 76px auto;*/
            }

        .icheckbox_square-green {
            margin-top: 8.01px !important;
            margin-right: 50%
        }
        #divparameters .form-control {
            /*height: 31.2px !important;*/
        }

    </style>


    <div class="row" style="margin: 0px 10px;">
        <div class="x_panel">
            <div class="x_title">
                <div class="clearfix col-lg-6 col-md-6 col-sm-7 col-xs-12">
                    <h1 class="title-master" style="margin-top: 0;"><span class="fa fa-bullhorn fa-fw"></span>Configuración de Parametros</h1>
                </div>
            </div>
            <div class="col-lg-6 col-md-6 col-sm-5 col-xs-12  Botns">
                <button title="Guardar" id="guardar" class="btn btn-outline btn-primary dim waves-effect waves-light pull-right btn-loading-state" type="button"><i class="fa fa-paste"></i></button>
            </div>
        </div>

    </div>

    <div class="card" id="divparameters" style="padding-bottom:20px !important;">
        <div class="row" style="margin: 0px 10px;">

            <asp:Literal ID="LiteralParametros" runat="server" Text="" />
        </div>
    </div>

    <span class="ir-arriba fa fa-sort-asc"></span>
 
    <script src="../Pages/ScriptsPage/Parametrizacion/Parametros.js?1"></script>
    <script>
        $(document).ready(function () {
            $('.i-checks').iCheck({
                checkboxClass: 'icheckbox_square-green',
                radioClass: 'iradio_square-green',
            });

            $('.ir-arriba').click(function () {
                $('body, html').animate({
                    scrollTop: '0px'
                }, 300);
            });

            $(window).scroll(function () {
                if ($(this).scrollTop() > 0) {
                    $('.ir-arriba').slideDown(300);
                } else {
                    $('.ir-arriba').slideUp(300);
                }
            });

        });

    </script>
  
</asp:Content>
