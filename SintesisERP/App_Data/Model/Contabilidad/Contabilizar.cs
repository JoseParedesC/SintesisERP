using J_W.Estructura;
using J_W.Vinculation;
using Newtonsoft.Json.Linq;
using SintesisERP.Pages.Connectors;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Runtime.Remoting.Messaging;
using System.Web.Script.Serialization;
using System.Xml;
/// <summary>
/// Descripción breve de Buscadores
/// </summary>
/// 
namespace SintesisERP.App_Data.Model.Contabilidad
{
    public class Contabilizar : Session_Entity
    {
        private JavaScriptSerializer jsSerialize;
        public Contabilizar()
        {
            jsSerialize = new JavaScriptSerializer();
        }
        /// <summary>
        /// Metodo Cargar Cajas
        /// Este metodo es utilizado para recibir el filtro de busqueda y conectarse a la BD 
        /// Cajas  
        /// </summary>
        /// <returns> 
        /// La lista de Cajas encontradas
        /// </returns>
        public object DocumentList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[CNT].[DocumentListSNCount]", "@page:int", dc_params.GetString("start"), "@numpage:int", dc_params.GetString("length"), "@filter:varchar:50", dc_params.GetString("filter"), "@countpage:int:output", 0, "@fechaini:varchar:10", dc_params.GetString("fecha"), "@fechafin:varchar:10", dc_params.GetString("fechafin")).RunData(out outoaram);
                if (!result.Error)
                {
                    return jsSerialize.Serialize(new { Data = Props.table2List(result.Data.Tables[0]), totalpage = outoaram["countpage"] });
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

        private delegate void AsyncMethodCaller(DataTable reader, object id_user);
        private delegate void AsyncMethodCallerConta(String id, String id_user, String fecha, String anomes, String nombreview, String id_rev);

        public Result ContabilizarPendientes(Dictionary<string, object> dc_params)
        {
            Result result = new Result("Proceso ejecutandose", false);
            DataTable table = new DataTable();
            try
            {
                //Valido si el valor de xml es nulo
                if (dc_params["xml"] != null)
                {
                    String path = dc_params["xml"].ToString();
                    table = path.ElemToTable();
                }
                else
                {
                    Dictionary<string, object> outoaram;
                    result = dbase.Procedure("[CNT].[DocumentListSNCount]", "@fechaini:varchar:10", dc_params.GetString("fecha"), "@fechafin:varchar:10", dc_params.GetString("fechafin")).RunData(out outoaram);
                    if (!result.Error)
                    {
                        if (result.Data.Tables.Count > 0)
                        {
                            table = result.Data.Tables[0];
                        }
                    }
                }
                AsyncMethodCaller caller = new AsyncMethodCaller(ContabilizarPendientes);
                AsyncCallback callbackHandler = new AsyncCallback(AsyncCallback);
                caller.BeginInvoke(table, dc_params.GetString("userID"), callbackHandler, table);
            }
            catch (Exception ex)
            {
                result.Message = ex.Message;
            }
            return result;
        }

        private void ContabilizarPendientes(DataTable reader, object id_user)
        {
            foreach (DataRow row in reader.Rows)
            {
                try
                {
                    string id = row["id"].ToString();
                    string vista = row["vista"].ToString();
                    string fecha = row["fecha"].ToString();
                    string anomes = row["anomes"].ToString();

                    ContabilizarDocumentos(id, id_user.ToString(), fecha, anomes, vista, null);
                }
                catch (Exception ex) { }
            }
        }

        private void AsyncCallback(IAsyncResult ar)
        {
            try
            {
                AsyncResult result = (AsyncResult)ar;
                AsyncMethodCaller caller = (AsyncMethodCaller)result.AsyncDelegate;
                caller.EndInvoke(ar);
                var outp = (Dictionary<string, object>)ar.AsyncState;
            }
            catch (Exception)
            {
            }
        }

        public void ContabilizarDocumento(String id, String id_user, String fecha, String anomes, String nombreview, String id_rev)
        {
            AsyncMethodCallerConta caller = new AsyncMethodCallerConta(ContabilizarDocumentos);
            AsyncCallback callbackHandler = new AsyncCallback(AsyncCallback);
            caller.BeginInvoke(id, id_user, fecha, anomes, nombreview, id_rev, callbackHandler, null);
        }

        private void ContabilizarDocumentos(String id, String id_user, String fecha, String anomes, String nombreview, String id_rev)
        {
            try
            {
                Result res = dbase.Procedure("[CNT].[ST_MOVContabilizar]",
                "@id:BIGINT", id,
                "@id_user:BIGINT", id_user,
                "@fecha:VARCHAR:50", fecha,
                "@anomes:VARCHAR:6", anomes,
                "@nombreview:VARCHAR:50", nombreview,
                "@id_rev:VARCHAR:50", id_rev).RunScalar();
                if (res.Error)
                {
                    Result log = dbase.Procedure("[dbo].[ST_LogSaveContabilizacion]",
                     "@id:BIGINT", id,
                     "@mensaje:VARCHAR:-1", res.Message,
                     "@id_user:VARCHAR:50", id_user,
                     "@nombreview:VARCHAR:50", nombreview).RunScalar();
                }
            }
            catch (Exception ex){}
        }
    }
}