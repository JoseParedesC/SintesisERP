using System;
using System.Collections.Generic;
using System.Data;
using J_W.Vinculation;
using SintesisERP.Pages.Connectors;
using System.Web.Script.Serialization;
using System.IO;
using J_W.Estructura;
using System.Web.Hosting;
using System.Drawing;
/// <summary>
/// Descripción breve de Buscadores
/// </summary>
/// 
namespace SintesisERP.App_Data.Model
{
    public class Solicitudes : Session_Entity
    {
        private JavaScriptSerializer jsSerialize;
        public Solicitudes()
        {
            jsSerialize = new JavaScriptSerializer();
        }
        /*Metodo que se usa para listar las Personas de la base de datos que 
         Tengan una Solicitud creada, solicitada o reprocesada  */
        public object SolicitudesList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[CRE].[ST_SolicitudesListar]",
                    "@page:int", dc_params.GetString("start"),
                    "@numpage:int", dc_params.GetString("length"),
                    "@filter:varchar:50", dc_params.GetString("filter"),
                    "@countpage:int:output", 0,
                    "@id_estacion:BIGINT", 0,
                    "@id_asesor:BIGINT", 0
                    //,"@estado:VARCHAR:100", dc_params["estado"]
                    ).RunData(out outoaram);

                if (!result.Error)
                {
                    return jsSerialize.Serialize(new { Data = Props.table2List(result.Data.Tables[0]), totalpage = outoaram["countpage"] });
                }
                else
                {
                    return new { error = 1, errorMesage = result.Message };
                }
            }
            catch (Exception ex)
            {
                return new { error = 1, errorMesage = ex.Message };
            }
        }

        /*Metodo que guarda la informacion de la solicitud, la persona que lo solicita, el 
         codedor y las referencias y el conyugue tanto del solicitante como del codeudor*/
        public Result SolicitudesSave(Dictionary<string, object> dc_params)
        {

            Result re = dbase.Procedure("[CRE].[ST_SolicitudesSave]",
                    "@id_solicitud:BIGINT", dc_params["id_solicitud"],//
                    "@id:BIGINT", dc_params["id_persona"],//
                    "@tipo:char:2", dc_params["tipo"],//
                    "@tipoper:int", dc_params["tipoper"],//
                    "@pnombre:VARCHAR:50", dc_params["pnombre"],//
                    "@snombre:VARCHAR:50", dc_params["snombre"],//
                    "@papellido:VARCHAR:50", dc_params["papellido"],//
                    "@sapellido:VARCHAR:50", dc_params["sapellido"],//
                    "@id_tipoiden:INT", dc_params["id_tipoiden"],//
                    "@iden:VARCHAR:20", dc_params["iden"],//
                    "@verificacion:CHAR:1", dc_params["verificacion"],//
                    "@id_cotizacion:BIGINT", dc_params["id_cotizacion"],//
                    "@id_escolaridad:BIGINT", dc_params["id_escola"],//
                    "@id_empresa:BIGINT", dc_params["userID"],
                    "@detalleobser:VARCHAR:500", dc_params["detalleobser"],
                    "@genero:INT", dc_params["genero"],//
                    "@estrato:INT", dc_params["estrato"],//
                    "@estadocivil:INT", dc_params["estadocivil"],//
                    "@percargo:INT", dc_params["percargo"],//
                    "@celular:VARCHAR:20", dc_params["celular"],//
                    "@otro:VARCHAR:20", dc_params["otro"],//
                    "@ciudad:INT", dc_params["id_ciudad"],//
                    "@direccion:VARCHAR:120", dc_params["direccion"],//
                    "@correo:VARCHAR:120", dc_params["correo"],//
                    "@viveinmu:INT", dc_params["viveinmu"],//
                    "@valorinm:NUMERIC", dc_params["valorinm"],//
                    "@connombre:VARCHAR:250", dc_params["connombre"],//
                    "@contelefono:VARCHAR:20", dc_params["contelefono"],//
                    "@conempresa:VARCHAR:150", dc_params["conempresa"],///
                        "@consalario:NUMERIC", dc_params["consalario"],//
                    "@tipoempleo:INT", dc_params["tipoempleo"],//
                    "@empresalab:VARCHAR:120", dc_params["empresalab"],//
                    "@direccionem:VARCHAR:120", dc_params["direccionem"],//
                    "@telefonoemp:VARCHAR:20", dc_params["telefonoemp"],//
                    "@cargoempr:VARCHAR:50", dc_params["cargoempr"],//
                    "@tiempoemp:INT", dc_params["tiempoemp"],//
                    "@salarioemp:NUMERIC", dc_params["salarioemp"],//
                    "@otrosing:NUMERIC", dc_params["otrosing"],//
                    "@concepto:VARCHAR:50", dc_params["concepto"],//
                    "@referencias:XML", dc_params["referencias"],//
                    "@urlperfil:VARCHAR:-1", "",//
                    "@urlimgper:VARCHAR:-1", "",//
                    "@observaciones:VARCHAR:-1", dc_params["observaciones"],//
                    "@id_user:INT", dc_params["userID"]).RunRow();



            return re;



        }


        /*Metodo que se utiliza para cambiar el estado de la solicitud y enviarlo a analisis*/
        public Result SolicitudesState(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[CRE].[ST_SolicitudesState]", "@id_solicitud:BIGINT", dc_params["id"], "@estado:VARCHAR:20", dc_params["estado"], "@id_user:int", dc_params["userID"]).RunScalar();
        }

        /*Metodo que se utiliza para traer la informacion suficiente para llenar 
         los recuadros de el modal de agregados*/
        public object SolicitudesGet(Dictionary<string, object> dc_params)
        {
            try
            {
                List<Dictionary<string, object>> list = new List<Dictionary<string, object>>();
                //Dictionary<string, object> list2 = new Dictionary<string, object>();
                Result data = dbase.Procedure("[CRE].[ST_SolicitudesGetCredito]", "@id_solicitud:int", dc_params.GetString("id"), "@id_user:int", dc_params["userID"]).RunData();
                if (data.Data.Tables[0].Rows.Count > 0)
                    data.Row = data.Data.Tables[0].Rows[0].ToDictionary();
                data.Table = data.Data.Tables[1].ToList();

                return new { Row = data.Row, Table = data.Table };
            }
            catch (Exception ex)
            {
                return new { Error = true, Message = ex.Message };
            }
        }

        /*Metodo que regresa toda la información de las personas que hacen parte de 
         la solicitud (Deudor y Codeudor)*/
        public object SolicitudesGetPersona(Dictionary<string, object> dc_params)
        {
            try
            {
                List<Dictionary<string, object>> list = new List<Dictionary<string, object>>();
                Result data = dbase.Procedure("[CRE].[ST_AnalisisGetPersona]", "@id_solicitud:int", dc_params.GetString("id"), "@id_persona:int", dc_params.GetString("id_persona"), "@id_user:int", dc_params["userID"]).RunData();
                if (data.Data.Tables[0].Rows.Count > 0)
                    data.Row = data.Data.Tables[0].Rows[0].ToDictionary();
                data.Table = data.Data.Tables[1].ToList();
                list = data.Data.Tables[2].ToList();

                return new { Row = data.Row, Table = data.Table, Files = list };
            }
            catch (Exception ex)
            {
                return new { Error = true, Message = ex.Message };
            }
        }


        public Result SolicitudesSaveFiles(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[CRE].[ST_SolicitudesFileSave]", "@id_solicitud:BIGINT", dc_params["id_solicitud"], "@xml:xml", "<items>" + dc_params.GetString("xml") + "</items>", "@id_user:INT", dc_params["userID"]).RunRow();
        }

        public Result PersonaGet(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[CRE].[ST_PersonaGet]", "@iden:varchar:20", dc_params["iden"], "@id_user:int", dc_params["userID"]).RunRow();
        }

        public Result SolicitudesDeleteFile(Dictionary<string, object> dc_params)
        {
            Result resp = dbase.Procedure("[CRE].[ST_SolicitudesFileDelete]", "@id_solicitudper:BIGINT", dc_params["id_solicitudper"], "@token:VARCHAR:255", dc_params["token"], "@id_user:INT", dc_params["userID"]).RunRow();
            if (!resp.Error)
            {
                try
                {
                    string url = resp.Row.GetString("URL");
                    if (File.Exists(url))
                        File.Delete(url);
                }
                catch (Exception ex)
                {
                    resp.Error = true;
                    resp.Message = "Error eliminando el archivo en el servidor de documentos.";
                }
            }
            return resp;
        }

        public object SolicitudesDeleteCodeudor(Dictionary<string, object> dc_params)
        {
            try
            {
                Result data = dbase.Procedure("[CRE].[ST_SolicitudDeleteCodeudor]", "@id:BIGINT", dc_params["id"]).RunData();
                return new { Table = data.Table };
            }
            catch (Exception ex)
            {
                return new { Error = true, Message = ex.Message };
            }
        }

        public Result SolicitudesUpdateCotizacion(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[CRE].[ST_SolicitudesUpdateCotizacion]", "@id_solicitud:BIGINT", dc_params["id"], "@id_cotizacion:BIGINT", dc_params["id_cotizacion"], "@id_user:int", dc_params["userID"]).RunScalar();
        }


        /*Metodo que se utiliza para cargar la lista de tipo de identificación 
         en base a la opción escogida en tipo de persona*/
        public object CargarListadotipoiden(Dictionary<string, object> dc_params)
        {
            try
            {
                Result data = dbase.FW_LoadSelector("SELTIPOIDEN", Usuario.UserId, dc_params["Selectipoper"]).RunData();
                data.Table = data.Data.Tables[0].ToList();
                data.Data = null;
                return data;
            }
            catch (Exception ex)
            {
                return new { Error = true, Message = ex.Message };
            }
        }

        /*Metodo que se utiliza para cargar la lista de tipo de referencia 
         en base a la opción escogida en tipo de parentezco*/
        public object CargarListadotiporef(Dictionary<string, object> dc_params)
        {
            try
            {
                Result data = dbase.FW_LoadSelector("SELTIPOREF", Usuario.UserId, dc_params["tiporef"]).RunData();
                data.Table = data.Data.Tables[0].ToList();
                data.Data = null;
                return data;
            }
            catch (Exception ex)
            {
                return new { Error = true, Message = ex.Message };
            }
        }

        /*Metodo qeue se utiliza para verificar la cantidad de codeudores permitidos según la la tabla "Parametros"
         de la base de datos*/
        public object Verificarcod(Dictionary<string, object> dc_params)
        {
            try
            {
                Result data = dbase.FW_LoadSelector("VERICOD", Usuario.UserId).RunData();
                data.Table = data.Data.Tables[0].ToList();
                data.Data = null;
                return data;
            }
            catch (Exception ex)
            {
                return new { Error = true, Message = ex.Message };
            }
        }

        /*Metodo que se utiliza para validar si existe la ruta de el cliente y si no existe la crea
         además crea la imagen*/
        public object Verificarcarpeta(Dictionary<string, object> dc_params)
        {

            byte[] data;
            try
            {
                string source = dc_params["urlimg"].ToString();
                string base64 = source.Substring(source.IndexOf(',') + 1);
                data = Convert.FromBase64String(base64);
            }
            catch (Exception ex)
            {
                return new { Error = true, Message = ex.Message };
            }
            string url = dc_params["a"].ToString();
            string ruta = url + "\\" + dc_params["tipo"] + dc_params["iden"] + ".jpeg";

            try
            {

                if (!Directory.Exists(url))
                {
                    //Directory.CreateDirectory(url);
                    System.IO.Directory.CreateDirectory(url);
                }
            }
            catch (Exception ex)
            {
                return new { Error = true, Message = ex.Message };
            }

            try
            {
                using (var imageFile = new FileStream(ruta, FileMode.Create))
                {
                    imageFile.Write(data, 0, data.Length);
                    imageFile.Flush();
                }

            }
            catch (Exception e)
            {
                return new { Error = true, Message = "Error al renombrar archivo: {0}" + e.Message };
            }
            return ruta;
        }


        public Result CotizacionesGet(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[CRE].[ST_SolicitudesUpdateCotizacion]", "@id:INT", dc_params["iden"], "@id_user:int", dc_params["userID"]).RunScalar();
        }

        #region
        public object HistorialsolList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[CRE].[ST_Historial_Solicitud]", "@page:int", dc_params.GetString("start"), "@numpage:int", dc_params.GetString("length"), "@filter:varchar:50", dc_params.GetString("filter"), "@countpage:int:output", 0).RunData(out outoaram);
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

        public object HistorialProductoList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[CRE].[ST_Historial_Solicitud_Producto]",
                    "@page:int", dc_params.GetString("start"),
                    "@numpage:int", dc_params.GetString("length"),
                    "@filter:varchar:50", dc_params.GetString("filter"),
                    "@id_cotizacion:int", dc_params.GetString("id_cotizacion"),
                    "@countpage:int:output", 0
                    ).RunData(out outoaram);

                if (!result.Error)
                {
                    return jsSerialize.Serialize(new { Data = Props.table2List(result.Data.Tables[0]), totalpage = outoaram["countpage"] });
                }
                else
                {
                    return new { error = 1, errorMesage = result.Message };
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