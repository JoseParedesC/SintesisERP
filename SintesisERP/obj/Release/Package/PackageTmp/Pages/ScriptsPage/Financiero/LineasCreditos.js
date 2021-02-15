var JsonValidate = [{ id: 'codigo', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'id_iva', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'nombre', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'id_AccountBox1', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'txtporcentaje', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'TasaAnual', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'id_AccountBox3', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'id_AccountBox2', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'id_AccountBox4', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' }];

var JsonServicio = [{ id: 'id_forma', type: 'TEXT', htmltype: 'SELECT', required: true, depends: false, iddepends: '' },
{ id: 'Text_Porcentaje', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' }];

window.griddocumentos;

function Loadtable() {
    window.gritipoImp = $("#tbldocumentos").bootgrid({
        ajax: true,
        post: function () {
            return {
                'params': "",
                'class': "LineasCredito",
                'method': 'LineasCreditoList'
            };
        },
        url: window.appPath + "/Pages/Connectors/ConnectorList.ashx", //conecta los metodos con los controladores
        formatters: {
            "edit": function (column, row) {
                return "<a class=\"action command-edit\" data-row-id=\"" + row.id + "\"><span class=\"fa-2x fa fa-pencil iconfa\"></span></a>";
            },
            "delete": function (column, row) {
                return "<a class=\"action command-delete\" data-row-id=\"" + row.id + "\"><span class=\"fa fa-2x fa-trash-o text-danger iconfa\"></span></a>";
            }
        }
    }).on("loaded.rs.jquery.bootgrid", function () {
        // Executes after data is loaded and rendered 
        window.gritipoImp.find(".command-edit").on("click", function (e) {
            removeerror();
            id = $(this).data("row-id")
            params = {};
            params.id = id;
            MethodService("LineasCredito", "LineasCreditoGet", JSON.stringify(params), 'EndCallbackGet');

        }).end().find(".command-delete").on("click", function (e) {
            if (confirm("Desea eliminar la Lineas credito?")) {
                id = $(this).data("row-id");
                params = {};
                params.id = id;
                MethodService("LineasCredito", "LineasCreditoDelete", JSON.stringify(params), 'EndCallbackupdate');
            }
        });
    });
}

window.tableServicio;
function LoadtableService() {

    window.tableServicio = $("#tblServicios").bootgrid({
        ajax: true,
        post: function () {
            return {
                'params': function () {
                    param = { idlinecre: $('#btnSave').attr('data-id') }
                    return JSON.stringify(param)

                },
                'class': "LineasCredito",
                'method': 'servicioAndCreditoList'
            };
        },
        url: window.appPath + "/Pages/Connectors/ConnectorList.ashx", //conecta los metodos con los controladores
        formatters: {
            "edit": function (column, row) {
                return "<a class=\"action command-edit\" data-row-id=\"" + row.id + "\"><span class=\"fa-2x fa fa-pencil iconfa\"></span></a>";
            },
            "delete": function (column, row) {
                return "<a class=\"action command-delete\" data-row-id=\"" + row.id + "\"><span class=\"fa fa-2x fa-trash-o text-danger iconfa\"></span></a>";
            }
        }
    }).on("loaded.rs.jquery.bootgrid", function () {
        // Executes after data is loaded and rendered 
        window.tableServicio.find(".command-edit").on("click", function (e) {
            removeerror();
            id = $(this).data("row-id")
            params = {};
            params.id = id;
            MethodService("LineasCredito", "ServiciosCreditosGet", JSON.stringify(params), 'EndCallbackServiCreditoGet');

        }).end().find(".command-delete").on("click", function (e) {
            if (confirm("Desea eliminar la Lineas credito?")) {
                id = $(this).data("row-id");
                params = {};
                params.id = id;
                MethodService("LineasCredito", "ServiciosCreditosDelete", JSON.stringify(params), 'EndCallbackupdateServicios');
            }
        });
    });
}
$(document).ready(function () {
    Loadtable();
    $('#mostrar').hide();
});


$(document).ready(function () {
    LoadtableService();
});

$('#btnnew').click(function () {
    newDocumento();
});

$('.iconnew').click(function (e) {
    formReset();
    $('#ModalDocumento').modal({ backdrop: 'static', keyboard: false }, 'show');
});


$("#ISIva").click(function (event) {

    !(event.target.checked) ? $('#button2').prop('disabled', true) && $('#txtporcenIva').prop('disabled', true) && $('#button2').val('') && $('#id_iva').val('') && $('#txtporcenIva').val('') && $('#ISIvaIncluido').prop('disabled', true) : $('#button2').prop('disabled', false) && $('#txtporcenIva').prop('disabled', false) && $('#ISIvaIncluido').prop('disabled', false);

});


function formReset() {
    div = $('#ModalDocumento');
    div.find('input.form-control, select').val('');
    $('select').selectpicker('refresh');
    div.find('textarea').val('');
    $('#codigo').prop('disabled', false);
    $('#id_iva').val('');
    $('#id_ctaantCredito').val('');
    $('#id_ctaantIntCorri').val('');
    $('#id_ctaantIntMora').val('');
    $('#id_ctaantFianza').val('');
    $('#ISIva').prop('checked', false);
    $('#ISIvaIncluido').prop('checked', false);
    $('.i-checks').iCheck('update');
    $('#button2').prop('disabled', true);
    $('#txtporcenIva').prop('disabled', true);
    $('#ISIvaIncluido').prop('disabled', true)
    $('#btnSave').attr('data-id', '0');
    window.tableServicio.bootgrid('reload');
    $('#mostrar').hide();
}


$('#addServicio').click(function () {
    var id = $('#btnSave').attr('data-id');
    var idservi = $('#addServicio').attr('data-id');
    if (validate(JsonServicio)) {
        var Parameter = {};
        Parameter.id = id;
        Parameter.idservi = idservi;
        Parameter.servicio = $('#id_forma').val();
        Parameter.porcentaje = parseFloat(SetNumber($('#Text_Porcentaje').val()));
        MethodService("LineasCredito", "LineascreditoServicio", JSON.stringify(Parameter), "EndCallbackAddServicio");

    }
});

function EndCallbackServiCreditoGet(params, answer) {
    if (!answer.Error) {
        data = answer.Row;
        $('#addServicio').attr('data-id', data.id);
        $('#id_forma').val(data.id_financiero).selectpicker('refresh');
        $('#Text_Porcentaje').val(data.porcentaje);
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}

function EndCallbackAddServicio(Parameter, Result) {
    if (!Result.Error) {
        $('#addServicio').attr('data-id', 0);
        $('#Text_Porcentaje').val('');
        $('#id_forma').val(0).selectpicker('refresh');
        window.tableServicio.bootgrid('reload');
        toastr.success('Agregado Correctamente.', 'Sintesis ERP');


    }
    else {
        toastr.warning(Result.Message, 'Sintesis ERP');
    }
}


$('#btnSave').click(function () {
    if (validate(JsonValidate)) {
        var sJon = {};
        sJon.id = $('#btnSave').attr('data-id');
        sJon.codigo = $('#codigo').val();
        sJon.nombre = $('#nombre').val();
        sJon.ISIva = $('#ISIva').prop('checked');
        sJon.ISIvaIncluido = $('#ISIvaIncluido').prop('checked');
        sJon.porcenIva = parseFloat(SetNumber($('#txtporcenIva').val()));
        sJon.porcentaje = parseFloat(SetNumber($('#txtporcentaje').val()));
        sJon.TasaAnual = parseFloat(SetNumber($('#TasaAnual').val()));
        sJon.id_iva = $('#id_iva').val() != '' ? $('#id_iva').val() : 0;
        sJon.id_ctaantCredito = ($('#id_ctaantCredito').val() == '') ? '0' : $('#id_ctaantCredito').val();
        sJon.id_ctaantIntCorri = ($('#id_ctaantIntCorri').val() == '') ? '0' : $('#id_ctaantIntCorri').val();
        sJon.id_ctaantIntMora = ($('#id_ctaantIntMora').val() == '') ? '0' : $('#id_ctaantIntMora').val();
        sJon.id_ctaantFianza = ($('#id_ctaantFianza').val() == '') ? '0' : $('#id_ctaantFianza').val();


        var btn = $(this);
        btn.button('loading');
        MethodService("LineasCredito", "LineasCreditosSave", JSON.stringify(sJon), "EndCallbackFinan");
    }

});

$('#cd_tipodoc').change(function () {
    if ($("#id_documento").val() == '0') {
        var valores = $(this).find('option:selected').attr('data-centro');
        var split = valores.split('|~|');
        $('#id_ccostos').val(split[1]);
        $('#codigoccostos').val(split[2]);
    }

    JsonValidate[1].required = (split[0] == '1') ? true : false;
});



$('#cd_tipoter').change(function () {
    $('#tipotercero1').val($(this).find('option:selected').attr('data-iden'));
});


function newDocumento() {
    $('input.form-control, select, textarea').val('');
    $('[money]').val('0.00');
    fieldsMoney();
    $('#mostrar').hide();
    datepicker();
    $('.entradanumber').html('0');
    $('#btnSave').removeAttr('disabled');
    $('#btnRev, #btnPrint').attr('disabled', 'disbled');
    $('#id_documento').val('0');
    var div = $('#diventrada');
    div.find('[money], .btnsearch, select.selectpicker, input.form-control, textarea').removeAttr('disabled');
    div.find('select').selectpicker('refresh');
}

function EndCallbackGet(params, answer) {
    if (!answer.Error) {
        data = answer.Row;
        console.log(data)
        $('#btnSave').attr('data-id', data.id);
        $('#codigo').val(data.codigo);
        $('#nombre').val(data.nombre);
        $('#TasaAnual').val(data.Tasaanual);
        $('#txtporcenIva').val(data.porcenIva);
        $('#codigo').prop('disabled', true);
        $('#ISIva').prop('checked', data.Estado);
        $('#ISIvaIncluido').prop('checked', data.Incluido);
        $('#id_iva').val(data.id_ctaiva);
        $('#txtporcentaje').val(data.Porcentaje);
        $('#button2').val(data.iva);

        $('#id_AccountBox2').val(data.CuentaCorriente);
        $('#id_ctaantIntCorri').val(data.id_ctaintcorriente);

        $('#id_AccountBox1').val(data.CuentaCredito);
        $('#id_ctaantCredito').val(data.id_ctacredito);

        $('#id_AccountBox3').val(data.CuentaMora);
        $('#id_ctaantIntMora').val(data.id_ctamora);

        $('#id_AccountBox4').val(data.CuentaFianza);
        $('#id_ctaantFianza').val(data.id_ctaantFianza);

        $('#mostrar').show();

        window.gritipoImp.bootgrid('reload');
        window.tableServicio.bootgrid('reload');
        $('#ModalDocumento').modal({ backdrop: 'static', keyboard: false }, 'show');

    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}


function CallbackReversion(Parameter, Result) {
    json = JSON.parse(Parameter);
    if (!Result.Error) {
        datos = Result.Row;
        $('.entradanumber').html(datos.id);
        $('#id_documento').val(datos.id);
        $('#btnSave, #btnRev').attr('disabled', 'disabled');
        var div = $('.diventrada');
        div.find('[money], .btnsearch, input.form-control, textarea').attr('disabled', true);
        toastr.success('Anticipo Revertido.', 'Sintesis ERP');
    }
    else
        toastr.error(Result.Message, 'Sintesis ERP');
}

function CallbackComodity(Parameter, Result) {
    json = JSON.parse(Parameter);
    if (!Result.Error) {
        datos = Result.Row;
        $('.entradanumber').html(datos.id);
        $('#id_documento').val(datos.id);
        $('#btnSave').attr('disabled', 'disabled');
        $('#btnRev, #btnPrint').removeAttr('disabled');
        var div = $('#diventrada');
        div.find('[money], .addconcepto, select.selectpicker, .btnsearch, input.form-control, textarea').attr('disabled', true);
        div.find('select').selectpicker('refresh');
        toastr.success('Servicio Guardado.', 'Sintesis ERP');
    }
    else
        toastr.error(Result.Message, 'Sintesis ERP');
}


function EndCallbackupdate(params, answer) {
    if (!answer.Error) {
        window.gritipoImp.bootgrid('reload');
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}


function EndCallbackupdateServicios(params, answer) {
    if (!answer.Error) {
        window.tableServicio.bootgrid('reload');
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}

function EndCallbackFinan(params, answer) {
    if (!answer.Error) {
        data = answer.Value;
        $('#btnSave').attr('data-id', data);
        toastr.success('Se guardo exitosamente', 'Sintesis ERP');
        window.gritipoImp.bootgrid('reload');
        $('#mostrar').show();
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }

    $('#btnSave').button('reset');
}
