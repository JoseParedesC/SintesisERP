<%@ Page Language="C#" ValidateRequest="false" AutoEventWireup="true" CodeBehind="UserCaja.aspx.cs"
    Inherits="UserCaja" MasterPageFile="~/Components/Masters/MasterPages.Master" %>

<asp:Content ID="Content3" ContentPlaceHolderID="MainLayout" runat="server">
    <style>
        .modal-content {
            min-height: 450px;
        }

        .modal-header {
            max-height: 210px;
        }

        .btn-primary {
            color: #fff;
            background-color: #051835;
            border-color: #051835;
        }

        .btn-danger {
            background-color: #ed5565 !important;
            border-color: #ed5565 !important;
            color: #FFFFFF !important;
        }

            .btn-danger:hover {
                opacity: 0.8;
            }

        .btn {
            border-radius: 3px;
        }
    </style>
        
    <link href="Package/Vendor/css/plugins/bootstrap-select/bootstrap-select.css" rel="stylesheet" />
    <div class="container" style="margin-top: 5%;">
        <div class="modal-dialog modal-sm pd10">
            <div class="modal-content">
                <div class="modal-header text-center " style="border-bottom: none !important;">
                    <img src="Images/SINTESIS_CLOUD_LOGO__.png" style="width: 100%; height: 100%" />
                </div>
                <div class="modal-body clearfix ">
                    <div class="form-group">
                        <label for="cajas" class="active">Caja</label>
                        <select runat="server" clientidmode="static" id="cajas" name="cajas" data-size="8" class="form-control" data-live-search="true">
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Monto Inicial</label>
                        <input money="true" data-a-dec="." data-a-sep="," data-m-dec="2" data-v-min="0" data-a-sign="$ " data-v-max="999999999" value="0.00" class="form-control" id="startmoney" runat="server" clientidmode="static" />
                    </div>

                    <asp:Button ID="btnIniciar" Text="Aceptar" runat="server" CssClass="btn btn-rounded btn-block mt-2 btn-primary" OnClick="IniciarSesion_Click" />
                    <a href="index.aspx" class="btn btn-rounded btn-block mt-2 btn-danger" data-dismiss="modal" aria-label="Close">Cancelar</a>
                </div>
            </div>
            <div class="modal-footer">
                <div class="col-md-12 col-lg-12 col-xs-12 col-sm-12">
                    <p class="text-center text-sm">
                        ©<%=DateTime.Now.Year.ToString()%> Derechos reservados.
                            <br />
                        Sintesis Cloud
                    </p>
                </div>
            </div>
            <asp:Literal ID="mensajescript" runat="server" Text=""></asp:Literal>
        </div>
    </div>

    <script type="text/javascript" src="Package/Vendor/js/bootstrap.min.js"></script>
    <script>
        $(function () {
            //$('select').selectpicker();
            $("[money]").each(function (i, control) {
                $(control).autoNumeric('init');
            });
        })
    </script>
</asp:Content>
