var JsonValidate = [
    { id: 'id_tipoiden', type: 'TEXT', htmltype: 'SELECT', required: true, depends: false, iddepends: '' },
    { id: 'iden', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'fechaexp', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'pnombre', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'papellido', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'sapellido', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'fechacaci', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'profesion', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'universidad', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'escolaridad', type: 'TEXT', htmltype: 'SELECT', required: true, depends: false, iddepends: '' },
    { id: 'scorreo', type: 'EMAIL', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'nacionalidad', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'direccion', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'Text_city', type: 'TEXT', htmltype: 'SELECT', required: true, depends: false, iddepends: '' },
    { id: 'estrato', type: 'TEXT', htmltype: 'SELECT', required: true, depends: false, iddepends: '' },
    { id: 'genero', type: 'TEXT', htmltype: 'SELECT', required: true, depends: false, iddepends: '' },
    { id: 'ecivil', type: 'TEXT', htmltype: 'SELECT', required: true, depends: false, iddepends: '' },
    { id: 'pcargo', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'TipoSangre', type: 'TEXT', htmltype: 'SELECT', required: true, depends: false, iddepends: '' },
    { id: 'scelular', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'sotrotel', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' }
];
/*json que se usa para verificar que los campos no esten vacios*/
var JsonValidateDir = [{ id: 'tmpdireccion', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' }];

var JsonValidateextr = [{ id: 'fechavenpas', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' }];

var JsonValidateConyuge = [
    { id: 'congenero', type: 'TEXT', htmltype: 'SELECT', required: true, depends: false, iddepends: '' },
    { id: 'confecha_naci', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'conprofesion', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'nconyuge', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'aconyuge', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'coniden', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' }];

var JsonValidateDisca = [
    { id: 'tipodis', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'porcentaje', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'grado', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'carnet', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'fechaexpdis', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'vencimiento', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' }];

var JsonValidateRef = [
    { id: 'idenhijo', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'nombrehijo', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'apellhijo', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'hijogenero', type: 'TEXT', htmltype: 'SELECT', required: true, depends: false, iddepends: '' },
    { id: 'hijo_profesion', type: 'TEXT', htmltype: 'SELECT', required: true, depends: false, iddepends: '' }];

var JsonValidateContrato = [
    { id: 'contratacion', type: 'TEXT', htmltype: 'SELECT', required: true, depends: false, iddepends: '' },
    { id: 'tipocontrato', type: 'TEXT', htmltype: 'SELECT', required: true, depends: false, iddepends: '' },
    { id: 'tipocot', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'salario', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'tiponom', type: 'TEXT', htmltype: 'SELECT', required: true, depends: false, iddepends: '' },
    { id: 'fechainicontra', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'area', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'cargo', type: 'TEXT', htmltype: 'SELECT', required: true, depends: false, iddepends: '' },
    { id: 'horario', type: 'TEXT', htmltype: 'SELECT', required: true, depends: false, iddepends: '' },
    { id: 'eps', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'cesan', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'pen', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'cajacomp', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'formapago', type: 'TEXT', htmltype: 'SELECT', required: true, depends: false, iddepends: '' },
    { id: 'tipojor', type: 'TEXT', htmltype: 'SELECT', required: true, depends: false, iddepends: '' },
    { id: 'centrocosac', type: 'TEXT', htmltype: 'SELECT', required: true, depends: false, iddepends: '' },
    { id: 'centrocostra', type: 'TEXT', htmltype: 'SELECT', required: true, depends: false, iddepends: '' },
    { id: 'proce', type: 'TEXT', htmltype: 'SELECT', required: true, depends: false, iddepends: '' }];

var JsonValidateContratofecha = [{ id: 'fechafincontra', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' }];

var JsonValidateContratotiposal = [{ id: 'diaspag', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' }];

var JsonValidateContratocualjefe = [{ id: 'jefe', type: 'TEXT', htmltype: 'SELECT', required: true, depends: false, iddepends: '' }];

var JsonValidateContratojefe = [
    { id: 'ncuenta', type: 'TEXT', htmltype: 'TEXT', required: true, depends: false, iddepends: '' },
    { id: 'tipocuenta', type: 'TEXT', htmltype: 'SELECT', required: true, depends: false, iddepends: '' }];

window.gridempleado;
window.gridcontrato;

$('#programed').click(function () {
    ResetForm();
});

function Loadtable() {
    window.gridempleado = $("#tblEmpleado").bootgrid({
        ajax: true,
        post: function () {
            if ($("#filtrocen").val() == 0) {
                return {
                    'params': "",
                    'class': 'RHumanos',
                    'method': 'EmpleadoList'
                };
            } else {
                return {
                    'params': function () {
                        param = {
                            id_centro: $('#filtrocen').val()
                        };
                        return JSON.stringify(param);
                    },
                    'class': 'RHumanos',
                    'method': 'EmpleadoListfiltro'
                };
            }
        },
        url: window.appPath + "/Pages/Connectors/ConnectorList.ashx",
        formatters: {
            "ver": function (column, row) {
                return "<a class=\"action command-ver\" data-row-id=\"" + row.id + "\"><span class=\"fa-2x fa fa-eye iconfa\"></span></a>";
            },
            "contra": function (column, row) {
                return "<a class=\"action command-contra\" data-row-id=\"" + row.id + "\"><span class=\"fa fa-2x fa-plus text-success iconfa\"></span></a>";
            },
            "delete": function (column, row) {
                return "<a class=\"action command-delete\" data-row-id=\"" + row.id + "\"><span class=\"fa fa-2x fa-trash-o text-danger iconfa\"></span></a>";
            }
        }
    }).on("loaded.rs.jquery.bootgrid", function () {
        // Executes after data is loaded and rendered 
        window.gridempleado.find(".command-ver").on("click", function (e) {
            id = $(this).data("row-id");
            params = {};
            params.iden = null;
            params.id_persona = id;
            MethodService("RHumanos", "EmpleadoGet", JSON.stringify(params), 'EndCallbackGet');
        }).end().find(".command-delete").on("click", function (e) {
            if (confirm("Desea eliminar este Empleado?")) {
                id = $(this).data("row-id");
                params = {};
                params.id = id;
                MethodService("RHumanos", "EmpleadosDelete", JSON.stringify(params), 'EndCallbackupdate');
            }
        }).end().find(".command-contra").on("click", function (e) {
            id = $(this).data("row-id");
            params = {};
            params.id_empleado = id;
            MethodService("RHumanos", "ContratoPersona", JSON.stringify(params), 'EndCallbackContratoGetPersona');
        });
    });

    window.gridcontrato = $("#tblcontratop").bootgrid({
        ajax: true,
        post: function () {
            return {
                'params': function () {
                    param = {
                        id_empleado: $('#hidempleado').val()
                    };
                    return JSON.stringify(param);
                },
                'class': 'RHumanos',
                'method': 'ContratoList'
            };
        },
        url: window.appPath + "/Pages/Connectors/ConnectorList.ashx",
        formatters: {
            "ver": function (column, row) {
                return "<a class=\"action command-ver\" data-row-id=\"" + row.id + "\"><span class=\"fa-2x fa fa-eye iconfa\"></span></a>";
            },
            "salario": function (column, row) {
                return "<span class='tdedit action command-salario' data-type='numeric' data-column='salario' data-min='0' data-max='999999999999999999' data-simbol='$' data-value='" + row.salario + "' data-id='" + row.id + "'>" + row.salario.Money() + "</span>";
            },
            "estado": function (column, row) {
                return "<div class='tdedit stateclass command-edit' id='estadito" + row.id + "'' data-type='SELECT' data-idvalue='" + row.idestado + "' data-value= '" + row.estado + "' data-id='" + row.id + " '>" + row.estado + "</div>";
            }
        }
    }).on("loaded.rs.jquery.bootgrid", function () {
        if (window.gridcontrato.bootgrid("getCurrentRows").length > 0) {
            $('#tablacontrato').show();
        } else {
            $('#tablacontrato').hide();
        }
        // Executes after data is loaded and rendered 
        window.gridcontrato.find(".command-ver").on("click", function (e) {
            id = $(this).data("row-id")
            params = {};
            params.id = id;
            params.id_empleado = $('#hidempleado').val();
            MethodService("RHumanos", "ContratosGet", JSON.stringify(params), 'EndCallbackGetContrato');
        }).end().find(".command-edit").on("dblclick", function (e) {
            if ($(this).data('type') == 'SELECT' && $(this).data('value') == 'Vigente') {
                params = {};
                $(this).hide();
                data = $(this).data();
                tr = $(this).closest('td');
                var html = '';
                select = $('<select id="estado" class="select-css rowedit" data-value="' + $(this).attr('data-value') + '" data-oldvalue="' + $(this).attr('data-value') + '" data-size="2" data-id="' + $(this).attr('data-id') + '"/>');
                html = $('#htmlestado').val();
                select.html(html);
                oldvalue = $(this).attr('data-value');
                select.blur(function () {
                    var row = $(this).data();
                    newvalue = ($(this).val() == null) ? '0' : $(this).val();
                    oldvalue = $(this).attr('data-oldvalue');
                    value = $(this).attr('data-value');
                    if (newvalue != oldvalue && newvalue != '0') {
                        params = {};
                        params.id = row.id;
                        params.value = 0;
                        params.text = "";
                        MethodService("RHumanos", "ContratosUpdate", JSON.stringify(params), 'EndCallbackupdatecontrato');
                    } else {
                        tr = $(this).closest('td');
                        tr.find('div.tdedit').show();
                        $(this).remove();
                    }
                });
                select.change(function () {
                    var row = $(this).data();
                    newvalue = ($(this).val() == null) ? '0' : $(this).val();
                    oldvalue = $(this).attr('data-oldvalue');
                    value = $(this).attr('data-value');
                    if (newvalue != oldvalue && newvalue != '0') {
                        params = {};
                        params.id = row.id;
                        params.color = $(this).find('option:selected').attr('data-color');
                        params.value = select.val();
                        params.text = $(this).find('option:selected').html();
                        MethodService("RHumanos", "ContratosUpdate", JSON.stringify(params), 'EndCallbackupdatecontrato');
                    } else {
                        tr = $(this).closest('td');
                        $(this).closest('.bootstrap-select.rowedit').remove();
                        tr.find('div.tdedit').show();
                    }
                })
                tr.find('span.tdedit').hide();
                tr.append(select);
                data.idvalue = (data.idvalue == '0') ? '' : data.idvalue;
                tr.find('select').val(data.idvalue).focus();
                select.val(oldvalue);
            }
        });
    });
    fieldsMoney();
}

var salario = 0;
$(document).ready(function () {
    Loadtable();

    $('.inputaddress').click(function () {
        $('.inputaddress').removeClass('active');
        $(this).addClass('active');
        $('#comboaddress').val('').selectpicker('refresh');
        $('#tmpdireccion').focus();
    });

    salario = ($('#hidsalario').val() == null ? 0 : $('#hidsalario').val());
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

    $('#noneempleado').click(function () {
        $(".tblempleados").toggleClass('noneclient');
        $('#dataempleado').hide();
        $('.conve').removeAttr('style');
        $('.conve').attr('style', 'padding-top: 0 !important; padding-left: 2px !important;');
        $('.btnempleado').hide();
        $('.iconnew').show();
        $('#btnnews').attr('style', 'display : none');
    });

    $('.iconnew').click(function () {
        $(".tblempleados").toggleClass('noneclient');
        $('#dataempleado').show();
        $('.conve').removeAttr('style');
        $('.conve').attr('style', 'padding-top: 0 !important;');
        ResetForm();
        $(this).hide();
        $('.btnempleado').show();
        $('#atras').click();
        $('#btnnews').removeAttr('style', 'display : none');
        window.gridcontrato.bootgrid('reload');     
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
        } else
            $('.asigned').hide();

        $('.spanact').removeClass('active');
        $(this).addClass('active');
    });

    $('#filtrocen').change(function () {
        window.gridempleado.bootgrid('reload');
    });

    $("#certijudicial").fileinput('destroy');
    $("#certijudicial").fileinput({
        theme: 'fa',
        showUpload: false,
        uploadUrl: "D:\Proyectos Sintesis\Creditos\SintesisCloud\Cliente",
        dropZoneEnabled: false,
        maxFileCount: 1,
        mainClass: "input-group-lg",
        maxFilePreviewSize: 2000,
        allowedFileExtensions: ["pdf"]
    });

    $("#soporte").fileinput('destroy');
    $("#soporte").fileinput({
        theme: 'fa',
        showUpload: false,
        uploadUrl: "D:\Proyectos Sintesis\Creditos\SintesisCloud\Clientes",
        dropZoneEnabled: false,
        maxFileCount: 4,
        mainClass: "input-group-lg",
        showPreview: false,
        maxFilePreviewSize: 2000,
        removeFromPreviewOnError: true,
        allowedFileExtensions: ["pdf"]
    });
    /*carga la parte visual de los botones de la foto*/
    window.img = $('.dropify').dropify({
        messages: {
            default: '',
            replace: '',
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
});

function EndCallbackupdatecontrato(params, answer) {
    if (!answer.Error) {
        data = JSON.parse(params);
        select = $('select.rowedit');
        select.closest('td').find('div.tdedit').attr({ 'data-value': data.value, 'data-idvalue': data.id }).html(data.text).show();
        params = {};
        select.remove();
        window.gridempleado.bootgrid('reload');
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}

function EndCallbackupdate(params, answer) {
    if (!answer.Error) {
        window.gridempleado.bootgrid('reload');
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}

function EndCallbackGet(Params, answer) {
    if (!answer.Error) {
        if (Params.ter != 1) {
            $('.iconnew').click();
        }
        var emp = answer.Row
        $('#hidempleado').val((emp.id == null ? 0 : emp.id));
        $('#id_tipoiden').val((emp.tipoiden == null ? 0 : emp.tipoiden));
        $('#iden').val((emp.iden == null ? 0 : emp.iden));
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
        $('#btnguardar').attr('disabled', 'disabled');
        window.gridcontrato.bootgrid('reload');
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}

function EndCallbackContratoGetPersona(Params, answer) {
    if (!answer.Error) {
        ResetContraForm();
        data = answer.Row;
        $('#NombreEmp').val(data.razonsocial);
        $('#Iden').val(data.iden);
        $('.iconnew').click();
        $('#Contrato').removeAttr('style', 'display: none;');
        $('#Contrato').addClass('active');
        $('#tab-1').removeClass('active');
        $('#infopersonal').attr('style', 'display: none;');
        $('#infopersonal').removeClass('active');
        $('#tab-3').addClass('active');
        $('#btnguardar').attr('style', 'display: none;');
        $('#btnguardarcontra').attr('disabled', 'disabled');
        $('#btnguardarcontra').removeAttr('style', 'display: none;');
        $('#btnguardarcontra').attr('style', 'margin-right: 40px !important;"');
        $('#salario').val(salario);
        $('#hidempleado').val(data.id);
        $('#codContrato').val('');
        $('#btnnewscon').removeAttr('style', 'display: none;');
        $('#btnnews').attr('style', 'display: none;');
        //tiene que borrar el formulario de el contrato        
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}

function EndCallbackGetContrato(Params, answer) {
    if (!answer.Error) {

        $('#Contrato').removeAttr('style', 'display: none;');
        $('#Contrato').addClass('active');
        $('#tab-1').removeClass('active');
        $('#infopersonal').attr('style', 'display: none;');
        $('#infopersonal').removeClass('active');
        $('#tab-3').addClass('active');
        $('#atras').removeAttr('style', 'display: none;');
        $('#noneempleado').attr('style', 'display: none;');
        $('#btnguardar').attr('style', 'display: none;');
        $('#btnPrint').attr('style', 'margin-right: 40px !important;"');
        $('#btnnewscon').removeAttr('style', 'display: none;');
        $('#btnnews').attr('style', 'display: none;');
        var contra = answer.Row
        var estado = contra.estado
        $('#hidcontrato').val(contra.id);
        $('#hidempleado').val(contra.id_empleado);
        $('#NombreEmp').val(contra.razonsocial);
        $('#Iden').val(contra.iden);
        $('#codContrato').val(contra.codigo);
        $('#contratacion').val(contra.id_contratacion);
        $('#tipocontrato').val(contra.id_tipo_contrato);
        document.getElementById('ch_CotExtrangero').checked = contra.coti_extranjero;
        $('#id_tipocot').val(contra.id_tipo_cotizante);
        $('#tipocot').val(contra.tipo_cotizante);
        document.getElementById('ch_salinte').checked = contra.tipo_salario;
        $('#salario').val(contra.salario.Money());
        $('#tiponom').val(contra.tipo_nomina);
        $('#fechainicontra').val(contra.fecha_inicio);
        document.getElementById('ch_jefe').checked = contra.jefe;
        $('#id_jefe').val(contra.id_cual_jefe);
        $('#jefe').val(contra.cual_jefe);
        $('#id_area').val(contra.id_area);
        $('#area').val(contra.area);
        $('#cargo').val(contra.cargo);
        $('#horario').val(contra.id_horario);
        $('#id_eps').val(contra.id_eps);
        $('#eps').val(contra.eps);
        $('#id_cesan').val(contra.id_cesantias);
        $('#cesan').val(contra.cesantias);
        $('#id_pen').val(contra.id_pension);
        $('#pen').val(contra.pension);
        $('#id_cajacomp').val(contra.id_cajacomp);
        $('#cajacomp').val(contra.cajacomp);
        $('#formapago').val(contra.id_formapago);
        $('#tipojor').val(contra.tipo_jornada);
        $('#centrocosac').val(contra.sede_contratacion);
        $('#centrocostra').val(contra.centrocosto);
        document.getElementById('ch_ley').checked = contra.ley50;
        $('#proce').val(contra.procedimiento);
        fieldsMoney();
        $('input.contrato').attr('disabled', 'disabled');
        $('select.contrato').attr('disabled', 'disabled');
        $('.i-checks').attr('disabled', 'disabled');
        $('.i-checks').iCheck('update');
        $('#tipocontrato').change();
        $('#tiponom').change();
        $('#cargo').change();
        $('#formapago').change();
        $('#btnnewscon').attr('style', 'display:none');
        $('#atras').removeAttr('style', 'display:none');
        var atr = $('#tipocontrato').find('option:selected').attr('param');
        if (!(atr == null || atr == '' || atr == 'INDEFINIDO' || atr == 'OBRALABOR' || atr == 'MEDITIEMP')) {
            $('#fechafincontra').val(contra.fecha_final);
        }
        if (estado == 'CAN') {
            $('#fechafin').show();
            $('#fechafincontra').val(contra.fecha_final);
        }
        var atri = $('#tiponom').find('option:selected').attr('param');
        if (atri == 'OTRO') {
            $('#diaspag').val(contra.diasapagar);
        }
        var atrc = $('#cargo').find('option:selected').attr('param');
        if (atrc == 'True') {
            $('#funesp').val(contra.funciones_esp);
        }
        var atrfpago = $('#formapago').find('option:selected').attr('param');
        if (atrfpago == 'TRANS') {
            $('#ncuenta').val(contra.ncuenta);
            $('#tipocuenta').val(contra.tipo_cuenta);
            $('#banco').val(contra.banco);
        }
        $('select.contrato').selectpicker('refresh');
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}

$('#btnnews').click(function () {
    ResetForm();
});

function ResetForm() {
    $('input.trabajador').val('');
    $('select.trabajador').val('');
    fieldsMoney();
    $('select.trabajador').selectpicker('refresh');
    $('#iden').blur();
    $('#ecivil').change();
    $("#pcargo").blur();
    document.getElementById('ch_Discapasidad').checked = false;
    $('#hidempleado').val(0);
    $("#ch_Discapasidad").change();
    $('#id_tipoiden').change();
    $('#btnguardar').attr('disabled', 'disabled');
}

function ResetContraForm() {
    $('input.contrato').val('');
    $('select.contrato').val('');
    fieldsMoney();
    $('#hidcontrato').val(0);
    $('#hidhorario').val(0);
    $('.i-checks').iCheck('uncheck');
    $('#tipocontrato').change();
    $('#tiponom').change();
    $('#cargo').change();
    $('#formapago').change();
    $('input.contrato').removeAttr('disabled', 'disabled');
    $('select.contrato').removeAttr('disabled', 'disabled');
    $('.i-checks').removeAttr('disabled', 'disabled');
    $('select.contrato').selectpicker('refresh');
}

$('#atras').click(function () {
    $('#noneempleado').removeAttr('style', 'display: none;');
    $('#btnnewscon').attr('style', 'display: none;');
    $('#btnPrint').attr('style', 'display: none;');
    $('#btnnews').removeAttr('style', 'display: none;');
    $('#infopersonal').removeAttr('style', 'display: none;');
    $('#infopersonal').addClass('active');
    $('#tab-3').removeClass('active');
    $('#Contrato').attr('style', 'display: none;');
    $('#Contrato').removeClass('active');
    $('#tab-1').addClass('active');
    $('.i-checks').removeAttr('disabled', 'disabled');
    $('.i-checks').iCheck('update');
    $(this).attr('style', 'display: none;');
    $('#btnguardar').removeAttr('style', 'display: none;');
    $('#btnguardar').attr('style', 'margin-right: 40px !important;"');
    $('#btnguardarcontra').attr('style', 'display: none;');
    $('#btnguardarcontra').attr('disabled', 'disabled');
    $('#horario').hide();
});

$('#btnnewscon').click(function () {
    ResetContraForm();
    $('#btnguardarcontra').attr('disabled', 'disabled');
})

$('.trabajador').change(function () {
    $('#btnguardar').removeAttr('disabled', 'disabled');
});

$('.contrato').change(function () {
    $('#btnguardarcontra').removeAttr('disabled', 'disabled');
});

$("#ch_Discapasidad").change(function (event) {
    (event.target.checked) ? $('.discapasidad').removeAttr('style', 'display:none;') && $('.discapasidad').attr('style', 'display:block;') : $('.discapasidad').removeAttr('style', 'display:block;') && $('.discapasidad').attr('style', 'display:none;');
});

$("#ch_salinte").on('ifChanged', function (event) {
    (event.target.checked) ? $('#hidsalario').val($('#salario').val()) && $('#salario').val($('#hidsalarioIntegral').val()) : $('#salario').val($('#hidsalario').val());
    fieldsMoney();
})

$("#pcargo").blur(function () {
    if ($("#pcargo").val() != 0) {
        $("#tablahijos").show();
    }
    else {
        $("#tablahijos").hide();
    }
});

$('#ecivil').change(function () {
    val = $(this).val();
    atr = $(this).find('option:selected').attr('param');
    if (val != "" && atr != 'SOL') {
        $('.conyuge').removeAttr('style', 'display:none;');
        $('.conyuge').attr('style', 'display:block;');
    } else {
        $('.conyuge').removeAttr('style', 'display:block;');
        $('.conyuge').attr('style', 'display:none;');
    }
    $('select.conyuge').selectpicker('refresh');
});

$('#addref').click(function () {
    var tabla = $('#tbodyhijos')[0].childElementCount
    if (tabla < $('#pcargo').val()) {
        if (validate(JsonValidateRef)) {
            genero = $('#hijogenero').val();
            textgen = $('#hijogenero option:selected').text();
            nom = $('#nombrehijo').val();
            ape = $('#apellhijo').val();
            iden = $('#idenhijo').val();
            profe = $('#hijo_profesion').val();
            textprofe = $('#hijo_profesion option:selected').text();
            var body = $('#tbodyhijos');
            tr = $('<tr/>').attr({ 'data-id': '0', 'data-identificacion': iden, 'data-nombres': nom, 'data-apellidos': ape, 'data-genero': genero, 'data-gen': textgen, 'data-profesion': profe, 'data-profes': textprofe });
            a = $('<a/>').html('<span class="fa fa-2x fa-trash-o text-danger iconfa"></span>').click(function () {
                $(this).closest('tr').remove();
            })
            td = $('<td class="text-center"/>').append(a);
            td1 = $('<td class="text-center"/>').html(iden);
            td2 = $('<td class="text-center"/>').html(nom);
            td3 = $('<td class="text-center"/>').html(ape);
            td4 = $('<td class="text-center"/>').html(textgen);
            td5 = $('<td class="text-center"/>').html(textprofe);
            td6 = $('<td class="text-center"/>').html();
            tr.append(td, td1, td2, td3, td4, td5, td6);
            body.append(tr);
            $('#nombrehijo, #apellhijo, #idenhijo, #hijogenero, #hijo_profesion').val('');
            $('#hijogenero, #hijo_profesion').selectpicker('refresh');
        }
    }
    else {
        toastr.warning('no puede ingresar mas hijos de los registrados', 'Sintesis ERP');
    }
});

$('#id_tipoiden').change(function () {
    val = $(this).val();
    atr = $(this).find('option:selected').attr('param');
    if (atr == 'PS' || atr == 'CE' || atr == 'TE') {
        $('input.extran').val('');
        $('.extran').removeAttr('style', 'display: none;');
        $('.extran').attr('style', 'display: block;');
    } else {
        $('.extran').removeAttr('style', 'display: block;');
        $('.extran').attr('style', 'display: none;');
    }
});

function valorpordefecto(params) {
    params.id_empleado = null;
    params.tipoiden = null;
    params.iden = null;
    params.digverificacion = null;
    params.fechaexp = null;
    params.pnombre = null;
    params.snombre = null;
    params.papellido = null;
    params.sapellido = null;
    params.fechanaci = null;
    params.profesion = null;
    params.universidad = null;
    params.escolaridad = null;
    params.correo = null;
    params.nacionalidad = null;
    params.direccion = null;
    params.ciudad = null;
    params.estrato = null;
    params.genero = null;
    params.ecivil = null;
    params.hijos = null;
    params.TipoSangre = null;
    params.celular = null;
    params.fijo = null;
    params.discapasidad = null;
    params.fechavenidenext = null;
    params.congenero = null;
    params.confecha_naci = null;
    params.conprofesion = null;
    params.nconyuge = null;
    params.aconyuge = null;
    params.coniden = null;
    params.tipodiscapasidad = null;
    params.porcentaje = null;
    params.grado = null;
    params.carnet = null;
    params.fechaexpdiscapasidad = null;
    params.vencimiento = null;
    params.infohijos = null;
    //contrato
    params.id_contrato = null;
    params.contratacion = null;
    params.tipocontra = null;
    params.cotextranjero = null;
    params.tipocotizante = null;
    params.tiposalario = null;
    params.salario = null;
    params.tiponom = null;
    params.fecha_inicio = null;
    params.cargo = null;
    params.jefe = null;
    params.area = null;
    params.eps = null;
    params.cesantias = null;
    params.pension = null;
    params.cajacomp = null;
    params.formapago = null;
    params.tipojor = null;
    params.lugar_contra = null;
    params.lugar_laborar = null;
    params.fecha_fin = null;
    params.dias_pago = null;
    params.funciones_esp = null;
    params.jefedirecto = null;
    params.numcuenta = null;
    params.banco = null;
    params.tipo_cuenta = null;
    params.convenio = null;
    params.id_horario = null;
    return params
}

$('#btnguardar').click(function () {
    if (validate(JsonValidate)) {
        //console.log($('#soporte').fileinput('readFiles', files));
        var error = 0;
        var params = {}
        valorpordefecto(params);
        /*var temp = foto.split("token=");
        var temp2 = temp[0].split("Pages");
        if ((foto == null || foto == "") || temp2[1] == '/Connectors/ConnectorGetFile.ashx?') {
            params.urlimg = temp[1];
        } else {
            params.urlimg = foto;
        }
        params.nameFile = "EM" + $('#iden').val();*/
        params.id_empleado = $('#hidempleado').val();
        params.tipoiden = $('#id_tipoiden').val();
        params.iden = $('#iden').val();
        params.digverificacion = $('#identificacion').text();
        params.fechaexp = $('#fechaexp').val();
        params.pnombre = $('#pnombre').val();
        params.snombre = $('#snombre').val();
        params.papellido = $('#papellido').val();
        params.sapellido = $('#sapellido').val();
        params.fechanaci = $('#fechacaci').val();
        params.profesion = $('#profesion').val();
        params.universidad = $('#universidad').val();
        params.escolaridad = $('#escolaridad').val();
        params.correo = $('#scorreo').val();
        params.nacionalidad = $('#nacionalidad').val();
        params.direccion = $('#direccion').val();
        params.ciudad = $('#Text_city').val();
        params.estrato = $('#estrato').val();
        params.genero = $('#genero').val();
        params.ecivil = $('#ecivil').val();
        params.hijos = $('#pcargo').val();
        params.TipoSangre = $('#TipoSangre').val();
        params.celular = $('#scelular').val();
        params.fijo = $('#sotrotel').val();
        params.discapasidad = document.getElementById('ch_Discapasidad').checked
        var atri = $('#id_tipoiden').find('option:selected').attr('param');
        if (atri == 'PS' || atri == 'CE' || atri == 'TE') {
            if (validate(JsonValidateextr))
                params.fechavenidenext = $('#fechavenpas').val();
        }
        var atr = $('#ecivil').find('option:selected').attr('param');
        if (val != "" && atr != 'SOL') {
            if (validate(JsonValidateConyuge)) {
                params.congenero = $('#congenero').val();
                params.confecha_naci = $('#confecha_naci').val();
                params.conprofesion = $('#conprofesion').val();
                params.nconyuge = $('#nconyuge').val();
                params.aconyuge = $('#aconyuge').val();
                params.coniden = $('#coniden').val();
            }
        }
        var isChecked = document.getElementById('ch_Discapasidad').checked
        if (isChecked) {
            if (validate(JsonValidateDisca)) {
                params.tipodiscapasidad = $('#tipodis').val();
                params.porcentaje = $('#porcentaje').val();
                params.grado = $('#grado').val();
                params.carnet = $('#carnet').val();
                params.fechaexpdiscapasidad = $('#fechaexpdis').val();
                params.vencimiento = $('#vencimiento').val();
            }
        }
        if (params.hijos != null || params.hijos != '') {
            var tabla = $('#tbodyhijos')[0].childElementCount
            params.hijos = params.hijos * 1;
            if (params.hijos != 0) {
                if (params.hijos == tabla) {
                    trs = $('#tbodyhijos').find('tr');
                    xml = "";
                    if (trs.length > 0) {
                        $.each(trs, function (i, e) {
                            data = $(e).data();
                            xml += '<item id="' + data.id + '" Identificacion="' + data.identificacion + '" Nombres="' + data.nombres + '" Apellidos="' + data.apellidos + '" Genero="' + data.genero + '" profesion="' + data.profesion + '" />'
                        });
                        xml = "<items>" + xml + "</items>"
                    }
                    params.infohijos = xml;
                }
                else {
                    error += 1;
                    toastr.error("La cantidad de hijos no coincide con los marcados.", 'Sintesis ERP');
                }
            }
        }
        if (error == 0) {
            MethodService("RHumanos", "EmpleadoSave", JSON.stringify(params), "EndCallbackSave");
        }
    }
});
/* guarda los archivos que se suben en la parte inferior del formulario */
/*function UploadFiles(Params, datos) {
    EnabledFinish(true);
    var data = new FormData();
    var ds_fileUpload = $('#certijudicial').get(0);
    var ds_fileUpload1 = $('#certijudicial').get(0);
    var ds_files = ds_fileUpload.files;
    var ds_files1 = ds_fileUpload1.files;
    var archivos = false;
    for (var i = 0; i < ds_files.length; i++) {
        filename = ds_files[i].name;
        data.append(ds_files[i].name, ds_files[i]);
    }
    for (var i = 0; i < ds_files1.length; i++) {
        filename = ds_files1[i].name;
        data.append(ds_files1[i].name, ds_files1[i]);
    }
    var temp = foto.split("token=");
    var temp2 = temp[0].split("Pages")
    if (temp2[1] != '/Connectors/ConnectorGetFile.ashx?') {
        var file = dataURLtoFile($canvas.toDataURL(), 'FotoEmpleados_Sintesis.png');
        data.append(file.name, file);
    }
    if (data != undefined)
        archivos = true;
    if (archivos) {
        toastr.info("Subiendo Archivos.", 'Sintesis ERP');
        var par = JSON.parse(Params);
        params = {};
        params.iden = par.iden;
        params.id_empleado = datos.Row.consecutivo;
        params.id_solicitud = datos.Row.clavesolicitud;
        params.tipoper = par.tipo;
        params.fileDate = "S";
        MethodUploadsFiles("Solicitudes", "SolicitudesSaveFiles", data, JSON.stringify(params), "EndCallbackSaveFile");
    }
    else {
        toastr.warning("No hay archivos para subir", 'Sintesis ERP');
        EnabledFinish(false);
    }
}*/

$('#btnguardarcontra').click(function () {
    if (validate(JsonValidateContrato)) {
        var params = {}
        valorpordefecto(params);
        params.id_contrato = $('#hidcontrato').val();
        params.id_empleado = $('#hidempleado').val();
        params.contratacion = $('#contratacion').val();
        params.tipocontra = $('#tipocontrato').val();
        params.cotextranjero = document.getElementById('ch_CotExtrangero').checked;
        params.tipocotizante = $('#id_tipocot').val();
        var cheq = document.getElementById('ch_salinte').checked;
        if (cheq) {
            params.tiposalario = 'INTEGRAL';
        } else {
            params.tiposalario = 'FIJO';
        }
        params.salario = SetNumber($('#salario').val());
        params.tiponom = $('#tiponom').val();
        params.fecha_inicio = $('#fechainicontra').val().replace('-', '');
        params.jefe = document.getElementById('ch_jefe').checked;
        params.area = $('#id_area').val();
        params.cargo = $('#cargo').val();
        params.id_horario = $('#horario').val();
        params.eps = $('#id_eps').val();
        params.cesantias = $('#id_cesan').val();
        params.pension = $('#id_pen').val();
        params.cajacomp = $('#id_cajacomp').val();
        params.formapago = $('#formapago').val();
        params.tipojor = $('#tipojor').val();
        params.lugar_contra = $('#centrocosac').val();
        params.lugar_laborar = $('#centrocostra').val();
        params.convenio = document.getElementById('ch_Convenio').checked;
        params.ley50 = document.getElementById('ch_ley').checked;
        params.procedimiento = $('#proce').val();
        var atr = $('#tipocontrato').find('option:selected').attr('param');
        if (!(atr == null || atr == '' || atr == 'INDEFINIDO' || atr == 'OBRALABOR' || atr == 'MEDITIEMP')) {
            if (validate(JsonValidateContratofecha))
                params.fecha_fin = $('#fechafincontra').val().replace('-', '');
        } else if (atr == 'PRESSERVIS') {
            params.fecha_fin = ($('#fechafincontra').val() == '' ? null : $('#fechafincontra').val().replace('-', ''));
        }
        var atri = $('#tiponom').find('option:selected').attr('param');
        switch (atri) {
            case 'OTRO':
                if (validate(JsonValidateContratotiposal)) {
                    params.dias_pago = $('#diaspag').val();
                }
                break;
            case 'QUIN':
                params.dias_pago = 15;
                break;
            case 'MEN':
                params.dias_pago = 30;
                break;
            case 'SEM':
                params.dias_pago = 7;
                break;
        }
        var atrc = $('#cargo').find('option:selected').attr('param');
        if (atrc == 'True') {
            params.funciones_esp = $('#funesp').val();
        }
        var isChecked = document.getElementById('ch_jefe').checked
        if (!isChecked) {
            if (validate(JsonValidateContratocualjefe)) {
                params.jefedirecto = $('#id_jefe').val();
            }
        } else {
            params.jefedirecto = ($('#id_jefe').val() == '' ? null : $('#id_jefe').val());
        }
        var atrfpago = $('#formapago').find('option:selected').attr('param');
        if (atrfpago == 'TRANS') {
            params.numcuenta = $('#ncuenta').val();
            params.tipo_cuenta = $('#tipocuenta').val();
            params.banco = $('#banco').val();
        }
        MethodService("RHumanos", "ContratoSave", JSON.stringify(params), "EndCallbackSaveContrato");
    }
});

function EndCallbackSave(params, answer) {
    if (!answer.Error) {
        window.gridempleado.bootgrid('reload');
        $('#btnguardar').attr('disabled', 'disabled');
        //UploadFiles(params, answer);
        $('#noneempleado').click();
        toastr.info(answer.Message, 'Se guardó');
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}

function EndCallbackSaveContrato(params, answer) {
    if (!answer.Error) {
        $('#codContrato').val(answer.Row.consecutivo);
        window.gridempleado.bootgrid('reload');
        window.gridcontrato.bootgrid('reload');
        $('#btnguardarcontra').attr('disabled', 'disabled;');
        toastr.info('El contrato se creó exitosamente', 'Sintesis ERP');
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}

$('#iden').change(function () {
    params = {};
    params.id_persona = $('#hidempleado').val();
    params.iden = $(this).val();
    if (params.iden != "") {
        MethodService("RHumanos", "EmpleadoGet", JSON.stringify(params), "EndCallbackGetTercero");
    }
});

function EndCallbackGetTercero(params, answer) {
    if (!answer.Error) {
        params = {};
        params.ter = 1;
        EndCallbackGet(params, answer);
    } else {
        toastr.error(answer.Message, 'Sintesis Creditos');
    }
}
/*al salir de el input de identificación, se carga el 
 digito de verificación*/
$('#iden').blur(function () {
    var value = $(this).val();
    $('#identificacion').text(calcularDigitoVerificacion(value));
});
//cargar esta funcion en la master, para que sea general
/*calcula el digito de verificación, teniendo en cuenta 
 el valor de cada digito y la pocición del mismo*/
function calcularDigitoVerificacion(myNit) {
    var vpri,
        x,
        y,
        z;
    // Se limpia el Nit
    myNit = myNit.replace(/\s/g, ""); // Espacios
    myNit = myNit.replace(/,/g, ""); // Comas
    myNit = myNit.replace(/\./g, ""); // Puntos
    myNit = myNit.replace(/-/g, ""); // Guiones
    // Se valida el nit
    if (isNaN(myNit)) {
        toastr.info("La Identificación '" + myNit + "' no tiene Digito de verificación.", 'Sintesis Creditos');
        return "";
    };
    // Procedimiento
    vpri = new Array(16);
    z = myNit.length;
    vpri[1] = 3;
    vpri[2] = 7;
    vpri[3] = 13;
    vpri[4] = 17;
    vpri[5] = 19;
    vpri[6] = 23;
    vpri[7] = 29;
    vpri[8] = 37;
    vpri[9] = 41;
    vpri[10] = 43;
    vpri[11] = 47;
    vpri[12] = 53;
    vpri[13] = 59;
    vpri[14] = 67;
    vpri[15] = 71;
    x = 0;
    y = 0;
    for (var i = 0; i < z; i++) {
        y = (myNit.substr(i, 1));
        // console.log ( y + "x" + vpri[z-i] + ":" ) ;
        x += (y * vpri[z - i]);
        // console.log ( x ) ; 
    }
    y = x % 11;
    // console.log ( y ) ;
    return (y > 1) ? 11 - y : y;
}

$('#tipocontrato').change(function () {
    var atr = $(this).find('option:selected').attr('param');
    if (atr == null || atr == '' || atr == 'INDEFINIDO' || atr == 'OBRALABOR' || atr == 'MEDITIEMP') {
        $('#fechafin').hide();
    }
    else {
        $('#fechafin').show();
        if (atr == 'PRESSERVIS') {
            toastr.info('NO ES OBLIGATORIO llenar el campo de finalización', 'Sintesis Creditos');
        }
    }
});

$('#salario').change(function () {
    var SMMLV = $('#hidsalario').val() * 1;
    var salario = SetNumber($('#salario').val()) * 1;
    if (SMMLV != 0) {
        if (document.getElementById('ch_salinte').checked) {
            if (salario < $('#hidsalarioIntegral').val() * 1) {
                toastr.warning("El minimo para el salario integral es " + $('#hidsalarioIntegral').val().Money(), 'Sintesis ERP');
                $('#salario').val($('#hidsalarioIntegral').val());
                fieldsMoney();
            }
        }else if (SMMLV > salario) {
            toastr.warning("El salario minimo es " + SMMLV.Money(), 'Sintesis ERP');
        }
    } else {
        toastr.warning("No se han parametrizado los parametros anuales", 'Sintesis ERP');
    }
});

$('#tiponom').change(function () {
    var atr = $(this).find('option:selected').attr('param');
    if (atr == 'OTRO') {
        $('.diasparapag').show();
    }
    else {
        $('.diasparapag').hide();
    }
});

$('#cargo').change(function () {
    var atr = $(this).find('option:selected').attr('param');
    if (atr == 'True') {
        toastr.info('Este cargo puede tener funciones especificas, de no tenerlas NO llenar el campo', 'Sintesis ERP');
        $('.cargo').show();
    } else {
        $('.cargo').hide();
    }
});

$('#formapago').change(function () {
    var atr = $(this).find('option:selected').attr('param');
    if (atr == 'TRANS') {
        $('.formpago').show();
    } else {
        $('.formpago').hide();
    }
});

$('#contratacion').change(function () {
    var atrs = $(this).find('option:selected').attr('param');
    if (atrs != null) {
        params = {};
        params.op = 'TIPOCONTRAT';
        params.contratacion = ($('#contratacion').val() == '') ? '0' : $('#contratacion').val();
        MethodService("RHumanos", "CargarListadotipocontrato", JSON.stringify(params), 'EndCallbackGetSelect');
    }
});

function EndCallbackGetSelect(params, answer) {
    if (!answer.Error) {
        option = "<option value='' param=''>Seleccione</option>";
        tipo_contrato = $('#tipocontrato');
        tipo_contrato.empty();
        data = answer.Table;
        if (!data.length == 0) {
            $.each(data, function (i, e) {
                option += "<option value='" + e.id + "' param='" + e.param + "'>" + e.name + "</option>";
            });
            tipo_contrato.html(option).selectpicker('refresh');
        } else {
            tipo_contrato.html("<option value=''>Seleccione</option>").selectpicker('refresh');
        }
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}

var fotoget;
/*al precionar el campo de foto, muestra el modal, detecta las camaras conectadas 
 (incluyendo la web cam si nes portatil) y la activa, dando prioridad a la camara conectada*/
//$('#foto').click(function () {
//    $('#ModalFoto').modal({ backdrop: 'static', keyboard: false }, "show");
//    $('#previa').val($('#foto').val());
//    //$('.dropify-clear').click();
//    (function () {
//        // Comenzamos viendo si tiene soporte, si no, nos detenemos
//        if (!tieneSoporteUserMedia()) {
//            alert("Lo siento. Tu navegador no soporta esta característica");
//            $estado.innerHTML = "Parece que tu navegador no soporta esta característica. Intenta actualizarlo.";
//            return;
//        }
//        //Aquí guardaremos el stream globalmente
//        let stream;
//        // Comenzamos pidiendo los dispositivos
//        navigator
//            .mediaDevices
//            .enumerateDevices()
//            .then(function (dispositivos) {
//                // Vamos a filtrarlos y guardar aquí los de vídeo
//                const dispositivosDeVideo = [];
//                // Recorrer y filtrar
//                dispositivos.forEach(function (dispositivo) {
//                    const tipo = dispositivo.kind;
//                    if (tipo === "videoinput") {
//                        dispositivosDeVideo.push(dispositivo);
//                    }
//                });
//                // Vemos si encontramos algún dispositivo, y en caso de que si, entonces llamamos a la función
//                // y le pasamos el id de dispositivo
//                if (dispositivosDeVideo.length > 0) {
//                    // Mostrar stream con el ID del primer dispositivo, luego el usuario puede cambiar
//                    if (dispositivosDeVideo[1] != null) {
//                        mostrarStream(dispositivosDeVideo[1].deviceId);
//                    }
//                    mostrarStream(dispositivosDeVideo[0].deviceId);
//                }
//            });
//        const mostrarStream = idDeDispositivo => {
//            _getUserMedia(
//                {
//                    video: {
//                        // Justo aquí indicamos cuál dispositivo usar
//                        deviceId: idDeDispositivo,
//                    }
//                },
//                function (streamObtenido) {
//                    // Aquí ya tenemos permisos, ahora sí llenamos el select,
//                    // pues si no, no nos daría el nombre de los dispositivos
//                    //llenarSelectConDispositivosDisponibles();

//                    // Escuchar cuando seleccionen otra opción y entonces llamar a esta función
//                    $listaDeDispositivos.onchange = () => {
//                        // Detener el stream
//                        if (stream) {
//                            $localstream = stream;
//                            stream.getTracks().forEach(function (track) {
//                                track.stop();
//                            });
//                        }
//                        // Mostrar el nuevo stream con el dispositivo seleccionado
//                        mostrarStream($listaDeDispositivos.value);
//                    }
//                    // Simple asignación
//                    stream = streamObtenido;
//                    // Mandamos el stream de la cámara al elemento de vídeo
//                    $video.srcObject = stream;
//                    $video.play();
//                    //Escuchar el click del botón para tomar la foto
//                    $boton.addEventListener("click", function () {
//                        //Pausar reproducción
//                        $video.pause();
//                        //Obtener contexto del canvas y dibujar sobre él
//                        let contexto = $canvas.getContext("2d");
//                        $canvas.width = $video.videoWidth;
//                        $canvas.height = $video.videoHeight;
//                        contexto.drawImage($video, 0, 0, $canvas.width, $canvas.height);
//                        let foto = $canvas.toDataURL(); //Esta es la foto, en base 64
//                        //Reanudar reproducción
//                        $video.play();
//                    });
//                }, function (error) {
//                    toastr.error("Permiso denegado o error: ", error);
//                    $estado.innerHTML = "No se puede acceder a la cámara, o no diste permiso.";
//                });
//        }
//    })();


//});
///*verifica que el navegador pueda soportar la carga de la transmición 
// de la camara sea externa o la webcam*/
//function tieneSoporteUserMedia() {
//    return !!(navigator.getUserMedia || (navigator.mozGetUserMedia || navigator.mediaDevices.getUserMedia) || navigator.webkitGetUserMedia || navigator.msGetUserMedia)
//}
///*en conjunto co ls función anterior*/
//function _getUserMedia() {
//    return (navigator.getUserMedia || (navigator.mozGetUserMedia || navigator.mediaDevices.getUserMedia) || navigator.webkitGetUserMedia || navigator.msGetUserMedia).apply(navigator, arguments);
//}
///*Declaramos estas constasntes que son necesarias para 
// manejar el funcionamiento de la camara y capturar la imagen*/
//const $video = document.querySelector("#video"),
//    $canvas = document.querySelector("#canvas"),
//    $boton = document.querySelector("#boton"),
//    $estado = document.querySelector("#estado"),
//    $listaDeDispositivos = document.querySelector("#listaDeDispositivos");
///*y estas vaiables se declaran de manera global puesto que 
// se utilizan en 2 funciones completamente diferentes*/
//var localstream = null;
//foto = '';
///*La función que es llamada después de que ya se dieron los permisos
// Lo que hace es verifica los dispositivos obtenidos*/
//const llenarSelectConDispositivosDisponibles = () => {
//    navigator
//        .mediaDevices
//        .enumerateDevices()
//        .then(function (dispositivos) {
//            const dispositivosDeVideo = [];
//            dispositivos.forEach(function (dispositivo) {
//                const tipo = dispositivo.kind;
//                if (tipo === "videoinput") {
//                    dispositivosDeVideo.push(dispositivo);
//                }
//            });
//            // Vemos si encontramos algún dispositivo, y en caso de que si, entonces llamamos a la función
//            if (dispositivosDeVideo.length > 0) {
//                // Llenar el select
//                dispositivosDeVideo.forEach(dispositivo => {
//                    const option = document.createElement('option');
//                    option.value = dispositivo.deviceId;
//                    option.text = dispositivo.label;
//                    $listaDeDispositivos.appendChild(option);
//                    //$('#listaDeDispositivos').attr($listaDeDispositivos);
//                    //console.log("$listaDeDispositivos => ", $listaDeDispositivos)
//                });
//            }
//        });
//}
///*al hacer clic ya sea en el botón de la camara o en el recuadro de la 
// vista previa, captuta la imagen que sevea en la camara*/
//$('#boton, #previa').click(function () {
//    //Pausar reproducción
//    $video.pause();
//    //Obtener contexto del canvas y dibujar sobre él
//    var contexto = $canvas.getContext("2d");
//    $canvas.width = $video.videoWidth;
//    $canvas.height = $video.videoHeight;
//    contexto.drawImage($video, 0, 0, $canvas.width, $canvas.height);
//    foto = $canvas.toDataURL(); //Esta es la foto, en base 64
//    $('.dropify-render').empty();
//    $('.dropify-filename').empty();
//    $('.dropify-wrapper').attr('class', 'dropify-wrapper has-preview');
//    $('.dropify-preview').attr('style', 'display: block;');
//    $('.dropify-render').append('<img src="' + foto + '" style="max-heigth:205px">');
//    $('.dropify-filename').append('<span class="dropify-filename-inner">' + $('#tipoper').val() + '' + $('#iden').val() + '</span>');
//    //Reanudar reproducción
//    $video.play();
//});
///*cancela la foto tomada y borra los 2 recuadros de vista previa*/
//$('#btnCancelPhoto, .salgo').click(function () {
//    $('.dropify-clear').click();
//    video.srcObject.getTracks().forEach(function (track) {
//        track.stop();
//    });
//});
///*guarda la imagen tomada y la muestra en el lugar de la foto*/
//$('#btnSavePhoto').click(function () {
//    video.srcObject.getTracks().forEach(function (track) {
//        track.stop();
//    });
//});