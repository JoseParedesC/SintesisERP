var JsonValidate = [{ id: 'cd_tipodoc', type: 'TEXT', htmltype: 'SELECT', required: true, depends: false, iddepends: '' },
{ id: 'codigoccostos', type: 'TEXT', htmltype: 'INPUT', required: false, depends: false, iddepends: '' },
{ id: 'Text_Fecha', type: 'DATE', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'cd_tipoter', type: 'WHOLE', htmltype: 'SELECT', required: true, depends: false, iddepends: '' },
{ id: 'ds_cliente', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'id_forma', type: 'WHOLE', htmltype: 'SELECT', required: true, depends: false, iddepends: '' },
{ id: 'ds_ctaant', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'cd_voucher', type: 'TEXT', htmltype: 'INPUT', required: false, depends: false, iddepends: '' },
{ id: 'descripcion', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' }];


window.griddocumentos;
$(document).ready(function () {
    newDocumento();
    $('#btnList').click(function () {
        if (window.griddocumentos === undefined) {
            window.griddocumentos = $("#tbldocumentos").bootgrid({
                ajax: true,
                post: function () {
                    return {
                        'params': "",
                        'class': 'Anticipos',
                        'method': 'AnticiposList'
                    };
                },
                url: window.appPath + "/Pages/Connectors/ConnectorList.ashx",
                formatters: {
                    "edit": function (column, row) {
                        return "<a class=\"action command-edit\" data-row-id=\"" + row.id + "\"><span class=\"fa-2x fa fa-eye iconfa\"></span></a>";
                    },
                    "total": function (column, row) {
                        return row.valor.Money();
                    }
                }
            }).on("loaded.rs.jquery.bootgrid", function () {
                // Executes after data is loaded and rendered 
                window.griddocumentos.find(".command-edit").on("click", function (e) {
                    id = $(this).data("row-id")
                    params = {};
                    params.id = id;
                    MethodService("Anticipos", "AnticiposGet", JSON.stringify(params), 'EndCallbackGet');
                })
            });
        }
        else
            window.griddocumentos.bootgrid('reload');

        $('#ModalDocumento').modal("show");
    });

    $('#btnPrint').click(function () {
        var id_documento = $('#id_documento').val();
        param = 'id|' + id_documento + ';'
        PrintDocument(param, 'MOVANTICIPO', 'CODE');
    });

	$('#btnRev').click(function () {
        if ($('#id_documento').val() != '0' && $('#id_documento').val().trim() != '') {
            if (confirm("Desea revertir el anticipo?")) {
                var sJon = {};
                sJon.id = ($('#id_documento').val().trim() == "") ? "0" : $('#id_documento').val();
                MethodService("Anticipos", "RevertirAnticipos", JSON.stringify(sJon), "CallbackReversion");
            }
        }
    });
    $('#btnnew').click(function () {
        newDocumento();
    });

    $('#btnSave').click(function () {
        if (validate(JsonValidate)) {
            if (SetNumber($('#m_cost').val()) > 0) {
                var sJon = {};
                sJon.id_tipodoc = $('#cd_tipodoc').val();
                sJon.id_centrocostos = ($('#id_ccostos').val() == "") ? '0' : $('#id_ccostos').val();
                sJon.fecha = SetDate($('#Text_Fecha').val());
                sJon.descripcion = $('#descripcion').val();
                sJon.id_tipoanticipo = $('#cd_tipoter').val();
                sJon.id_tercero = $('#cd_cliente').val();
                sJon.valor = SetNumber($('#m_cost').val());
                sJon.id_forma = $('#id_forma').val();
                sJon.voucher = $('#cd_voucher').val();
                sJon.idctaant = ($('#id_ctaant').val() == '') ? '0' : $('#id_ctaant').val();

                $('#btnSave').button('loading');
                MethodService("Anticipos", "FacturarAnticipos", JSON.stringify(sJon), "CallbackComodity");
            }
            else
                toastr.warning('El valor del anticipo no puede ser menor ni igual a 0.', 'Sintesis ERP');
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
        var valor = $(this).find('option:selected').attr('data-iden');
        $('#tipotercero1').val(valor);
        $('#ds_cliente').val('').attr('data-params', "op:T;o:" + valor).removeData('params').data('params');

    });
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

function EndCallbackGet(Parameter, Result) {
    if (!Result.Error) {
        var row = Result.Row;
        $('#btnPrint').removeAttr('disabled');
        if (row.estado == 'PROCESADO') {
            $('#btnSave').attr('disabled', 'disabled');
            $('#btnRev').removeAttr('disabled');
        }
        else {
            $('#btnSave, #btnRev').attr('disabled', 'disabled');
        }

        var div = $('#diventrada');
        div.find('[money], .btnsearch, input.form-control, select, textarea').attr('disabled', true);

        $(this).attr('data-option');
        $('#id_documento').val(row.id);
        $('.entradanumber').text(row.id);
        $('#Text_Fecha').val(row.fecha);
        $('#cd_tipodoc').val(row.id_tipodoc);
        $('#id_ccostos').val(row.id_centrocostos);
        $('#codigoccostos').val(row.centrocosto);
        $('#cd_cliente').val(row.id_tercero);
        $('#ds_cliente').val(row.tercero);
        $('#ds_ctaant').val(row.cuenta);
        $('#id_ctaant').val(row.id_cuenta);
        $('#descripcion').val(row.descripcion);
        $('#id_forma').val(row.id_formapago);
        $('#cd_tipoter').val(row.id_tipoanticipo);
        $('#m_cost').val(row.valor.Money());

        $('select').selectpicker('refresh');

        $('#ModalDocumento').modal('hide');
    }
    else {
        toastr.error(Result.Message, 'Sintesis ERP');
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
    $('#btnSave').button('reset'); 
    if (!Result.Error) {
        datos = Result.Row;
        $('.entradanumber').html(datos.id);
        $('#id_documento').val(datos.id);
        $('#btnSave').attr('disabled', 'disabled');
        $('#btnRev, #btnPrint').removeAttr('disabled');
        var div = $('#diventrada');
        div.find('[money], .addconcepto, select.selectpicker, .btnsearch, input.form-control, textarea').attr('disabled', true);
        div.find('select').selectpicker('refresh');
        toastr.success('Anticipo facturado.', 'Sintesis ERP');
    }
    else
        toastr.error(Result.Message, 'Sintesis ERP');
}
