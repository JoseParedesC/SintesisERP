<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Periodos.aspx.cs"
    Inherits="Periodos" MasterPageFile="~/Masters/SintesisMaster.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPage" runat="server">
    <script type="text/javascript">
        window.appPath = "<%=Request.ApplicationPath%>";
    </script>
    <style>
        @media (min-width:1200px) {
            .col-010{
                width: 10% !important;
            }
        }
       
        .checkf{
            margin-top: 7px;
        }
        .form-group {
            margin-bottom: 0;
        }

        #tblfecha-header .actionBar {
            display: none !important;
        }

        .datepicker-inline {
            width: auto !important;
        }

        .datepicker td, .datepicker th {
            width: 100px !important;
        }

        .datepicker table {
            width: 100%;
        }
    </style>
    <div class="row" style="margin-left: 0;">
        <div class="x_panel">
            <div class="x_title">
                <h1 class="title-master" style="margin-top: 0;"><span class="fa fa-calendar fa-fw"></span>Periodos</h1>
                <div class="clearfix"></div>
            </div>
        </div>
    </div>

    <div class="card" id="diventrada">
        <div class="row" style="margin: 0px 10px;">
            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 sn-padding">
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <div class="form-group">
                        <label for="Text_Periodo" class="active">Año Periodo:</label>
                        <div class="input-group ">
                            <input id="Text_Periodo" type="text" placeholder=" " class="form-control" current="true" date="true" format="YYYY" data-op="C" />
                            <span class="input-group-addon ">
                                <button id="refreshano" type="button" class="btn btn-primary">
                                    <i class="fa fa-fw fa-refresh"></i>
                                </button>
                            </span>
                        </div>
                    </div>
                </div>
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding-top: 5px; padding-bottom: 15px; padding-left: 2px;">
                    <div class="table-responsive " style="max-height: 350px;">
                        <table class="table table-striped jambo_table bootgrid-table" id="tblfecha">
                            <thead>
                                <tr>
                                    <th data-column-id="id" data-formatter="select" data-sortable="false">#</th>
                                    <th data-column-id="anomes" data-sortable="false">Añomes</th>
                                    <th data-column-id="id" data-formatter="state" data-sortable="false">Contabilidad</th>
                                    <th data-column-id="id" data-formatter="statein" data-sortable="false">Inventario</th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 sn-padding">
                <div class="form-group">
                    <label for="Text_Dia" class="active">Mes de Periodo:</label>
                    <input id="Text_Diastext" type="text" placeholder=" " class="form-control" disabled="disabled" />
                    <input type="hidden" id="valuedate" value="" />
                </div>
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 sn-padding" id="fechasstring" style="border: 1px solid #0094ff">                    
                </div>
                <div class="row buttonaction pull-right">
                    <button title="Guardar" id="btnSave" data-anomes="" class="btn btn-outline btn-primary dim waves-effect waves-light" type="button"><i class="fa fa-paste"></i></button>
                </div>
            </div>

        </div>
    </div>
    <%--</main>--%>
    <script type="text/javascript">
        $(function () {
            iddatepicker($('#Text_Periodo'));            
        });
    </script>
    <script src="../Pages/ScriptsPage/Seguridad/DiasFact.js"></script>
</asp:Content>
