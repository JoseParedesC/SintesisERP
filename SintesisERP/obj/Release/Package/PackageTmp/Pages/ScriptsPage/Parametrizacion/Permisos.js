$('#id_permiso').change(function () {
    var id = $('#id_permiso').val();
    window.gridpermiso.bootgrid('reload');
});

//Evento que se genera cuando el usuario pulsa click en el botón de guardar
$('#btnSave').click(function () {
    var xml = '';
    $.each($('.command-permiso'), function (i, e) {
        id = $(e).attr('data-row-id');
        xml += '<item id_menu="' + id + '" viewer="' + $('#checkview' + id).prop("checked") + '" created="' + $('#checkcrea' + id).prop("checked") + '" updated="' + $('#checkupda' + id).prop("checked") + '" deleter="' + $('#checkdele' + id).prop("checked") + '" />'
    });
    params.id = $('#id_permiso').val();
    params.xml = '<items>' + xml + '</items>';
    MethodService("Usuarios", "UsuariosPermisosSave", JSON.stringify(params), 'EndCallbackGet');
});
//Function para guardar la información en la base de datos
function EndCallbackGet(params, answer) {
    if (!answer.Error) {
        toastr.success("Proceso ejecutado exitosamente.", 'Sintesis ERP');
        LoadMenu();
        $('#id_permiso').val('0');
    } else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}

window.gridpermiso;
//Function para llenar la tabla de información
function LoadMenu() {
    window.gridpermiso = $("#tblpermisos").bootgrid({
        ajax: true,
        post: function () {
            return {
                'params': function () {
                    params = {};
                    params.id = ($('#id_permiso').val() == '') ? '0' : $('#id_permiso').val();
                    return JSON.stringify(params);
                },
                'class': 'Usuarios',
                'method': 'UsuariosPermisosMenu'
            };
        },
        navigation: false,
        url: window.appPath + "/Pages/Connectors/ConnectorList.ashx",
        formatters: {
            "view": function (column, row) {
                return "<div class='check-mail'><input id='checkview" + row.id_menu + "' " + ((!row.view == '0') ? "checked='checked'" : "") + ((row.modific == '0') ? "disabled='disabled'" : "") + "type='checkbox' class='i-checks' data-row-id='" + row.view + "'></div";
            },
            "creater": function (column, row) {
                return "<div class='check-mail'><input id='checkcrea" + row.id_menu + "'" + ((!row.crea == '0') ? "checked='checked'" : "") + ((row.modific == '0') ? "disabled='disabled'" : "") + "type='checkbox' class='i-checks' data-row-id='" + row.crea + "'></div";
            },
            "updater": function (column, row) {
                return "<div class='check-mail'><input id='checkupda" + row.id_menu + "'" + ((!row.updat == '0') ? "checked='checked'" : "") + ((row.modific == '0') ? "disabled='disabled'" : "") + "type='checkbox' class='i-checks' data-row-id='" + row.updat + "'></div";
            },
            "deleter": function (column, row) {
                return "<div class='check-mail'><input id='checkdele" + row.id_menu + "'" + ((!row.delet == '0') ? "checked='checked'" : "") + ((row.modific == '0') ? "disabled='disabled'" : "") + "type='checkbox' class='i-checks' data-row-id='" + row.delet + "'></div";
            },
            "menu": function (column, row) {
                if (row.modific == '1')
                    return "<a class=\"action command-permiso item-menu\" id='edit" + row.id + "' data-permiso=\"" + row.id + "\" data-row-id=\"" + row.id_menu + "\"><span>"+ row.menu +"</span></a>";
                else return "<a class=\"item-menu\" id='edit" + row.id + "' data-permiso=\"" + row.id + "\" data-row-id=\"" + row.id_menu + "\"><span>" + row.menu +"</span></a>";
            }
        }
    }).on("loaded.rs.jquery.bootgrid", function () {
        $('.i-checks').iCheck({
            checkboxClass: 'icheckbox_square-green'

        });
    });
}
$(document).ready(function () {
    LoadMenu();
});