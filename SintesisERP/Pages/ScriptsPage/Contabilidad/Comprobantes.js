
var JsonValidate = [{ id: 'cd_tipodoc', type: 'WHOLE', htmltype: 'SELECT', required: true, depends: false, iddepends: '' },
{ id: 'codigoccostos', type: 'TEXT', htmltype: 'INPUT', required: false, depends: false, iddepends: '' },
{ id: 'Text_Fecha', type: 'DATE', htmltype: 'INPUT', required: true, depends: false, iddepends: '' }
];

var JsonCommodity = [{ id: 'ds_cliente', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'ds_factura', type: 'TEXT', htmltype: 'INPUT', required: false, depends: false, iddepends: '' }]

window.tblcommodity = null;
$(document).ready(function () {
    window.tblcommodity = $("#tblcommodity").bootgrid({
        ajax: true,
        post: function () {
            return {
                'params': function () {
                    var param = {};
                    param.id_comprobante = $('#id_comprobante').val();
                    param.opcion = $('#opTipoComprobante').val();
                    return JSON.stringify(param);
                },

                'class': "Comprobantes",
                'method': 'ComprobanteContableItemsList'
            };
        },
        url: window.appPath + "/Pages/Connectors/ConnectorList.ashx", //conecta los metodos con los controladores*/
        // rowCount: -1,
        columnSelection: false,
        formatters: {
            "delete": function (column, row) {
                return ("<a class=\"action command-delete\" data-row-id=\"" + row.id + "\"><span class=\"fa fa-2x fa-trash-o text-danger iconfa\"></span></a>");
            },

            "debito": function (column, row) {
                return "<span class='tdedit action command-edit' data-type='numeric' data-column='debito' data-min='0' data-max='999999999999999999' data-simbol='$' data-value='" + row.debito + "' data-id='" + row.id + "'>" + row.debito.Money() + "</span>";
            },
            "credito": function (column, row) {
                return "<span class='tdedit action command-edit' data-type='numeric' data-column='credito' data-min='0' data-max='999999999999999999' data-simbol='$' data-value='" + row.credito + "' data-id='" + row.id + "'>" + row.credito.Money() + "</span>";
            },

        }
    }).on("loaded.rs.jquery.bootgrid", function () {
        window.tblcommodity.find(".command-delete").on("click", function (e) {
            id = $(this).data("row-id");
            params = {};
            params.id_item = id;
            params.id_comprobante = $('#id_comprobante').val();
            MethodService("Comprobantes", "ComprobantesDelItems", JSON.stringify(params), 'EndCallbackupdate');
        }).end().find(".command-edit").on("dblclick", function (e) {
            params = {};
            data = $(this).data();
            if (data.value != 0 && $('#opTipoComprobante').val() == 'T') {
                tr = $(this).closest('td');
                $(this).hide();
                input = $('<input class="form-control rowedit" date-type="numeric" data-oldvalue="' + data.value + '" data-column="' + data.column + '" data-id="' + data.id + '" value="' + data.value + '" money="true" data-a-dec="." data-a-sep="," data-m-dec="2" data-v-min="0" data-v-max="9999999999999999999">');
                input.autoNumeric('init');
                input.blur(function () {
                    var row = $(this).data();
                    newvalue = $(this).val();
                    oldvalue = $(this).attr('data-oldvalue');
                    type = $(this).attr('date-type');
                    if ((type == 'numeric' && SetNumber(newvalue) != oldvalue) || (type != 'numeric' && newvalue != oldvalue)) {
                        params = {};
                        params.id = row.id;
                        params.column = row.column;
                        params.value = (type != 'numeric') ? '0' : SetNumber(newvalue);
                        MethodService("Comprobantes", "ComprobantesSetItems", JSON.stringify(params), 'EndCallbackupdate');
                    }
                    else {
                        tr = $(this).closest('td');
                        var ret = (type == 'numeric') ? parseFloat(oldvalue).Money() : oldvalue;
                        tr.find('.tdedit').html(ret).show();
                        $(this).remove();
                    }
                });
                tr.find('.tdedit').hide();
                tr.append(input);
                input.focus().select();
            }
        });
        if ($('#opTipoComprobante').val() == 'E') {
            window.tblcommodity.find(".command-delete").remove();
            //window.tblcommodity.find(".command-edit").remove();
        }
    });
    newComprobante();

    $('#id_concepto').change(function () {
        if ($(this).val() != 0) {
            ($('#id_ctacon').val('0'), $('#ds_ctacon').val(''))
        }
    });
    $('#id_ctacon').change(function () {
        if ($(this).val() != 0) {
            ($('#id_concepto,#cd_cliente,#cd_idsaldo').val('0'), $('#ds_concepto,#ds_cliente,#ds_factura').val(''));
            $('#fechadoc').val(SetDate($('#Text_Fecha').val()));
        }

    });

    //evento que bloquea en caso tal que cambie y actualiza el input de centro de costo detalle si es vacio se deshabilita  
    $('#id_ccostos').change(function () {
        val = $(this).val();
        val1 = $('#codigoccostos').val();
        element = $("#id_ccostosDe");
        element1 = $("#codigoccostosDe");
        

        if (val != '0' && val != null && val.trim() != '' ) {
           element.val(val);
            element1.val(val1).attr('disabled', 'disabled');
        }
        else {
            element.val('0');
            element1.val('').removeAttr('disabled');
        }
       
    });

    $('#codigoccostos').blur(function () {
        val = $(this).val();
        element1 = $("#codigoccostosDe");
        element = $("#id_ccostosDe");
        if (val.trim() == '') {
            element.val('0')
            element1.val('').removeAttr('disabled');
        }
    })

    $('#id_ctacon').change(function () {
        id = $(this).val();
        params = {};
        params.id = id;
        if ($(this).val() != '' && $(this).val() != undefined) {
            $('#concepto').val('');
            $('#id_concepto').val('0')
        }
        MethodService("CNTCuentas", "CNTCuentasGet", JSON.stringify(params), 'EndCallbackGetCuenta');
    });

    $('#cd_tipoter').change(function () {
        var valor = $(this).find('option:selected').attr('data-iden');
        $('#tipotercero1').val(valor);
        $('#ds_cliente').val('').attr('data-params', "op:T;o:" + valor).removeData('params').data('params')
    });
});



