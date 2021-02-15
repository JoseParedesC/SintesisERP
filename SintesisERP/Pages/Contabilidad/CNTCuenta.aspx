<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CNTCuenta.aspx.cs" Inherits="CNTCuenta" MasterPageFile="~/Masters/SintesisMaster.Master" %>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPage" runat="server">
    <script type="text/javascript">
        window.appPath = "<%=Request.ApplicationPath%>";
    </script>
    <div class="row" style="margin-left: 0;">
        <div class="x_panel">
            <div class="x_title">
                <h1 class="title-master" style="margin-top: 0;"><span class="fa fa-bullhorn fa-fw"></span>Maestro cuentas</h1>
                <div class="clearfix"></div>
            </div>
        </div>
    </div>
    <div class="card" style="margin-top: 5px;">
        <div class="col-lg-12 sn-padding">
            <div role="alert" aria-live="polite" aria-atomic="true" class="alert alert-dismissible alert-alert alert-card alert-info" style="margin-bottom: 0px">
                <strong class="text-capitalize">Información!</strong>
                <br />
                1. Las cuentas solo pueden llegar a un 6 nivel.
                    <br />
                2. Para crear una cuenta debe tener seleccionado la cuenta que la contendra.
                    <br />
                3. Para editar una cuenta debe presionar doble click sobre ella.
            </div>
        </div>
        <div class="card-body">
            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 sn-padding">
                <div class="form-group">
                    <label for="ds_buscadorcuenta" class="active">Código o Nombre</label>
                    <div class="input-group ">
                        <input type="text" class="form-control" placeholder=" " id="ds_buscadorcuenta" aria-describedby="sizing-addon1">
                        <span class="input-group-addon ">
                            <button id="BtnRefresAccount" type="button" class="btn btn-primary waves-effect waves-light">
                                <i class="fa fa-fw fa-search"></i>
                            </button>
                        </span>
                    </div>
                </div>
            </div>
            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 sn-padding">
                <hr class="hrseparator">
                <div class="table-responsive" style="max-height: 500px">
                    <!---->
                    <!---->
                    <div role="tree" class="tree tree-default tree-checkbox-selection">
                        <ul role="group" class="tree-container-ul tree-children tree-wholerow-ul" id="ulcuentastree">
                            <asp:Literal ID="lbcnttree" runat="server" Text=""></asp:Literal>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <span class="fa-stack fa-lg pull-right goTop iconnew">
        <i class="fa fa-circle fa-stack-2x"></i>
        <i class="fa fa-plus fa-stack-1x fa-inverse"></i>
    </span>
    <!--Modal Del formulario de registro de Cuentas-->
    <div class="modal fade" id="ModalAccounts">
        <div class="modal-dialog modal-md" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h2 class="modal-title">Detalle Cuenta</h2>
                </div>
                <div class="modal-body clearfix" style="margin-bottom: 0; padding-top: 0 !important">
                    <input type="hidden" id="id_hiddengrupo" value="0" />
                    <div class=" row">
                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 sn-padding">
                            <h1 class="text-center">Niveles</h1>
                            <div class="list-group" id="listtreeaccount">
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="v_codigo" class="active">Codigo</label>
                                <input type="text" placeholder=" " class="form-control" id="v_codigo" maxlength="2" />
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="v_nombre" class="active">Nombre</label>
                                <input type="text" placeholder=" " class="form-control" id="v_nombre" />
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-3 col-sm-12 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="Inventario" class="active">Transaccional? </label>
                                <div class="check-mail">
                                    <input type="checkbox" class="i-checks pull-right" id="transaccional" />
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="cd_tipo" class="active">Tipo:</label>
                                <select runat="server" clientidmode="static" id="cd_tipo" class="form-control selectpicker" data-size="8">
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="row buttonaction pull-right">
                        <button title="Guardar" id="btnSave" data-option="I" class="btn btn-outline btn-primary dim waves-effect waves-light" type="button"><i class="fa fa-paste"></i></button>
                        <button title="Cancelar" id="btnCance" class="btn btn-outline btn-danger  dim waves-effect waves-light" data-dismiss="modal" aria-label="Close" type="button"><i class="fa-file-o fa"></i></button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="../Pages/ScriptsPage/Contabilidad/CNTCuentas.js?1"></script>
    <script>
        $(function () {
            $('.i-checks').iCheck({
                checkboxClass: 'icheckbox_square-green',
                radioClass: 'iradio_square-green',
            });
        })
    </script>
</asp:Content>
