var JsonValidate = [{ id: 'iden', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'ds_factura', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'id_asesores', type: 'TEXT', htmltype: 'SELECT', required: true, depends: false, iddepends: '' },
{ id: 'asunto', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'tipoact', type: 'TEXT', htmltype: 'SELECT', required: true, depends: false, iddepends: '' },
{ id: 'Text_FechaI', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'Text_FechaF', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'motivo', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' }];

window.gridclientes;
window.gridfacturas;
window.gridcuovenci;
window.gridcuocance;
window.gridcodeudor;
window.gridproducto;
var id_Cliente = 0;

function Loadtable() {

    window.gridcodeudor = $("#tblcodeudor").bootgrid({
        rowCount: -1,
        navigation: 0,
        columnSelection: false
    });


    window.gridproducto = $("#tblproducto").bootgrid({
        rowCount: -1,
        navigation: 0,
        columnSelection: false,
        formatters: {
            "valor": function (column, row) {
                return row[column.id].Money();
            }
        }
    });


    window.gridfacturas = $("#tblfacturas").bootgrid({
        rowCount: -1,
        navigation: 0,
        columnSelection: false,
        formatters: {
            "ver": function (column, row) {
                return "<a class=\"action command-ver changeact\" data-tipofac=\"" + row.TIPOFACT + "\" data-numfac=\"" + row.NUMEFAC + "\"><span class=\"fa fa-2x fa-eye text-info iconfa\"></span></a>";
            },
            "valor": function (column, row) {
                return row[column.id].Money();
            }
        }
    }).on("loaded.rs.jquery.bootgrid", function () {
        window.gridfacturas.find(".command-ver").on("click", function (e) {
            var drDestroy = window.gridcuovenci.data('.rs.jquery.bootgrid');
            drDestroy.clear()
            drDestroy = window.gridcuocance.data('.rs.jquery.bootgrid');
            drDestroy.clear()
            $('.cuotasfac').show();
            tipofac = $(this).data("tipofac");
            params = {};
            params.idC = $('#cd_cliente').val();
            params.numefac = $(this).attr('data-numfac');
            MethodService("ClientesGestion", "ClientesGestionGetCuotas", JSON.stringify(params), 'EndCallbackGetCuotas');
        });
    });

    window.gridcuovenci = $("#tblcuovencidas").bootgrid({
        rowCount: -1,
        navigation: 0,
        columnSelection: false,
        formatters: {
            "valor": function (column, row) {
                return row[column.id].Money();
            },
            "debe": function (column, row) {
                var state = '';
                if (row.estado == 1)
                    state = 'statecuotawarning';
                else if (row.estado == 2)
                    state = 'statecuotaerror';
                else
                    state = 'statecuotasuccess';

                return '<span class="stateclientcuota ' + state + '">' + row[column.id].Money() + '</span>';
            },
            "interes": function (column, row) {
                return '<span style="font-weight: bold;">' + row[column.id].Money() + '</span>';
            }
        }
    });

    window.gridcuocance = $("#tblcuocanceladas").bootgrid({
        rowCount: -1,
        navigation: 0,
        columnSelection: false,
        formatters: {
            "valor": function (column, row) {
                return row[column.id].Money();
            }
        }
    });
}


$(document).ready(function () {
    Loadtable();

    $('#cd_cliente').change(function () {
        if ($(this).val() == "" | $(this).val() == undefined) {
            ResetForm()
        } else {
            param = {};
            param.idC = $(this).val();
            id_Cliente = $(this).val();

            $(this).closest('table').find('tr').removeClass('rowselection');
            $(this).closest('tr').addClass('rowselection');
            $('.cuotasfac').hide();
            if (window.gridcuovenci == true) {
                var drDestroy = window.gridcuovenci.data('.rs.jquery.bootgrid');
                drDestroy.clear()
            }

            if (window.gridcuocance == true) {
                drDestroy = window.gridcuocance.data('.rs.jquery.bootgrid');
                drDestroy.clear()
            }
            MethodService('ClientesGestion', 'ClientesGestionGet', JSON.stringify(param), 'EndCallbackTerceros');
        }
    });


    $('#noneclientes').click(function () {
        $(".tablaclients").toggleClass('noneclient');
        if ($('.tablaclients').is(':visible')) {
            $('#dataclient').removeClass('col-lg-12');
            $('#dataclient').addClass('col-lg-8 col-md-8 col-sm-7');
        }
        else {
            $('#dataclient').removeClass('col-lg-8 col-md-8 col-sm-7');
            $('#dataclient').addClass('col-lg-12');
        }
    });
    $('#btnChangestate').click(function () {
        $('#ModalChangeState').modal({ backdrop: 'static', keyboard: false }, 'show');
    });
    $('#programer').on('ifChecked', function (event) {
        $('.programdate').show();
        if ($('.spanact.active').attr('data-type') == 'visit' || $('.spanact.active').attr('data-type') == 'inmov') {
            $('.asigned').show();
        }
    }).on('ifUnchecked', function () {
        $('.programdate, .asigned').hide();
    });

    $('.spanact').click(function () {
        if (($(this).attr('data-type') == 'visit' || $(this).attr('data-type') == "inmov") && $('#programer').prop('checked')) {
            $('.asigned').show();
        }
        else
            $('.asigned').hide();

        $('.spanact').removeClass('active');
        $(this).addClass('active');
    });

    $('#btnSearchClient').click(function () {
        window.gridclientes.bootgrid('reload');
        toggleCC();
    });
});
$('#btnnew').click(function () {
    var type = $('.spanact.active').attr('data-type');
    var fecha = $('#ds_fechapro').val();
    var programer = $('#programer').prop('checked');
    var descripcion = $('#descripcion').val();
    var cliente = $('#cd_cliente').val();
    if ((type == undefined || fecha == '') && programer) {
        toastr.warning('Verifique tipo de programación o fecha de programación.', 'Sintesis Gestion Cartera');
    }
    else if (cliente == '0') {
        toastr.warning('Seleccione un cliente.', 'Sintesis Gestion Cartera');
    }
    else if (descripcion == '') {
        toastr.warning('Escriba el seguimiento.', 'Sintesis Gestion Cartera');
    }
    else {
        params = {};
        params.id_cliente = cliente;
        params.type = (type == undefined) ? '' : type;
        if ($('#programer').prop('checked')) {
            fecha = $('#ds_fechapro').val();
        } else {
            fecha = null;
        }
        params.fecha = fecha;
        params.descripcion = descripcion;
        params.programer = programer;
        params.iden = $('#iden').val();
        var btn = $(this);
        btn.button('loading');
        MethodService("ClientesGestion", "ClienteGestionSaveBitacora", JSON.stringify(params), "EndCallbackBitacora");
    }
});

function EndCallbackBitacora(params, answer) {
    var list = answer.Table;
    if (!answer.Error) {
        $('#descripcion').val('');
        $('#id_uservisit').val('0').selectpicker('refresh');
        $('#programer').prop('checked', false).iCheck('update');
        toastr.success('Proceso Exitoso.', 'Sintesis ERP');
        $('#myTimeline').albeTimeline(list, {
            language: 'es-ES',
            showGroup: false,
            formatDate: 'd de MMMM de yyyy HH:mm:ss'
        });

        $('.spanact').removeClass('active');
        $('.programdate').hide();
        $('.asigned').hide();
    }
    else {
        toastr.error(answer.Message, 'Sintesis Creditos');
    }

    $('#btnnew').button('reset');
}


function EndCallbackTerceros(param, answer) {
    if (!answer.Error) {
        data = answer.Row;
        $('#cliente').val(data.cliente);
        $('#iden').val(data.iden);
        $('#tipoiden').val(data.tipoiden);
        $('#direccion').val(data.ciudad + ' - ' + data.direccion);
        $('#telefono').val(data.telefono);
        $('#celular').val(data.celular);
        $('#intmoravalor').text(data.porintmora);
        $('#myTimeline').albeTimeline(answer.Tseguiz, {
            language: 'es-ES',
            showGroup: false,
            formatDate: 'd de MMMM de yyyy HH:mm:ss'
        });

        var drDestroy = window.gridfacturas.data('.rs.jquery.bootgrid');
        drDestroy.clear();
        drDestroy.append(answer.Table2);
        drDestroy = window.gridcodeudor.data('.rs.jquery.bootgrid');
        drDestroy.clear();
        drDestroy.append(answer.Table);

    } else {
        toastr.error(answer.Message + 'Sintesis ERP');
    }
}

function EndCallbackGet(Parameter, Result) {
    if (!Result.Error) {
        var row = Result.Row;

        var drDestroy = window.gridfacturas.data('.rs.jquery.bootgrid');
        drDestroy.clear();
        drDestroy.append(Result.Table2);
        drDestroy = window.gridcodeudor.data('.rs.jquery.bootgrid');
        drDestroy.clear();
        drDestroy.append(Result.Table);
    }
    else {
        toastr.error(Result.Message, 'AASintesis ERP');
    }
}

function EndCallbackGetCuotas(Parameter, Result) {

    if (!Result.Error) {

        var drDestroy = window.gridcuovenci.data('.rs.jquery.bootgrid');
        drDestroy.clear();
        drDestroy.append(Result.Table);
        $('#cuoven').html('#' + Result.Table.length);


        drDestroy = window.gridcuocance.data('.rs.jquery.bootgrid');
        drDestroy.clear();
        drDestroy.append(Result.Table1);
        $('#cuocan').html('#' + Result.Table1.length);


        drDestroy = window.gridproducto.data('.rs.jquery.bootgrid');
        drDestroy.clear();
        drDestroy.append(Result.Table2);
        $('#producto').html('#' + Result.Table2.length);

    }
    else {
        toastr.error(Result.Message, 'Sintesis ERP');
    }
}


function formReset() {
    div = $('#ModalProviders');
    div.find('input.form-control').val('');
    div.find('textarea').val('');
    div.find('select').val('').selectpicker('refresh');
    $('#btnSave').attr('data-id', '0');
}


function toggleCC() {
    var fd = $('.fold');
    var fc = $('.tableclients, #tblClientes-header, #tblClientes-footer');
    if (fd.is(':visible')) {
        fd.slideUp();
        fc.slideDown();
    }
    else {
        fd.slideDown();
        fc.slideUp();
    }
}

$('#btnSave').click(function (e) {
    if (validate(JsonValidate)) {
        params = {};
        params.id = $(this).attr('data-id');
        params.id_cliente = $('#iden').val();
        params.factura = $('#cd_factura').val();
        params.id_tipoact = $('#tipoact').val();
        params.asunto = $('#asunto').val();
        params.fechaini = SetDate($('#Text_FechaI').val());
        params.fechafin = SetDate($('#Text_FechaF').val());
        params.motivo = $('#motivo').val();
        params.tipofac = '';
        var btn = $(this);
        btn.button('loading');
        MethodService("Actividades", "ActividadesSave", JSON.stringify(params), "EndCallbackActividades");
    }
});

function EndCallbackActividades(Parameter, Result) {
    json = JSON.parse(Parameter);
    if (!Result.Error) {
        toastr.success('Actividad Programada.', 'Sintesis ERP');
        $("#ModalDocumento").modal('hide');
    }
    else
        toastr.error(Result.Message, 'Sintesis ERP');

    $('#btnSave').button('reset');
}

function EndCallbackProviders(params, answer) {
    if (!answer.Error) {
        $('#ModalProviders').modal("hide");
        window.gridprovee.bootgrid('reload');
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }

    $('#btnSave').button('reset');
}

function EndCallbackGet2(params, answer) {
    if (!answer.Error) {
        data = answer.Row;
        $('#btnSave').attr('data-id', data.id);
        $('#cd_type').val(data.id_tipo).selectpicker('refresh');
        $('#cd_city').val(data.id_ciudad).selectpicker('refresh');
        $('#v_businessname').val(data.razonsocial);
        $('#v_nit').val(data.nit);
        $('#v_digitverification').val(data.digverificacion);
        $('#v_activityeconomic').val(data.acteconomica);
        $('#v_address').val(data.direccion);
        $('#v_email').val(data.correo);
        $('#v_website').val(data.sitioweb);
        $('#v_phone').val(data.telefono);
        $('#v_manager').val(data.administrador);
        $('#id_fiscalcategory').val(data.id_catfiscal);
        $('#id_account').val(data.id_cuenta);
        $('#ds_cuenta').val(data.cuenta);
        $('#ModalProviders').modal({ backdrop: 'static', keyboard: false }, 'show');
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}

function EndCallbackupdate(params, answer) {
    if (!answer.Error) {
        window.gridprovee.bootgrid('reload');
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
};


function ResetForm() {
    $('.divclientinfo input').val('');
    $('#hidempresa').val('0');
    $('#hidcliente').val('0');

    $('#myTimeline').albeTimeline([], {
        language: 'es-ES',
        showGroup: false,
        formatDate: 'd de MMMM de yyyy HH:mm:ss'
    });

    $('.cuotasfac').hide();

    var drDestroy = window.gridfacturas.data('.rs.jquery.bootgrid');
    drDestroy.clear();
    drDestroy = window.gridcodeudor.data('.rs.jquery.bootgrid');
    drDestroy.clear();
    drDestroy = window.gridcuocance.data('.rs.jquery.bootgrid');
    drDestroy.clear();
    drDestroy = window.gridcuovenci.data('.rs.jquery.bootgrid');
    drDestroy.clear();
    drDestroy = window.gridproducto.data('.rs.jquery.bootgrid');
    drDestroy.clear();

}