function newComprobante() {
    $('#opTipoComprobante').val('T');
    $('input.form-control').val('');
    $('#descripcion').val('');
    $('[money]').val('0.00');
    fieldsMoney();
    $('#totalItems').val(0)
    datepicker();
    $('.entradanumber').html('0');
    $('#btnSave, #btnTemp,  #btnconf, #btnLoad,#cd_tipodoc,.btnsearch,#descripcion,#cd_movimiento,m_valor,#detalle,#btnload').removeAttr('disabled');
    $('.dropify-clear').click();
    $('#btnRev').attr('disabled', 'disbled');
    $('#addarticle').removeAttr('disabled');
    $('#cd_tipodoc').val('0').selectpicker('refresh');
    $('.cred,#venciproveedor,#vencicliente').css('display', 'none');
    $('#cd_concepto,#id_ctacon,#cd_cliente,#cd_factura,#cd_idsaldo').val('0');
    $('#ds_ctacon,#ds_cliente,#fechadoc,ds_saldo').val('');
    var div = $('.diventrada');
    div.find('[money], .addarticle, select.selectpicker, .btnsearch, input.form-control').removeAttr('disabled');
    div.find('select').selectpicker('refresh');
    $('#prorratear').prop('checked', true).iCheck('update').trigger('ifChecked');
    $('#btnproviderconf').attr('disabled', 'disabled');

    var Parameter = {};
    MethodService("Comprobantes", "ComprobanteSaveConsecutivo", JSON.stringify(Parameter), "EndCallbackTempComprobante");

}

