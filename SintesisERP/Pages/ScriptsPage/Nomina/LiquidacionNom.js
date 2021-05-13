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

window.gridliquidacion;
window.gridcontrato;


$('#programed').click(function () {
    ResetForm();
});

function Loadtable() {

    window.gridliquidacionperiod = $("#tblLiquidacionperiod").bootgrid({
        ajax: true,
        post: function () {
            return {
                'params': "",
                'class': 'LiquidacionNom',
                'method': 'LiquidacionList'
            };
        },
        url: window.appPath + "/Pages/Connectors/ConnectorList.ashx",
        formatters: {
            "ver": function (column, row) {
                return "<a class=\"action command-ver\" data-row-id=\"" + row.id + "\"><span class=\"fa-2x fa fa-eye iconfa\"></span></a>";
            }
        }
    }).on("loaded.rs.jquery.bootgrid", function () {
        // Executes after data is loaded and rendered 
        window.gridliquidacionperiod.find(".command-ver").on("click", function (e) {
            id = $(this).data("row-id")
            params = {};
            params.iden = null;
            params.id_persona = id;
            MethodService("LiquidacionNom", "EmpleadoGet", JSON.stringify(params), 'EndCallbackGet');
        }).end();
    });


    window.gridliquidacioncontra = $("#tblLiquidacioncontrato").bootgrid({
        ajax: true,
        post: function () {
            return {
                'params': function () {
                    param = {
                        id_periodo: ($('#period').val() == '' ? 0 : $('#period').val() )

                    };
                    return JSON.stringify(param);
                },
                'class': 'LiquidacionNom',
                'method': 'LiquidacionListPeriodo'
            };
        },
        url: window.appPath + "/Pages/Connectors/ConnectorList.ashx",
        formatters: {
            "ver": function (column, row) {
                return "<a class=\"action command-ver\" data-row-id=\"" + row.id + "\"><span class=\"fa-2x fa fa-eye iconfa\"></span></a>";
            },
            "novedad": function (column, row) {
                return "<a class=\"action command-novedad\" data-id-periodo-contrato=\"" + row.id_periodo_contrato + "\" data-row-id=\"" + row.id + "\"><span class=\"fa fa-2x fa-plus text-success iconfa\"></span></a>";
            }
        }
    }).on("loaded.rs.jquery.bootgrid", function () {

        //if (window.gridliquidacioncontra.bootgrid("getCurrentRows").length > 0) {
        //    $('#tablacontrato').show();
        //} else {
        //    $('#tablacontrato').hide();
        //}
        // Executes after data is loaded and rendered 
        window.gridliquidacioncontra.find(".command-ver").on("click", function (e) {
            id = $(this).data("row-id")
            params = {};
            params.id = id;
            MethodService("LiquidacionNom", "LiquidacionGet", JSON.stringify(params), 'EndCallbackGetContrato');
        }).end().find(".command-novedad").on("click", function (e) {
            $('#btnSaveNovedad').attr('data-id', $(this).data('id-periodo-contrato'))
            params = {}
            params.id = $(this).data('id-periodo-contrato')
            MethodService('LiquidacionNom', 'NovedadesGet', JSON.stringify(params), 'EndCallBackGetNovedad')
        });
    });

    fieldsMoney();
}


