var ValidateDeven = [{ id: 'f_ini', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'f_fin', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'boni', type: 'NUMERIC', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'comi', type: 'NUMERIC', htmltype: 'INPUT', required: true, depends: false, iddepends: '' }]

var ValidateAusencia = [{ id: 'fecha_ini', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'fecha_fin', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'ds_ausencia', type: 'NUMERIC', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'ds_diagnostico', type: 'TEXT', htmltype: 'INPUT', required: false, depends: false, iddepends: '' }]

var ValidateDeduc = [{ id: 'prestamo', type: 'NUMERIC', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'libranza', type: 'NUMERIC', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'ds_embargo', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'retefuente', type: 'NUMERIC', htmltype: 'INPUT', required: true, depends: false, iddepends: '' }]

$(document).ready(function () {

    $('#ds_ausencia').on('change', function () {
        setAusencia();
    });

    datepicker();

    $('#btnGetNovedad').click(function () {
        params = {}
        params.id = $('#hidper_por_cont').val()
        MethodService('LiquidacionNom', 'NovedadesGet', JSON.stringify(params), 'EndCallBackGet')
    })

});

$('#addDeven').on('click', function () {
    if (validate(ValidateDeven) & ($('#f_fin').val() > $('#f_ini').val())) {

        var json = {
            'fecha_ini': $('#f_ini').val(), 'fecha_fin': $('#f_fin').val(),
            'bonificacion': $('#boni').val(), 'comision': $('#comi').val()
        }

        setTableDevengo(json)

    } else {
        if ($('#f_fin').val() < $('#f_ini').val()) {
            a = $('#f_fin').closest('.form-group').addClass('is-focused error');
        }
    }
});

$('#addAusenc').on('click', function () {
    if (validate(ValidateAusencia) & ($('#fecha_fin').val() > $('#fecha_ini').val())) {

        var json = {
            'fecha_ini': $('#fecha_ini').val(), 'fecha_fin': $('#fecha_fin').val(),
            'ds_ausencia': $('#ds_ausencia').find('option:selected').text(), 'ds_diagnostico': $('#ds_diagnostico').val(),
            'remunerado': $('#remunerado').prop('checked'), 'suspendido': $('#suspendido').prop('checked'),
            'id_diagnostico': $('#id_diagnostico').val(), 'id_ausencia': $('#ds_ausencia').val()
        };

        setTableAusen(json);
    } else {
        if ($('#fecha_fin').val() < $('#fecha_ini').val()) {
            $('#fecha_fin').closest('.form-group').addClass('is-focused error')
        }
    }
});

$('#addDeduc').on('click', function () {
    if (validate(ValidateDeduc)) {

        var json = {
            'prestamo': $('#prestamo').val(), 'libranza': $('#libranza').val(),
            'ds_embargo': $('#ds_embargo').val(), 'retencion': $('#retefuente').val(),
            'id_embargo': $('#id_embargo').val()
        }

        setTableDeduc(json)
    }
});

$('.iconnew').click(function (e) {
    formReset();
    $('#tbnDevengo tbody').empty()
    $('#tblAusenc tbody').empty()
    $('#tblDeduc tbody').empty()
    $('h2.totales').text('$ 0.00')
    $('#ModalNovedades').modal({ backdrop: 'static', keyboard: false }, 'show');
});

function validateFecha(item1, item2) {
    if ($(item1).val() <= $(item2).val()) {
        toastr.warning('La feha final no puede ser menor a la inicial', 'Sintesis ERP')
        
    } else {
        toastr.info($(item1).val())
    }
}

function setAusencia() {
    var tipo = $('#ds_ausencia option:selected').attr('data-iden');
    $('.ausencia').css('display', 'none')
    $('#remunerado').prop('checked', true).iCheck('update')
    ValidateAusencia[3].required = false;

    if (tipo == "LIC") {
        $('#remunerado').closest('.ausencia').css('display', 'block');
        $('#remunerado').prop('checked', false).iCheck('update')

    } else if (tipo == "INC") {
        $('#ds_diagnostico').closest('.ausencia').css('display', 'block');
        ValidateAusencia[3].required = true;
    }
}

