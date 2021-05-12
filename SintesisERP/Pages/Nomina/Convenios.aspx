<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Convenios.aspx.cs" Inherits="Convenios" MasterPageFile="~/Masters/SintesisMaster.Master" %>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPage" runat="server">
    <script type="text/javascript">
        window.appPath = "<%=Request.ApplicationPath%>";
    </script>

    <style>
        textarea {
            resize: none;
        }

        .fake-textarea {
            padding: .5rem;
            min-height: 3rem;
        }

            .fake-textarea:focus {
                border-color: #66afe9;
                outline: 0;
                -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233, .6);
                box-shadow: inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233, .6);
            }

            .fake-textarea::-moz-placeholder {
                color: #999;
                opacity: 1;
            }

            .fake-textarea:-ms-input-placeholder {
                color: #999;
            }

            .fake-textarea::-webkit-input-placeholder {
                color: #999;
            }

            .fake-textarea:empty::before {
                position: absolute !important;
                content: "Escribe aquí...";
            }

            .fake-textarea::after, .fake-textarea::before {
                box-sizing: border-box;
            }
    </style>

    <div class="row" style="margin: 0px 10px;">
        <div class="x_panel">
            <div class="x_title">
                <h1 class="title-master" style="margin-top: 0;"><span class="fa fa-bullhorn fa-fw"></span>Maestro Cargos</h1>
                <div class="clearfix"></div>
            </div>
        </div>
    </div>

    <div class="card" id="diventrada">
        <div class="row" style="margin: 0px 10px;">
            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                <div class="table-responsive ">
                    <table class="table table-striped jambo_table" id="tblcargo">
                        <thead>
                            <tr>
                                <th data-column-id="edit" data-formatter="edit" data-sortable="false" style="max-width: 30px !important;">Editar</th>
                                <th data-column-id="nombre">Nombre</th>
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
    <div class="modal fade" id="ModalCargo">
        <div class="modal-dialog modal-md" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h2 class="modal-title">Descripción del Cargo</h2>
                </div>

                <div class="modal-body clearfix" style="margin-bottom: 0; padding-top: 0 !important">
                    <div class="row">
                        <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="carnombre" class="active">Nombre:</label>
                                <input type="text" placeholder=" " class="form-control" id="carnombre" />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group sn-padding">
                            <label for="descripcion">Descripción:</label>
                            <textarea id="descripcion" class="form-control"></textarea>
                        </div>

                        <div class="form-group sn-padding">
                            <label for="funciones">Funciones:</label>
                            <div id="funciones" contenteditable class="fake-textarea"></div>
                        </div>
                    </div>
                    <br />
                    <input type="hidden" value="0" id="idcargo" />
                    <div class="row buttonaction pull-right">
                        <button title="Guardar" id="btnSave" data-option="I" class="btn btn-outline btn-primary dim waves-effect waves-light" type="button"><i class="fa fa-paste"></i></button>
                        <button title="Cancelar" id="btnCance" class="btn btn-outline btn-danger  dim waves-effect waves-light" data-dismiss="modal" aria-label="Close" type="button"><i class="fa-file-o fa"></i></button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%--</main>--%>
    <script src="../Pages/ScriptsPage/Nomina/Convenios.js?1"></script>

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