window.gridcomprobantes;
$(document).ready(function () {
    $('#btnList').click(function () {
        if (window.gridcomprobantes === undefined) {
            window.gridcomprobantes = $("#tblcomprobante").bootgrid({
                ajax: true,
                post: function () {
                    return {
                        'params': "",
                        'class': 'Comprobantes',
                        'method': 'ComprobanteContableList'
                    };
                },
                url: window.appPath + "/Pages/Connectors/ConnectorList.ashx",
                formatters: {
                    "edit": function (column, row) {
                        return "<a class=\"action command-edit\" data-row-id=\"" + row.id + "\"><span class=\"fa-2x fa fa-pencil iconfa\"></span></a>";
                    },
                    "ver": function (column, row) {
                        return "<a class=\"action command-ver\" data-row-id=\"" + row.id + "\"><span class=\"fa fa-2x fa-print iconfa\"></span></a>";
                    },
                    "rever": function (column, row) {
                        return "<a class=\"action command-rever\" data-row-id=\"" + row.id + "\"><span class=\"fa fa-2x fa-fw fa-exclamation-triangle text-warning  iconfa\" /></a>";

                    }
                }
            }).on("loaded.rs.jquery.bootgrid", function () {
                // Executes after data is loaded and rendered 
                window.gridcomprobantes.find(".command-edit").on("click", function (e) {
                    id = $(this).data("row-id")
                    params = {};
                    params.id = id;
                    MethodService("Comprobantes", "ComprobanteContableGet", JSON.stringify(params), 'EndCallbackGet');
                }).end().find(".command-ver").on("click", function (e) {
                    $('#ModalLoad').modal({ backdrop: 'static', keyboard: false }, "show");
                    id = $(this).data("row-id")
                    var idpagoprov = id
                    param = 'id|' + idpagoprov + ';'
                    PrintDocument(param, 'MOVCOMPROCONTA', 'CODE');

                }).end().find(".command-rever").on("click", function (e) {
                    id = $(this).data("row-id")
                    if (id != '0' && id != '') {
                        if (confirm("Desea revertir Comprobante?")) {
                            var sJon = {};
                            sJon.id = id;
                            MethodService("Comprobantes", "RevertirComprobante", JSON.stringify(sJon), "CallbackReversionList")
                        }
                    }
                });

            });
        }
        else
            window.gridcomprobantes.bootgrid('reload');

        $('#Modalcomprobantes').modal({ backdrop: 'static', keyboard: false }, "show");
    });

    $('#btnRev').click(function () {
        if ($('#id_comprobante').val() != '0' && $('#id_comprobante').val().trim() != '') {
            if (confirm("Desea revertir el comprobante?")) {
                var sJon = {};
                sJon.id = ($('#id_comprobante').val().trim() == "") ? "0" : $('#id_comprobante').val();
                MethodService("Comprobantes", "RevertirComprobante", JSON.stringify(sJon), "CallbackReversion");
            }
        }
    });

    $('#btnsupri').click(function () {
        $('.dropify-clear').click();
        var Parameter = {};
        Parameter.id_comprobante = $('#id_comprobante').val();

        MethodService("Comprobantes", "ComprobanteDescargar", JSON.stringify(Parameter), "EndCallbackUnLoad");
    });

    $("#btnload").click(function () {
        $('#ModalLoadPlano').modal({ backdrop: 'static', keyboard: false }, 'show');
    });

    $('#btnLoad').click(function () {
        var data = new FormData();
        var ds_fileUpload = $('#File1').get(0);
        var ds_files = ds_fileUpload.files;
        if (ds_files.length > 0) {
            if (confirm("Se eliminaran todos los registros que ya ha insertado, desea seguir?")) {
                for (var i = 0; i < ds_files.length; i++) {
                    filename = ds_files[i].name;
                    data.append(ds_files[i].name, ds_files[i]);
                }
                data.append("folder", 'Filetemp');
               
                Parameter = {};
                Parameter.id_comprobante = $('#id_comprobante').val();
                var btn = $(this);
                btn.button('loading');
                MethodUploads("Comprobantes", "ComprobantesCargarItems", data, JSON.stringify(Parameter),"EndCallbackLoad");
            }
        }
        else
            toastr.warning('No ha seleccionado ningun archivo.', 'Sintesis ERP');
    });
    $('#addarticle').click(function (e) {
        if (validate(JsonCommodity)) {
            var Parameter = {};
            Parameter.id = $(this).attr('data-id');
            Parameter.id_comprobante = $('#id_comprobante').val();
            Parameter.id_centrocosto = $('#id_ccostosDe').val();
            Parameter.concepto = $('#id_concepto').val() == '' ? 0 : $('#id_concepto').val();
            Parameter.cuenta = $('#id_ctacon').val() == '' ? 0 : $('#id_ctacon').val();
            Parameter.tercero = $('#cd_cliente').val();
            Parameter.factura = $('#ds_factura').val() != "" ? $('#ds_factura').val() : null;
            Parameter.fechavencimiento = $('#tipotercero1').val() === 'Cl' ? ($('#ds_factura').val() != "" ? SetDate($('#ds_saldo').val()) : null) : ($('#ds_factura').val() != ""? SetDate($('#Text_FechaVenpro').val()):null); //Actualizado
            Parameter.id_saldocuota = $('#ds_factura').val() != "" ? $('#cd_idsaldo').val() : null;
            Parameter.detalle = $('#detalle').val();
            Parameter.valor = $('#cd_movimiento').val() == 'debito' ? SetNumber($('#m_valor').val()) : SetNumber($('#m_valor').val()) * -1;
            Parameter.Fecha = SetDate($('#Text_Fecha').val());
            if ($('#cd_movimiento').val() != '') {
                if (SetNumber($('#m_valor').val()) != 0) {
                    $('#addarticle').button('loading');
                    MethodService("Comprobantes", "ComprobantecontableADD", JSON.stringify(Parameter), "EndCallbackAddArticle");
                } else {
                    toastr.warning("Valor debe ser mayor de 0", 'Sintesis ERP');
                }
            } else {
                toastr.warning("Seleccionar un tipo de movimiento.", 'Sintesis ERP');
            }
        }
    });

    $('#btnPrint').click(function () {
        var idcomprobante = $('#id_comprobante').val();
        param = 'id|' + idcomprobante + ';'
        console.log(idcomprobante)
        PrintDocument(param, 'MOVCOMPROCONTA', 'CODE');
    });

    $('#btnnew').click(function () {
        newComprobante();
    });

    $('#btnSave').click(function () {
        if (validate(JsonValidate)) {
            if (window.tblcommodity.bootgrid("getTotalRowCount") > 0) {
                var sJon = {};
                sJon.Id = ($('#id_comprobante').val().trim() == "") ? "0" : $('#id_comprobante').val();
                sJon.id_tipodoc = $('#cd_tipodoc').val();
                sJon.Fecha = SetDate($('#Text_Fecha').val());
                sJon.detalle = $('#descripcion').val();
                sJon.id_comprobante = $('#id_comprobante').val();
                if (SetNumber($('#Tdiferencia').text()) == 0.00) {
                    $('#btnSave').button('loading');
                    MethodService("Comprobantes", "FacturarComprobante", JSON.stringify(sJon), "CallbackComodity");
                } else {
                    toastr.warning("Comprobante descuadrado.", 'Sintesis ERP');
                }
            }
            else
                toastr.warning("No ha agregado ningun artículo.", 'Sintesis ERP');
        }
    });
});