function calcTotal(item1, item2, type) {
    if (type)
        total = parseFloat(SetNumber($(item2).html())) + parseFloat(SetNumber(item1))
    else
        total = parseFloat(SetNumber($(item2).html())) - parseFloat(SetNumber(item1))

    $(item2).html(total.Money())
}

function formReset() {
    div = $('#ModalNovedades');
    //utilizar .nodate para no limpiar los inputs de fecha
    div.find('input.form-control').val('');
    $('.i-checks').prop('checked', false).iCheck('update')
    $('.selectpicker').val('').selectpicker('refresh');
    $('.ausencia').css('display', 'none')
}

$('#btnSaveNovedad').click(function (e) {
    params = {}
    xmlDeven = '<items>'
    xmlAusen = '<items>'
    xmlDeduc = '<items>'
    Devengos = true
    Ausencias = true
    Deducciones = true
    

    if ($('#tbnDevengo tbody tr').length > 0) {

        tr = $('#tbnDevengo tbody tr');
        $.each(tr, function (i, e) {
            xmlDeven += '<item fecha_ini="' + $(e).data('fecha_ini') +
                '" fecha_fin="' + $(e).data('fecha_fin') +
                '" bonifi="' + $(e).data('bonifi') +
                '" comi="' + $(e).data('comi') +'"></item>'
        });

    } else {
        Devengos = false
    }

    if ($('#tblAusenc tbody tr').length > 0) {

        tr = $('#tblAusenc tbody tr');
        $.each(tr, function (i, e) {
            xmlAusen += '<item fecha_ini="' + $(e).data('fecha_ini') +
                '" fecha_fin="' + $(e).data('fecha_fin') +
                '" id_ausen="' + $(e).data('id_ausen') +
                '" id_inca="' + $(e).data('id_inca') +
                '" remun="' + $(e).data('remun') +
                '" suspen="' + $(e).data('suspen') + '"></item>'
        });

    } else {
        Ausencias = false
    }

    if ($('#tblDeduc tbody tr').length > 0) {

        tr = $('#tblDeduc tbody tr');
        $.each(tr, function (i, e) {
            xmlDeduc += '<item prestamo="' + $(e).data('prestamo') +
                '" libranza="' + $(e).data('libranza') +
                '" id_embargo="' + $(e).data('id_embargo') +
                '" retefuente="' + $(e).data('retefuente') + '"></item>'
        });

    } else {
        Deducciones = false
    }

    xmlDeven += '</items>'
    xmlAusen += '</items>'
    xmlDeduc += '</items>'

    params.xmlDeven = (Devengos ? xmlDeven : '')
    params.xmlAusen = (Ausencias ? xmlDeven : '')
    params.xmlDeduc = (Deducciones ? xmlDeven : '')

    params.id = 1 //$('#btnSaveNovedad').attr('data-id') == undefined ? 0 : $('#btnSaveNovedad').attr('data-id')
    params.id_contrato = $('#hidcontrato').val();
    params.id_periodo_contrato = $('#hidper_por_cont').val()

    if (confirm('Hay tablas vacias. \n¿Desea continuar?'))
        MethodService("LiquidacionNom", "NovedadesSaveUpdate", JSON.stringify(params), "EndCallbackCesantias");

});

function EndCallbackCesantias(param,answer) {
    if (!answer.Error) {
        toastr.success('Proceso ejecutado exitosamente', 'Sintesis ERP')
        formReset();
        $('#ModalNovedades').modal('hide')
    } else {
        toastr.error(answer.Message, 'Sintesis ERP')
    }

}

