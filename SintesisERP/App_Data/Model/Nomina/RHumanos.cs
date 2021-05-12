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
namespace SintesisERP.App_Data.Model.Nomina
{
    public class RHumanos : Session_Entity
    {
        private JavaScriptSerializer jsSerialize;
        public RHumanos()
        {
            jsSerialize = new JavaScriptSerializer();
        }
        #region
        /*Metodo que se usa para listar las Personas de la base de datos que 
         Tengan una Solicitud creada, solicitada o reprocesada  */
        public object EmpleadoList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[NOM].[ST_EmpleadosList]", 
                    "@page:int", dc_params.GetString("start"), 
                    "@numpage:int", dc_params.GetString("length"),
                    "@filter:varchar:50", dc_params.GetString("filter"), 
                    "@countpage:int:output", 0
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
        public Result EmpleadoSave(Dictionary<string, object> dc_params)
        {
           
                Result re = dbase.Procedure("[NOM].[ST_EmpleadosSave]",
                        "@id:BIGINT", dc_params["id_empleado"],
                        "@id_tipoiden:INT", dc_params["tipoiden"],//
                        "@iden:VARCHAR:20", dc_params["iden"],//
                        "@verificacion:CHAR:1", dc_params["digverificacion"],//
                        "@fechaexp:VARCHAR:10", dc_params["fechaexp"],//
                        "@pnombre:VARCHAR:50", dc_params["pnombre"],//
                        "@snombre:VARCHAR:50", dc_params["snombre"],//
                        "@papellido:VARCHAR:50", dc_params["papellido"],//
                        "@sapellido:VARCHAR:50", dc_params["sapellido"],//
                        "@fechanaci:VARCHAR:10", dc_params["fechanaci"],//
                        "@profesion:VARCHAR:120", dc_params["profesion"],//
                        "@universidad:VARCHAR:80", dc_params["universidad"],//
                        "@id_escolaridad:INT", dc_params["escolaridad"],//
                        "@correo:VARCHAR:100", dc_params["correo"],//
                        "@nacionalidad:VARCHAR:100", dc_params["nacionalidad"],//
                        "@direccion:VARCHAR:120", dc_params["direccion"],//
                        "@ciudad:BIGINT", dc_params["ciudad"],//
                        "@estrato:INT", dc_params["estrato"],//
                        "@genero:INT", dc_params["genero"],//
                        "@estadocivil:INT", dc_params["ecivil"],//
                        "@hijos:INT", dc_params["hijos"],//
                        "@id_tiposangre:INT", dc_params["TipoSangre"],//
                        "@celular:VARCHAR:20", dc_params["celular"],//
                        "@fijo:VARCHAR:20", dc_params["fijo"],//
                        "@discapasidad:BIT", dc_params["discapasidad"],//

                        "@extfechaven:VARCHAR:10", dc_params["fechavenidenext"],//

                        "@congenero:INT", dc_params["congenero"],//
                        "@confechanaci:VARCHAR:10", dc_params["confecha_naci"],//
                        "@conprofesion:VARCHAR:120", dc_params["conprofesion"],//
                        "@connombres:VARCHAR:100", dc_params["nconyuge"],//
                        "@conapellidos:VARCHAR:100", dc_params["aconyuge"],//
                        "@coniden:VARCHAR:20", dc_params["coniden"],//

                        "@id_distipo:INT", dc_params["tipodiscapasidad"],//
                        "@porcentajedis:INT", dc_params["porcentaje"],//
                        "@disgrado:INT", dc_params["grado"],//
                        "@discarnet:VARCHAR:30", dc_params["carnet"],//
                        "@disfechaexp:VARCHAR:10", dc_params["fechaexpdiscapasidad"],//
                        "@disvencimiento:VARCHAR:10", dc_params["vencimiento"],//

                        "@xmlhijos:XML", dc_params["infohijos"],




                        //"@otrosing:NUMERIC", dc_params["otrosing"],//
                        //"@concepto:VARCHAR:50", dc_params["concepto"],//
                        //"@referencias:XML", dc_params["referencias"],//
                        //"@urlperfil:VARCHAR:-1", "",//
                        //"@urlimgper:VARCHAR:-1", "",//
                        //"@observaciones:VARCHAR:-1", dc_params["observaciones"],//
                        "@id_user:INT", dc_params["userID"]).RunRow();

              

                return re;
            
            
         
        }


