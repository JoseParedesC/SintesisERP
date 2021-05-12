//Vector  de validación
var JsonValidate = [{ id: 'tipohora', type: 'TEXT', htmltype: 'SELECT', required: true, depends: false, iddepends: '' },
{ id: 'nombre', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' }];

var JsonValidatehora = [{ id: 'horaini', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'horainides', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'horafindes', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'horafin', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' }];

var JsonValidatesab = [{ id: 'horainisab', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'horafinsab', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' }];

var JsonValidatecant = [{ id: 'cadadia', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' }];

var JsonValidateirreg = [{ id: 'cantdiastr', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'cantdiasds', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' }];



window.gridchorario;
//Funcion para el cargado de la información en la tabla de listado de las bodegas ya guardadas.
function Loadtable() {
    window.gridchorario = $("#tblcargo").bootgrid({
        ajax: true,
        post: function () {
            return {
                'params': "",
                'class': 'Horario',
                'method': 'HorarioList'
            };
        },
        url: window.appPath + "/Pages/Connectors/ConnectorList.ashx",
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
        window.gridchorario.find(".command-edit").on("click", function (e) {
            removeerror();
            id = $(this).data("row-id")
            params = {};
            params.id = id;
            MethodService("Horario", "HorarioGet", JSON.stringify(params), 'EndCallbackGet');
        }).end().find(".command-delete").on("click", function (e) {
            if (confirm("Desea eliminar este Horario?")) {
                id = $(this).data("row-id");
                params = {};
                params.id = id;
                MethodService("Horario", "HorarioDelete", JSON.stringify(params), 'EndCallbackupdate');
            }
        });
    });
}

$(document).ready(function () {
    Loadtable();

});


//Función utilizada para hacer visible el formulado de un nuevo registro
$('.iconnew').click(function (e) {
    formReset();

    $('#ModalHorario').modal({ backdrop: 'static', keyboard: false }, 'show');
});

//Resetear los campos del formulario
function formReset() {
    $('#tipohora').val('');
    $('#nombre').val('');
    $('#idhorario').val(0);


    ResetForm();
    $('#tipohora').change();
}

function valorpordefecto(params) {

    params.id = null;
    params.nombre = null;
    params.tipohor = null;
    params.iden = null;
    params.horaini = null;
    params.horainides = null;
    params.horafindes = null;
    params.horafin = null;
    params.sabado = null;
    params.horainisab = null;
    params.horafinsab = null;
    params.candiastrab = null;
    params.cantdiasdes = null;
    params.cantdias = null;
    params.xmlhorario = null;

    return params
}

//Funcion del boton guardar
$('#btnSave').click(function (e) {
    if (validate(JsonValidate)) {
        params = {};
        valorpordefecto(params);
        params.id = $('#idhorario').val();
        params.nombre = $('#nombre').val();
        params.tipohor = $('#tipohora').val();
        var atr = $('#tipohora').find('option:selected').attr('param');
        params.iden = atr;
        switch (atr) {

            case 'REG':
                if (validate(JsonValidatehora)) {
                    params.horaini = $('#horaini').val();
                    params.horainides = $('#horainides').val();
                    params.horafindes = $('#horafindes').val();
                    params.horafin = $('#horafin').val();

                    if ($('#horainisab').val() == null || $('#horainisab').val() == '' || $('#horafinsab').val() == null || $('#horafinsab').val() == '') {
                        MethodService("Horario", "HorarioSave", JSON.stringify(params), "EndCallbackSave");
                    } else {
                        params.sabado = 1;
                        if (validate(JsonValidatesab)) {
                            params.horainisab = $('#horainisab').val();
                            params.horafinsab = $('#horafinsab').val();
                            MethodService("Horario", "HorarioSave", JSON.stringify(params), "EndCallbackSave");
                        }
                    }

                }


                break;

            case 'CXD':
                if (validate(JsonValidatecant)) {
                    params.cantdias = $('#cadadia').val();
                    if (validate(JsonValidatehora)) {
                        params.horaini = $('#horaini').val();
                        params.horainides = $('#horainides').val();
                        params.horafindes = $('#horafindes').val();
                        params.horafin = $('#horafin').val();

                        MethodService("Horario", "HorarioSave", JSON.stringify(params), "EndCallbackSave");
                    }
                }

                break;

            case 'IREG':
                if (validate(JsonValidateirreg)) {
                    params.candiastrab = $('#cantdiastr').val();
                    params.cantdiasdes = $('#cantdiasds').val();

                    var xmll = "";

                    for (let id = 0; id < iCnt; id++) {

                        var JsonValidatedias = [{ id: 'horaini' + (id + 1), type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
                        { id: 'horainides' + (id + 1), type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
                        { id: 'horafindes' + (id + 1), type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
                        { id: 'horafin' + (id + 1), type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' }];

                        if (validate(JsonValidatedias)) {
                            idlinea = $('#linea' + (id + 1)).val();
                            horai = $('#horaini' + (id + 1)).val();
                            horaides = $('#horainides' + (id + 1)).val();
                            horafdes = $('#horafindes' + (id + 1)).val();
                            horaf = $('#horafin' + (id + 1)).val();

                            xmll += '<item id="' + idlinea + '" hini="' + horai + '" hinidesc="' + horaides + '" hfindesc="' + horafdes + '" hfin="' + horaf + '"/>'
                        }

                    };

                    xmll = "<items>" + xmll + "</items>";
                    params.xmlhorario = xmll;
                    MethodService("Horario", "HorarioSave", JSON.stringify(params), "EndCallbackSave");
                }

                break;
        }



    }
});

//Funcion de retorno de la respuesta del servidor al guardar
function EndCallbackSave(params, answer) {
    if (!answer.Error) {
        $('#ModalHorario').modal("hide");
        window.gridchorario.bootgrid('reload');
        formReset();
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}

//Funcion de retorno de la respuesta del servidor al consultar una bodega
function EndCallbackGet(params, answer) {
    if (!answer.Error) {
        data = answer.Row;
        dota = answer.Table;
        console.log(data)
        $('#tipohora').val(data.tipo_horario);
        $('#idhorario').val(data.id);
        $('#nombre').val(data.nombre);
        
        $('#tipohora').selectpicker('refresh');
        $('#tipohora').trigger('change');
        
        
        var atr = $('#tipohora').find('option:selected').attr('param');
        switch (atr) {

            case 'REG':
                $('#horaini').val(data.Hinicio);
                $('#horainides').val(data.Hiniciodesc);
                $('#horafindes').val(data.Hfindesc);
                $('#horafin').val(data.Hfin);

                sabado = dota.length;
                if (sabado > 1) {
                    $('#horainisab').val(dota[1].Hinicio);
                    $('#horafinsab').val(dota[1].Hfin);
                }

                break;

            case 'CXD':
                $('#cadadia').val(data.cantdesdias);
                $('#horaini').val(data.Hinicio);
                $('#horainides').val(data.Hiniciodesc);
                $('#horafindes').val(data.Hfindesc);
                $('#horafin').val(data.Hfin);
                break;

            case 'IREG':
                iCnt = 0;
                $('#cantdiastr').val(data.cantdias);
                $('#cantdiasds').val(data.cantdesdias);
                $('#cantdiastr').change();

                for (var i = 0; i < dota.length; i++) {
                    valor = dota[i];
                    $('#linea' + (i + 1)).val(valor.id);
                    $('#horaini' + (i + 1)).val(valor.Hinicio);
                    $('#horainides' + (i + 1)).val(valor.Hiniciodesc);
                    $('#horafindes' + (i + 1)).val(valor.Hfindesc);
                    $('#horafin' + (i + 1)).val(valor.Hfin);
                };

                break;

        }

        $('#ModalHorario').modal({ backdrop: 'static', keyboard: false }, 'show');
        
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}
//Funcion de retorno de la respuesta del servidor al Cambiar estado
function EndCallbackupdate(params, answer) {
    if (!answer.Error) {
        window.gridchorario.bootgrid('reload');
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}
//funcion que separa con coma un resultado recibe un string
function f(d) {
    return d.split(',')
}

$('#tipohora').change(function () {

    var atr = $(this).find('option:selected').attr('param');

    switch (atr) {

        case 'IREG':
            $('.cadadia').hide();
            $('.reg').hide();
            $('#rowhora').hide();
            $('.cantdias').show();
            $('#cantdiastr').val('');
            $('#cantdiasds').val('');
            $('#cantdiastr').change();
            ResetForm();
            break;

        case 'CXD':
            $('.cantdias').hide();
            $('.reg').hide();
            $('.cadadia').show();
            $('#rowhora').show();
            $('#cadadia').val('');
            ResetForm();
            break;

        case 'REG':
            $('.cadadia').hide();
            $('.cantdias').hide();
            $('.reg').show();
            $('#rowhora').show();
            ResetForm();
            break;

        default:
            $('.cadadia').hide();
            $('.cantdias').hide();
            $('.reg').hide();
            $('#rowhora').hide();
            ResetForm();
            break;
    }
});


$('#horainides').focusout(function () {

    var hi = (($('#horaini').val()).split(":") == "" ? "0" : ($('#horaini').val()).split(":"));
    var hides = (($(this).val()).split(":") == "" ? "0" : ($(this).val()).split(":"));
    var hini = "";
    var hinides = "";
    if (hides != 0) {
        for (var i = 0; i < hides.length; i++) {
            hinides += hides[i]
            hini += (hi[i] == null ? 0 : hi[i]);
        };
        hini = hini * 1;
        hinides = hinides * 1;
        if (hini >= hinides) {

            toastr.error('La Hor. de inicio desc. debe ser mayor a Hor. de inicio', 'Sintesis ERP');
            $(this).val('');

        }
    }

});


$('#horafindes').focusout(function () {

    var hides = (($('#horainides').val()).split(":") == "" ? "0" : ($('#horainides').val()).split(":"));
    var hfdes = (($(this).val()).split(":") == "" ? "0" : ($(this).val()).split(":"));
    var hinides = "";
    var hfindes = "";
    if (hfdes != 0) {
        for (var i = 0; i < hfdes.length; i++) {
            hfindes += hfdes[i]
            hinides += (hides[i] == null ? 0 : hides[i]);
        };
        hinides = hinides * 1;
        hfindes = hfindes * 1;
        if (hinides == 0) {
            toastr.error('No puede existir Hor de final desc. sin Hor. de inicio desc.', 'Sintesis ERP');
            $(this).val('');
        }

        if (hinides >= hfindes) {

            toastr.error('La Hor de final desc. debe ser mayor a Hor. de inicio desc.', 'Sintesis ERP');
            $(this).val('');

        }
    }
});


$('#horafin').focusout(function () {

    var hi = (($('#horaini').val()).split(":") == "" ? "0" : ($('#horaini').val()).split(":"));
    var hfdes = (($('#horafindes').val()).split(":") == "" ? "0" : ($('#horafindes').val()).split(":"));
    var hf = (($(this).val()).split(":") == "" ? "0" : ($(this).val()).split(":"));
    var hini = "";
    var hfindes = "";
    var hfin = "";
    if (hf != 0) {
        for (var i = 0; i < hf.length; i++) {
            hfin += hf[i]
            hfindes += (hfdes[i] == null ? 0 : hfdes[i]);
            hini += (hi[i] == null ? 0 : hi[i]);
        };
        hfindes = hfindes * 1;
        hfin = hfin * 1;
        hini = hini * 1;
        if (hfindes >= hfin || hini >= hfin) {
            toastr.error('La Hor. de final debe ser la hora mayor', 'Sintesis ERP');
            $(this).val('');

        }
    }
});


$('#horafinsab').focusout(function () {

    var hi = (($('#horainisab').val()).split(":") == "" ? "0" : ($('#horainisab').val()).split(":"));
    var hf = (($(this).val()).split(":") == "" ? "0" : ($(this).val()).split(":"));
    var hini = "";
    var hfin = "";
    if (hf != 0) {
        for (var i = 0; i < hf.length; i++) {
            hfin += hf[i]
            hini += (hi[i] == null ? 0 : hi[i]);
        };
        hini = hini * 1;
        hfin = hfin * 1;
        if (hini == 0) {
            toastr.error('No puede existir Hor de final sin Hor. de inicio', 'Sintesis ERP');
            $(this).val('');
        }

        if (hini >= hfin) {

            toastr.error('La Hor de final desc. debe ser mayor a Hor. de inicio desc.', 'Sintesis ERP');
            $(this).val('');

        }
    }
});


$('#cantdiasds').change(function () {
    verificarsemana();
});


$('#cantdiastr').change(function () {
    verificarsemana();
    var dias = ($(this).val()) * 1;
    var html = "";


    if (dias <= 7) {
        
        if (iCnt == 0) {
            $(container).empty();
            $(container).remove();
            for (let id = 0; id < dias; id++) {
                iCnt += 1;

                html = '<h2 class="cantdias dia' + iCnt+'" >Día ' + iCnt + '</h2><div class="row cantdias" id="row' + iCnt + '" style="border-top: 1px dashed #AAB7B8; margin-top: 15px"><div class="col-lg-3 col-md-3 col-sm-6 col-xs-12"><div class="form-group"><label for="horaini' + iCnt + '" class="active">Hor. de inicio:</label><input type="text" class="form-control" id="horaini' + iCnt + '"   date="true" format="HH:mm" /></div>' +
                    '</div><div class="col-lg-3 col-md-3 col-sm-6 col-xs-12" style="padding-right: 1px !important; right: 8px !important;"><div class="form-group"><label for="horainides' + iCnt + '" class="active">Hor. de inicio desc.:</label><input type="text" class="form-control" id="horainides' + iCnt + '"   date="true" format="HH:mm" /></div>' +
                    '</div><div class="col-lg-3 col-md-3 col-sm-6 col-xs-12" style="padding-right: 7px !important;"><div class="form-group"><label for="horafindes' + iCnt + '" class="active">Hor de final desc.:</label><input type="text" class="form-control" id="horafindes' + iCnt + '"   date="true" format="HH:mm" /></div>' +
                    '</div><div class="col-lg-3 col-md-3 col-sm-6 col-xs-12"><div class="form-group"><label for="horafin' + iCnt + '" class="active">Hor. de final:</label><input type="text" class="form-control" id="horafin' + iCnt + '"   date="true" format="HH:mm" /></div></div><input type="hidden" value="0" id="linea' + iCnt + '" /></div>'
                $(container).append(html);


                $('#esp').after(container);
                $('.cantdias').show();
            };
            datepicker();
        } else if (iCnt > 0) {
            if (iCnt > dias) {
                while (iCnt > dias) {
                    $('#row' + iCnt).remove();
                    $('.dia' + iCnt).remove();
                    iCnt = iCnt - 1;
                }  
                
            } else if (iCnt < dias) {
                for (let id = iCnt; id < dias; id++) {
                    iCnt += 1;

                    html = '<h2 class="cantdias dia' + iCnt +'" >Día' + iCnt + '</h2><div class="row cantdias" id="row' + iCnt + '" style="border-top: 1px dashed #AAB7B8; margin-top: 15px"><div class="col-lg-3 col-md-3 col-sm-6 col-xs-12"><div class="form-group"><label for="horaini' + iCnt + '" class="active">Hor. de inicio:</label><input type="text" class="form-control" id="horaini' + iCnt + '"   date="true" format="HH:mm" /></div>' +
                        '</div><div class="col-lg-3 col-md-3 col-sm-6 col-xs-12" style="padding-right: 1px !important; right: 8px !important;"><div class="form-group"><label for="horainides' + iCnt + '" class="active">Hor. de inicio desc.:</label><input type="text" class="form-control" id="horainides' + iCnt + '"   date="true" format="HH:mm" /></div>' +
                        '</div><div class="col-lg-3 col-md-3 col-sm-6 col-xs-12" style="padding-right: 7px !important;"><div class="form-group"><label for="horafindes' + iCnt + '" class="active">Hor de final desc.:</label><input type="text" class="form-control" id="horafindes' + iCnt + '"   date="true" format="HH:mm" /></div>' +
                        '</div><div class="col-lg-3 col-md-3 col-sm-6 col-xs-12"><div class="form-group"><label for="horafin' + iCnt + '" class="active">Hor. de final:</label><input type="text" class="form-control" id="horafin' + iCnt + '"   date="true" format="HH:mm" /></div></div><input type="hidden" value="0" id="linea' + iCnt + '" /></div>'
                    $(container).append(html);


                    $('#esp').after(container);
                    $('.cantdias').show();
                };
            }
        }

    } else {
        toastr.error('La semana solo tiene 7 días', 'Sintesis ERP');
        $(this).val('');
    }
});

var container = $(document.createElement('div')).css({
    display: 'block;'
});
var iCnt = 0;

function verificarsemana() {

    var diastra = ($('#cantdiastr').val() == null ? 0 : $('#cantdiastr').val());
    var diasdes = ($('#cantdiasds').val() == null ? 0 : $('#cantdiasds').val());
    var dias = (diastra * 1) + (diasdes * 1);

    if (dias > 7 || dias < 0) {
        toastr.error('La suma de los días debe ser max 7', 'Sintesis ERP');
        $('#cantdiasds').val('');
    }

};

function ResetForm() {
    $('input.hora').val('');
    iCnt = 0;
    $(container).empty();
    $(container).remove();
}