function EndCallLoadItem(params, answer) {
    if (!answer.Error) {
        data = answer.Row;
        $('#addarticle').attr('data-id', data.id);
        $('#cd_concepto').val(data.id_concepto);
        $('#ds_concepto').val(data.concepto);
        if (!(data.cd_concepto === undefined)) {
            $('#id_ctacomdev').val(data.id_cuenta);
            $('#ds_ctacomdev').val(data.cuenta);
        }
        $('#cd_provider').val(data.id_tercero);
        $('#ds_provider').val(data.tercero);
        $('#detalle').val(data.detalle);

        if (data.valor > 0) {
            $('#cd_movimiento').val('debito').selectpicker('refresh');
            $('#m_valor').val(data.valor);
        } else {
            $('#cd_movimiento').val('credito').selectpicker('refresh');
            $('#m_valor').val(data.valor * -1);
        }
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}

function EndCallbackUnLoad(Parameter, Result) {
    if (!Result.Error) {
        window.tblcommodity.bootgrid('reload');
        $('#btnLoad, #addarticle').removeAttr('disabled');

    }
    else {
        toastr.error(Result.Message, 'Sintesis ERP');
    }
    $('#btnsupri').button('reset');
}

function EndCallbackGet(Parameter, Result) {
    if (!Result.Error) {
        var row = Result.Row;
        if (row.estado == 'PROCESADO') {
            $('#btnSave, #btnTemp, #btnconf').attr('disabled', 'disabled');
            $('#btnRev').removeAttr('disabled');
        }
        else {
            $('#btnSave, #btnTemp, #btnRev, #btnconf').attr('disabled', 'disabled');
        }
        $('#opTipoComprobante').val('E');
        $(this).attr('data-option');
        $('#cd_tipodoc,.btnsearch,#descripcion,#cd_movimiento,m_valor,#detalle').attr('disabled', 'disabled');
        $('.entradanumber').text(row.id);
        $('#id_comprobante').val(row.id);
        $('#Text_Fecha').val(row.fecha);
        $('#descripcion').val(row.detalle);
        $('#id_ccostos').val(row.id_centrocosto).attr('disabled', 'disabled')
        $('#cd_tipodoc').val(row.id_documento).selectpicker('refresh');
        $('#codigoccostos').val(row.centrocosto).attr('disabled', 'disabled');
       // $('#codigoccostos')

        TotalizarComprobante(row);
        var div = $('.diventrada');
        div.find('[money], .addarticle, select.selectpicker, .btnsearch, input.form-control, textarea').attr('disabled', true);
        div.find('select').selectpicker('refresh');
        window.tblcommodity.bootgrid('reload');

        window.setTimeout(function () {
            $('#Modalcomprobantes').modal('hide');
        }, 4);

    }
    else {
        toastr.error(Result.Message, 'Sintesis ERP');
    }
}
function EndCallbackGetCuenta(Parameter, Result) {
    if (!Result.Error) {
        var row = Result.Row;
        categoria = row.nomcategoria;
        if (categoria == 'Cliente') {
            tipotercero = 'Cl';
        } else if (categoria == 'Proveedor') {
            tipotercero = 'PR';
        } else {
            tipotercero = 'TC';
        }
        $('#fechadoc').val(SetDate($('#Text_Fecha').val()));
        $('#tipotercero1').val(tipotercero);
        (tipotercero == 'TC') ? $('.cred').css('display', 'none') : $('.cred').css('display', 'block');
        if (tipotercero == 'Cl') {
            $('#venciproveedor').css('display', 'none')
            $('#vencicliente').css('display', 'block')
           
        } else if (tipotercero=='PR') {
            $('#vencicliente').css('display', 'none');
            $('#venciproveedor').css('display', 'block');

        }
        JsonCommodity[1].required = (tipotercero == 'TC') ? false : true;
    }


}

function EndCallbackupdate(params, Result) {
    if (!Result.Error) {
        param = JSON.parse(params);
        window.tblcommodity.bootgrid('reload');
        Data = Result.Row;
        TotalizarComprobante(Data);
    }
    else {
        toastr.error(Result.Message, 'Sintesis ERP');
    }
}
function EndCallbackLoad(Parameter, Result) {
    if (!Result.Error) {
        console.log(Result);
        Data = Result.Row

        window.tblcommodity.bootgrid('reload');
        TotalizarComprobante(Data);
        $('#ModalLoadPlano').modal("hide");

        $('#btnLoad').button('reset');
        $('#btnLoad, #addarticle').attr('disabled', 'disabled');
    }
    else {
        toastr.error(Result.Message, 'Sintesis ERP');
        $('#btnLoad').button('reset');
    }
}
function EndCallbackAddArticle(Parameter, Result) {
    if (!Result.Error) {
        $('#opTipoComprobante').val('T');
       
        $('#ds_concepto').val('');
        $('#cd_concepto,#id_ctacon,#cd_cliente,#cd_factura,#cd_idsaldo').val('0');
        $('#ds_ctacon,#ds_cliente,#fechadoc,#ds_saldo,#fechadoc1,#cd_factura1').val('');

        $('#ds_factura').val('');
        $('#detalle').val('');
        $('#m_valor').val('$ 0.00');
        $('.cred,#venciproveedor,#vencicliente').css('display', 'none');
        $('.addart').val('0.00');
        $('#addarticle').attr('data-id', 0);
        $('#cd_movimiento').val('').selectpicker('refresh');
        $('#Button3').removeAttr('disabled');

        if (!($('#id_ccostos').val() != 0 && $('#codigoccostos').val().trim() != '')) {
            $('#id_ccostosDe').val('0');
            $('#codigoccostosDe').val('');
            $('#codigoccostosDe').focus()
        } else {
            $('#concepto').focus()
        }
        Data = Result.Row

        var registros = $('#totalItems').val();
        registros > 0 ? $('#totalItems').val(registros - 1) : $('#totalItems').val(0);
        window.tblcommodity.bootgrid('reload');
        
        TotalizarComprobante(Data);
    }
    else {
        toastr.error(Result.Message, 'Sintesis ERP');
    }
    $('#addarticle').button('reset');
}
function TotalizarComprobante(Data) {
    (Data.Tdebito === undefined) ? $('#Tdebito').text('$ 0.00') : $('#Tdebito').text('$ ' + Data.Tdebito.Money());
    (Data.Tcredito === undefined) ? $('#Tcredito').text('$ 0.00') : $('#Tcredito').text('$ ' + Data.Tcredito.Money());
    if (Data.diferencia === undefined) {
        $('#Tdiferencia').text('$ 0.00');
        $('#Tdiferencia').css('color', '#676A6C');
    } else {
        $('#Tdiferencia').text('$ ' + Data.diferencia.Money());
        if (Data.diferencia.Money() != 0) {
            $('#Tdiferencia').css('color', 'red');
        } else {
            $('#Tdiferencia').css('color', '#676A6C');
        }
    }



}
function EndCallbackTempComprobante(Parameter, Result) {
    if (!Result.Error) {
        Data = Result.Row;
        $('#id_comprobante').val(Data.id);
        window.tblcommodity.bootgrid('reload');
        TotalizarComprobante(Data);
        var par = JSON.parse(Parameter);
        if (par.id_entrada != '0' && par.id_entrada != 0 && par.id_entrada !== undefined)
            toastr.info("Guardado temporal realizado.", 'Sintesis ERP');
    }
    else {
        toastr.error(Result.Message, 'Sintesis ERP');
    }
}

function CallbackReversionList(Parameter, Result) {
    json = JSON.parse(Parameter);
    if (!Result.Error) {
        window.gridcomprobantes.bootgrid('reload');
        toastr.success('Comprobante Revertido.', 'Sintesis ERP');
    }
    else
        toastr.error(Result.Message, 'Sintesis ERP');
}

function CallbackReversion(Parameter, Result) {
    json = JSON.parse(Parameter);
    if (!Result.Error) {
        datos = Result.Row;
        $('.entradanumber').html(datos.id);
        $('#id_entrada').val(datos.id);
        $('#btnSave, #btnTemp, #btnRev').attr('disabled', 'disabled');
        var div = $('.diventrada');
        div.find('[money], .addarticle, select.selectpicker, .btnsearch, input.form-control').attr('disabled', true);
        div.find('select').selectpicker('refresh');
        $('#tblcommodity').find('a.command-delete').remove();
        toastr.success('Entrada Revertida.', 'Sintesis ERP');
    }
    else
        toastr.error(Result.Message, 'Sintesis ERP');
}
function CallbackComodity(Parameter, Result) {
    json = JSON.parse(Parameter);
    if (!Result.Error) {
        datos = Result.Row;
        $('.entradanumber').html(datos.id);
        $('#id_comprobante').val(datos.id);
        $('#btnSave, #btnTemp,#cd_tipodoc,.btnsearch,#descripcion,#cd_movimiento,m_valor,#detalle').attr('disabled', 'disabled');
        $('#btnRev').removeAttr('disabled');
        var div = $('.diventrada');
        div.find('[money], .addarticle, select.selectpicker, .btnsearch, input.form-control,#btnload').attr('disabled', true);
        div.find('select').selectpicker('refresh');
        $('#tblcommodity').find('a.command-delete').remove();
        toastr.success('Comprobante Realizado.', 'Sintesis ERP');
    }
    else
        toastr.error(Result.Message, 'Sintesis ERP');

    $('#btnSave').button('reset');
}
function cleanartycle() {
    $('#v_serie').val('');
}
$('#Text_Fecha').blur(function () {
    $('#fechadoc,#fechadoc1').val(SetDate($('#Text_Fecha').val()));
    $('#cd_idsaldo,#ds_saldo').val('');
});

$('#cd_factura').change(function () {
    if ($('#tipotercero1').val() == 'Cl') {
        $('#cd_factura1').val($('#ds_factura').val());
        $('#fechadoc1').val(SetDate($('#Text_Fecha').val()));
    } else {
        id = $(this).val();
        params = {};
        params.id = id;
        params.tipoterce = 'PR';
        params.fecha = SetDate($('#Text_Fecha').val());
        params.id_cliente = $('#cd_cliente').val();
        params.nrofactura = $('#ds_factura').val();
        params.cuenta = $('#id_ctacon').val()
        MethodService("NotasCartera", "SaldosGET", JSON.stringify(params), 'EndCallbackGetSaldos');
    }
});
function EndCallbackGetSaldos(params, answer) {
    if (!answer.Error) {
        data = answer.Row;
        $('#Text_FechaVenpro').val(data.vencimientocuota);
        $('#cd_idsaldo').val(data.id);
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}
