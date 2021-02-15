<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CierreCaja.aspx.cs"
    Inherits="CierreCaja" MasterPageFile="~/Masters/SintesisMaster.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPage" runat="server">
    <script type="text/javascript">
        window.appPath = "<%=Request.ApplicationPath%>";
    </script>
    <style>
        .form-group {
            margin-bottom: 0;
        }
    </style>
    <div class="wrapper wrapper-content" style="padding-top: 5px; background: #fff !important;">
        <div class="row" style="margin-left: 0;">
            <div class="x_panel">
                <div class="x_title">
                    <h1 class="title-master" style="margin-top: 0;"><span class="fa fa-bullhorn fa-fw"></span>Cierre de Caja</h1>
                    <div class="clearfix"></div>
                </div>
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding-top: 5px; padding-bottom: 15px; padding-left: 2px;">
                    <div class="table-responsive " style="max-height: 250px;">
                        <table class="table table-striped jambo_table bootgrid-table" id="tblcajas">
                            <thead>
                                <tr>
                                    <th data-column-id="caja">Caja</th>
                                    <th data-column-id="userapertura">Usuario de Apertura</th>
                                    <th data-column-id="fechaapert">Fecha de Apertura</th>
                                    <th data-column-id="estado" data-formatter="state" data-sortable="false">Estado</th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="../Pages/ScriptsPage/Seguridad/CierreCaja.js"></script>
</asp:Content>
