$(document).on('click', '.btnsearch', function () {
    var data = $(this).data();
    $('#generalsearch').val(data.fields);
    var column = data.column.split(',');
    var select = (data.select) ? data.select : "1,2";
    var parametros = (data.params) ? data.params : "";
    var jsonpar = {};
    if (parametros != undefined && parametros != '') {
        var vecpar = parametros.split(";");
        $.each(vecpar, function (i, e) {
            var split = e.split(',');
            if (split.length > 1) {
                var val = $('#' + split[1]).val();
                jsonpar[split[0]] = val;
            }
        });
    }

    $('#generalselect').val(select);
    $("#GridGeneralSearch").bootgrid("destroy");
    window.TblGenSearch = $("#GridGeneralSearch").bootgrid({
        ajax: true,
        autoColumn: true,
        fields: column,
        selectSearch: true,
        columnSelection: false,
        post: function () {
            return {
                'params': JSON.stringify(jsonpar),
                'class': data.search,
                'method': data.method,
            };
        },
        url: window.appPath + "/Pages/Connectors/ConnectorList.ashx",
        formatters: {
            "edit": function (column, row) {
                return "<a class=\"action command-edit\"><span class=\"fa-2x fa  fa-check text-success\"></span></a>";
            }
        }
    }).on("loaded.rs.jquery.bootgrid", function () {
        window.TblGenSearch.find(".command-edit").on("click", function (e) {
            $tr = $(this).closest('tr');
            select = $('#generalselect').val();
            select = select.split(',');
            if (select.length > 0) {
                code = $tr.find('td:eq(' + select[0] + ')').html();
                descrip = $tr.find('td:eq(' + select[1] + ')').html();
            } else {
                code = $tr.find('td:eq(1)').html();
                descrip = $tr.find('td:eq(2)').html();
            }
            fields = $('#generalsearch').val();
            values = fields.split(',');
            $('#' + values[0]).val(code);
            $('#' + values[1]).val(descrip);
            $('#' + values[0]).trigger('change');
            $('#ModalSearch').modal("hide");
            $('#' + values[1]).focus().select();
        });
    });
    $('#ModalSearch').modal('show');
});

//Funcion que convierte los inputs en autocompletados
$(document).ready(function () {
    
    //aqui toma los inputs que tienen esta clase
    var data = $('.actionautocomple');
    //para cada input se repite este procedimiento
    $.each(data, function (i, e) { //recibo dos parametros i y e que es posicionamiento y valor
        var datae = $(e).data();//al valor le obtengo los data
        //divido los parametros donde encuentre una coma
        var dataid = datae.idvalue; // obtengo el data-idvalue
        var dataresult = datae.result.split(';');
        var EndCallBack = datae.endcallback;
        var block = datae.block;
        //aqui bloqueo los inputs que quiero que esten desabilitados 
        if (block != undefined && block != '') {
            block = datae.block.split(';')
            $.each(block, function (i, e) {
                $('#' + e).prop("disabled", true);
            });
        }
        //dentro, hago otro each por cada parametro y los divido donde esten los dos puntos
        
        //aqui implemento el plugin autocomplete
        $(e).autocomplete({
            serviceUrl: window.appPath + "/Pages/Connectors/Connector.ashx",
            type: 'post',
            datatype: 'json',
            paramName: 'keyword',
            params: { 'class': datae.search, method: datae.method },
            noCache: true,
            onSelect: function (select) {
                
                //esta funcion le da el data al input de tipo hidden (cabe resaltar que el select trae un value y un data)
                $('#' + dataid).val(select.data).trigger('change');
                //aqui llamo la funcion que cree en el js 
                if (EndCallBack != undefined && EndCallBack != '') {
                    var sFuncion = (EndCallBack + "(x);");
                    var myFuntion = new Function("x", sFuncion);
                    myFuntion(select);
                }
            },
            onSearchStart: function (query) {
                //aqui hara el query del buscador
                var araypar = {};                
                araypar = GetValuesSearch($(this));
                araypar.filtro = query.keyword;
                //aqui mando como parametros al araypar que trae todos los data-params
                query.params = JSON.stringify(araypar);
            },
            minChars: 2,
            //aqui se hace lo mismo de crear el json para cada respuesta que me traigo de la base de datos
            transformResult: function (response) {
                json = JSON.parse(response).ans;
                var object = json.data;
                if (object.length > 0) {
                    return {
                        suggestions: $.map(object, function (dataItem) {
                            dataritemesult = {}
                            $.each(dataresult, function (i, e) {
                                if (e != undefined && e != '') {
                                    pp = e.split(':');
                                    dataritemesult[pp[0]] = dataItem[pp[1]];
                                }
                            });
                            return dataritemesult;
                        })
                    };
                }
                else {
                    return { suggestions: [] }
                }
            }
        });     
    });
});

function GetValuesSearch(elemn) {
    var arayparp = {};
    var dataparam = elemn.data('params').split(';'); 
    $.each(dataparam, function (i, e) {
        if (e != undefined && e != '') {
            pp = e.split(':');
            arayparp[pp[0]] = (pp[1] == '#') ? '' : pp[1]; //aqui le asigno al araypar en formato de json for example json; arraypar[{a : b }] por cada parametro
        }
    });
    return arayparp;
}

//clase para limpiar el input al hacer doble click
$(document).on('dblclick', '.inputsearch', function () {
    if ($(this).is(':enabled')) {
        //aqui asigno a una variable el data-idvalue para limpiar tanto el input que se ve como su input de tipo hidden
        var idvalue = $(this).attr('data-idvalue');
									   
        $(this).val('');
		   

        $('#' + idvalue).val('').trigger('change');
    }
});

$(document).on('dblclick', '.input-group .inputsearch', function () {
    if ($(this).is(':enabled')) {
        var data = $(this).closest('div').find('button.btnsearch').data();
        var split = data.fields.split(',');
        $.each(split, function (i, e) {
            $('#' + e).val('');
        });

        $('#' + split[0]).trigger('change');
    }
});

$(document).on('dblclick', '#GridGeneralSearch tbody tr', function () {
    select = $('#generalselect').val();
    select = select.split(',');
    if (select.length > 0) {
        code = $(this).find('td:eq(' + select[0] + ')').html();
        descrip = $(this).find('td:eq(' + select[1] + ')').html();
    } else {
        code = $(this).find('td:eq(1)').html();
        descrip = $(this).find('td:eq(2)').html();
    }
    fields = $('#generalsearch').val();
    values = fields.split(',');
    $('#' + values[0]).val(code);
    $('#' + values[1]).val(descrip);
    $('#' + values[0]).trigger('change');
    $('#ModalSearch').modal("hide");
    $('#' + values[1]).focus().select();
});