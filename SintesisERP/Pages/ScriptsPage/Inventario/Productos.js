//Vector  de validación
var JsonValidate = [
    { id: 'cd_tipoprod', type: 'REAL', htmltype: 'SELECT', required: false, depends: false, iddepends: '' },
    { id: 'cd_tipodoc', type: 'TEXT', htmltype: 'SELECT', required: false, depends: false, iddepends: '' },
    { id: 'Text_Codigo', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'Text_codigobarra', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'Text_Presentacion', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'Text_Nombre', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'Text_Precio', type: 'REAL', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'Text_Descuento', type: 'REAL', htmltype: 'INPUT', required: false, depends: false, iddepends: '' },
    { id: 'ds_ctacon', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'cd_naturaleza', type: 'TEXT', htmltype: 'SELECT', required: false, depends: false, iddepends: '' }]
//Vector  de validación
var JsonValidate2 = [{ id: 'codigobodega', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'Text_stockmin', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'Text_stockmax', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' }];

//Vector  de validación
var JsonCommodity = [{ id: 'valor_prod', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'm_quantity', type: 'REAL', htmltype: 'INPUT', required: true, depends: false, iddepends: '' }];

window.gridarti;
//Funcion para el cargado de la información en la tabla de listado de los productos ya guardadas.
function Loadtable() {
    window.gridarti = $("#tblarti").bootgrid({
        ajax: true,
        post: function () {
            return {
                'params': "",
                'class': 'Productos',
                'method': 'ProductosList'
            };
        },
        url: window.appPath + "/Pages/Connectors/ConnectorList.ashx",
        formatters: {
            "edit": function (column, row) {
                return "<a class=\"action command-edit\" data-row-id=\"" + row.id + "\"><span class=\"fa-2x fa fa-pencil iconfa\"></span></a>";
            },
            "state": function (column, row) {
                return "<a class=\"action command-state\" data-row-id=\"" + row.id + "\">" +
                    "<span class=\"fa fa-2x fa-fw " +
                    ((!row.estado) ? "fa-square-o text-danger" : "fa-check-square-o text-success") + "  iconfa\"></span></a>";
            },
            "stock": function (column, row) {

                return (row.stock ? "<a class=\"action command-stock\" data-row-id=\"" + row.id + "\"><span class=\"fa fa-cog fa-2x iconfa\"></span></a>" : '');
            },
            "delete": function (column, row) {
                return "<a class=\"action command-delete\" data-row-id=\"" + row.id + "\"><span class=\"fa fa-2x fa-trash-o text-danger iconfa\"></span></a>";
            }
        }
    }).on("loaded.rs.jquery.bootgrid", function () {
        // Executes after data is loaded and rendered 
        window.gridarti.find(".command-edit").on("click", function (e) {
            removeerror();
            id = $(this).data("row-id")
            params = {};
            params.id = id;
            MethodService("Productos", "ProductosGet", JSON.stringify(params), 'EndCallbackGet');
        }).end().find(".command-delete").on("click", function (e) {
            if (confirm("Desea eliminar este Producto?")) {
                id = $(this).data("row-id");
                params = {};
                params.id = id;
                MethodService("Productos", "ProductosDelete", JSON.stringify(params), 'EndCallbackupdate');
            }
        }).end().find(".command-state").on("click", function (e) {
            id = $(this).data("row-id");
            params = {};
            params.id = id;
            MethodService("Productos", "ProductosState", JSON.stringify(params), 'EndCallbackupdate');
        }).end().find(".command-stock").on("click", function (e) {
            id = $(this).data("row-id");
            params = {};
            params.id = id;
            MethodService("Productos", "ProductosGet", JSON.stringify(params), 'EndCallbackGetStock');
        });
    });
}
//Funcion para el cargado de la información en la tabla de listado del stock de los productos configurados por bodegas ya guardadas.
function Loadtabledetalle() {
    window.gridbodegaprod = $("#tblbodegaprodu").bootgrid({
        ajax: true,
        post: function () {
            return {
                'params': function () {
                    var param = {};

                    param.id_producto = $('#btnSaveStock').attr('data-id');
                    return JSON.stringify(param);
                },
                'class': "Productos",
                'method': 'ProductosBodegaList'
            }
        },
        url: window.appPath + "/Pages/Connectors/ConnectorList.ashx", //conecta los metodos con los controladores
        formatters: {
            "edit": function (column, row) {
                return "<a class=\"action command-edit\" data-row-id=\"" + row.id + "\"><span class=\"fa-2x fa fa-pencil iconfa\"></span></a>";
            },
            "state": function (column, row) {
                return "<a class=\"action command-state\" data-row-id=\"" + row.id + "\">" +
                    "<span class=\"fa fa-2x fa-fw " +
                    ((!row.estado) ? "fa-square-o text-danger" : "fa-check-square-o text-success") + "  iconfa\"></span></a>";
            },
            "delete": function (column, row) {
                return "<a class=\"action command-delete\" data-row-id=\"" + row.id + "\"><span class=\"fa fa-2x fa-trash-o text-danger iconfa\"></span></a>";
            }
        }
    }).on("loaded.rs.jquery.bootgrid", function () {
        // Executes after data is loaded and rendered 
        window.gridbodegaprod.find(".command-edit").on("click", function (e) {
            removeerror();
            id = $(this).data("row-id");
            params = {};
            params.id = id;
            MethodService("Productos", "ProductosBodegasGet", JSON.stringify(params), 'EndCallbackGetBodegaProd');

        }).end().find(".command-delete").on("click", function (e) {
            if (confirm("Desea Eliminar Stock De Esta Bodega?")) {
                id = $(this).data("row-id");
                params = {};
                params.id = id;
                MethodService("Productos", "ProductosBodegaDelete", JSON.stringify(params), 'EndCallbackupdateStock');
            }
        })
    });
}
//Evento de campo de presentacion el cual carga las series configurada por codigo de articulo
$('#v_presen').change(function () {
    loadSerie($('#v_presen option:selected').attr('value'));

});
//Evento de campo de serie el cual carga los lotes configurada por codigo de articulo y serie
$('#cd_serie').change(function () {
    loadLote($('#cd_serie option:selected').attr('value') + '-' + $('#cd_serie option:selected').attr('data-serie'), 'M');
});
//Evento de campo lote que en caso tal de cambio el foco se centrara en el campo cantidad
$('#cd_lote').change(function () {
    $('#m_quantity').focus().select()
});
$('#v_code').change(function () {
    let element = $('#valor_prod').val()
    let split = element.split('-')
    $('#nombre').val($.trim(split[2]))
    $('#serie').val('').attr('data-params', "op:G;o:" + element).removeData('params').data('params');
});
//Funcion de busqueda de cargar presentacion por codigo
function loadpresentation(v_code) {
    cleanartycle();
    params = {};
    params.filtro = v_code;
    $('#hiddencode').val(v_code);
    params.op = 'P';
    params.o = 'PR';
    params.formula = 0;
    params.id_prod = 0;
    MethodService("Productos", "ArticulosBuscador", JSON.stringify(params), "EndCallbackArticlebus");
}
//Funcion de busqueda de cargar serie por codigo
function loadSerie(v_code) {
    params = {};
    params.filtro = v_code;
    params.op = 'F';
    params.o = 'SE';
    params.formula = 0;
    params.id_prod = 0;
    MethodService("Productos", "ArticulosBuscador", JSON.stringify(params), "EndCallbackArticleSerie");
}

//Funcion de busqueda de cargar lote por codigo
function loadLote(v_code, option) {
    params.filtro = v_code;
    params.op = 'F';
    params.o = option;
    params.formula = 0;
    params.id_prod = 0;
    MethodService("Productos", "ArticulosBuscador", JSON.stringify(params), "EndCallbackArticleLote");
}
//Funcion de retorno de la respuesta del servidor al consultar la presentacion 
function EndCallbackArticlebus(params, answer) {
    if (!answer.Error) {
        var options = "";
        var inventario;
        $.each(answer.data, function (i, e) {
            options += '<option data-existencia="' + e.existencia + '" data-price="' + e.precio + '" value="' + e.id + '" ' + ((i == 0) ? 'selected="selected"' : '') + '>' + e.name + '</option>';
            inventario = e.inventario;

        });

        $('#v_presen').html(options).selectpicker('refresh');

        if (inventario == 0) {
            $('#m_quantity').focus().select()
        } else {
            $('#v_presen').trigger('change');
            $('#cd_serie').trigger('change');
            $('#cd_lote').trigger('change');

        }
    }
    else {
        console.log(answer.Message);
    }
}
//Funcion de retorno de la respuesta del servidor al consultar la serie de un producto
function EndCallbackArticleSerie(params, answer) {
    if (!answer.Error) {
        var options = "";
        var serie = "";
        var id_articulo = "";
        $.each(answer.data, function (i, e) {
            options += '<option  data-serie="' + e.serie + '" value = "' + e.id + '" ' + ((i == 0) ? 'selected = "selected"' : '') + ' > ' + e.serie + '</option > ';
            serie = e.serie;
            id_articulo = e.id;

        });
        if (serie != "") {
            $('#cd_serie').html(options).selectpicker('refresh');
            var codigoformateado = id_articulo + '-' + $('#cd_serie option:selected').attr('data-serie')
            loadLote(codigoformateado, 'M');

        } else {
            loadLote(id_articulo, 'LO');
        }

    }
}
//Funcion de retorno de la respuesta del servidor al consultar el lote de un producto
function EndCallbackArticleLote(params, answer) {
    if (!answer.Error) {
        var options = "";
        $.each(answer.data, function (i, e) {
            options += '<option  data-existencia="' + e.existencia + '" data-lote="' + e.id_lote + '" data-price="' + e.precio + '"  data-venci="' + ((e.id_lote == 1) ? '' : e.venciLote) + '"  data-codBarra="' + e.codBarra + '" value="' + e.id + '" ' + ((i == 0) ? 'selected="selected"' : '') + '>' + e.lote + '</option>';

        });

        $('#cd_lote').html(options).selectpicker('refresh');
        $('#cd_lote').trigger('change');


        if (answer.data.length >= 1) {
            $('#m_quantity').focus().select()
        }
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}
//Function que limpia los campos de presentacion, lote y serie
function cleanartycle() {
    $('#v_presen').val('0');
    $('#cd_serie').val('0');
    $('#cd_lote').val('0');
    $('Select.article').html('').selectpicker('refresh');

}

$(document).ready(function () {
    window.img = $('.dropify').dropify({
        messages: {
            default: 'Arrastre un archivo o haga clic aquí',
            replace: 'Arrastre un archivo o haga clic para reemplazar',
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
    Loadtable();
    Loadtabledetalle();

    $('#cd_tipoprod').change(function () {
        var tipo = $('#cd_tipoprod option:selected').attr('data-tipo');
        if (tipo == 'SERVICIOS') {
            $('#Inventario, #Text_serie, #lote, #Formulado, #stock').prop('checked', false).attr('disabled', true);
            $('#Text_Color, #Text_Modelo, #codigomarca, #cd_naturaleza, #btnsearhmar, #id_marcas').val('').attr('disabled', true);
            $('#Text_Descuento').val('0.00').removeAttr('disabled');
            $('#cd_naturaleza,#cd_tipodoc').val('').removeAttr('disabled');
            $('#ds_ctacon, #btncuenta').removeAttr('disabled');
            JsonValidate[1].required = true;
            JsonValidate[8].required = true;
            JsonValidate[9].required = true;
        }
        else if (tipo == 'CONSUMO') {
            $('#Inventario, #Text_serie, #lote, #Formulado, #stock, #facturable').prop('checked', false).attr('disabled', true);
            $('#Text_Color, #Text_Modelo, #codigomarca, #btnsearhmar, #Text_Descuento').val('').attr('disabled', true);
            $('#id_marcas, #Text_Descuento').val('0');
            $('#cd_naturaleza,#cd_tipodoc').val('').removeAttr('disabled');
            $('#ds_ctacon, #btncuenta').removeAttr('disabled');
            JsonValidate[1].required = true;
            JsonValidate[8].required = true;
            JsonValidate[9].required = true;
        }
        else {
            $('#Text_serie, #lote, #Formulado, #stock, #facturable').prop('checked', false).removeAttr('disabled');
            $('#Text_Cdescuento').prop('checked', false).attr('disabled', true);
            $('#Inventario').prop('checked', true).attr('disabled', true);
            $('#Text_Descuento').val('0.00').removeAttr('disabled');
            $('#Text_Color, #Text_Modelo, #codigomarca, #cd_naturaleza, #btnsearhmar').removeAttr('disabled');
            $('#cd_naturaleza, #id_ctacon,#cd_tipodoc').val('').attr('disabled', true);
            $('#ds_ctacon, #btncuenta').val('').attr('disabled', true);
            JsonValidate[1].required = false;
            JsonValidate[8].required = false;
            JsonValidate[9].required = false;
        }
        $('select').selectpicker('refresh');
        $('.i-checks').iCheck('update');
    });

    //Evento en campo de codigo que valida si el campo esta vacio no actualice el campo de presentacion
    $('#v_code').blur(function () {
        if ($(this).val() && $(this).val().trim() == '') {
            $('#v_presen').html("").selectpicker('refresh');
        }
    });
    //Evento en campo de checked inventario donde se valida si esta activo habilite y deshabilite campos que cumplen con la caracteristica de inventario
    $('#Inventario').on('ifChanged', function () {
        if ($(this).prop('checked')) {
            $('#id_ctacon').val('0');
            $('#ds_ctacon').val('');
            $('#btncuenta, #ds_ctacon').attr('disabled', 'disabled')
            JsonValidate[8].required = false;
        }
        else {
            $('#btncuenta, #ds_ctacon').removeAttr('disabled')
            JsonValidate[8].required = true;
        }
    });
});


//Función utilizada para hacer visible el formulado de un nuevo registro
$('.iconnew').click(function (e) {
    formReset();
    loadimg('');
    fieldsMoney();
    $('#ModalArticle').modal({ backdrop: 'static', keyboard: false }, 'show');
});

function nuevobodega() {
    $('#idbodega').val('');
    $('#codigobodega').val('');
    $('#Text_stockmin').val('');
    $('#Text_stockmax').val('');

}
//Resetear los campos del formulario
function formReset() {
    div = $('#ModalArticle');
    div.find('input.form-control, textarea').val('');
    div.find('[money]').val('0.00');
    div.find("input[type='checkbox']").prop('checked', false);
    $('#Text_IncuyeIva,#Text_IncuyeInc').prop('checked', false).iCheck('update').iCheck('disable');
    $('#cd_iva,#cd_inc').removeAttr('disabled');
    $('#cd_naturaleza').removeAttr('disabled');
    div.find('select').val('').removeAttr('disabled').selectpicker('refresh');
    $('#btnSave').attr('data-id', '0');
    $('#btncuentaiva').attr('disabled', 'disabled');
    $('#btncuenta').removeAttr('disabled')
    $('.i-checks').iCheck('update');
    $('#tabuno').trigger('click');
    $('#tabdos').attr('href', "#");
    $('#tbodformulado').empty();
    $('#isService').css('display', 'none');
    $('#cd_iva,#cd_inc').attr('disabled', 'disabled')
}
//Evento que valida si el producto creado maneja impuesto
$('#Text_Categoria').on('ifChecked', function (event) {
    $("#cd_iva,#cd_inc").removeAttr('disabled').selectpicker('refresh');
    $('#Text_IncuyeIva,#Text_IncuyeInc').iCheck('enable');
}).on('ifUnchecked', function () {
    $('#cd_iva,#cd_inc').val('').attr('disabled', 'disabled').selectpicker('refresh');
    $('#Text_IncuyeIva,#Text_IncuyeInc').prop('checked', false).iCheck('update').iCheck('disable');
});

function MostrarStock() {
    var sjson = {};
    var Criterio = {};
    sjson.Codigo = document.getElementById('Text_Codigo').value;
    sjson.Presentacion = document.getElementById('Text_Presentacion').value;
    Criterio = {};
    Criterio.sDato = JSON.stringify(sjson);
    WebServiceMetodo("ArticuloForm", "ConsultarStock", Criterio, "EndCallCargarStock");
}

function EndCallCargarStock(Parameter, Result) {
    if (Result.sCodigo === 'OK') {
        var split = JSON.parse(Result.sResultado);
        CargarTablaBodegaArticulo(split);
    }
    else {
        parent.MensajeError(true, 'Sintesis', Result.sMensaje, '');
    }
}
$("#Text_codigobarra").focus(function () {
    if ($(this).val() == '')
        $(this).val($('#Text_Codigo').val());
});

$('#btnSaveStock').click(function (e) {
    if (validate(JsonValidate2)) {
        params = {};
        params.id = $('#idbodprod').val();
        params.idproducto = $(this).attr('data-id');
        params.id_bodega = $('#idbodega').val();
        params.stockmin = $('#Text_stockmin').val();
        params.stockmax = $('#Text_stockmax').val();
        var btn = $(this);
        if (SetNumber($('#Text_stockmax').val()) >= SetNumber($('#Text_stockmin').val())) {
            btn.button('loading');
            MethodService("Productos", "ProductosBodegaSave", JSON.stringify(params), "EndCallbackupdateStock");
        } else {
            toastr.warning("El stock maximo no puede ser menor que el stock minimo. ", 'Sintesis ERP');
        }
    }

});
//Funcion del boton guardar
$('#btnSave').click(function (e) {
    if (validate(JsonValidate)) {
        var data = new FormData();
        var ds_fileUpload = $('#imgarticulo').get(0);
        var ds_files = ds_fileUpload.files;
        for (var i = 0; i < ds_files.length; i++) {
            filename = ds_files[i].name;
            data.append(ds_files[i].name, ds_files[i]);
        }
        data.append("folder", 'Imgarticulos');
        params = {};
        params.id = $(this).attr('data-id');
        params.code = $('#Text_Codigo').val();
        params.codeBar = $('#Text_codigobarra').val();
        params.present = $('#Text_Presentacion').val();
        params.nombre = $('#Text_Nombre').val();
        params.modelo = $('#Text_Modelo').val();
        params.color = $('#Text_Color').val();
        params.categoria = ($('#Select_Grupo').val() != '') ? $('#Select_Grupo').val() : 0;
        params.tipoproducto = $('#cd_tipoprod').val();
        params.marca = $('#id_marcas').val() != '' ? $('#id_marcas').val() : 0;
        params.impuesto = $('#Text_Categoria').prop('checked');
        params.ivainclu = $('#Text_IncuyeIva').prop('checked');
        params.id_iva = ($('#cd_iva').val() != '') ? $('#cd_iva').val() : 0;
        params.id_inc = ($('#cd_inc').val() != '') ? $('#cd_inc').val() : 0;
        params.pordesc = SetNumber($('#Text_Descuento').val());
        params.formulado = $('#Formulado').prop('checked');
        params.stock = $('#stock').prop('checked');
        params.serie = $('#Text_serie').prop('checked');
        params.facturable = $('#Text_factura').prop('checked');
        params.inventario = $('#Inventario').prop('checked');
        params.lote = $('#lote').prop('checked');
        params.precio = SetNumber($('#Text_Precio').val());
        params.id_cuenta = $('#id_ctacon').val() != '' ? $('#id_ctacon').val() : 0;
        params.tipodocume = ($('#cd_tipodoc').val() != '') ? $('#cd_tipodoc').val() : 0;
        params.naturaleza = ($('#cd_naturaleza').val() != '') ? $('#cd_naturaleza').val() : 0;
        params.esdescuento = $('#Text_Cdescuento').prop('checked');
        params.reorden = "<reorden></reorden>";
        params.xmlformulado = GenerarXMLFormulados();
        if ((params.xmlformulado != "" && params.formulado == true) || params.formulado == false) {
            var btn = $(this);
            btn.button('loading');
            MethodUploads("Productos", "ProductosSave", data, JSON.stringify(params), "EndCallbackArticle");
        }
        else
            toastr.warning("El artículo es formulado y no hay artículos dependientes, verifique. ", 'Sintesis ERP');
    }
});
//Funcion de retorno de la respuesta del servidor al guardar
function EndCallbackArticle(params, answer) {
    if (!answer.Error) {
        toastr.success('Guardado Exitosoe', 'Sintesis ERP');
        formReset();
        loadimg('');
        fieldsMoney();
        $('#imgarticulo').val('');
        window.gridarti.bootgrid('reload');
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }

    $('#btnSave').button('reset');
}
//Funcion de retorno de la respuesta del servidor al consultar un producto
function EndCallbackGet(params, answer) {
    if (!answer.Error) {

        $('#imgarticulo').val('')
        data = answer.Row;
        $('#cd_tipoprod').val(data.tipoproducto).trigger('change');

        $('#btnSave').attr('data-id', data.id);
        $('#Text_Codigo').val(data.codigo);
        $('#Text_codigobarra').val(data.codigobarra);
        $('#Text_Presentacion').val(data.presentacion);
        $('#Text_Nombre').val(data.nombre);
        $('#Text_Modelo').val(data.modelo);
        $('#Text_Color').val(data.color);
        $('#Select_Grupo').val(data.categoria).selectpicker('refresh');
        $('#codigomarca').val(data.marcacompl);
        $('#id_marcas').val(data.marca);

        if (data.impuesto) {
            $('#Text_Categoria').prop('checked', true);
            $('#Text_IncuyeIva,#Text_IncuyeInc').iCheck('enable');
            $("#cd_iva").removeAttr('disabled').val(data.id_iva).selectpicker('refresh');
            $("#cd_inc").removeAttr('disabled').val(data.id_inc).selectpicker('refresh');
            $('#Text_IncuyeIva').prop('checked', data.ivaincluido);
            $('#Text_IncuyeInc').prop('checked', data.incincluido);
        } else {
            $('#Text_Categoria').prop('checked', false);
            $('#cd_iva,#cd_inc').attr('disabled', 'disabled').val(0).selectpicker('refresh');
            $('#Text_IncuyeIva,#Text_IncuyeInc').prop('checked', false).iCheck('update').iCheck('disable');
        }
        if (data.formulado) {
            $('#tabdos').attr('href', "#tab-2");
        }
        else {
            $('#tabdos').attr('href', "#");
        }
        $('#Text_Descuento').val(data.porcendescto.Money());
        $('#Formulado').prop('checked', data.formulado);
        $('#Inventario').prop('checked', data.inventario);
        $('#Text_serie').prop('checked', data.serie);
        $('#Text_factura').prop('checked', data.facturable);
        $('#Text_Precio').val(data.precio.Money());
        $('#stock').prop('checked', data.stock);
        $('#lote').prop('checked', data.lote);
        $('#cd_tipodoc').val(data.id_tipodocu);
        $('#cd_tipodoc').removeAttr('disabled');
        if ($('#Formulado').prop('checked')) {
            $('#tabdos').attr('href', "#tab-2");
            $('#tabdos').css('display', 'block')
        }
        if (!data.inventario) {
            $('#ds_ctacon').val(data.Cuentacontable);
            $('#id_ctacon').val(data.id_ctacontable);
            $('#btncuenta,#cd_tipodoc').removeAttr('disabled', 'disabled');

        } else {
            $('#btncuenta,#cd_tipodoc').attr('disabled', 'disabled')
        }

        $('#cd_naturaleza').val(data.id_naturaleza);

        $('#Text_Cdescuento').prop('checked', data.esdescuento);
        loadimg(data.urlimg);

        $('select').selectpicker('refresh');

        $('.i-checks').iCheck('update');
        fieldsMoney();
        var body = $('#tbodformulado');
        body.empty();
        if (answer.Table != null && answer.Table != undefined) {
            $.each(answer.Table, function (i, e) {
                tr = $('<tr/>').attr({ 'data-idarticulo': e.id, 'data-cantidad': e.cantidad, 'data-producto': e.codigo, 'data-id_padre:': e.id_padre });
                a = $('<a/>').html('<span class="fa fa-2x fa-trash-o text-danger iconfa"></span>').click(function () {
                    $(this).closest('tr').remove();
                })
                td = $('<td class="text-center"/>').append(a);
                td1 = $('<td class="text-center"/>').html(e.id);
                td2 = $('<td class="text-center"/>').html(e.codigo);
                td3 = $('<td class="text-center"/>').html(Number(e.cantidad).Money());
                tr.append(td, td1, td2, td3);
                body.append(tr);
            });
        }
        $('#tabuno').trigger('click');
        $('#ModalArticle').modal({ backdrop: 'static', keyboard: false }, 'show');
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}
function EndCallbackGetStock(params, answer) { // GeT para cargar la info del producto y solicitar datos de bodega y stock
    if (!answer.Error) {
        data = answer.Row;
        if (data.inventario) {
            if (data.stock) {
                $('#btnSaveStock').attr('data-id', data.id);
                $('#producto').val(data.codigo + ' ' + data.nombre);
                nuevobodega();
                window.gridbodegaprod.bootgrid('reload');

                $('#ModalStock').modal({ backdrop: 'static', keyboard: false }, 'show');
            } else {
                toastr.error('Este producto no maneja Stock', 'Sintesis ERP');
            }
        } else {
            toastr.error('Este producto no maneja inventario', 'Sintesis ERP');
        }
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }

}
//Funcion de retorno de la respuesta del servidor al Cambiar estado
function EndCallbackupdate(params, answer) {
    if (!answer.Error) {
        window.gridarti.bootgrid('reload');
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}
//Funcion de retorno de la respuesta del servidor al Cambiar estado de stcok
function EndCallbackupdateStock(params, answer) {
    if (!answer.Error) {
        window.gridbodegaprod.bootgrid('reload');
        nuevobodega();
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
    $('#btnSaveStock').button('reset');
}
function EndCallbackGetBodegaProd(params, answer) { // GeT para cargar de la tabla de productos bodegas
    if (!answer.Error) {
        data = answer.Row;
        $('#idbodprod').val(data.id);
        $('#idbodega').val(data.id_bodega);
        $('#codigobodega').val(data.bodega);
        $('#Text_stockmin').val(data.stockmin);
        $('#Text_stockmax').val(data.stockmax);

    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }

}
//Funcion de cargar imagen
function loadimg(src) {
    drDestroy = $('#imgarticulo');
    //drDestroy.val(src);
    drDestroy = drDestroy.data('dropify');
    if (drDestroy.isDropified()) {
        drDestroy.settings.defaultFile = src;
        drDestroy.destroy();
        drDestroy.init();
    }
}
//Evento que agrega un articulo en la grilla de formulados
$('#addArticulo').click(function (e) {
    if (validate(JsonCommodity)) {
        code = $('#v_code').val();
        id_articulo = $('#v_code').val();
        producto = $('#valor_prod').val();
        data = $('#btnSave').data()
        id_padre = data.id;
        //present = $('#v_presen option:selected').text();
        //serie = $('#cd_serie option:selected').text();
        //Lote = $('#cd_lote option:selected').text();
        cantidad = SetNumber($('#m_quantity').val());
        if (cantidad > 0) {
            var body = $('#tbodformulado');
            count = body.find('tr[data-idarticulo="' + id_articulo + '"]');
            if (count == undefined || count.length == 0) {
                tr = $('<tr/>').attr({ 'data-idarticulo': id_articulo, 'data-cantidad': cantidad, 'data-id_padre': id_padre });
                a = $('<a/>').html('<span class="fa fa-2x fa-trash-o text-danger iconfa"></span>').click(function () {
                    $(this).closest('tr').remove();
                })
                td = $('<td class="text-center"/>').append(a);
                td1 = $('<td class="text-center"/>').html(code);
                //td2 = $('<td class="text-center"/>').html(present);
                //td3 = $('<td class="text-center"/>').html(serie);
                //td4 = $('<td class="text-center"/>').html(Lote);   
                td2 = $('<td class="text-center" />').html(producto)
                td3 = $('<td class="text-center"/>').html(Number(cantidad).Money(4));

                tr.append(td, td1, td2, td3);
                body.append(tr);
                $('#valor_prod').val('');
                //$('#v_presen').html('').selectpicker('refresh');
                //$('#cd_serie').html('').selectpicker('refresh');
                //$('#cd_lote').html('').selectpicker('refresh');
                $('#m_quantity').val('0.00');
                $('#v_code').focus();
                $('#nombre').val('')
            }
            else
                toastr.warning("Este artículo ya esta dentro de la formulación", 'Sintesis ERP');
        }
        else
            toastr.warning("La cantidad no puede ser menor ni igual a 0.", 'Sintesis ERP');
    }

    $('#hiddencode').val('');
});
//evento que elimina los articulos de la grilla
$('#removeart').click(function () {
    $('#tbodformulado').empty();
});
//Evento que valida si el articulo es formulado el cual habilita y deshabilita el panel de formulado
$('#Formulado').on('ifChecked', function (event) {
    $('#tabdos').attr('href', "#tab-2");
    $('#tabdos').css('display', 'block')
}).on('ifUnchecked', function () {
    $('#tabdos').attr('href', "#");
    $('#tbodformulado').empty();
    $('#tabdos').css('display', 'none')
});


//Funcion que genera el xml de los articulos que hacen parte de los formulados
function GenerarXMLFormulados() {
    var xml = "";
    trs = $('#tbodformulado').find('tr');
    if (trs.length > 0) {
        $.each(trs, function (i, e) {
            data = $(e).data();
            xml += '<item id_item="' + data.idarticulo + '" id_producto="' + $('#btnSave').data('id') + '"  cantidad="' + data.cantidad + '" />'

        });
        xml = "<items>" + xml + "</items>"
    }
    return xml;
}