$(document).ready(function () {
    Loadtable();

    toggleCC()

    $('#tblLiquidacionperiod-header').hide();
    $('#tblLiquidacionperiod-footer').hide();
    $('#tblLiquidacioncontrato-header').hide();
    $('#tblLiquidacioncontrato-footer').hide();


    $('.inputaddress').click(function () {
        $('.inputaddress').removeClass('active');
        $(this).addClass('active');
        $('#comboaddress').val('').selectpicker('refresh');
        $('#tmpdireccion').focus();
    });


    $('#comboaddress').change(function () {
        $('.inputaddress').removeClass('active');
        $('#tmpdireccion').focus();

    });


    $('#btnSaveAdd').click(function () {
        var dir = $('#tempdir').val();
        $('#direccion').val(dir);
        $('#tmpdireccion, #tempdir').val('');
        $('#ModalDirecciones').modal('hide');
    });

    /*agrega (concatena) la dirección escrita en el imput tmpdireccion y
     lo carga en el imput tempdir*/
    $('#adddirec').click(function () {
        if (validate(JsonValidateDir)) {
            var val = $('#comboaddress option:selected').attr('data-dian');
            val = (val == undefined || val == '') ? $('.inputaddress.active').attr('data-dian') : val;
            val = val = (val == undefined) ? '' : val;
            if (val != '') {
                vald = $('#tmpdireccion').val();
                dir = $('#tempdir').val();
                $('#tempdir').val(dir + ((dir == "") ? val + '' + vald : ' ' + val + ' ' + vald));
                $('.inputaddress').removeClass('active');
                $('#tmpdireccion').val('');
                $('#comboaddress').val('').selectpicker('refresh');
            }
            else {
                toastr.warning("Seleccione Nomenclatura.", 'Sintesis Creditos');
            }
        }
    });

    /*elimina la dirección escrita en el imput tmpdireccion*/
    $('#remdirec').click(function () {
        if (confirm('Desea eliminar la Dirección?'))
            $('#tempdir').val('');
    });

    /*muestra el modal de dirección*/
    $('#direccion').click(function () {
        $('#ModalDirecciones').modal({ backdrop: 'static', keyboard: false }, "show");
    });

    $('#noneempleado').on('click', function () {
        if ($('.left').hasClass('my-show')) { //Acá se muestra la tabla
            $('.left').css({ 'width': '40%', 'transition': '1s' }).removeClass('my-show').fadeIn('slow');
            $('.rigth').css({ 'width': '60%', 'transition': '1s' });
            $('#iconbot').removeAttr('class', 'fa fa-caret-right');
            $('#iconbot').attr('class', 'fa fa-caret-left');
        } else {//Aquí se oculta la tabla
            $('.left').css({ 'width': '0px', 'transition': '1s' }).addClass('my-show').fadeOut('slow');
            $('.rigth').fadeIn('fast').css({ 'width': '100%', 'transition': '1s' })
            $('#iconbot').removeAttr('class', 'fa fa-caret-left');
            $('#iconbot').attr('class', 'fa fa-caret-right');
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
        atr = $('#filtroliq').find('option:selected').attr('param');

        if (atr == 'PERIOD') {
            $('.tabla1').show();
            $('.tabla2').hide();
            window.gridliquidacionperiod.bootgrid('reload');
            $('#tblLiquidacionperiod-header').show();
            $('#tblLiquidacionperiod-footer').show();
            $('#tblLiquidacioncontrato-header').hide();
            $('#tblLiquidacioncontrato-footer').hide();

        } else if (atr == 'CONTRA') {
            $('.tabla2').show();
            $('.tabla1').hide();
            window.gridliquidacioncontra.bootgrid('reload');            
            $('#tblLiquidacionperiod-header').hide();
            $('#tblLiquidacionperiod-footer').hide();
            $('#tblLiquidacioncontrato-header').show();
            $('#tblLiquidacioncontrato-footer').show();
        }
        
        if (!$('#tblliquidacion-header').is(':visible')) {
            toggleCC();
            $(this).hide();
        }

        ResetForm();
    });


    $('#ds_ausencia').on('change', function () {
        setAusencia();
    });

    datepicker();





});

$('#btnnews').click(function () {
    ResetForm();
    window.gridcontrato.bootgrid('reload');
});



function EndCallbackupdatecontrato(params, answer) {
    if (!answer.Error) {

        data = JSON.parse(params);

        select = $('select.rowedit');
        select.closest('td').find('div.tdedit').attr({ 'data-value': data.value, 'data-idvalue': data.id }).html(data.text).show();
        params = {};
        select.remove();
        //if (answer.Row.xml !== '') {
        //    params = {};
        //    params.xml = answer.Row.xml;
        //    params.email = answer.Row.email;
        //    params.server = answer.Row.servermail;
        //    params.port = answer.Row.portmail;
        //    params.ssl = answer.Row.sslmail;
        //    params.usermail = answer.Row.usermail;
        //    params.usertitlemail = answer.Row.usertitlemail;
        //    params.pass = answer.Row.passmail;
        //    $.ajax({
        //        url: '../pages/connectors/connector.ashx/tickets/SendMail',
        //        method: 'post',
        //        data: { "class": "Tickets", method: "SendMail", params: JSON.stringify(params) },
        //        success: function (data) {
        //            if (!data.ans.error)
        //                toastr.success(data.ans.mensaje, 'Sintesis ERP');
        //            else
        //                toastr.error(data.ans.mensaje, 'Sintesis ERP');
        //        },
        //        error: function (err) {
        //            toastr.error(err.message, 'sintesis ERP');
        //        },
        //        async: false
        //    })
        //}

        window.gridliquidacion.bootgrid('reload');
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}

function EndCallbackupdate(params, answer) {
    if (!answer.Error) {
        window.gridliquidacion.bootgrid('reload');
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}

function EndCallbackGet(Params, answer) {
    if (!answer.Error) {
        $('#atras').click();
        var emp = answer.Row

        $('#hidempleado').val(emp.id);
        $('#id_tipoiden').val(emp.tipoiden);
        $('#iden').val(emp.iden);
        $('#fechaexp').val(emp.fechaexpedicion);
        $('#pnombre').val(emp.primernombre);
        $('#snombre').val(emp.segundonombre);
        $('#papellido').val(emp.primerapellido);
        $('#sapellido').val(emp.segundoapellido);
        $('#fechacaci').val(emp.fechanacimiento);
        $('#profesion').val(emp.profesion);
        $('#universidad').val(emp.universidad);
        $('#escolaridad').val(emp.id_escolaridad);
        $('#scorreo').val(emp.email);
        $('#nacionalidad').val(emp.nacionalidad);
        $('#direccion').val(emp.direccion);
        $('#Text_city').val(emp.id_ciudad);
        $('#estrato').val(emp.id_estrato);
        $('#genero').val(emp.id_genero);
        $('#ecivil').val(emp.id_estadocivil);
        $('#pcargo').val(emp.cant_hijos);
        $('#TipoSangre').val(emp.id_tiposangre);
        $('#scelular').val(emp.celular);
        $('#sotrotel').val(emp.telefono);
        document.getElementById('ch_Discapasidad').checked = emp.discapasidad

        $('select.trabajador').selectpicker('refresh');
        $('#iden').blur();
        $('#ecivil').change();
        $("#pcargo").blur();
        $("#ch_Discapasidad").change();
        $('#id_tipoiden').change();

        window.gridcontrato.bootgrid('reload');
        var atri = $('#id_tipoiden').find('option:selected').attr('param');
        if (atri == 'PS' || atri == 'CE' || atri == 'TE') {

            $('#fechavenpas').val(emp.fechavenci_extran);
        }

        var atr = $('#ecivil').find('option:selected').attr('param');
        if (val != "" && atr != 'SOL') {

            $('#congenero').val(emp.congenero);
            $('#confecha_naci').val(emp.confecha_naci);
            $('#conprofesion').val(emp.conprofesion);
            $('#nconyuge').val(emp.connombres);
            $('#aconyuge').val(emp.conapellidos);
            $('#coniden').val(emp.coniden);

        }

        var isChecked = document.getElementById('ch_Discapasidad').checked
        if (isChecked) {

            $('#tipodis').val(emp.tipodiscapasidad);
            $('#porcentaje').val(emp.porcentajedis);
            $('#grado').val(emp.gradodis);
            $('#carnet').val(emp.carnetdis);
            $('#fechaexpdis').val(emp.fechaexpdis);
            $('#vencimiento').val(emp.vencimientodis);

        }


        var body = $('#tbodyhijos');
        body.empty();
        $.each(answer.Table, function (i, e) {
            tr = $('<tr/>').attr({ 'data-id': e.id, 'data-identificacion': e.identificacion, 'data-nombres': e.nombres, 'data-apellidos': e.apellidos, 'data-genero': e.genero, 'data-gen': e.textgen, 'data-profesion': e.profesion, 'data-profes': e.textprofe });
            a = $('<a/>').html('<span class="fa fa-2x fa-trash-o text-danger iconfa"></span>').click(function () {
                $(this).closest('tr').remove();
            })
            td = $('<td class="text-center"/>').append(a);
            td1 = $('<td class="text-center"/>').html(e.identificacion);
            td2 = $('<td class="text-center"/>').html(e.nombres);
            td3 = $('<td class="text-center"/>').html(e.apellidos);
            td4 = $('<td class="text-center"/>').html(e.textgen);
            td5 = $('<td class="text-center"/>').html(e.textprofe);
            td6 = $('<td class="text-center"/>').html();
            tr.append(td, td1, td2, td3, td4, td5, td6);
            body.append(tr);
        })

        $('select.trabajador').selectpicker('refresh');
        $('#btncontra').removeAttr('style', 'display: none;');
        $('#btnguardar').attr('disabled', 'disabled');

    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}

function EndCallbackGetContrato(Params, answer) {
    if (!answer.Error) {
        $('#dataempleado').attr('class', 'col-lg-12');
        $('#noneempleado').click();

        devengo = answer.Row;
        deduccion = answer.Table[0]
        totales = answer.Lista
        prestaciones = answer.Lista1

        console.log(devengo)
        console.log(deduccion)
        console.log(totales)
        console.log(prestaciones)        

        

        $('#hidcontrato').val(devengo.id);
        $('#salario').val(devengo.salario_X_dias);
        if ($('#salario').val() != "0") {
            $('#salarioDev').show();
            $('#salario').text('$ '+ devengo.salario_X_dias.Money())
        }
        $('#dias').val(devengo.diaspagar);
        if ($('#dias').val() != "0") {
            $('#diasDev').show();
            $('#dias').text(devengo.diaspagar);
        }
        $('#aux_trans').val(devengo.aux_transporte_X_dias);
        if ($('#aux_trans').val() != "0") {
            $('#aux_transDev').show();
            $('#aux_trans').text('$ ' + devengo.aux_transporte_X_dias.Money());
        }
        $('#rec_noc').val(devengo.REC_NOC);
        if ($('#rec_noc').val() != "0") {
            $('#rec_nocDev').show();
            $('#rec_noc').text('$ ' + devengo.REC_NOC.Money());
        }
        $('#H_extra').val(devengo.TOTAL_H_EXTRA);
        if ($('#H_extra').val() != "0") {
            $('#H_extraDev').show();
            $('#H_extra').text('$ ' + devengo.TOTAL_H_EXTRA.Money());
        }
        $('#bonifi').val(devengo.BONI);
        if ($('#bonifi').val() != "0") {
            $('#bonifiDev').show();
            $('#bonifi').text('$ ' + devengo.BONI.Money());
        }
        $('#comi').val(0);
        if ($('#comi').val() != "0") {
            $('#comiDev').show();
            $('#comi').text('$ ' + 0);
        }
        $('#deduccion').val(totales.TOTAL_DEDUCCION);
        if ($('#deduccion').val() != "0") {
            $('#deduccionDev').show();
            $('#deduccion').text('$ -' + totales.TOTAL_DEDUCCION.Money());
        }
        $('#total').val(totales.TOTAL_PAGAR);
        if ($('#total').val() != "0") {
            $('#totalDev').show();
            $('#total').text('$ ' + totales.TOTAL_PAGAR.Money());
        }

        

        $('#ibc').val(deduccion.IBC_SEGSOCIAL);
        if ($('#ibc').val() != "0") {
            $('#ibcDed').show();
            $('#ibc').text('$ ' + deduccion.IBC_SEGSOCIAL.Money());
        }
        $('#salud').val(deduccion.SALUD_EMPLEADOR);
        if ($('#salud').val() != "0") {
            $('#saludDed').show();
            $('#salud').text('$ ' + deduccion.SALUD_EMPLEADOR.Money());
            $('#saludp').text(deduccion.PORCEN_SALUDE.Money() + ' %');
        }
        $('#pension').val(deduccion.PENSION_EMPLEADOR);
        if ($('#pension').val() != "0") {
            $('#pensionDed').show();
            $('#pension').text('$ ' + deduccion.PENSION_EMPLEADOR.Money());
            $('#pensionp').text(deduccion.PORCEN_PENSIONE.Money() + ' %');
        }
        $('#totalded').val(totales.TOTAL_SEGURIDAD_SOCIAL_EMPLEADOR);
        if ($('#totalded').val() != "0") {
            $('#totalDed').show();
            $('#totalded').text('$ ' + deduccion.TOTAL_SEGURIDAD_SOCIAL_EMPLEADOR.Money());
        }
        //$('#centrocostra').val(contra.centrocosto);
        //document.getElementById('ch_jefe').checked = contra.jefe;
        //fieldsMoney();

        //$('input.contrato').attr('disabled', 'disabled');
        //$('select.contrato').attr('disabled', 'disabled');
        //$('#ch_jefe').attr('disabled', 'disabled');
        //$('select.contrato').selectpicker('refresh');

        //$('#tipocontrato').change();
        //$('#tiposal').change();
        //$('#cargo').change();
        //$('#formapago').change();

        //$('#btnnewscon').attr('style', 'display:none');

        //var atr = $('#tipocontrato').find('option:selected').attr('param');

        //if (!(atr == null || atr == '' || atr == 'INDEFINIDO')) {
        //    $('#fechafincontra').val(contra.fecha_final);
        //}

        //if (estado == 'CAN') {
        //    $('#fechafin').show();
        //    acomodarcheck(estado);
        //    $('#fechafincontra').val(contra.fecha_final);

        //}

        //var atri = $('#tiposal').find('option:selected').attr('param');

        //if (atri == 'OTRO') {
        //    $('#diaspag').val(contra.diasapagar);
        //}

        //var atrc = $('#cargo').find('option:selected').attr('param');

        //if (atrc == 'True') {
        //    $('#funesp').val(contra.funciones_esp);
        //}

        //var atrfpago = $('#formapago').find('option:selected').attr('param');

        //if (atrfpago == 'TRANS') {
        //    $('#ncuenta').val(contra.ncuenta);
        //    $('#tipocuenta').val(contra.tipo_cuenta);
        //    $('#banco').val(contra.banco);
        //}
        //$('#salario').val(contra.salario.Money());
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }

}

function toggleCC() {
    var fd = $('.fold');
    if (fd.is(':visible')) {
        fd.slideUp();
        $('#btnSearchClient').hide();
    }
    else {
        fd.slideDown();
        $('#btnSearchClient').show();
    }

}

function ResetForm() {

}

function ResetContraForm() {
    $('input.contrato').val('');
    $('select.contrato').val('');
    fieldsMoney();
    document.getElementById('ch_jefe').checked = false;
    $('#hidcontrato').val(0);


    $("#ch_jefe").change();
    $('#tipocontrato').change();
    $('#tiposal').change();
    $('#cargo').change();
    $('#formapago').change();


    $('input.contrato').removeAttr('disabled', 'disabled');
    $('select.contrato').removeAttr('disabled', 'disabled');
    $('#ch_jefe').removeAttr('disabled', 'disabled');
    $('select.contrato').selectpicker('refresh');
}

$('#filtroliq').change(function () {

    atr = $(this).find('option:selected').attr('param');

    if (atr != "" && atr != 'PERIOD') {
        $('.contra').show();
    } else {
        $('.contra').hide();
    }

});

$('#btnguardar').click(function () {
   
});

function EndCallbackSave(params, answer) {
    if (!answer.Error) {
        window.gridliquidacion.bootgrid('reload');
        $('#btnguardar').attr('disabled', 'disabled');
        toastr.info(answer.Message, 'Se guardó');

    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}

$('#iden').change(function () {
    params = {};
    params.id_persona = 0;
    params.iden = $(this).val();
    if (params.iden != "") {
        MethodService("LiquidacionNom", "EmpleadoGet", JSON.stringify(params), "EndCallbackGetTercero");
    }
});

function EndCallbackGetTercero(params, answer) {
    if (!answer.Error) {
        valorpordefecto(params);
        EndCallbackGet(params, answer);
        $('#btncontra').attr('style', 'display: none;');
    } else {
        toastr.error(answer.Message, 'Sintesis Creditos');
    }
}

function EndCallbackGetverificacion(params, answer) {
    if (!answer.Error) {
        if (!answer.Table.length == 0) {


            var SMMLV = answer.Table[0].valor * 1;
            var salario = SetNumber($('#salario').val()) * 1;


            if (SMMLV > salario) {
                toastr.error("el salario minimo es " + SMMLV, 'Sintesis ERP');
            }
            else {
                toastr.info("(Y)", 'Sintesis ERP');
            }

        } else {
            toastr.error('No se encuentra el parametro en la base de datos', 'Sintesis ERP');
        }
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }

}

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
                '" comi="' + $(e).data('comi') + '"></item>'
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
    params.xmlAusen = (Ausencias ? xmlAusen : '')
    params.xmlDeduc = (Deducciones ? xmlDeduc : '')

    params.id = $('#btnSaveNovedad').attr('data-id') == undefined ? 0 : $('#btnSaveNovedad').attr('data-id')
    params.id_contrato = $('#hidcontrato').val();
    params.id_periodo_contrato = $('#btnSaveNovedad').attr('data-id')

    bolean = true
    if ((!Devengos) | (!Ausencias) | (!Deducciones))
        bolean = confirm('Hay tablas vacias. \n¿Desea continuar?')

    if (bolean)
        MethodService("LiquidacionNom", "NovedadesSaveUpdate", JSON.stringify(params), "EndCallbackCesantias");

});

function EndCallbackCesantias(param, answer) {
    if (!answer.Error) {
        toastr.success('Proceso ejecutado exitosamente', 'Sintesis ERP')
        formReset();
        $('#ModalNovedades').modal('hide')
    } else {
        toastr.error(answer.Message, 'Sintesis ERP')
    }

}

function EndCallBackGetNovedad(param, answer) {
    formReset();
    $('h2.totales').text('$ 0.00')
    console.log(answer)

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
        $.each(data, function (i, e) {

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

$('#addDeven').on('click', function () {
    if (validate(ValidateDeven) & (($('#f_fin').val() > $('#f_ini').val()) | $('#f_ini').val() == '')) {

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
