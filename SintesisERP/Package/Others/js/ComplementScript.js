
function datepicker() {
    $("[date]").each(function (i, control) {
        control = $(control);
        var format = control.attr("format");
        var currentdate = control.attr("current");  //Fecha actual para colocar por defecto
        var mindatecurrent = control.attr("min"); // Fecha a partir de la cual se podrá elegir en el calendario
        var maxdatecurrent = control.attr("max"); // Fecha a partir de la cual se podrá elegir en el calendario

        if ($.trim(format) == "") {
            format = "YYYY-MM-DD";
        }

        control.datetimepicker({
            format: format,
            locale: "es"
        });

        if (typeof (mindatecurrent) != 'undefined') {
            if (typeof (mindatecurrent) != 'undefined')
                control.data("DateTimePicker").minDate(mindatecurrent);
            else
                control.data("DateTimePicker").minDate(new Date());
        } else if (typeof (maxdatecurrent) != 'undefined') {
            control.data("DateTimePicker").maxDate(new Date());
        }

        if (typeof (currentdate) != 'undefined') {
            control[0].value = moment(new Date()).format(format);
        } else {
            if (control[0].defaultValue == "") {
                control[0].value = "";
            }
        }
    });
    $("[date]").each(function (i, control) {
        control = $(control);
        var maxDate = control.attr("maxDate");
        if (maxDate != undefined) {
            control.on("dp.change", function (e) {
                $('#' + maxDate).data("DateTimePicker").minDate(e.date);
                $('#' + maxDate).focus();
            });
        }

    });
}

function iddatepicker(control) {
    //control = $(id);
    var format = control.attr("format");
    var currentdate = control.attr("current");  //Fecha actual para colocar por defecto
    var mindatecurrent = control.attr("min"); // Fecha a partir de la cual se podrá elegir en el calendario
    var maxdatecurrent = control.attr("max"); // Fecha a partir de la cual se podrá elegir en el calendario

    if ($.trim(format) == "") {
        format = "YYYY-MM-DD";
    }

    control.datetimepicker({
        format: format,
        locale: "es"
    });

    if (typeof (mindatecurrent) != 'undefined') {
        if (typeof (mindatecurrent) != 'undefined')
            control.data("DateTimePicker").minDate(mindatecurrent);
        else
            control.data("DateTimePicker").minDate(new Date());
    } else if (typeof (maxdatecurrent) != 'undefined') {
        control.data("DateTimePicker").maxDate(new Date());
    }

    if (typeof (currentdate) != 'undefined') {
        control[0].value = moment(new Date()).format(format);
    } else {
        if (control[0].defaultValue == "") {
            control[0].value = "";
        }
    }

    var maxDate = control.attr("maxDate");
    if (maxDate != undefined) {
        control.on("dp.change", function (e) {
            $('#' + maxDate).data("DateTimePicker").minDate(e.date);
            $('#' + maxDate).focus();
        });
    }

}

function setMultiSelect(id) {
    var str = '';
    sep = ",";

    $("#" + id + " option:selected").each(function () {
        str += $(this).val() + sep;
    });
    str = str.substring(0, str.length - 1);
    return str;
}


//var startDate = moment(new Date());
//var endDate = startDate;
function daterangepicker() {
    $("[daterange]").each(function (i, control) {
        control = $(control);
        var format = control.attr("format");
        var currentdate = control.attr("current");  //Fecha actual para colocar por defecto
        var mindatecurrent = control.attr("min"); // Fecha a partir de la cual se podrá elegir en el calendario
        var maxdatecurrent = control.attr("max"); // Fecha a partir de la cual se podrá elegir en el calendario

        if ($.trim(format) == "") {
            format = "YYYY-MM-DD";
        }

        startDate = moment(new Date());
        endDate = moment(startDate);
        startDate.locale('es');
        endDate.locale('es');
        if (typeof (mindatecurrent) != 'undefined') {
            if (mindatecurrent == "true") {
                time = moment(new Date());
            }
            else {
                time = moment(mindatecurrent);
            }
            mindatecurrent = time;
        }
        else
            mindatecurrent = '';

        if (typeof (maxdatecurrent) != 'undefined') {
            if (maxdatecurrent == "true") {
                time = moment(new Date());
            }
            else {
                time = moment(maxdatecurrent);
            }
            maxdatecurrent = time;
        }
        else
            maxdatecurrent = '';

        ids = control.attr('data-idfstar');
        ide = control.attr('data-idfend');
        control.find('span').html(capitalizeMonth(startDate.format('DD-MMMM-YYYY')) + ' al ' + capitalizeMonth(endDate.format('DD-MMMM-YYYY')));
        $('#' + ids).val(startDate.format('YYYY-MM-DD'));
        $('#' + ide).val(endDate.format('YYYY-MM-DD'));


        control.daterangepicker({
            "buttonClasses": "btn btn-block btn-default",
            "startDate": startDate,
            "endDate": endDate,
            "locale": {
                "format": "YYYY-MM-DD",
                "separator": " al ",
                "applyLabel": "Aceptar",
                "cancelLabel": "Cancelar",
                "fromLabel": "Desde",
                "toLabel": "Hasta",
                "customRangeLabel": "Rango de Fechas",
                "daysOfWeek": [
                    "Do",
                    "Lu",
                    "Ma",
                    "Mi",
                    "Ju",
                    "Vi",
                    "Sa"
                ],
                "monthNames": [
                    "Enero",
                    "Febrero",
                    "Marzo",
                    "Abril",
                    "Mayo",
                    "Junio",
                    "Julio",
                    "Agosto",
                    "Septiembre",
                    "Octubre",
                    "Noviembre",
                    "Diciembre"
                ],
                "firstDay": 1
            },
            opens: ('center'),
            "applyClass": "btn-hover-gosocket",
            "cancelClass": "btn-hover-gosocket",
            "ranges": {
                'Últimos 7 Días': [moment().subtract('days', 6), moment()],
                'Mes actual': [moment().startOf('month'), moment().endOf('month')],
                'Mes Anterior': [moment().subtract('month', 1).startOf('month'), moment().subtract('month', 1).endOf('month')],
                'Últimos 3 Meses': [moment().subtract('month', 3).startOf('month'), moment().endOf('month')]
            },
            "minDate": mindatecurrent,
            "maxDate": maxdatecurrent,
        }, function (start, end, label) {
            start.locale('es');
            end.locale('es');
            ids = control.attr('data-idfstar');
            ide = control.attr('data-idfend');
            control.find('span').html(capitalizeMonth(start.format('DD-MMMM-YYYY')) + ' al ' + capitalizeMonth(end.format('DD-MMMM-YYYY')));
            $('#' + ids).val(start.format('YYYY-MM-DD'));
            $('#' + ide).val(end.format('YYYY-MM-DD'));
        });
    });
}

function capitalizeMonth(date) {
    return date.substring(0, 3) + date.charAt(3).toUpperCase() + date.slice(4);
}