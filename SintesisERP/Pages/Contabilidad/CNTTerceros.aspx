<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CNTTerceros.aspx.cs" Inherits="CNTTerceros" MasterPageFile="~/Masters/SintesisMaster.Master" %>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPage" runat="server">
    <script type="text/javascript">
        window.appPath = "<%=Request.ApplicationPath%>";
    </script>

    <div class="row" style="margin: 0px 10px;">
        <div class="x_panel">
            <div class="x_title">
                <h1 class="title-master" style="margin-top: 0;"><span class="fa fa-bullhorn fa-fw"></span>Maestro Terceros</h1>
                <div class="clearfix"></div>
            </div>
        </div>
    </div>

    <div class="card" id="diventrada">
        <div class="row" style="margin: 0px 10px;">
            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                <div class="table-responsive ">
                    <table class="table table-striped jambo_table" id="tbltipo">
                        <thead>
                            <tr>
                                <th data-column-id="edit" data-formatter="edit" data-sortable="false" style="max-width: 30px !important;">Editar</th>
                                <th data-column-id="iden">Identificación</th>
                                <th data-column-id="tercero">Nombre</th>
                                <th data-column-id="estado" data-formatter="state" data-sortable="false" style="max-width: 30px">Estado</th>
                                <th data-column-id="delete" data-formatter="delete" data-sortable="false" style="max-width: 30px">Eliminar</th>
                            </tr>
                        </thead>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <span class="fa-stack fa-lg pull-right goTop iconnew">
        <i class="fa fa-circle fa-stack-2x"></i>
        <i class="fa fa-plus fa-stack-1x fa-inverse"></i>
    </span>
    <!--Modal Del formulario de registro de Cuentas-->
    <div class="modal fade" id="ModalThirds">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h2 class="modal-title">Detalle Tercero</h2>
                </div>

                <div class="modal-body clearfix" style="margin-bottom: 0; padding-top: 0 !important">
                    <div class="row">
                        <div class="col-lg-3 col-md-3 col-sm-12 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="cd_tipoterce" class="active">Tipo de Tercero:</label>
                                <select runat="server" clientidmode="static" id="cd_tipoterce" class="form-control selectpicker" data-size="8" multiple title="Tipo">
                                </select>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-3 col-sm-12 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="pn_type" class="active">Tipo de Persona</label>
                                <select runat="server" clientidmode="static" id="pn_type" data-size="8" class="form-control selectpicker" title="Tipo">
                                </select>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-3 col-sm-12 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="cd_catfiscal" class="active">Categoria fiscal</label>
                                <select runat="server" clientidmode="static" id="cd_catfiscal" data-size="8" class="form-control selectpicker" title="Categoria" data-live-search="true">
                                </select>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-3 col-sm-12 sn-padding" style="padding-right: 0px">
                            <div class="form-group">
                                <label for="esReponsable" class="active">Es Reponsable de IVA?</label>
                                <div class="check-mail">
                                    <input type="checkbox" class="i-checks pull-right" id="esReponsable" value="P" />
                                </div>
                            </div>
                        </div>

                    </div>
                    <div class="row">
                        <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="cd_type" class="active">Tipo de Identificación</label>
                                <select runat="server" clientidmode="static" id="cd_type" data-size="8" class="form-control selectpicker" title="Tipo" data-live-search="true">
                                </select>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="cd_identification" class="active">Identificación</label>
                                <input type="text" placeholder=" " class="form-control" id="cd_identification" maxlength="50" />
                            </div>
                        </div>
                        <div class="col-lg-1 col-md-1 col-sm-4 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="dig_verif" class="active">Dig.Verifi</label>
                                <input type="text" placeholder=" " class="form-control" id="dig_verif" maxlength="1" disabled="disabled" />
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="fecha_exp" class="active">Fec Expedicion:</label>
                                <input id="fecha_exp" type="text" placeholder=" " class="form-control" current="true" date="true" format="YYYY-MM-DD" max="true" min="1800-01-01" />
                            </div>
                        </div>
                    </div>
                    <div class=" row">
                        <div id="isnatural">
                            <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12 sn-padding">
                                <div class="form-group">
                                    <label for="v_firstname" class="active">Primer Nombre</label>
                                    <input name="v_firstname" type="text" placeholder=" " class="form-control" id="v_firstname" maxlength="50" />
                                </div>
                            </div>
                            <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12 sn-padding">
                                <div class="form-group">
                                    <label for="v_secondname" class="active">Segundo Nombre</label>
                                    <input type="text" placeholder=" " class="form-control" id="v_secondname" maxlength="50" />
                                </div>
                            </div>
                            <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12 sn-padding">
                                <div class="form-group">
                                    <label for="v_surname" class="active">Primer Apellido</label>
                                    <input type="text" placeholder=" " class="form-control" id="v_surname" maxlength="50" />
                                </div>
                            </div>
                            <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12 sn-padding">
                                <div class="form-group">
                                    <label for="v_secondsurname" class="active">Segundo Apellido</label>
                                    <input type="text" placeholder=" " class="form-control" id="v_secondsurname" maxlength="50" />
                                </div>
                            </div>
                        </div>
                        <div id="isJuridica" style="display: none">
                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 sn-padding">
                                <div class="form-group">
                                    <label for="v_razonsocial" class="active">Razon Social</label>
                                    <input name="v_razonsocial" type="text" placeholder=" " class="form-control" id="v_razonsocial" maxlength="50" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="cd_city" class="active">Ciudad</label>
                                <select runat="server" clientidmode="static" id="cd_city" data-size="8" class="form-control selectpicker" title="Ciudad" data-live-search="true">
                                </select>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="v_phone" class="active">Teléfono</label>
                                <input type="text" placeholder=" " class="form-control" id="v_phone" maxlength="20" />
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="v_cellphone" class="active">Celular</label>
                                <input type="text" placeholder=" " class="form-control" id="v_cellphone" maxlength="20" />
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="fecha_naci" class="active">Fec Nacimiento:</label>
                                <input id="fecha_naci" type="text" placeholder=" " class="form-control"  current="true" date="true" format="YYYY-MM-DD"/>
                            </div>
                        </div>
                    </div>
                    <div class="row">

                        <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="v_address" class="active">Dirección</label>
                                <input type="text" placeholder=" " class="form-control" id="v_address" maxlength="100" />
                            </div>
                        </div>
                        <div class=" col-sm-6 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="email" class="active">Email</label>
                                <input type="email" placeholder=" " class="form-control" id="email" maxlength="100" />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="cd_sucursal" class="active">Sucursal</label>
                                <input type="text" placeholder=" " class="form-control" id="cd_sucursal" maxlength="50" />
                            </div>
                        </div>
                        <div class="col-lg-5 col-md-5 col-sm-6 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="cd_nombrecomercial" class="active">Nombre comercial</label>
                                <input type="text" placeholder=" " class="form-control" id="cd_nombrecomercial" maxlength="50" />
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="cd_webpage" class="active">Pagina web</label>
                                <input type="text" placeholder=" " class="form-control" id="cd_webpage" maxlength="80" />
                            </div>
                        </div>
                    </div>
                    <div class="row ">
                        <fieldset>

                            <h2 class="modal-title">Datos de Contacto</h2>
                            <!-- <legend style="font-weight: bold; text-align: left;">
                                Datos de Contacto
                            </legend>-->

                            <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12 sn-padding">
                                <div class="form-group">
                                    <label for="nombrecontacto" class="active">Nombre Completo</label>
                                    <input name="nombrecontacto" type="text" placeholder=" " class="form-control" id="nombrecontacto" maxlength="200" />
                                </div>
                            </div>
                            <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12 sn-padding">
                                <div class="form-group">
                                    <label for="telefonocontacto" class="active">Telefono</label>
                                    <input type="text" placeholder=" " class="form-control" id="telefonocontacto" maxlength="20" />
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 sn-padding">
                                <div class="form-group">
                                    <label for="emailcont" class="active">Email</label>
                                    <input type="email" placeholder=" " class="form-control" id="emailcont" maxlength="100" />
                                </div>
                            </div>
                        </fieldset>
                    </div>
                    <div class="row buttonaction pull-right">
                        <button title="Guardar" id="btnSave" data-option="I" class="btn btn-outline btn-primary dim waves-effect waves-light" type="button"><i class="fa fa-paste"></i></button>
                        <button title="Cancelar" id="btnCance" class="btn btn-outline btn-danger  dim waves-effect waves-light" data-dismiss="modal" aria-label="Close" type="button"><i class="fa-file-o fa"></i></button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%--</main>--%>
    <script src="../Pages/ScriptsPage/Contabilidad/CNTTerceros.js?1"></script>
    <script>
        $(function () {
            $('select').selectpicker();
            $('.i-checks').iCheck({
                checkboxClass: 'icheckbox_square-green',
                radioClass: 'iradio_square-green',
            });
            datepicker();
        })
    </script>
</asp:Content>
