var JsonValidate = [{ id: 'cd_tipodoc', type: 'TEXT', htmltype: 'SELECT', required: true, depends: false, iddepends: '' },
{ id: 'codigoccostos', type: 'TEXT', htmltype: 'INPUT', required: false, depends: false, iddepends: '' },
{ id: 'Text_Fecha', type: 'DATE', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'cd_tipoter', type: 'WHOLE', htmltype: 'SELECT', required: true, depends: false, iddepends: '' },
{ id: 'ds_cliente', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'ds_ctaant', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'id_forma', type: 'WHOLE', htmltype: 'SELECT', required: true, depends: false, iddepends: '' },
{ id: 'descripcion', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' }];

function newDocumento() {
    $('input.form-control, select, textarea,#tipotercero1').val('');
    $('[money]').val('0.00');
    fieldsMoney();
    datepicker();
    $('.entradanumber').html('0');
    $('#btnSave,#cd_tipodoc,#cd_tipoter,#m_cost,#id_forma').removeAttr('disabled');
    $('.btnsearch').removeAttr('disabled');
    $('#btnRev, #btnPrint').attr('disabled', 'disbled');
    $('#id_entrada,#cd_cliente,#id_ctaant').val('0');
    $('#cd_tipodoc,#cd_tipoter,#id_forma').val('').selectpicker('refresh');
    var div = $('.diventrada');
    div.find('[money], .btnsearch, select.selectpicker, input.form-control, textarea').removeAttr('disabled');
    div.find('select').selectpicker('refresh');
}

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
                        'method': 'DevAnticiposList'
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
                    MethodService("Anticipos", "DevAnticiposGet", JSON.stringify(params), 'EndCallbackGet');
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
        PrintDocument(param, 'MOVDEVANTICIPO', 'CODE');
    });

    $('#btnRev').click(function () {
        if ($('#id_documento').val() != '0' && $('#id_documento').val().trim() != '') {
            if (confirm("Desea revertir la dev de anticipo?")) {
                var sJon = {};
                sJon.id = ($('#id_documento').val().trim() == "") ? "0" : $('#id_documento').val();
                MethodService("Anticipos", "RevertirDevAnticipos", JSON.stringify(sJon), "CallbackReversion");
            }
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
                sJon.id_cliente = $('#cd_cliente').val();
                sJon.id_cta = $('#id_ctaant').val();
                sJon.id_forma = $('#id_forma').val();
                sJon.valor = SetNumber($('#m_cost').val());
                MethodService("Anticipos", "FacturarDevAnticipos", JSON.stringify(sJon), "CallbackComodity");
            }
            else
                toastr.warning('El valor del anticipo no puede ser menor ni igual a 0.', 'Sintesis POS');
        }
    });


    $('#cd_tipoter').change(function () {
        var valor = $(this).find('option:selected').attr('data-iden');
        $('#tipotercero1').val(valor);
        $('#ds_cliente').val('').attr('data-params', "op:T;o:" + valor).removeData('params').data('params');

    });


    $('.recalculo').change(function () {
        RecalcularFactura($(this));
    });

});

function RecalcularFactura(elemento) {
    var Parameter = {};
    Parameter.idToken = 0;
    Parameter.anticipo = 0;
    Parameter.id_cta = ($('#id_ctaant').val() == '' ? '0' : $('#id_ctaant').val());
    Parameter.id_cliente = ($('#cd_cliente').val() == '' ? '0' : $('#cd_cliente').val());
    Parameter.fecha = SetDate($('#Text_Fecha').val());
    Parameter.op = elemento.attr('data-op');
    Parameter.descuentoFin = '0'; //Modificado 28/01/2021
    MethodService("Facturas", "FacturasRecalcular", JSON.stringify(Parameter), "EndCallbackRecalculo");
}

function EndCallbackRecalculo(Parameter, Result) {
    if (!Result.Error) {
        Data = Result.Row;
        par = JSON.parse(Parameter);
        if (par.op == 'C' && Data.anticipo == 0)
            $('#m_cost').attr({ 'data-v-max': 0, 'disabled': 'disabled' }).val('0.00').autoNumeric('init');
        else
            $('#m_cost').attr('data-v-max', Data.anticipo).val(Data.anticipo.Money()).removeAttr('disabled').autoNumeric('init');

    }
    else {
        toastr.error(Result.Message, 'Sintesis ERP');
    }
}

function EndCallbackGet(Parameter, Result) {
    if (!Result.Error) {
        var row = Result.Row;
        $('#btnPrint').removeAttr('disabled');
        if (row.estado == 'TEMPORAL') {
            $('#btnSave,#cd_tipodoc,.btnsearch,#cd_tipoter,#m_cost,#id_forma').attr('disabled', 'disabled');
            $('#btnRev').removeAttr('disabled');
        }
        else {
            $('#btnSave, #btnRev').attr('disabled', 'disabled');
        }

        var div = $('.diventrada');
        div.find('[money], .btnsearch, input.form-control, select, textarea').attr('disabled', true);

        $(this).attr('data-option');
        $('#id_documento').val(row.id);
        $('.entradanumber').text(row.id);
        $('#Text_Fecha').val(row.fecha);
        $('#cd_cliente').val(row.id_tercero);
        $('#cd_tipoter').val(row.id_tipoanticipo).selectpicker('refresh');
        $('#ds_cliente').val(row.tercero);
        $('#descripcion').val(row.descripcion);
        $('#m_cost').val(row.valor.Money());
        $('#cd_tipodoc').val(row.id_tipodoc).selectpicker('refresh');
        $('#id_forma').val(row.id_formapago).selectpicker('refresh');
        $('#id_ccostos').val(row.id_centrocostos);
        $('#codigoccostos').val(row.centrocostos);
        $('#id_ctaant').val(row.id_cta);
        $('#ds_ctaant').val(row.cuenta);


        $('#ModalDocumento').modal('hide');
    }
    else {
        toastr.error(Result.Message, 'Sintesis POS');
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
        toastr.success('Anticipo Revertido.', 'Sintesis POS');
    }
    else
        toastr.error(Result.Message, 'Sintesis POS');
}

function CallbackComodity(Parameter, Result) {
    json = JSON.parse(Parameter);
    if (!Result.Error) {
        datos = Result.Row;
        $('.entradanumber').html(datos.id);
        $('#id_documento').val(datos.id);
        $('#btnSave,#cd_tipodoc,.btnsearch,#cd_tipoter,#m_cost,#id_forma').attr('disabled', 'disabled');
        $('#btnRev, #btnPrint').removeAttr('disabled');
        var div = $('.diventrada');
        div.find('[money], .addconcepto, select.selectpicker, .btnsearch, input.form-control, textarea').attr('disabled', true);
        div.find('select').selectpicker('refresh');
        toastr.success('Anticipo facturado.', 'Sintesis POS');
    }
    else
        toastr.error(Result.Message, 'Sintesis POS');
}
