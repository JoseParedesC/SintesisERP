using System;
using System.Collections.Generic;
using System.Data;
using J_W.Vinculation;
using SintesisERP.Pages.Connectors;
using System.Web.Script.Serialization;
using J_W.Estructura;
using System.IO;
using System.Data.OleDb;
using System.Linq;
using SintesisERP.App_Data.Model.Contabilidad;
/// <summary>
/// Descripción breve de Buscadores
/// </summary>
/// 
namespace SintesisERP.App_Data.Model.Inventario
{
    public class Entradas : Session_Entity
    {
        private JavaScriptSerializer jsSerialize;
        public Entradas()
        {
            jsSerialize = new JavaScriptSerializer();
        }
        #region
        public object EntradasList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[Dbo].[ST_MovEntradasList]", "@page:int", dc_params.GetString("start"), "@numpage:int", dc_params.GetString("length"), "@filter:varchar:50", dc_params.GetString("filter"), "@countpage:int:output", 0).RunData(out outoaram);
                if (!result.Error)
                {
                    return jsSerialize.Serialize(new { Data = result.Data.Tables[0].ToList(), totalpage = outoaram["countpage"] });
                }
                else
                {
                    return new { error = 1, errorMesage = "No hay resultado" };
                }
            }
            catch (Exception ex)
            {
                return new { error = 1, errorMesage = ex.Message };
            }
        }

        public object EntradasListProcess(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[Dbo].[ST_MovEntradasListProcess]", "@page:int", dc_params.GetString("start"), "@numpage:int", dc_params.GetString("length"), "@filter:varchar:50", dc_params.GetString("filter"), "@countpage:int:output", 0).RunData(out outoaram);
                if (!result.Error)
                {
                    return jsSerialize.Serialize(new { Data = result.Data.Tables[0].ToList(), totalpage = outoaram["countpage"] });
                }
                else
                {
                    return new { error = 1, errorMesage = "No hay resultado" };
                }
            }
            catch (Exception ex)
            {
                return new { error = 1, errorMesage = ex.Message };
            }
        }

        public object EntradasItemList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[Dbo].[ST_MovEntradasItemList]", "@page:int", dc_params.GetString("start"), "@numpage:int", dc_params.GetString("length"), "@filter:varchar:50", dc_params.GetString("filter"), "@countpage:int:output", 0, "@id_entrada:BIGINT", dc_params.GetString("id_entrada"),
                    "@op:CHAR:1", dc_params.GetString("opcion")).RunData(out outoaram);
                if (!result.Error)
                {
                    return jsSerialize.Serialize(new { Data = result.Data.Tables[0].ToList(), totalpage = outoaram["countpage"] });
                }
                else
                {
                    return new { error = 1, errorMesage = "No hay resultado" };
                }
            }
            catch (Exception ex)
            {
                return new { error = 1, errorMesage = ex.Message };
            }
        }

        public Result EntradasRecalcular(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("ST_MovEntradaCalcularTotal",
                "@id_proveedor:INT", dc_params.GetString("id_proveedor"),
                "@id_entra:INT", dc_params.GetString("id_entrada"),
                "@flete:NUMERIC", dc_params.GetString("flete"),
                "@opcion:VARCHAR:3", "EN",
                "@id_entrada:BIGINT", 0,
                "@id_proveedorfle:BIGINT", dc_params.GetString("id_proveedorfle"),
                "@anticipo:NUMERIC", dc_params.GetString("anticipo"),
                "@fecha:VARCHAR:10", dc_params.GetString("fecha"),
                "@id_ctaant:BIGINT", dc_params.GetString("id_cta"),
                "@op:CHAR:1", dc_params.GetString("op")
                ).RunRow();
        }

        public Result EntradasGetSeriesTemp(Dictionary<string, object> dc_params)
        {
            string query = "";
            switch (dc_params.GetString("op"))
            {
                case "E":
                    query = "SELECT id, serie, selected FROM[dbo].[MovEntradasSeries] WHERE id_items ";
                    break;
                case "D":
                    query = "SELECT id, serie, 1 selected FROM[dbo].[MovDevEntradasSeries] WHERE id_items ";
                    break;
                default:
                    query = "SELECT id, serie, selected FROM[dbo].[MovEntradasSeriesTemp] WHERE id_itemstemp ";
                    break;
            }
            Result res = dbase.Query(query + " = " + dc_params.GetString("id_articulo"), true).RunData();

            if (!res.Error)
            {
                res.Table = res.Data.Tables[0].ToList();
                res.Data = null;
            }
            return res;
        }

        public Result EntradasGet(Dictionary<string, object> dc_params)
        {
            Result data = dbase.Procedure("[Dbo].ST_MovEntradasGet", "@id:int", dc_params.GetString("id"), "@op:CHAR:1", dc_params.GetString("op"), "@id_temp:BIGINT", dc_params.GetString("idtemp")).RunRow();
            return data;
        }

        public Result EntradasAddArticulo(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].ST_MovEntradaAddArticulo",
            "@id_proveedor:int", dc_params["id_proveedor"],
            "@flete:NUMERIC", dc_params["flete"],
            "@id_entrada:int", dc_params["id_entrada"],
            "@id_articulo:INT", dc_params["id_article"],
            "@lote:VARCHAR:30", dc_params["id_lote"],
            "@serie:BIT", dc_params["serie"],
            "@islote:BIT", dc_params["lote"],
            "@inventario:BIT", dc_params["inventario"],
            "@vencimiento_lote:VARCHAR:10", dc_params["vencimiento"],
            "@id_iva:BIGINT", dc_params["id_iva"],
            "@id_inc:BIGINT", dc_params["id_inc"],
            "@id_retefuente:BIGINT", dc_params["id_retefuente"],
            "@id_reteiva:BIGINT", dc_params["id_reteiva"],
            "@id_reteica:BIGINT", dc_params["id_reteica"],
            "@cantidad:NUMERIC", dc_params["quantity"],
            "@costo:NUMERIC", dc_params["cost"],
            "@descuento:NUMERIC", dc_params["discount"],
            "@pordescuento:NUMERIC", dc_params["pordiscount"],
            "@id_proveedorfle:BIGINT", dc_params["id_proveedorfle"],
            "@anticipo:NUMERIC", dc_params["anticipo"],
            "@id_user:int", dc_params["userID"]).RunRow();
        }

        public Result EntradasSetArticulo(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].ST_MovEntradasSetItemTemp",
            "@id_proveedor:int", dc_params["id_proveedor"],
            "@id_proveedorfle:int", dc_params["id_proveedorfle"],
            "@flete:NUMERIC", dc_params["flete"],
            "@id_entrada:int", dc_params["id_entrada"],
            "@id:INT", dc_params["id"],
            "@valor:NUMERIC", dc_params["value"],
            "@extravalor:VARCHAR:-1", dc_params.GetString("extravalue"),
            "@op:CHAR:1", dc_params.GetString("op"),
            "@column:VARCHAR:20", dc_params["column"],
            "@id_entradaofi:BIGINT", (dc_params.GetString("id_entradaoficial").Equals("") ? "0" : dc_params.GetString("id_entradaoficial")),
            "@modulo:CHAR:1", dc_params.GetString("modulo"),
            "@xml:XML", dc_params.GetString("xml"),
            "@anticipo:NUMERIC", (dc_params.GetString("anticipo").Equals("") ? "0" : dc_params.GetString("anticipo"))
            ).RunRow();
        }

        public Result EntradasDelArticulo(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].ST_MovEntradaDelArticulo",
            "@id_articulo:INT", dc_params["id_articulo"],
            "@id_proveedor:int", dc_params["id_proveedor"],
            "@id_proveedorfle:int", dc_params["id_proveedorfle"],
            "@flete:NUMERIC", dc_params["flete"],
            "@id_entrada:int", dc_params["id_entrada"],
            "@anticipo:NUMERIC", (dc_params.GetString("anticipo").Equals("") ? "0" : dc_params.GetString("anticipo"))).RunRow();
        }

        public Result EntradasSaveTemp(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].ST_MovEntradasTemp",
             "@id:int", dc_params["id_entrada"],
             "@fechadocumen:VARCHAR:10", dc_params["fechadocumen"],
             "@fechafactura:VARCHAR:10", dc_params["fechafactura"],
             "@fechavence:VARCHAR:10", dc_params["fechavence"],
             "@numfactura:VARCHAR:50", dc_params["factura"],
             "@diasvence:INT", dc_params["diasvence"],
             "@id_bodega:BIGINT", dc_params["id_wineri"],
             "@id_proveedor:INT", dc_params["id_proveedor"],
             "@flete:NUMERIC", dc_params["flete"],
             "@id_pedido:INT", dc_params["id_pedido"],
             "@id_user:int", dc_params["userID"]).RunRow();
        }

        public Result EntradasSaveConsecutivo(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].ST_MovEntradasTemp",
            "@id_user:int", dc_params["userID"]).RunRow();
        }

        public Result FacturarEntrada(Dictionary<string, object> dc_params)
        {
            Result res = dbase.Procedure("[Dbo].ST_MOVFacturarEntrada",
            "@id:BIGINT", dc_params["Id"],
            "@id_tipodoc:BIGINT", dc_params["id_tipodoc"],
            "@id_centrocosto:BIGINT", dc_params["id_centrocosto"],
            "@fechadoc:VARCHAR:10", dc_params["Fecha"],
            "@fechafac:VARCHAR:10", dc_params["FechaFac"],
            "@fechavence:VARCHAR:10", dc_params["FechaVen"],
            "@numfac:VARCHAR:50", dc_params["NumeroFac"],
            "@dias:INT", dc_params["Dias"],
            "@id_bodega:BIGINT", dc_params["id_wineri"],
            "@id_proveedor:BIGINT", dc_params["Proveedor"],
            "@id_formaPago:BIGINT", dc_params["id_formapago"],
            "@id_entradatemp:BIGINT", dc_params["id_entradatemp"],
            "@Flete:NUMERIC", dc_params["Flete"],
            "@id_user:INT", dc_params["userID"],
            "@prorratea:BIT", dc_params["prorratea"],
            "@id_proveflete:BIGINT", dc_params["id_proveflete"],
            "@tipoprorrat:CHAR:1", dc_params["tipoprorrat"],
            "@id_orden:INT", dc_params["id_orden"],
            "@id_formaPagoFlete :BIGINT", dc_params["id_formapagoFlete"],
            "@id_ctaant :BIGINT", dc_params["id_ctaant"],
            "@anticipo :NUMERIC", dc_params["anticipo"]
            ).RunRow();

            if (!res.Error)
            {
                String id = res.Row["id"].ToString();
                String nombreview = res.Row["nombreview"].ToString();
                String fecha = res.Row["fecha"].ToString();
                String anomes = res.Row["anomes"].ToString();
                String id_user = res.Row["id_user"].ToString();
                ////Creamos el delegado 
                //ThreadStart delegado = new ThreadStart(CorrerProceso);
                ////Creamos la instancia del hilo 
                //Thread hilo = new Thread(delegado);
                ////Iniciamos el hilo 
                //hilo.Start();
                new Contabilizar().ContabilizarDocumento(id, id_user, fecha, anomes, nombreview, null);
            }

            return res;

        }

        public Result RevertirEntrada(Dictionary<string, object> dc_params)
        {
            Result res = dbase.Procedure("[Dbo].[ST_MOVRevertirEntrada]", "@id:BIGINT", dc_params["id"], "@id_user:int", dc_params["userID"]).RunRow();
            if (!(res.Row == null))
            {
                String id = res.Row["id"].ToString();
                String nombreview = res.Row["nombreview"].ToString();
                String fecha = res.Row["fecha"].ToString();
                String anomes = res.Row["anomes"].ToString();
                String id_user = res.Row["id_user"].ToString();
                String id_rev = res.Row["idrev"].ToString();
                ////Creamos el delegado 
                //ThreadStart delegado = new ThreadStart(CorrerProceso);
                ////Creamos la instancia del hilo 
                //Thread hilo = new Thread(delegado);
                ////Iniciamos el hilo 
                //hilo.Start();
                new Contabilizar().ContabilizarDocumento(id, id_user, fecha, anomes, nombreview, id_rev);
            }

            return res;
        }

        public Result TraslaOrdenCompraEntrada(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].ST_MovOrdenCompraToEntrada", "@idOrden:BIGINT", dc_params["id_Orden"], "@id_user:int", dc_params["userID"]).RunRow();
        }

        public Result EntradaCargarArticulos(Dictionary<string, object> dc_params)
        {
            Result res = new Result();
            res.Error = true;
            string url = dc_params.GetString("url").Trim(), dir = "";
            try
            {
                dir = Server.MapPath("~/" + url.Replace("../", ""));
                if (!url.Equals(""))
                {
                    if (File.Exists(dir))
                    {
                        string fileExtension = "", connStr = "", reqXml = "";
                        OleDbConnection MyConnection;
                        DataSet ds;
                        OleDbDataAdapter MyCommand;

                        fileExtension = System.IO.Path.GetExtension(dir);
                        if (fileExtension == ".xls" || fileExtension == ".XLS")
                        {
                            connStr = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + dir + ";Extended Properties=\"Excel 8.0;HDR=Yes;IMEX=2\"";
                        }
                        else if (fileExtension == ".xlsx" || fileExtension == ".XLSX")
                        {
                            connStr = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + dir + ";Extended Properties=\"Excel 12.0;HDR=Yes;IMEX=2\"";
                        }

                        MyConnection = new OleDbConnection(connStr);
                        MyCommand = new OleDbDataAdapter("SELECT Codigo, Presentacion, Nombre, Cantidad , Costo, porceiva,Iva,porceinc, Descuento, Bodega, Lote, codBarra,Vencimientolote FROM [Entrada$]", MyConnection);
                        MyCommand.TableMappings.Add("Table", "Art");
                        ds = new System.Data.DataSet();
                        MyCommand.Fill(ds);
                        MyConnection.Close();
                        DataTable table = ds.Tables[0];
                        table = table.Rows.Cast<DataRow>().Where(row => !row.ItemArray.All(field => field is DBNull || string.IsNullOrWhiteSpace(field as string))).CopyToDataTable();
                        reqXml = table.ToXml();

                        File.Delete(dir);
                        res = dbase.Procedure("[Dbo].[ST_MOVEntradaLoadFile]",
                        "@id_proveedor:int", dc_params["id_proveedor"],
                        "@flete:NUMERIC", dc_params["flete"],
                        "@id_entrada:int", dc_params["id_entrada"],
                        "@id_user:int", dc_params["userID"],
                        "@xmlart:XML", "<items>" + reqXml + "</items>").RunData();

                        if (!res.Error)
                        {
                            if (res.Data.Tables[0].Rows.Count > 0)
                                res.Row = res.Data.Tables[0].Rows[0].ToDictionary();
                            res.Table = res.Data.Tables[1].ToList();
                            res.Data = null;
                        }
                    }
                    else
                        res.Message = "No se subio el archivo.";
                }
                else
                    res.Message = "No se subio el archivo.";
            }
            catch (Exception ex)
            {
                res.Message = ex.Message;
                File.Delete(dir);
            }
            return res;
        }

        public Result EntradasItemTempGet(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].ST_MovEntradasItemTempGet", "@id_entrada:int", dc_params.GetString("id_entrada"),
                "@id_producto:bigint", dc_params.GetString("id_articulo"),
                "@lote:VARCHAR:30", dc_params.GetString("lote"),
                "@costo:NUMERIC", dc_params.GetString("costo"),
                "@descuento:NUMERIC", dc_params.GetString("descuento"),
                "@serie:VARCHAR:200", dc_params.GetString("serie")
                ).RunRow();

        }

        public Result EntradasItemTempGetArtycle(Dictionary<string, object> dc_params)
        {
            Result res = dbase.Procedure("[Dbo].ST_MovEntradasItemTempGetArtycle", "@id_entrada:int", dc_params.GetString("id_entrada")).RunRow();
            return res;
        }

        public Result EntradaDescargar(Dictionary<string, object> dc_params)
        {
            return dbase.Query(" DELETE[dbo].[MOVEntradasItemsTemp] WHERE id_entrada = " + dc_params.GetString("id_entrada"), true).RunVoid();
        }

        public object EntradaContabilizar(Dictionary<string, object> dc_params)
        {
            try
            {
                Result a = null;
                string opcion = dc_params.GetString("tipo"), mensaje = "Contabilización exitosa.", tipo = "FA";

                switch (opcion)
                {
                    case "EN":
                        a = dbase.Procedure("[Dbo].[ST_EntradaContabilizar]", "@id:int", dc_params.GetString("id"), "@id_user:int", dc_params["userID"]).RunData();
                        break;
                    case "DE":
                        a = dbase.Procedure("[Dbo].[ST_DevEntradaContabilizar]", "@id:int", dc_params.GetString("id"), "@id_user:int", dc_params["userID"]).RunData();
                        break;
                    case "AJ":
                        a = dbase.Procedure("[Dbo].[ST_AjusteContabilizar]", "@id:int", dc_params.GetString("id"), "@id_user:int", dc_params["userID"]).RunData();
                        break;
                    case "TR":
                        a = dbase.Procedure("[Dbo].[ST_TrasladoContabilizar]", "@id:int", dc_params.GetString("id"), "@id_user:int", dc_params["userID"]).RunData();
                        break;
                    default:
                        a.Error = true;
                        a.Message = "No a mandado ninguna opción  valida;";
                        break;
                }

                if (!a.Error)
                {
                    if (a.Data.Tables.Count > 0)
                    {
                        if (a.Data.Tables[0].Rows.Count > 0)
                        {
                            mensaje = a.Data.Tables[0].Rows[0][a.Data.Tables[0].Columns[0].ToString()].ToString();
                            tipo = "RE";
                            a.Message = "Error al contabilizar, verifique el log.";
                            a.Data = null;
                            a.Error = true;
                        }
                    }
                }
                else
                {
                    mensaje = a.Message;
                    tipo = "RE";
                }

                Result b = dbase.Procedure("[Dbo].[ST_EntradaLogSaveContabilizacion]", "@id:int", dc_params.GetString("id"), "@id_user:int", dc_params["userID"], "@mensaje:varchar:-1", mensaje, "@op:varchar:2", tipo, "@opcion:VARCHAR:2", opcion).RunVoid();
                a.Data = null;
                return a;
            }
            catch (Exception ex)
            {
                return new { error = 1, errorMesage = ex.Message };
            }
        }

        #endregion

        #region
        public object AjusteList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[Dbo].[ST_MovAjustesList]", "@page:int", dc_params.GetString("start"), "@numpage:int", dc_params.GetString("length"), "@filter:varchar:50", dc_params.GetString("filter"), "@countpage:int:output", 0).RunData(out outoaram);
                if (!result.Error)
                {
                    return jsSerialize.Serialize(new { Data = result.Data.Tables[0].ToList(), totalpage = outoaram["countpage"] });
                }
                else
                {
                    return new { error = 1, errorMesage = "No hay resultado" };
                }
            }
            catch (Exception ex)
            {
                return new { error = 1, errorMesage = ex.Message };
            }
        }

        public Result AjustesGet(Dictionary<string, object> dc_params)
        {

            Result data = dbase.Procedure("[Dbo].ST_MOVAjusteGet", "@id:int", dc_params.GetString("id")).RunRow();
            return data;


        }

        public Result AjustesConsulCosto(Dictionary<string, object> dc_params)
        {
            return dbase.Query("SELECT costo, existencia FROM Dbo.Existencia WHERE id_articulo = " + dc_params.GetString("id_article") + " AND id_bodega = " + dc_params.GetString("id_wineri") + " AND serie='" + dc_params.GetString("serie") + "' AND id_lote=" + dc_params.GetString("id_lote") + " ;", true).RunRow();
        }


        public Result DocumentosAddArticulo(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].ST_MovDocumentosAddArticulo",
            "@idToken:varchar:255", dc_params["idToken"],
            "@id_articulo:BIGINT", dc_params["id_article"],
            "@serie:BIT", dc_params["serie"],
            "@lote:BIGINT", dc_params["lote"],
            "@id_bodega:BIGINT", dc_params["id_bodega"],
            "@id_bodegadest:BIGINT", dc_params["id_bodegadest"],
            "@series:VARCHAR:-1", dc_params["series"],
            "@cantidad:NUMERIC", dc_params["quantity"],
            "@costo:NUMERIC", dc_params["costo"],
            "@inventario:BIT", dc_params["inventario"],
            "@id_user:int", dc_params["userID"]).RunRow();
        }

        public Result AjustesDelArticulo(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].ST_MovAjusteDelArticulo",
            "@id_articulo:INT", dc_params["id_articulo"],
            "@idToken:varchar:255", dc_params["idToken"]).RunRow();
        }

        public Result FacturarAjuste(Dictionary<string, object> dc_params)
        {
            Result res = dbase.Procedure("[Dbo].ST_MOVFacturarAjuste",
           "@id_tipodoc:BIGINT", dc_params["id_tipodoc"],
           "@id_centrocosto:BIGINT", dc_params["id_centrocosto"],
           "@fechadoc:VARCHAR:10", dc_params["Fecha"],
           "@id_entradatemp:VARCHAR:255", dc_params["idToken"],
           "@id_concepto:BIGINT", dc_params["id_concepto"],
           "@detalle:VARCHAR:-1", dc_params["detalle"],
           "@id_user:INT", dc_params["userID"]
           ).RunRow();
            if (!(res.Row == null))
            {
                String id = res.Row["id"].ToString();
                String nombreview = res.Row["nombreview"].ToString();
                String fecha = res.Row["fecha"].ToString();
                String anomes = res.Row["anomes"].ToString();
                String id_user = res.Row["id_user"].ToString();
                ////Creamos el delegado 
                //ThreadStart delegado = new ThreadStart(CorrerProceso);
                ////Creamos la instancia del hilo 
                //Thread hilo = new Thread(delegado);
                ////Iniciamos el hilo 
                //hilo.Start();
                new Contabilizar().ContabilizarDocumento(id, id_user, fecha, anomes, nombreview, null);
            }

            return res;

        }



        public Result RevertirAjuste(Dictionary<string, object> dc_params)
        {
            Result res = dbase.Procedure("[Dbo].[ST_MOVRevertirAjuste]", "@id:BIGINT", dc_params["id"], "@id_user:int", dc_params["userID"]).RunRow();
            if (!(res.Row == null))
            {
                String id = res.Row["id"].ToString();
                String nombreview = res.Row["nombreview"].ToString();
                String fecha = res.Row["fecha"].ToString();
                String anomes = res.Row["anomes"].ToString();
                String id_user = res.Row["id_user"].ToString();
                String id_rev = res.Row["idrev"].ToString();

                new Contabilizar().ContabilizarDocumento(id, id_user, fecha, anomes, nombreview, id_rev);
            }

            return res;
        }
        public Result FacturarTraslado(Dictionary<string, object> dc_params)
        {
            Result res = dbase.Procedure("[Dbo].ST_MOVFacturarTraslado",
            "@id_tipodoc:BIGINT", dc_params["id_tipodoc"],
            "@id_centrocosto:BIGINT", dc_params["id_centrocosto"],
            "@fechadoc:VARCHAR:10", dc_params["Fecha"],
            "@id_entradatemp:VARCHAR:255", dc_params["idToken"],
            "@detalle:VARCHAR:-1", dc_params["detalle"],
            "@id_user:INT", dc_params["userID"]
            ).RunRow();
            if (!(res.Row == null))
            {
                String id = res.Row["id"].ToString();
                String nombreview = res.Row["nombreview"].ToString();
                String fecha = res.Row["fecha"].ToString();
                String anomes = res.Row["anomes"].ToString();
                String id_user = res.Row["id_user"].ToString();
                ////Creamos el delegado 
                //ThreadStart delegado = new ThreadStart(CorrerProceso);
                ////Creamos la instancia del hilo 
                //Thread hilo = new Thread(delegado);
                ////Iniciamos el hilo 
                //hilo.Start();
                new Contabilizar().ContabilizarDocumento(id, id_user, fecha, anomes, nombreview, null);
            }
            return res;
        }
        public object TrasladoList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[Dbo].[ST_MovTrasladosList]", "@page:int", dc_params.GetString("start"), "@numpage:int", dc_params.GetString("length"), "@filter:varchar:50", dc_params.GetString("filter"), "@countpage:int:output", 0).RunData(out outoaram);
                if (!result.Error)
                {
                    return jsSerialize.Serialize(new { Data = result.Data.Tables[0].ToList(), totalpage = outoaram["countpage"] });
                }
                else
                {
                    return new { error = 1, errorMesage = "No hay resultado" };
                }
            }
            catch (Exception ex)
            {
                return new { error = 1, errorMesage = ex.Message };
            }
        }
        public Result TrasladosGet(Dictionary<string, object> dc_params)
        {
            Result data = dbase.Procedure("[Dbo].ST_MovTrasladoGet", "@id:int", dc_params.GetString("id")).RunData();
            if (data.Data.Tables[0].Rows.Count > 0)
                data.Row = data.Data.Tables[0].Rows[0].ToDictionary();
            data.Table = data.Data.Tables[1].ToList();
            data.Data = null;
            return data;
        }

        public Result RevertirTraslado(Dictionary<string, object> dc_params)
        {
            Result res = dbase.Procedure("[Dbo].[ST_MOVRevertirTraslado]", "@id:BIGINT", dc_params["id"], "@id_user:int", dc_params["userID"]).RunRow();
            if (!(res.Row == null))
            {
                String id = res.Row["id"].ToString();
                String nombreview = res.Row["nombreview"].ToString();
                String fecha = res.Row["fecha"].ToString();
                String anomes = res.Row["anomes"].ToString();
                String id_user = res.Row["id_user"].ToString();
                String id_rev = res.Row["idrev"].ToString();
                ////Creamos el delegado 
                //ThreadStart delegado = new ThreadStart(CorrerProceso);
                ////Creamos la instancia del hilo 
                //Thread hilo = new Thread(delegado);
                ////Iniciamos el hilo 
                //hilo.Start();
                new Contabilizar().ContabilizarDocumento(id, id_user, fecha, anomes, nombreview, id_rev);
            }

            return res;
        }
        public object EntradasBuscadorSerieLote(Dictionary<string, object> dc_params)
        {
            try
            {
                Result result = dbase.Procedure("[Dbo].[ST_MOVDocumentosBuscadorLoteSerie]", "@opcion:CHAR:2", dc_params["opcion"], "@op:CHAR:2", dc_params["op"], "@id_bodega:BIGINT", dc_params["id_bodega"], "@id_articulo:BIGINT", dc_params["id_articulo"], "@id_documento:VARCHAR:255", dc_params["id_documento"]).RunData();
                if (!result.Error)
                {
                    return new { data = Props.table2List(result.Data.Tables[0]) };
                }
                else
                {
                    return new { error = 1, errorMesage = "No hay resultado" };
                }
            }
            catch (Exception ex)
            {
                return new { error = 1, errorMesage = ex.Message };
            }
        }
        #endregion

        #region
        public object ConversionList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[Dbo].[ST_MovConversionList]", "@page:int", dc_params.GetString("start"), "@numpage:int", dc_params.GetString("length"), "@filter:varchar:50", dc_params.GetString("filter"), "@countpage:int:output", 0).RunData(out outoaram);
                if (!result.Error)
                {
                    return jsSerialize.Serialize(new { Data = result.Data.Tables[0].ToList(), totalpage = outoaram["countpage"] });
                }
                else
                {
                    return new { error = 1, errorMesage = "No hay resultado" };
                }
            }
            catch (Exception ex)
            {
                return new { error = 1, errorMesage = ex.Message };
            }
        }

        public Result ConversionGet(Dictionary<string, object> dc_params)
        {
            Result data = dbase.Procedure("[Dbo].ST_MovConversionGet", "@id:int", dc_params.GetString("id")).RunData();
            if (data.Data.Tables[0].Rows.Count > 0)
                data.Row = data.Data.Tables[0].Rows[0].ToDictionary();
            data.Table = data.Data.Tables[1].ToList();
            data.Data = null;
            return data;
        }

        public Result ConversionAddArticulo(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].ST_MovConversionAddArticulo",
            "@id_entrada:int", dc_params["id_entrada"],
            "@id_articulo:INT", dc_params["id_article"],
            "@id_bodega:INT", dc_params["id_wineri"],
            "@cantidad:NUMERIC", dc_params["quantity"],
			"@serie:BIT", (dc_params["series"]),
            "@lote:BIT", dc_params["lote"],
            "@factura:VARCHAR:255", dc_params.GetString("factura"),											   
            "@id_user:int", dc_params["userID"]).RunRow();
        }

        public Result ConversionDelArticulo(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].ST_MovConversionDelArticulo",
            "@id_articulo:INT", dc_params["id_articulo"],
            "@id_entrada:int", dc_params["id_entrada"],
            "@factura:VARCHAR:255", dc_params.GetString("factura")).RunRow();		 
        }

        public Result FacturarConversion(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].ST_MOVFacturarConversion",
            "@fechadoc:VARCHAR:10", dc_params["fecha"],
            "@id_tipodoc:BIGINT", dc_params["id_tipodoc"],
            "@id_entradatemp:BIGINT", dc_params["id_entradatemp"],
			"@factura:VARCHAR:255", dc_params["factura"],
            "@bodegadef:BIGINT", dc_params["bodegadef"],
            "@centrocosto: BIGINT", dc_params["centrocosto"],											 
            "@id_user:INT", dc_params["userID"]).RunRow();
        }

        public Result RevertirConversion(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].[ST_MOVRevertirConversion]", "@id:BIGINT", dc_params["id"],
                "@factura:VARCHAR:-1", dc_params["factura"],
                "@id_user:BIGINT", dc_params["userID"]).RunRow();
        }
		
		
        public object ConversionSearchConfig(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[Dbo].[ST_MovConversionGetSerieLote]", "@page:int", dc_params.GetString("start"), "@numpage:int", dc_params.GetString("length"), 
                    "@filter:varchar:50", dc_params.GetString("filter"), "@countpage:int:output", 0, "@id_user:int", dc_params["userID"], "@id_articulo:int", dc_params["id_articulo"], 
                    "@factura:VARCHAR:255", dc_params["factura"], "@op:char:1",dc_params["op"]).RunData(out outoaram);
                if (!result.Error)
                {
                    return jsSerialize.Serialize(new { Data = result.Data.Tables[0].ToList(), totalpage = outoaram["countpage"] });
                }
                else
                {
                    return new { error = 1, errorMesage = "No hay resultado" };
                }
            }
            catch (Exception ex)
            {
                return new { error = 1, errorMesage = ex.Message };
            }
        }
        #endregion
    }
		
}