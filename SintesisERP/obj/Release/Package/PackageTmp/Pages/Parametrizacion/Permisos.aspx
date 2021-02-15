<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Permisos.aspx.cs"
    Inherits="Permisos" MasterPageFile="~/Masters/SintesisMaster.Master" %>

<asp:Content ID="Content30" ContentPlaceHolderID="ContentPage" runat="server">
    <script type="text/javascript">
        window.appPath = "<%=Request.ApplicationPath%>";
    </script>
    <style>
        .ir-arriba {
            display: none;
            padding: 20px;
            background: #0074bc;
            font-size: 20px;
            color: #fff;
            cursor: pointer;
            position: fixed;
            bottom: 20px;
            right: 20px;
            z-index: 1;
            border-radius: 30%;
            height: 50px;
            width: 50px;
        }

        .item-menu {
            text-decoration: none;
            color: black;
            font-weight: bold;
        }

            .item-menu:hover {
                color: black;
            }
    </style>
    <div id="content">
        <div class="row" style="margin: 0px 10px;">
            <div class="x_panel">
                <div class="x_title">
                    <h1 class="title-master" style="margin-top: 0;"><span class="fa fa-bullhorn fa-fw"></span>Maestro Permisos</h1>
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>

        <div class="card" id="diventrada">
            <div class="row" style="margin: 0px 10px;">
                <div class="col-lg-3 col-md-3 col-sm-3 col-xs-12 sn-padding">
                    <div class="form-group">
                        <label for="Text_Nombre" class="active">Usuarios</label>
                        <div class="input-group ">
                            <input type="hidden" id="id_permiso" value="" />
                            <input type="text" class="form-control inputsearch" placeholder=" " readonly="readonly" id="user_permiso" aria-describedby="sizing-addon1" />
                            <span class="input-group-addon ">
                                <button id="Button2" type="button" class="btn btn-primary btnsearch" data-search="Usuarios" data-method="UsuariosList" data-title="Lista de usuarios" data-select="1,2" data-column="id,username,nombre" data-fields="id_permiso,user_permiso">
                                    <i class="fa fa-fw fa-search"></i>
                                </button>
                            </span>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-3 col-sm-3 col-xs-12 sn-padding pull-right">
                    <button title="Guardar" id="btnSave" class="btn btn-outline btn-primary dim  pull-right" type="button" style="margin-top: 15px; margin-bottom: 0 !important;">
                        <i class="fa fa-paste"></i>
                    </button>

                </div>
            </div>

            <div class="row" style="margin: 0px 10px;">
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding-top: 5px; padding-bottom: 15px; padding-left: 2px;">

                    <div class="table-responsive" style="max-height: 500px; min-height: 250px; overflow-y: auto">
                        <table class="table table-striped jambo_table" id="tblpermisos">
                            <thead>
                                <tr>
                                    <th data-column-id="menu" data-formatter="menu">Menu</th>
                                    <th data-column-id="view" data-formatter="view">READER</th>
                                    <th data-column-id="crea" data-formatter="creater">CREATER</th>
                                    <th data-column-id="updat" data-formatter="updater">UPDATED</th>
                                    <th data-column-id="delet" data-formatter="deleter">DELETE</th>
                                </tr>
                            </thead>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <span class="ir-arriba fa fa-sort-asc"></span>

    <script>
        $(document).ready(function () {

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
    <script src="../Pages/ScriptsPage/Parametrizacion/Permisos.js"></script>
</asp:Content>
