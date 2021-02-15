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
/// <summary>
/// Descripción breve de Buscadores
/// </summary>
/// 
namespace SintesisERP.App_Data.Model.Contabilidad
{
    public class Comprobantes : Session_Entity
    {
        private JavaScriptSerializer jsSerialize;
        public Comprobantes()
        {
            jsSerialize = new JavaScriptSerializer();
        }
        #region
        public object ComprobanteContableList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[CNT].[ST_MOVComprobanteContaList]", "@page:int", dc_params.GetString("start"), "@numpage:int", dc_params.GetString("length"), "@filter:varchar:50", dc_params.GetString("filter"), "@countpage:int:output", 0).RunData(out outoaram);
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

        public object ComprobanteContableItemsList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[CNT].[ST_MOVcomprobanteContableItemList]", "@page:int", dc_params.GetString("start"), "@numpage:int", dc_params.GetString("length"), "@filter:varchar:50", dc_params.GetString("filter"), "@countpage:int:output", 0, "@id_comprobante:BIGINT", dc_params.GetString("id_comprobante"),
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


        public Result ComprobantecontableADD(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[CNT].ST_MOVComprobanteContaADD",
            "@id:bigint", dc_params["id"],
            "@id_comprobante:bigint", dc_params["id_comprobante"],
            "@id_centrocosto:bigint", dc_params["id_centrocosto"],
            "@concepto:BIGINT", dc_params["concepto"],
            "@cuenta:BIGINT", dc_params["cuenta"],
            "@tercero:BIGINT", dc_params["tercero"],
            "@factura:VARCHAR:50", dc_params["factura"],
            "@id_saldocuota:VARCHAR:10", dc_params["id_saldocuota"],
            "@fechavencimiento:VARCHAR:10", dc_params["fechavencimiento"],
            "@detalle:VARCHAR:-1", dc_params["detalle"],
            "@valor:NUMERIC", dc_params["valor"],
            "@fechadoc:VARCHAR:10", dc_params["Fecha"],
            "@id_user:int", dc_params["userID"]).RunRow();
        }

        public Result ComprobantesDelItems(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[CNT].ST_MovComprobanteDELItems",
            "@id_item  :BIGINT", dc_params["id_item"],
            "@id_comprobante:BIGINT", dc_params["id_comprobante"]).RunRow();
        }

        public Result ComprobanteDescargar(Dictionary<string, object> dc_params)
        {
            return dbase.Query(" DELETE[CNT].[MOVComprobantesItemsTemp] WHERE id_comprobante = " + dc_params.GetString("id_comprobante"), true).RunVoid();
        }

        public Result ComprobanteSaveConsecutivo(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[CNT].ST_MovComprobanteTemp",
            "@id_user:int", dc_params["userID"]).RunRow();
        }

        public Result FacturarComprobante(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[CNT].[ST_MOVContabilizarComprobantesContable]",
            "@id:BIGINT", dc_params["Id"],
            "@fecha:VARCHAR:10", dc_params["Fecha"],
            "@detalle:VARCHAR:-1", dc_params["detalle"],
            "@id_tipodoc:BIGINT", dc_params["id_tipodoc"],
            "@id_comprobantetemp:BIGINT", dc_params["id_comprobante"],
            "@id_user:INT", dc_params["userID"]
            ).RunRow();
        }

        public Result RevertirComprobante(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[CNT].[ST_MOVRevertirComprobanteContable]", "@id:BIGINT", dc_params["id"], "@id_user:int", dc_params["userID"]).RunRow();
        }

        public Result ComprobanteContableGet(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[CNT].ST_MOVComprobanteContaGet", "@id:Bigint", dc_params.GetString("id")).RunRow();

        }
        public object ComprobanteContableItemGet(Dictionary<string, object> dc_params)
        {            
            try
            {
                List<Dictionary<string, object>> list = new List<Dictionary<string, object>>();
                Result data = dbase.Procedure("[CNT].[ST_MOVComprobanteItemGet]", "@id_item:Bigint", dc_params.GetString("id_items")).RunData();
                if (data.Data.Tables[0].Rows.Count > 0)
                    data.Row = data.Data.Tables[0].Rows[0].ToDictionary();
                return new { Row = data.Row };
            }
            catch (Exception ex)
            {
                return new { Error = true, Message = ex.Message };
            }
        }

        public Result ComprobantesSetItems(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[CNT].ST_MovComprobanteSetItemTemp",
            "@id:INT", dc_params["id"],
            "@valor:NUMERIC", dc_params["value"],
            "@column:VARCHAR:20", dc_params["column"]
            ).RunRow();
        }

        public Result ComprobantesCargarItems(Dictionary<string, object> dc_params)
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
                            connStr = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + dir + ";Extended Properties=\"Excel 8.0;HDR=Yes;IMEX=1\"";
                        }
                        else if (fileExtension == ".xlsx" || fileExtension == ".XLSX")
                        {
                            connStr = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + dir + ";Extended Properties=\"Excel 12.0;HDR=Yes;IMEX=1\"";
                        }

                        MyConnection = new OleDbConnection(connStr);
                        MyCommand = new OleDbDataAdapter("SELECT CENTRO,CUENTA,TERCERO, DESCRIPCION,DEBITO , CREDITO FROM [Comprobantes$]", MyConnection);
                        MyCommand.TableMappings.Add("Table", "Art");
                        ds = new System.Data.DataSet();
                        MyCommand.Fill(ds);
                        MyConnection.Close();
                        DataTable table = ds.Tables[0];
                        table = table.Rows.Cast<DataRow>().Where(row => !row.ItemArray.All(field => field is DBNull || string.IsNullOrWhiteSpace(field as string))).CopyToDataTable();
                        reqXml = table.ToXml();

                        File.Delete(dir);
                        res = dbase.Procedure("[CNT].[ST_MOVComprobanteLoadFile]",
                        "@id_comprobante:bigint", dc_params["id_comprobante"],
                        "@id_user:int", dc_params["userID"],
                        "@xmlart:XML", "<items>" + reqXml + "</items>").RunRow();

                  
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
        #endregion

    }

}