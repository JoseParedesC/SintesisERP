<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Empresas.aspx.cs" Inherits="Empresas" MasterPageFile="~/Masters/SintesisMaster.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPage" runat="server">
    <script type="text/javascript">
        window.appPath = "<%=Request.ApplicationPath%>";
    </script>
    <style>
        .nav.nav-tabs {
            margin-bottom: 10px !important;
        }

            .nav.nav-tabs li a {
                border: 1px solid #ccc;
            }

            .nav.nav-tabs li.active a {
                background-color: #1ab394 !important;
                color: white;
                border: none;
            }
    </style>
    <div class="row" style="margin-left: 0;">
        <div class="x_panel">
            <div class="x_title">
                <h1 class="title-master" style="margin-top: 0;"><span class="fa fa-building fa-fw"></span>Maestro Empresas 
                    <div class="clearfix"></div>
            </div>
        </div>
    </div>


    <div class="card" id="diventrada">
        <div class="row" style="margin: 0px 10px;">
            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding-top: 5px; padding-bottom: 15px; padding-left: 2px;">
                <div class="table-responsive">
                    <table class="table table-striped jambo_table" id="tblempresas">
                        <thead>
                            <tr>
                                <th data-column-id="edit" data-formatter="edit" data-sortable="false" style="max-width: 30px !important;">Editar</th>
                                <th data-column-id="razonsocial">Razon Social</th>
                                <th data-column-id="nit">Nit</th>
                                <th data-column-id="nombrecomercial">Nombre Comercial</th>
                                <th data-column-id="telefono">Telefono</th>
                                <th data-column-id="ciudad">Ciudad</th>
                                <th data-column-id="range" data-formatter="range" data-sortable="false" style="max-width: 30px">Ranguear</th>
                            </tr>
                        </thead>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="ModalEmpresas">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h2 class="modal-title">Detalle Empresa</h2>
                </div>
                <div class="modal-body clearfix" style="margin-bottom: 0;">
                    <ul class="nav nav-tabs">
                        <li class="active">
                            <a data-toggle="tab" href="#tab-1"><i class="fa fa-briefcase"></i>
                                <span class="hidden-xs">Información Empresa</span></a>
                        </li>
                        <li class=""><a data-toggle="tab" href="#tab-3"><i class="fa fa-file-text"></i>
                            <span class="hidden-xs">Facturación Elec.</span></a>
                        </li>
                    </ul>
                    <div class="tab-content">
                        <div id="tab-1" class="tab-pane active">
                            <div class="col-lg-3 col-md-3 col-sm-12 col-xs-12 pull-right" style="border: 1px solid #ccc; margin-bottom: 10px">
                                <div class="form-group">
                                    <label>Imagen</label>
                                    <input type="file" runat="server" clientidmode="Static" id="imgempresa" class="dropify" data-height="205" data-max-file-size="5M"
                                        data-allowed-file-extensions="png jpeg jpg" data-max-file-size-preview="5M" />
                                    <input id="ds_namefile" runat="server" clientidmode="static" type="hidden" />
                                </div>
                            </div>
                            <div class="col-lg-9 col-md-9 col-sm-12 col-xs-12" style="padding-left: 0px;">
                                <div class="row">
                                    <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
                                        <div class="form-group">
                                            <label for="ds_name" class="active">Razon Social:</label>
                                            <input class="form-control" id="ds_name" name="ds_name" type="text" />
                                        </div>
                                    </div>
                                    <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
                                        <div class="form-group">
                                            <label for="id_tipoid" class="active">Tipo Iden:</label>
                                            <select id="id_tipoid" name="id_tipoid" runat="server" data-size="8" clientidmode="Static" class="form-control selectpicker" data-live-search="true">
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                        <div class="form-group">
                                            <label for="ds_namecomercial" class="active">Nombre Comercial:</label>
                                            <input class="form-control" id="ds_namecomercial" name="ds_namecomercial" type="text" />
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
                                        <div class="form-group">
                                            <label for="ds_nit" class="active">Identificación:</label>
                                            <input class="form-control" id="ds_nit" name="ds_nit" type="text" />
                                        </div>
                                    </div>
                                    <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
                                        <div class="form-group">
                                            <label for="ds_digverificacion" class="active">Dig. Verificación:</label>
                                            <input class="form-control" id="ds_digverificacion" name="ds_digverificacion" type="text" disabled="disabled" />
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-5 col-md-5 col-sm-12 col-xs-12">
                                        <div class="form-group">
                                            <label for="id_city" class="active">Ciudad:</label>
                                            <select id="id_city" name="id_city" runat="server" data-size="8" clientidmode="Static" class="form-control selectpicker" data-live-search="true">
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-lg-7 col-md-7 col-sm-12 col-xs-12">
                                        <div class="form-group">
                                            <label for="ds_address" class="active">Dirección:</label>
                                            <input class="form-control" id="ds_address" name="ds_address" type="text" />
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
                                        <div class="form-group">
                                            <label for="ds_phone" class="active">Teléfono:</label>
                                            <input class="form-control" id="ds_phone" name="ds_phone" type="text" />
                                        </div>
                                    </div>
                                    <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
                                        <div class="form-group">
                                            <label for="ds_email" class="active">Email:</label>
                                            <input class="form-control" id="ds_email" name="ds_email" type="text" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div id="tab-3" class="tab-pane">
                            <div class="row">
                                <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
                                    <div class="form-group">
                                        <label for="ds_softid" class="active">Software ID:</label>
                                        <input class="form-control" id="ds_softid" name="ds_softid" type="text" />
                                    </div>
                                </div>
                                <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
                                    <div class="form-group">
                                        <label for="ds_softpin" class="active">Pin:</label>
                                        <input class="form-control" id="ds_softpin" name="ds_softpin" type="password" />
                                    </div>
                                </div>
                                <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
                                    <div class="form-group">
                                        <label for="ds_softteckey" class="active">Clave Tecnica:</label>
                                        <input class="form-control" id="ds_softteckey" name="ds_softteckey" type="text" />
                                    </div>
                                </div>
                                <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
                                    <div class="form-group">
                                        <label for="ds_testid" class="active">TestID:</label>
                                        <input class="form-control" id="ds_testid" name="ds_testid" type="text" />
                                    </div>
                                </div>
                                <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
                                    <div class="form-group">
                                        <label for="id_ambiente" class="active">Ambiente:</label>
                                        <select id="id_ambiente" name="id_ambiente" runat="server" data-size="8" clientidmode="Static" class="form-control selectpicker" data-live-search="true">
                                        </select>
                                    </div>
                                </div>
                                <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
                                    <div class="form-group">
                                        <label for="ds_carpeta" class="active">Carpeta:</label>
                                        <input class="form-control" id="ds_carpeta" name="ds_carpeta" type="text" />
                                    </div>
                                </div>
                                <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
                                    <div class="form-group">
                                        <label for="ds_certificate" class="active">Certificado:</label>
                                        <input class="form-control" id="ds_certificate" name="ds_certificate" type="text" />
                                    </div>
                                </div>
                                <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
                                    <div class="form-group">
                                        <label for="ds_passcertifi" class="active">Clave Certificado:</label>
                                        <input class="form-control" id="ds_passcertifi" name="ds_passcertifi" type="password" />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-12 sn-padding">
                            <button title="Cerrar" id="btnCan" data-op="C" class="btn btn-outline btn-danger  dim  pull-right" type="button" data-dismiss="modal" aria-label="Close"><i class="fa fa-minus-square-o"></i></button>
                            <button title="Guardar" id="btnSave" data-op="R" class="btn btn-outline btn-primary dim  pull-right" type="button"><i class="fa fa-paste"></i></button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%--</main>--%>
    <script>
        $(document).ready(function () {
            datepicker();
        });
    </script>
    <script src="../Pages/ScriptsPage/Parametrizacion/Empresa.js"></script>
</asp:Content>