function EndCallBackGet(param, answer) {
    formReset();
    $('h2.totales').text('$ 0.00')

    if (!answer.Error) {
        $('#tbnDevengo tbody').empty()
        $('#tblAusenc tbody').empty()
        $('#tblDeduc tbody').empty()


        data = answer.DataDev;
        $.each(data, function (i, e) {
            var json = {
                'fecha_ini': e.inicio_devengo,
                'fecha_fin': e.fin_devengo,
                'bonificacion': e.boni.Money(),
                'comision': e.comi.Money()
            }

            setTableDevengo(json)
        })


        data = answer.DataAus;
        $.each(data, function (i, e) {
            json = {
                'fecha_ini': e.inicio_ausencia, 'fecha_fin': e.fin_ausencia,
                'ds_ausencia': e.nombre, 'ds_diagnostico': e.ds_diagnostico,
                'remunerado': e.remunerado, 'suspendido': e.domingo_suspencion,
                'id_diagnostico': e.id_diagnostico, 'id_ausencia': e.id_tipoausencia
            };

            setTableAusen(json)
        })

        data = answer.DataDeduc;
        $.each(data, function(i, e){

            var json = {
                'prestamo': e.prestamos.Money(), 'libranza': e.libranzas.Money(),
                'ds_embargo': e.ds_embargo, 'retencion': e.retencion.Money(),
                'id_embargo': e.id_embargo
            }

            setTableDeduc(json)
        })

        $('#ModalNovedades').modal({ backdrop: 'static', keyboard: false }, 'show');
    } else {
        toastr.error(answer.Message, 'Sintesis ERP')
    }
}

function setTableDevengo(json) {
    trash = $('<a><i class="fa fa-2x fa-trash-o text-danger"></i></a>').on('click', function () {
        tr = $(this).closest('tr');
        calcTotal(tr.data('bonifi'), $('#mtotal_bonificacion'), false)
        calcTotal(tr.data('comi'), $('#mtotal_comision'), false)

        tr.remove();
    })

    pen = $('<a><i class="fa fa-2x fa-pencil text-primary"></i></a>').on('click', function () {
        tr = $(this).closest('tr');

        calcTotal(tr.data('bonifi'), $('#mtotal_bonificacion'), false)
        calcTotal(tr.data('comi'), $('#mtotal_comision'), false)

        $('#f_ini').val(tr.data('fecha_ini'));
        $('#f_fin').val(tr.data('fecha_fin'));
        $('#boni').val(tr.data('bonifi'));
        $('#comi').val(tr.data('comi'));

        tr.remove()
    });

    td = $('<td class="text-right"/>').html(pen)
    td1 = $('<td class="text-center" />').html(json.fecha_ini)
    td2 = $('<td class="text-center" />').html(json.fecha_fin)
    td3 = $('<td class="text-center" />').html(json.bonificacion)
    td4 = $('<td class="text-center" />').html(json.comision)
    td5 = $('<td class="text-left" />').html(trash)

    tr = $('<tr/>').attr({
        'data-fecha_ini': json.fecha_ini, 'data-fecha_fin': json.fecha_fin,
        'data-bonifi': SetNumber(json.bonificacion), 'data-comi': SetNumber(json.comision)
    })

    tr.append(td, td1, td2, td3, td4, td5)
    $('#tbnDevengo tbody').append(tr)

    calcTotal(tr.data('bonifi'), $('#mtotal_bonificacion'), true)
    calcTotal(tr.data('comi'), $('#mtotal_comision'), true)
    formReset();
}