        public object EmpleadoListfiltro(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[NOM].[ST_EmpleadosList]", "@id_centrocosto:BIGINT", dc_params.GetString("id_centro"), "@page:int", dc_params.GetString("start"), "@numpage:int", dc_params.GetString("length"), "@filter:varchar:50", dc_params.GetString("filter"), "@countpage:int:output", 0).RunData(out outoaram);
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



        /*Metodo que se utiliza para cambiar el estado de la solicitud y enviarlo a analisis*/
        public Result EmpleadosDelete(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[NOM].[ST_EmpleadosDelete]", "@id:BIGINT", dc_params["id"], "@id_user:int", dc_params["userID"]).RunScalar();
        }

        /*Metodo que se utiliza para traer la informacion suficiente para llenar 
         los recuadros de el modal de agregados*/
        public object EmpleadoGet(Dictionary<string, object> dc_params)
        {
            try
            {
                List<Dictionary<string, object>> list = new List<Dictionary<string, object>>();
                //Dictionary<string, object> list2 = new Dictionary<string, object>();
                Result data = dbase.Procedure("[NOM].[ST_EmpleadosGet]", "@id_persona:int", dc_params.GetString("id_persona"), "@iden:VARHAR:20", dc_params.GetString("iden"), "@id_user:int", dc_params["userID"]).RunData();
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

        #endregion

        #region
        public Result ContratoSave(Dictionary<string, object> dc_params)
        {

            Result re = dbase.Procedure("[NOM].[ST_ContratoSave]",
                    "@id:BIGINT", dc_params["id_contrato"],
                    "@id_empleado:BIGINT", dc_params["id_empleado"],//
                    "@contratacion:INT", dc_params["contratacion"],//
                    "@id_tipocontra:INT", dc_params["tipocontra"],//
                    "@cot_ext:BIT", dc_params["cotextranjero"],//
                    "@tipo_cot:INT", dc_params["tipocotizante"],//
                    "@tiposalario:VARCHAR:10", dc_params["tiposalario"],//
                    "@salario:NUMERIC", dc_params["salario"],//
                    "@tipo_nom:INT", dc_params["tiponom"],//
                    "@fechaini:VARCHAR:10", dc_params["fecha_inicio"],//
                    "@jefe:BIT", dc_params["jefe"],//
                    "@area:INT", dc_params["area"],//
                    "@cargo:INT", dc_params["cargo"],//
                    "@id_horario:INT", dc_params["id_horario"],//
                    "@eps:INT", dc_params["eps"],//
                    "@cesantias:INT", dc_params["cesantias"],//
                    "@pension:INT", dc_params["pension"],//
                    "@cajacomp:INT", dc_params["cajacomp"],//
                    "@forma_pago:INT", dc_params["formapago"],//
                    "@tipo_jornada:INT", dc_params["tipojor"],//
                    "@lugar_contrato:INT", dc_params["lugar_contra"],//
                    "@lugar_laborar:INT", dc_params["lugar_laborar"],//
                    "@convenio:BIT", dc_params["convenio"],//
                    "@ley50:BIT", dc_params["ley50"],//
                    "@procedimiento:INT", dc_params["procedimiento"],//
                    


                    "@fechafin:VARCHAR:10", dc_params["fecha_fin"],//

                    "@diaspago:INT", dc_params["dias_pago"],//

                    "@funciones_esp:VARCHAR:-1", dc_params["funciones_esp"],//

                    "@jefedirect:INT", dc_params["jefedirecto"],//

                    "@num_cuenta:VARCHAR:20", dc_params["numcuenta"],//
                    "@tipo_cuenta:INT", dc_params["tipo_cuenta"],//
                    "@banco:INT", dc_params["banco"],//
                    


                    "@id_user:INT", dc_params["userID"]).RunRow();



            return re;



        }

        public object ContratoList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[NOM].[ST_ContratosList]", "@id_empleado:BIGINT", dc_params.GetString("id_empleado"), "@page:int", dc_params.GetString("start"), "@numpage:int", dc_params.GetString("length"), "@filter:varchar:50", dc_params.GetString("filter"), "@countpage:int:output", 0).RunData(out outoaram);
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


        /*Metodo que se utiliza para traer la informacion suficiente para llenar 
         los recuadros de el modal de agregados*/
        public object ContratosGet(Dictionary<string, object> dc_params)
        {
            try
            {
                List<Dictionary<string, object>> list = new List<Dictionary<string, object>>();
                //Dictionary<string, object> list2 = new Dictionary<string, object>();
                Result data = dbase.Procedure("[NOM].[ST_ContratosGet]", "@id_contrato:int", dc_params.GetString("id"), "@id_empleado:int", dc_params.GetString("id_empleado"), "@id_user:int", dc_params["userID"]).RunData();
                if (data.Data.Tables[0].Rows.Count > 0)
                    data.Row = data.Data.Tables[0].Rows[0].ToDictionary();
                //data.Table = data.Data.Tables[1].ToList();

                return new { Row = data.Row, Table = data.Table };
            }
            catch (Exception ex)
            {
                return new { Error = true, Message = ex.Message };
            }
        }

        public object ContratoPersona(Dictionary<string, object> dc_params)
        {
            try
            {
                List<Dictionary<string, object>> list = new List<Dictionary<string, object>>();
                //Dictionary<string, object> list2 = new Dictionary<string, object>();
                Result data = dbase.Procedure("[NOM].[ST_ContratoGetPersona]", "@id_empleado:int", dc_params.GetString("id_empleado"), "@id_user:int", dc_params["userID"]).RunData();
                if (data.Data.Tables[0].Rows.Count > 0)
                    data.Row = data.Data.Tables[0].Rows[0].ToDictionary();
                //data.Table = data.Data.Tables[1].ToList();

                return new { Row = data.Row, Table = data.Table };
            }
            catch (Exception ex)
            {
                return new { Error = true, Message = ex.Message };
            }
        }


        public object ContratosUpdate(Dictionary<string, object> dc_params)
        {
            Result re = dbase.Procedure("[NOM].[ContratosUpdateEstado]",
                "@id:BIGINT", dc_params["id"],
                "@id_opcion:VARCHAR:30", dc_params["value"],
                "@id_user:BIGINT", dc_params["userID"]).RunRow();
            return re;
        }


        public object CargarListadotipocontrato(Dictionary<string, object> dc_params)
        {
            try
            {
                Result data = dbase.FW_LoadSelector("TIPOCONTRAT", Usuario.UserId, dc_params["contratacion"]).RunData();
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
        public object Cargarsalario(Dictionary<string, object> dc_params)
        {
            try
            {
                Result data = dbase.FW_LoadSelector(dc_params["op"], Usuario.UserId).RunData();
                data.Table = data.Data.Tables[1].ToList();
                data.Data = null;
                return data;
            }
            catch (Exception ex)
            {
                return new { Error = true, Message = ex.Message };
            }
        }

        #endregion


        //Buscador del autocompletado para las bodegas
        public object NominaBuscador(Dictionary<string, object> dc_params)
        {
            try
            {

                DataTable Temp = new DataTable();
                Result result = dbase.Procedure("[NOM].[BuscadorMaestrosNomina]",
                    "@filtro:VARCHAR:50", dc_params.GetString("filtro"),
                    "@opcion:CHAR:1", dc_params.GetString("op"),
                    "@op:VARCHAR:2", dc_params.GetString("o"),
                    "@tipo:VARCHAR:10", dc_params.GetString("tipo")).RunData();
                if (!result.Error)
                {
                    if (result.Data.Tables.Count > 1)
                        Temp = result.Data.Tables[1];

                    return new { data = Props.table2List(result.Data.Tables[0]), series = Props.table2List(Temp) };
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
    }



}