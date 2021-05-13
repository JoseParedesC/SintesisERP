//Vector  de validación
var ValidateGen = [{ id: 'smmlv', type: 'REAL', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'salInte', type: 'REAL', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'salInte', type: 'REAL', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'auxTrans', type: 'REAL', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'porcen_interes_Cesantias', type: 'TEXT', htmltype: 'SELECT', required: true, depends: false, iddepends: '' }];


var ValidateSociales = [{ id: 'porcen_salud_empleado', type: 'REAL', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'porcen_salud_empleador', type: 'REAL', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'porcen_salud_total', type: 'REAL', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'porcen_pension_empleado', type: 'REAL', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'porcen_pension_empleador', type: 'REAL', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'porcen_pension_total', type: 'REAL', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    /*--------------------------------------------------------------------------------------------------------------------*/
    { id: 'num_salmin_salud_empleador', type: 'REAL', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'porcen_icbf', type: 'REAL', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'num_salmin_ICBF', type: 'REAL', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'porcen_sena', type: 'REAL', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'num_salmin_SENA', type: 'REAL', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'num_max_seguridasocial', type: 'REAL', htmltype: 'INPUT', required: true, depends: false, iddepends: '' }];


var ValidateHora = [{ id: 'hediurnas', type: 'REAL', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'henoctur', type: 'REAL', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'hefdiurnas', type: 'REAL', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'hefnoctur', type: 'REAL', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'recnocturno', type: 'REAL', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'recdomfest', type: 'REAL', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'recnocdomfest', type: 'REAL', htmltype: 'INPUT', required: true, depends: false, iddepends: '' }];


var ValidateRow = [{ id: 'Rowdesde', type: 'REAL', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'Rowhasta', type: 'REAL', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'Rowporcen', type: 'REAL', htmltype: 'INPUT', required: true, depends: false, iddepends: '' }];


window.tblcommodity;

function Loadtable() {
    window.tblcommodity = $("#tblcommodity").bootgrid({
        ajax: true,
        post: function () {
            return {
                'params': "",
                'class': 'Nomina',
                'method': 'ParametrosList'
            };
        },
        url: window.appPath + "/Pages/Connectors/ConnectorList.ashx",
        formatters: {
            "edit": function (column, row) {
                return "<a class=\"action command-edit\" data-row-id=\"" + row.id + "\"><span class=\"fa-2x fa fa-pencil text-princ iconfa\"></span></a>";
            },
            "delete": function (column, row) {
                return "<a class=\"action command-delete\" data-row-id=\"" + row.id + "\"><span class=\"fa fa-2x fa-trash-o text-danger iconfa\"></span></a>";
            },
            "valor": function (column, row) {
                return row[column.id].Money()
            }
        }
    }).on("loaded.rs.jquery.bootgrid", function () {
        window.tblcommodity.find(".command-edit").on("click", function (e) {
            removeerror();
            id = $(this).data("row-id")
            params = {};
            params.id = id;
            params.op = '';
            MethodService("Nomina", "ParametrosGet", JSON.stringify(params), 'EndCallbackGet');
        }).end().find(".command-delete").on("click", function (e) {
            if (confirm("Desea eliminar este Cargo?")) {
                id = $(this).data("row-id");
                params = {};
                params.id = id;
                MethodService("Nomina", "ParametrosDelete", JSON.stringify(params), 'EndCallbackupdate');
            }
        });
    });
}

//Funcion para el cargado de la información en la tabla de listado de las bodegas ya guardadas.
function Resize() {
    if ($(window).width() <= 750) {
        $('.no-show').css('border', 'none');
    }
    else {
        $('.no-show').css('border-left', '2px dotted #1b84c5');
    }
}

$(document).ready(function () {
    Loadtable();

    Resize()

    $(window).resize(function () {
        Resize()
    })

    $('#porcen_salud_empleado').on('change', function () {
        sumar($(this), $('#porcen_salud_empleador'), $('#porcen_salud_total'))
    });

    $('#porcen_salud_empleador').on('change', function () {
        sumar($(this), $('#porcen_salud_empleado'), $('#porcen_salud_total'))
    });

    $('#porcen_pension_empleado').on('change', function () {
        sumar($(this), $('#porcen_pension_empleador'), $('#porcen_pension_total'));
    });

    $('#porcen_pension_empleador').on('change', function () {
        sumar($(this), $('#porcen_pension_empleado'), $('#porcen_pension_total'));
    });
});

function SetNumeric(item) {
    var text = item.toString().split('%')[1];
    return parseFloat(text);
}

function sumar(item1, item2, itemTotal) {
    if ($(item1).val() != "" & $(item2).val() != "") {
        suma = SetNumeric($(item1).val()) + SetNumeric($(item2).val())
        $(itemTotal).val('% ' + suma)
    }
}

function addRow() {
    var tbl = $('#mytable tbody')
    var i = (tbl.find('tr').length == 0 ? tbl.find('tr').length : tbl.find('tr').length + 1);

    button = '<a type="button" name="remove" data-id="' + i + '" id="' + i + '" class="btn_remove"><span class="fa-2x fa fa-trash-o text-danger iconfa"></span></a>'


    var fila = `<tr id="row${i}" style="border: 1px solid #AAB7B8;">
                <td class="text-center command-desde" style="font-size: 12px !important;height: 21px !important" id="desde${i}">${parseFloat($('#Rowdesde').val())}</td>
                <td class="text-center command-hasta" style="font-size: 12px !important;height: 21px !important" id="hasta${i}">${(isNaN($('#Rowhasta').val()) ? $('#Rowhasta').val() : parseFloat($('#Rowhasta').val()) - parseFloat(0.01))}</td>
                <td class="text-center command-porcen porcen" style="font-size: 12px !important;height: 21px !important; width: 20px !important; padding: 5px" id="porcen${i}"><span class="tdedit">% ${$('#Rowporcen').val()}</span></td>
                <td class="text-center">${button}</td>
                </tr>`;

    $.each(tbl, function (i, e) {
        row = $('#row' + i)
        if (tbl.find('tr').length == 0) {
            $('#mytable tbody').append(fila);
        } else if (parseFloat(row.find('td:first').text()) >= parseFloat($('#Rowdesde').val())) {
            $(fila).insertBefore(row)
        } else {
            if (parseFloat(row.find('td:first').text()) <= parseFloat($('#Rowdesde').val())) {
                tr = tbl.find('tr:last');
                $(fila).insertAfter(tr)
            } else {
                tbl.append(fila)
            }
        }
    });

    if ($('#Rowhasta').val().toUpperCase() != 'X') {
        $('#Rowdesde').val($('#Rowhasta').val())
        $('#Rowhasta').removeAttr('readonly')
        $('#Rowporcen').removeAttr('readonly')
    }
    else {
        $('#Rowdesde').val('')
        $('#Rowdesde').attr('readonly', 'readonly')
        $('#Rowhasta').attr('readonly', 'readonly')
        $('#Rowporcen').attr('readonly', 'readonly')
    }

    $('#Rowhasta').val("")
    $('#Rowporcen').val("")


    $('.btn_remove').click(function () {
        removeRow($(this))
    });


    $('#porcen' + i).on('dblclick', function () {
        EditRow($(this));
    });

    Alert()
}

//function findLast(item) {
//    //De Arriba hacia arriba
//    tbl = $('#mytable tbody tr');
//    pos = -1
//    $.each(tbl, function (i,e) {
//        row = $('#row' + i);
//        val = parseFloat(row.find('td:first').text());
//        if (val < parseFloat($(item).text())) {
//            pos = i
//        }
//    });
//    return pos
//}


function EditRow(item) {
    value = $(item).text();
    input = $('<input id="porcen" class="form-control" porcen="true" placeholder="% 0.0" data-a-sign="% " style="width: 100%; text-align: center;"/>');
    input.focus().select()
    tr.find('.tdedit').hide();
    $(item).html(input)
    $(item).find('input').val(value);


    input.blur(function () {
        value = $(item).find('input').val()
        td = $(item).closest('td')
        td.remove('input')
        td.html(value)
        tr.find('.edit').show()
    })
}

$('#Rowporcen').on('blur', function (e) {
    if (validate(ValidateRow) || $('#Rowhasta').val().toUpperCase() == 'X') {
        Alert()
        if (!$('#mytable tbody').find('tr').hasClass('danger')) {
            addRow();
        }
    }
    else if (!$('#Rowporcen').attr('readonly'))
        toastr.warning('Campos requeridos Vacios o no son numeros', 'Sintesis ERP')
});

$('#Rowhasta').on('change', function () {

    if (parseFloat($('#Rowhasta').val()) < parseFloat($('#Rowdesde').val())) {
        $(this).addClass('error is-focused')
        toastr.error('No puede ser menor al numero inicial', 'Sintesis ERP');
    } else {
        $(this).removeClass('error is-focused')
    }

    Alert()
})

$('#Rowdesde').on('change', function () {
    texto = $(this).val();
    $('.alert').remove();

    tbl = $('#mytable tbody').find('tr');

    $.each(tbl, function () {
        if (tbl.find('td:first') < $(this).val()) {
            toastr.warning('jajaja','Sintesis')
        }
    })

    Alert()

    if ((texto == null || texto == '') & (texto > 0)) {
        $("#Rowhasta, #Rowporcen").val('');
        $("#Rowhasta, #Rowporcen").attr('readonly', 'readonly');
        $('#Rowhasta').removeClass('error is-focused')
    }
    else
        $("#Rowhasta, #Rowporcen").removeAttr('readonly');

});

function checkId(id) {
    var che = false
    resul = {}
    tbl = $('#mytable tbody tr')
    $.each(tbl, function (i, e) {
        if (parseFloat($('#desde' + i).text()) == id) {
            che = true
            id = $('#desde' + i).closest('tr').attr('id');
        }
    });
    resul.che = che
    resul.id = id

    return resul
}

function Alert() {
    //$('.alert').remove()
    check = checkId(parseFloat($('#Rowdesde').val()));
    if (check.che) {
        var div = `<div role="alert" aria-live="polite" style="margin:5px; font-size:12px" aria-atomic="true"
        class="alert alert-dismissible alert-alert alert-card alert-info danger"><div class="warning-message"><strong>Información!</strong><br/>Numero de SMMLV ya esta en uso</div></div>`;

        $('#mytable').closest('.divParamAnual').append(div);
        $('#' + check.id).addClass('danger')
    } else {
        $('.alert').remove()
        clas = $('#mytable tbody').find('tr');
        clas.removeClass('danger');
    }
}

function removeRow(thi) {
    $('#Rowdesde').val($('#mytable tbody tr:last').find('.command-hasta').text())
    $(thi).closest('tr').remove()

    if ($('#mytable tbody').find('tr').length == 0) {
        $('#Rowdesde').val('').removeAttr('readonly')
        $('#Rowhasta, #Rowporcen').attr('readonly', 'readonly')
    } else
        $('#Rowhasta, #Rowporcen').removeAttr('readonly')
}

$('.iconnew').click(function (e) {
    formReset();
    $('#nav1').click();
    $('#diventrada').css('display', 'none')
    $('.divParam').css('display', 'block')
    params = {}
    params.id = 0;
    params.op = 'D';
    MethodService("Nomina", "ParametrosGet", JSON.stringify(params), 'EndCallbackGet');
});

$('#btnBack').click(function(e) {
    $('#nav1').click();
    formReset();
    $('#diventrada').css('display', 'block')
    $('.divParam').css('display', 'none')
})

function formReset() {
    div = $(document);
    div.find('input.form-control').val('');
    GetDated();
    tr = $('#mytable tbody').find('tr');
    tr.remove();
    $('#tblinfo tbody').empty()
    $('#tblinfo tbody').append('<tr class="text-center"><td colspan="5" class="no-results"> No hay resultado! </td></tr>');
    $('#Rowdesde, #Rowhasta, #Rowporcen').val('');
    $('#Rowdesde, #Rowhasta, #Rowporcen').attr('readonly', 'readonly');
    $('#Rowdesde').removeAttr('readonly');
    $('.selectpicker').val('');
    $('.selectpicker').selectpicker('refresh');
    $('#btnSave').removeAttr('data-id');
    $('.collapse').removeClass('in');
}

$('#btnSave').click(function (e) {
    if (validate(ValidateGen) & validate(ValidateHora) & validate(ValidateSociales)) {
        params = {};
        params.id_param = $(this).attr('data-id') == undefined ? 0 : $(this).attr('data-id');
        params.fecha_vigencia = $('#anoactual').val();

        // INFORMACION GENERAL
        params.salarioMinimoLegal = SetNumber($('#smmlv').val());
        params.salIntegral = SetNumber($('#salInte').val());
        params.auxTrans = SetNumber($('#auxTrans').val());
        params.int_Ces = SetNumber($('#porcen_interes_Cesantias').val());
        params.exonerado = $('#exonerado').prop('checked');

        // PRESTACIONES SOCIALES (Empleados)
        params.porcen_salud_empleado = SetNumeric($('#porcen_salud_empleado').val());
        params.porcen_pension_empleado = SetNumeric($('#porcen_pension_empleado').val());
        params.num_salmin_icbf = $('#num_salmin_ICBF').val();
        params.num_salmin_sena = $('#num_salmin_SENA').val();
        params.porcen_icbf = SetNumeric($('#porcen_icbf').val());
        params.porcen_sena = SetNumeric($('#porcen_sena').val());
        params.num_max_seguridasocial = $('#num_max_seguridasocial').val();
        params.id_cuenta = $('#id_cuenta').val();
        params.id_cuenta_arl = $('#id_cuenta_arl').val();
        params.caja_compensacion = SetNumeric($('#caja_compensacion').val());


        // PRESTACIONES SOCIALES (Empleador)
        params.porcen_salud_empleador = SetNumeric($('#porcen_salud_empleador').val());
        params.porcen_pension_empleador = SetNumeric($('#porcen_pension_empleador').val());
        params.num_salmin_salud_empleador = $('#num_salmin_salud_empleador').val();

        // PRESTACIONES SOCIALES (Total)
        params.porcen_salud_total = SetNumeric($('#porcen_salud_total').val());
        params.porcen_pension_total = SetNumeric($('#porcen_pension_total').val());

        // HORAS EXTRA
        params.hediurnas = SetNumber($('#hediurnas').val());
        params.henoctur = SetNumber($('#henoctur').val());
        params.hefdiurnas = SetNumber($('#hefdiurnas').val());
        params.hefnoctur = SetNumber($('#hefnoctur').val());
        params.recnocturno = SetNumber($('#recnocturno').val());
        params.recdomfest = SetNumber($('#recdomfest').val());
        params.recnocdomfest = SetNumber($('#recnocdomfest').val());

        // SOLIDARIDAD PESIONAL
        params.fondo_solidaridad = GetXML();

        //RETEFUENTE
        params.uvt = SetNumber($('#uvt').val());

        MethodService("Nomina", "ParametrosSaveUpdate", JSON.stringify(params), "EndCallBackUpdate");
    } else {
        toastr.error('Proceso NO ejecutado', 'Sintesis ERP');
    }
});

function GetXML(){
    tbl = $('#mytable tbody').find('tr');
    xml = '';

    $.each(tbl, function (i, e) {
        xml += `<item desde="${parseFloat($(e).find('.command-desde').text())}" 
                      hasta="${(isNaN($(e).find('.command-hasta').text()) ? $(e).find('.command-hasta').text() : parseFloat($(e).find('.command-hasta').text()))}" 
                      porcen="${SetNumeric($(e).find('.command-porcen').text())}"></item >`;
    });

    return '<items>' + xml + '</items>';
}

function SetFondoSegSocial(answer) {
    response = answer.List;
    var body = $('#mytable tbody');
    body.empty();
    $('#Rowdesde').attr('readonly','readonly')
    $.each(response, function (i, e) {
        tr = $('<tr id="row' + i + '" style="border: 1px solid #AAB7B8;"/>')

        a = $('<a class="btn_remove" data-id="' + i + '" id="' + i + '"/>').html('<span class="fa fa-2x fa-trash-o text-danger iconfa btn_remove"></span>').click(function () {
            removeRow($(this))
        });

        edit = $('<td class="text-center command-porcen porcen" style="font-size: 12px !important;height: 21px !important; width: 20px !important; padding: 5px" id="porcen' + i + '"/>').html('% ' + e.porcentaje).dblclick(function () {
            EditRow($(this));
        })

        td = $('<td class="text-center" />').append(a);
        td1 = $('<td class="text-center command-desde" id="desde' + i + '"/>').html(e.desde);
        hasta = e.hasta == 0 ? 'X' : e.hasta
        td2 = $('<td class="text-center command-hasta" id="hasta' + i +'"/>').html(hasta);
        td3 = edit;

        tr.append(td1, td2, td3, td);
        body.append(tr);
    })

    //findLast()
}

function EndCallbackGet(params, answer) {
    if (!answer.Error) {
        data = answer.Row[0];
        console.log(data)
        $('#btnSave').attr('data-id', data.id_param);
        $('#anoactual').val(data.fecha_vigencia);

        // INFORMACION GENERAL
        $('#smmlv').val('$ ' + data.salario_MinimoLegal.Money());
        $('#salInte').val('$ ' + data.salario_Integral.Money())
        $('#auxTrans').val('$ ' + data.aux_transporte.Money());
        $('#porcen_interes_Cesantias').val(data.id_interesCesantias).selectpicker('refresh')
        $('#exonerado').prop('checked', data.exonerado).iCheck('update');

        // PRESTACIONES SOCIALES (Empleados)
        $('#porcen_salud_empleado').val('% ' + parseFloat(data.porcen_saludE));
        $('#porcen_pension_empleado').val('% ' + data.porcen_pensionE);
        $('#num_salmin_ICBF').val(data.num_salariosMinICBF);
        $('#num_salmin_SENA').val(data.num_salariosMinSENA);
        $('#porcen_icbf').val('% ' + data.porcen_icbf);
        $('#porcen_sena').val('% ' + data.porcen_sena);
        $('#num_max_seguridasocial').val(data.num_salariosMinSegSocial);
        $('#id_cuenta').val(data.id_cuenta);
        $('#id_cuenta_arl').val(data.id_cuenta_arl);

        $('#ds_cuenta').val(data.ds_cuenta);
        $('#ds_cuenta_arl').val(data.ds_cuenta_arl);

        $('#caja_compensacion').val('% ' + data.caja_compensacion);

        // PRESTACIONES SOCIALES (Empleador)
        $('#porcen_salud_empleador').val('% ' + data.porcen_saludR);
        $('#porcen_pension_empleador').val('% ' + data.porcen_pensionR);
        $('#num_salmin_salud_empleador').val(data.num_salariosMinSalud);

        // PRESTACIONES SOCIALES (Total)
        $('#porcen_salud_total').val('% ' + data.porcen_saludTotal);
        $('#porcen_pension_total').val('% ' + data.porcen_pencionTotal);


        // HORAS EXTRA
        $('#hediurnas').val('% ' + data.extra_diurna.Money());
        $('#henoctur').val('% ' + data.extra_nocturna.Money());
        $('#hefdiurnas').val('% ' + data.extra_fesDiurna.Money());
        $('#hefnoctur').val('% ' + data.extra_fesNoct.Money());
        $('#recnocturno').val('% ' + data.recargoNocturno.Money());
        $('#recdomfest').val('% ' + data.recarg_DomDiurno.Money());
        $('#recnocdomfest').val('% ' + data.recarg_DomNoct.Money());

        // SOLIDARIDAD PESIONAL
        SetFondoSegSocial(answer)

        //RETEFUENTE
        $('#uvt').val('$ ' + data.uvt.Money())

        tr = `<tr >
                <td class="text-center">${data.fecha_vigencia}</td>
                <td class="text-center">${data.salario_MinimoLegal.Money()}</td>
                <td class="text-center">${data.aux_transporte.Money()}</td>
                </tr>`
        $('#tblinfo tbody').empty()
        tbl = $('#tblinfo tbody').append(tr)

    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }

    $('.divParam').css('display', 'block')
    $('#diventrada').css('display', 'none')
}

function EndCallBackUpdate(params, answer) {
    if (!answer.Error) {
        $('.divParam').css('display', 'none')
        formReset()
        $('#diventrada').css('display', 'block')
        window.tblcommodity.bootgrid('reload');
        toastr.success("Proceso ejecutado correctamente", "Sintesis ERP");
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}

function GetDated() {
    var date = new Date()
    $('#anoactual').val(date.getFullYear())
}