function setTableAusen(json) {
    a = $('<a><i class="fa fa-2x fa-trash-o text-danger"></i></a>').on('click', function () {
        $(this).closest('tr').remove()
    });

    pen = $('<a><i class="fa fa-2x fa-pencil text-primary"></i></a>').on('click', function () {
        tr = $(this).closest('tr');
        $('#fecha_ini').val(tr.data('fecha_ini'));
        $('#fecha_fin').val(tr.data('fecha_fin'));
        $('#ds_ausencia').val(tr.data('id_ausen')).selectpicker('refresh');
        $('#ds_diagnostico').val(tr.data('ds_inca'));
        $('#id_diagnostico').val(tr.data('id_inca'));
        $('#remunerado').prop('checked', tr.data('remun')).iCheck('update');
        $('#suspendido').prop('checked', tr.data('suspen')).iCheck('update');
        setAusencia()
        tr.remove()
    });
    
    td = $('<td class="text-right"/>').html(pen)
    td1 = $('<td class="text-center" />').html(json.fecha_ini)
    td2 = $('<td class="text-center" />').html(json.fecha_fin)
    td3 = $('<td class="text-center" />').html(json.ds_ausencia)
    td4 = $('<td class="text-center" />').html(json.ds_diagnostico)

    check = json.remunerado ? 'fa-check-square-o text-success' : 'fa-square-o text-danger'
    i = '<a><i class="fa fa-2x ' + check + '"></i></a>'
    td5 = $('<td class="text-center" />').html(i)

    check = json.suspendido ? 'fa-check-square-o text-success' : 'fa-square-o text-danger'
    i = '<a><i class="fa fa-2x ' + check + '"></i></a>'
    td6 = $('<td class="text-center" />').html(i)

    tr = $('<tr/>').attr({
        'data-fecha_ini': json.fecha_ini, 'data-fecha_fin': json.fecha_fin,
        'data-id_ausen': json.id_ausencia, 'data-ds_inca': json.ds_diagnostico,
        'data-id_inca': json.id_diagnostico, 'data-remun': json.remunerado,
        'data-suspen': json.suspendido
    })

    tr.append(td, td1, td2, td3, td4, td5, td6, a)
    $('#tblAusenc tbody').append(tr)
    formReset();
}

function setTableDeduc(json) {
    a = $('<a><i class="fa fa-2x fa-trash-o text-danger"></i></a>').on('click', function () {
        tr = $(this).closest('tr');
        calcTotal(tr.data('prestamo'), $('#mtotal_Prestamo'), false)
        calcTotal(tr.data('libranza'), $('#mtotal_Libranza'), false)
        calcTotal(tr.data('retefuente'), $('#mtotal_retefuente'), false)

        tr.remove()
    })

    pen = $('<a><i class="fa fa-2x fa-pencil text-primary"></i></a>').on('click', function () {
        tr = $(this).closest('tr');
        $('#prestamo').val(tr.data('prestamo'));
        $('#libranza').val(tr.data('libranza'));
        $('#ds_embargo').val(tr.data('ds_embargo'));
        $('#id_embargo').val(tr.data('id_embargo'));
        $('#retefuente').val(tr.data('retefuente'));

        calcTotal(tr.data('prestamo'), $('#mtotal_Prestamo'), false)
        calcTotal(tr.data('libranza'), $('#mtotal_Libranza'), false)
        calcTotal(tr.data('retefuente'), $('#mtotal_retefuente'), false)

        tr.remove()
    });

    td = $('<td class="text-right"/>').html(pen)
    td1 = $('<td class="text-center" />').html(json.prestamo)
    td2 = $('<td class="text-center" />').html(json.libranza)
    td3 = $('<td class="text-center" />').html(json.ds_embargo)
    td4 = $('<td class="text-center" />').html(json.retencion)

    tr = $('<tr/>').attr({
        'data-prestamo': SetNumber(json.prestamo), 'data-libranza': SetNumber(json.libranza),
        'data-ds_embargo': json.ds_embargo, 'data-id_embargo': json.id_embargo,
        'data-retefuente': SetNumber(json.retencion)
    })

    calcTotal(tr.data('prestamo'), $('#mtotal_Prestamo'), true)
    calcTotal(tr.data('libranza'), $('#mtotal_Libranza'), true)
    calcTotal(tr.data('retefuente'), $('#mtotal_retefuente'), true)

    tr.append(td, td1, td2, td3, td4, a)
    $('#tblDeduc tbody').append(tr)
    formReset();
}

