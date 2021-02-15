
$('#id_report').change(function (e) {
    $("#filterreport").empty();
    if ($(this).val() != "") {
        var params = {};
        params.id = $(this).val();
        MethodService("Reportes", "CargarCampos", JSON.stringify(params), 'EndCallbackArticle');
    }
});

function EndCallbackArticle(params, answer) {
    if (!answer.Error) {
        var html = answer.Row.html;
        var content = $("#filterreport").empty();
        content.append(html);
        $('select.selectpicker').selectpicker();
        datepicker();
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}


$('#btnReport').click(function () {
    var parametros = $('[data-param]');
    var json = '';
    var bl_ok = false;
    var idreport = $('#id_report').val();
    if (idreport != "" && idreport != undefined) {
        bl_ok = true;
        $.each(parametros, function (i, e) {
            val = $(e).val();
            //if ($(e).attr('data-type') == 'date' || $(e).attr('data-type') == 'datetime')
            //val = val.replace(/-/gi, '');
            /*else*/ if ($(e).attr('data-type') == 'search')
                val = (val.trim() == "") ? "0" : val;

            if (!$(e).hasClass('required') || (val != "" && val != "0")) {
                try {
                    json += $(e).attr('data-param') + "|" + val.replace(/;/gi, '') + ";";
                } catch (e) {
                    json += $(e).attr('data-param') + "|" + val + ";";
                }
                if ($(e).attr('data-type') == 'search')
                    $(e).closest('.form-group').removeClass('is-focused error');

                $(e).closest('.form-group').removeClass('is-focused error');
            }
            else {
                if ($(e).attr('data-type') == 'search')
                    $(e).closest('.form-group').addClass('is-focused error');
                $(e).closest('.form-group').addClass('is-focused error');
                bl_ok = false;
            }
        });
    }
    loading();
    if (bl_ok) {
        $('#pdf_content').attr('src', window.appPath + "/Pages/Connectors/ConnectorReport.ashx?params=" + json + "&idreport=" + idreport + "&type=id");
    } else {
        $('#pdf_content').attr('src', "../Informes/Generados/pdfblank.pdf");
    }
});

function loading() {
    $('#btnReport').attr('disabled', true);
    $("#loadingDiv").show();
}

$('#pdf_content').load(function () {
    $('#btnReport').removeAttr('disabled');
    $('#loadingDiv').hide();
});

$('#btnExport').click(function () {
    var parametros = $('[data-param]');
    var json = '';
    var bl_ok = false;
    var idreport = $('#id_report').val();
    var reportname = $('#id_report option:selected').text();
    if (idreport != "" && idreport != undefined) {
        bl_ok = true;
        $.each(parametros, function (i, e) {
            val = $(e).val();
            if ($(e).attr('data-type') == 'search')
                val = (val.trim() == "") ? "0" : val;

            if (!$(e).hasClass('required') || (val != "" && val != "0")) {
                try {
                    json += $(e).attr('data-param') + "|" + val.replace(/;/gi, '') + ";";
                } catch (e) {
                    json += $(e).attr('data-param') + "|" + val + ";";
                }
                if ($(e).attr('data-type') == 'search')
                    $(e).closest('.form-group').removeClass('is-focused error');

                $(e).closest('.form-group').removeClass('is-focused error');
            }
            else {
                if ($(e).attr('data-type') == 'search')
                    $(e).closest('.form-group').addClass('is-focused error');

                $(e).closest('.form-group').addClass('is-focused error');
                bl_ok = false;
            }
        });
        if (json.length > 0)
            json = json.substring(0, json.length - 1);
    }

    if (bl_ok) {
        var href = window.appPath + "/Pages/Connectors/ConnectorExcel.ashx?params=" + json + "&idreport=" + idreport + "&type=id";
        $('#downexcel').attr({ "src": href, "download": reportname + ".xlsx" });
    }
    else
        $('#downexcel').attr({ "src": "" });
});
