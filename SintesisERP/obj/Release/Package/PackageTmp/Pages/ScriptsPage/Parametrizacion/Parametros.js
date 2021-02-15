$(document).ready(function () {
    fieldsMoney();
    datepicker();
    $(function () {
        $('select').selectpicker();
        $('.i-checks').iCheck({
            checkboxClass: 'icheckbox_square-green',
            radioClass: 'iradio_square-green'
        });
    });

    $(document).ready(function () {
        datepicker();

    }); 
});

$("#guardar").click(function () {
    var xml = '';
    var codigo = '';
    $.each($(".paramform"), function (i, e) {
        var tipo = $(e).attr('data-type');
        var extraval = '';

        codigo = $(e).attr('data-codigo');
        var val = '';
        if (tipo == 'TEXT') {
            val = $(e).find('input').val();
        }
        else if (tipo == 'NUMERO') {
            val = SetNumber($(e).find('input').val());
        }
        else if (tipo == 'CHECKBOX') {
            val = ($(e).find('input').prop('checked')) ? 'S' : 'N';
        }
        else if (tipo == 'SEARCH') {
            var input = $(e).find('input.inputsearch');
            extraval = $('#' + input.attr('data-idhidden')).val();
            val = input.val();
        }
        else if (tipo == 'DATE') {
            val = ($(e).find('input').val());
        }
        else if (tipo == 'DATETIME') {
            val = ($(e).find('input').val());
        }
        xml += "<item codigo='" + codigo + "' valor='" + val + "' extratexto='" + ((extraval === undefined) ? '' : extraval) + "'/> ";
    });

    params = {}
    params.xml = "<root>" + xml + "</root>";
    MethodService("Parametros", "ParametrosSave", JSON.stringify(params), "EndCallbackParametros");
});

function EndCallbackParametros(params, answer) {
    if (!answer.Error) {
        toastr.success("Proceso Exitoso", "Sintesis ERP");
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }

}
