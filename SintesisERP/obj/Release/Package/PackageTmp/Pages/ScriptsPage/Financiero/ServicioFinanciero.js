var JsonValidate = [{ id: 'codigo', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'nombre', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'ds_ctaant', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' }];


window.griddocumentos;
 
 
function Loadtable() {
    window.gritipoImp = $("#tbldocumentos").bootgrid({
        ajax: true,
        post: function () {
            return {
                'params': "",
                'class': "ServiciosFinanciero",
                'method': 'CNTServicioFinancieroList'
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
            MethodService("ServiciosFinanciero", "ServicioFinanGet", JSON.stringify(params), 'EndCallbackGet');

        }).end().find(".command-delete").on("click", function (e) {
            if (confirm("Desea eliminar el Tipo de impuesto?")) {
                id = $(this).data("row-id");
                params = {};
                params.id = id;
                MethodService("ServiciosFinanciero", "ServicioDelete", JSON.stringify(params), 'EndCallbackupdate');
            }
        });
    });
}

 
$(document).ready(function () {
    Loadtable();
});
 
  
    $('#btnnew').click(function () {
        newDocumento();
    });

    $('.iconnew').click(function (e) { //
        formReset();
        $('#ModalDocumento').modal({ backdrop: 'static', keyboard: false }, 'show');
    });


    $('#btnSave').click(function () {
        if (validate(JsonValidate)) {
            var sJon = {};
            sJon.id = $('#btnSave').attr('data-id');
            sJon.codigo = $('#codigo').val();
            sJon.nombre = $('#nombre').val();
            sJon.idctaant = ($('#id_ctaant').val() == '') ? '0' : $('#id_ctaant').val();

            var btn = $(this);
            btn.button('loading');
            MethodService("ServiciosFinanciero", "FinancieroSave", JSON.stringify(sJon), "EndCallbackFinan");
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

    $('#id_forma').change(function () {
        if ($("#id_documento").val() == '0') {
            var valores = $(this).find('option:selected').attr('data-voucher');
            JsonValidate[7].required = (valores.toUpperCase() == 'TRUE') ? true : false;
            $('#cd_voucher').val('');
            if (JsonValidate[7].required)
                $('#divvoucher').show();
            else
                $('#divvoucher').hide();
        }
    });

    $('#cd_tipoter').change(function () {
        $('#tipotercero1').val($(this).find('option:selected').attr('data-iden'));
    });
 

function newDocumento() {
    $('input.form-control, select, textarea').val('');
    $('[money]').val('0.00');
    fieldsMoney();
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
        $('#btnSave').attr('data-id', data.id);
        $('#codigo').val(data.codigo);
        $('#nombre').val(data.nombre);
        //$('#codigo').prop('disabled', true);
        $('#ds_ctaant').val(data.cuenta);
        $('#id_ctaant').val(data.id_cuenta);
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


function EndCallbackFinan(params, answer) {
    if (!answer.Error) {
        data = answer.Value;
        $('#btnSave').attr('data-id', data);
        toastr.success('Se guardo exitosamente', 'Sintesis ERP');
        window.gritipoImp.bootgrid('reload');
        $('#ModalDocumento').modal("hide");
       
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }

    $('#btnSave').button('reset');
}

function formReset() {
    div = $('#ModalDocumento');
    div.find('input.form-control, select').val('');
    $('select').selectpicker('refresh');
    $('#codigo').prop('disabled', false);
    $('#btnSave').attr('data-id', '0');
}