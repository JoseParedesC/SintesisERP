var JsonValidate = [{ id: 'ds_name', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'ds_nit', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'ds_namecomercial', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'ds_address', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'ds_phone', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'ds_softid', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'ds_softpin', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'ds_softteckey', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' }];
window.gridtip;
function Loadtable() {
    window.gridtip = $("#tblempresas").bootgrid({
        ajax: true,
        rowCount: [50, 100, 150, 200],
        post: function () {
            return {
                'params': "",
                'class': 'Empresa',
                'method': 'EmpresasList'
            };
        },
        url: window.appPath + "/Pages/Connectors/ConnectorList.ashx",
        formatters: {
            "edit": function (column, row) {
                return "<a class=\"action command-edit\" data-row-id=\"" + row.id + "\"><span class=\"fa-2x fa fa-pencil iconfa\"></span></a>";
            },
            "range": function (column, row) {
                if (row.tipoambiente == "1") {
                    return "<a class=\"action command-range\" data-row-id=\"" + row.id + "\"><span class=\"fa fa-2x fa-retweet text-info iconfa\"></span></a>";
                }
                else
                    return "";
            }
        }
    }).on("loaded.rs.jquery.bootgrid", function () {
        // Executes after data is loaded and rendered 
        window.gridtip.find(".command-edit").on("click", function (e) {
            formReset();
            id = $(this).data("row-id")
            params = {};
            params.id = id;
            MethodService("Empresa", "EmpresasGet", JSON.stringify(params), 'EndCallbackGet');
        }).end().find(".command-range").on("click", function (e) {
            id = $(this).data("row-id");
            params = {};
            params.id = id;
            MethodService("Empresa", "EmpresasConsultarRango", JSON.stringify(params), 'EndCallbackRange');
        });
    });
}

$(document).ready(function () {
    $('.dropify').dropify({
        messages: {
            default: 'Arrastre un archivo o haga clic aquí',
            replace: 'Arrastre un archivo o haga clic para reemplazar',
            remove: 'Quitar',
            error: 'Lo sentimos, el archivo es demasiado grande'
        },
        error: {
            fileSize: 'El tamaño del archivo es muy grande ({{ value }} max).',
            minWidth: 'El ancho de la imagen es muy pequeño ({{ value }}}px min).',
            maxWidth: 'El ancho de la imagen es muy grande ({{ value }}}px max).',
            minHeight: 'La altura de la imagen es muy pequeña ({{ value }}}px min).',
            maxHeight: 'La altura de la imagen es muy grande ({{ value }}px max).',
            imageFormat: 'El formato de la imagen no esta permitido ({{ value }} solamente).',
            fileExtension: 'El archivo no es permitido ({{ value }} solamente).'
        }
    });
    Loadtable();

    $('#ds_nit').blur(function () {
        var dv = CalcularDv($(this).val());
        $('#ds_digverificacion').val(dv);
    });
});

function EndCallbackGetMail(params, answer) {
    if (!answer.Error) {
        $('#ModalMasive').modal('hide');
        toastr.success("Proceso se comenzo a ejecutar.", 'Sintesis Facturacion');
    }
    else {
        toastr.error(answer.Message, 'Sintesis Facturacion');
    }
}

$('.iconnew').click(function (e) {
    formReset();
    $('#ModalEmpresas').modal({ backdrop: 'static', keyboard: false }, 'show');
});

function formReset() {
    div = $('#ModalEmpresas');
    div.find('input.form-control, select').val('');
    div.find('select').selectpicker('refresh');
    $('#btnSave').attr('data-id', '0');
}


$('#btnSave').click(function (e) {
    if (validate(JsonValidate)) {
        var data = new FormData();
        var ds_fileUpload = $('#imgempresa').get(0);
        var ds_files = ds_fileUpload.files;
        for (var i = 0; i < ds_files.length; i++) {
            filename = ds_files[i].name;
            data.append(ds_files[i].name, ds_files[i]);
        }
        data.append("folder", 'Images');
        params = {};
        params.id = $(this).attr('data-id');
        params.razon = $('#ds_name').val();
        params.namecomercial = $('#ds_namecomercial').val();
        params.id_tipoid = $('#id_tipoid').val();
        params.nit = $('#ds_nit').val();
        params.digverificacion = $('#ds_digverificacion').val();
        params.ciudad = $('#id_city').val();
        params.direccion = $('#ds_address').val();
        params.telefono = $('#ds_phone').val();
        params.email = $('#ds_email').val();
        params.softid = $('#ds_softid').val();
        params.softpin = $('#ds_softpin').val();
        params.softtecnikey = $('#ds_softteckey').val();
        params.testid = $('#ds_testid').val();
        params.ambiente = $('#id_ambiente').val();
        params.carpeta = $('#ds_carpeta').val();
        params.certificate = $('#ds_certificate').val();
        params.passcertifi = $('#ds_passcertifi').val();
        var btn = $(this);
        btn.button('loading');
        MethodUploads("Empresa", "EmpresasSave", data, JSON.stringify(params), "EndCallbackEmpresa");
    }
});

function EndCallbackEmpresa(params, Result) {
    if (!Result.Error) {
        toastr.success("Empresa guardada.", 'Sintesis FE');
        window.gridtip.bootgrid('reload');
        $('#ModalEmpresas').modal('hide');
    }
    else {
        toastr.error(Result.Message, 'Sintesis FE');
    }
    $('#btnSave').button('reset');
}

function EndCallbackGet(params, answer) {
    if (!answer.Error) {
        data = answer.Row;
        $('#btnSave').attr('data-id', data.id);
        $('#ds_name').val(data.razonsocial);
        $('#ds_namecomercial').val(data.nombrecomercial);
        $('#id_tipoid').val(data.id_tipoid).selectpicker('refresh');
        $('#ds_nit').val(data.nit);
        $('#ds_digverificacion').val(data.digverificacion);
        $('#id_city').val(data.id_ciudad).selectpicker('refresh');
        $('#ds_address').val(data.direccion);
        $('#ds_phone').val(data.telefono);
        $('#ds_email').val(data.email);
        $('#ds_softid').val(data.softid);
        $('#ds_softpin').val(data.softpin);
        $('#ds_softteckey').val(data.softtecnikey);
        $('#ds_testid').val(data.testid);
        $('#id_ambiente').val(data.tipoambiente).selectpicker('refresh');
        $('#ds_carpeta').val(data.carpetaname);
        $('#ds_certificate').val(data.certificatename);
        $('#ds_passcertifi').val(data.passcertificate);
        $('#ModalEmpresas').modal({ backdrop: 'static', keyboard: false }, 'show');
    }
    else {
        toastr.error(answer.Message, 'Sintesis Facturacion');
    }
}

function EndCallbackRange(params, answer) {
    if (!answer.Error) {
        toastr.success("Consulta de rango exitosa.", 'Sintesis Facturacion');
        window.gridtip.bootgrid('reload');
    }
    else {
        toastr.error(answer.Message, 'Sintesis Facturacion');
    }
}

function EndCallbackupdate(params, answer) {
    if (!answer.Error) {
        toastr.success("Proceso ejecutado exitosamente.", 'Sintesis Facturacion');
        window.gridtip.bootgrid('reload');
    }
    else {
        toastr.error(answer.Message, 'Sintesis Facturacion');
    }
}
