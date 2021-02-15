<%@ Page Language="C#" ValidateRequest="false" AutoEventWireup="true" CodeBehind="index.aspx.cs"
    Inherits="index" MasterPageFile="~/Components/Masters/MasterPages.Master" %>

<asp:Content ID="Content3" ContentPlaceHolderID="MainLayout" runat="server">
    <div class="auth-layout-wrap" style="background-image: url(Images/sesion2.jpg)">
        <div class="auth-content">
            <div class="card o-hidden">
                <div class="row">
                    <div class="col-md-12">
                        <div class="p-4" style="margin-bottom: 10px;">
                            <div class="auth-logo text-center mb-30">
                                <img src="Images/SINTESIS_CLOUD_LOGO.png">
                            </div>
                            <h1 class="mb-3 text-18 text-center">Inicio de Sesión</h1>

                            <fieldset class="form-group text-12" id="__BVID__9">
                                <legend tabindex="-1" class="col-form-label pt-0" id="__BVID__9__BV_label_">Usuario</legend>
                                <div tabindex="-1" role="group">
                                    <asp:TextBox ID="Text_Username" name="Text_Username" runat="server" CssClass="form-control-rounded form-control" placeholder="Usuario"></asp:TextBox>
                                </div>
                            </fieldset>
                            <fieldset class="form-group text-12" id="__BVID__11">
                                <legend tabindex="-1" class="col-form-label pt-0" id="__BVID__11__BV_label_">Contraseña</legend>
                                <div tabindex="-1" role="group">
                                    <asp:TextBox ID="Text_Password" name="Text_Password" runat="server" TextMode="Password" CssClass="form-control-rounded form-control" placeholder="Contraseña"></asp:TextBox>
                                </div>
                            </fieldset>
                            <asp:Button ID="btnIniciar" Text="Ingresar" runat="server" CssClass="btn btn-rounded btn-block mt-2 btn-primary mt-2" OnClick="IniciarSesion_Click" />

                            <a href="/app/sessions/signUp" class="btn btn-rounded btn-primary mt-2 btn-block" target="_self">Recordar Contraseña</a>
                        </div>
                    </div>
                </div>
            </div>
            <asp:Literal ID="mensajescript" runat="server" Text=""></asp:Literal>
        </div>
    </div>

</asp:Content>
