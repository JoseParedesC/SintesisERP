using J_W.Estructura;
using J_W.Vinculation;
using SintesisERP.Pages.Connectors;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;

namespace SintesisERP.App_Data.Model
{
    public class Analisis : Session_Entity
    {
        // GET: Analisis

        private JavaScriptSerializer jsSerialize;
        public Analisis()
        {
            jsSerialize = new JavaScriptSerializer();
        }


        public object AnalisisList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[CRE].[ST_SolicitudesList]",
                    "@page:int", dc_params.GetString("start"),
                    "@numpage:int", dc_params.GetString("length"),
                    "@filter:varchar:50", dc_params.GetString("filter"),
                    "@countpage:int:output", 0,
                    "@id_estacion:BIGINT", dc_params["id_estacion"],
                    "@id_asesor:BIGINT", dc_params["id_asesor"],
                    "@id_user:BIGINT", dc_params["userID"],
                    "@op:VARCHAR:7", dc_params["op"]).RunData(out outoaram);
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

        public object AnalisisGetCredito(Dictionary<string, object> dc_params)
        {

            try
            {
                List<Dictionary<string, object>> list = new List<Dictionary<string, object>>();
                List<object> content;
                Dictionary<string, object> fila;

                Result data = dbase.Procedure("[CRE].[ST_AnalisisGetCredito]",
                    "@id_solicitud:BIGINT", dc_params.GetString("id_solicitud"),
                    "@id_persona:BIGINT", dc_params.GetString("id_persona"),
                    "@id_user:BIGINT", dc_params.GetString("userID")).RunData();
                if (data.Data.Tables[0].Rows.Count > 0)
                    
                    data.Row = data.Data.Tables[0].Rows[0].ToDictionary();
                data.Table = data.Data.Tables[1].ToList();

                foreach (DataRow rows in data.Data.Tables[2].Rows)
                {
                    fila = new Dictionary<string, object>();
                    content = new List<object>();
                    fila.Add("time", rows["time"]);
                    content.Add(new { tag = "p", content = rows["content"] });
                    fila.Add("body", content);
                    list.Add(fila);

                }

                return new { Row = data.Row, Table = data.Table, list = list};
            }
            catch (Exception ex)
            {
                return new { Error = true, Message = ex.Message };
            }

        }

        public object AnalisisGetPersona(Dictionary<string, object> dc_params)
        {
            try
            {
                List<Dictionary<string, object>> list = new List<Dictionary<string, object>>();

                Result data = dbase.Procedure("[CRE].[ST_AnalisisGetPersona]",
                    "@id_persona:BIGINT", dc_params["id_persona"],
                    "@id_solicitud:BIGINT", dc_params["id"],
                    "@id_user:BIGINT", dc_params["userID"]).RunData();

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

        public object AnalisisUpdateDeleteRef(Dictionary<string, object> dc_params)
        {
            try
            {
                List<Dictionary<string, object>> list = new List<Dictionary<string, object>>();

                Result data = dbase.Procedure("[CRE].[ST_AnalisisPersonaReferenciaDelete]",
                   "@id:BIGINT", dc_params["id"]).RunData();

                return new { Error = data.Error, Message = data.Message };

            }
            catch (Exception ex)
            {
                return new { Error = true, Message = ex.Message };
            }
        }

        public object AnalisisUpdateStateRef(Dictionary<string, object> dc_params)
        {
            try
            {
                List<Dictionary<string, object>> list = new List<Dictionary<string, object>>();

                Result data = dbase.Procedure("[CRE].[ST_AnalisisPersonaReferenciaEstado]",
                   "@estado:BIT", dc_params["estado"],
                   "@id_referencia:BIGINT", dc_params["id"],
                   "@id_user", dc_params["userID"]).RunData();

                if (data.Data.Tables[0].Rows.Count > 0)
                    data.Row = data.Data.Tables[0].Rows[0].ToDictionary();

                return new { Error = false, Row = data.Row };

            }
            catch (Exception ex)
            {
                return new { Error = true, Message = ex.Message };
            }
        }

        public object AnalisisUpdateSolicitud(Dictionary<string, object> dc_params)
        {
            try
            {
                return dbase.Procedure("[CRE].[ST_AnalisisUpdateSolicitud]",

                        //DEUDOR
                        "@id_persona:BIGINT", dc_params["id_persona"],
                        "@id_solicitud:BIGINT", dc_params["id_solicitud"],
                        "@tipoper:BIGINT", dc_params["id_tipoper"],
                        "@id_tipoiden:INT", dc_params["tipo_iden"],
                        "@iden:VARCHAR:20", dc_params["iden"],
                        "@pnombre:VARCHAR:50", dc_params["primernombre"],
                        "@snombre:VARCHAR:50", dc_params["segundonombre"],
                        "@papellido:VARCHAR:50", dc_params["primerapellido"],
                        "@sapellido:VARCHAR:50", dc_params["segundoapellido"],
                        "@fechanacimiento:VARCHAR:10", dc_params["fechanacimiento"],
                        "@fechaexpedicion:VARCHAR:10", dc_params["fechaexpedicion"],
                        "@ciudad:BIGINT", dc_params["id_ciudad"],
                        "@id_ciudadexped:BIGINT", dc_params["id_ciudadexped"],
                        "@genero:INT", dc_params["id_genero"],
                        "@estrato:INT", dc_params["id_estrato"],
                        "@estadocivil:INT", dc_params["id_estadocivil"],
                        "@profesion:VARCHAR:60", dc_params["id_profesion"],
                        "@percargo:INT", dc_params["percargo"],
                        "@telefono:VARCHAR:50", dc_params["telefono"],
                        "@celular:VARCHAR:20", dc_params["celular"],
                        "@otro:VARCHAR:20", dc_params["otrotel"],
                        "@direccion:VARCHAR:120", dc_params["direccion"],
                        "@correo:VARCHAR:120", dc_params["correo"],
                        "@valorinm:NUMERIC", dc_params["valorarriendo"],
                        "@viveinmu:BIGINT", dc_params["viveinmueble"],
                        "@id_fincaraiz:BIGINT", dc_params["id_fincaraiz"],
                        "@cualfinca:VARCHAR:150", dc_params["cualfinca"],
                        "@vehiculo:VARCHAR:500", dc_params["vehiculo"],
                        "@escolaridad:BIGINT", dc_params["escolaridad"],
                        "@verificacion:VARCHAR:50", dc_params["verificacion"],
                        "@tipoter:CHAR:2", dc_params["tipoter"],

                        //CONYUGE
                        "@connombre:VARCHAR:200", dc_params["connombre"],
                        "@id_contipo:BIGINT", dc_params["contipo"],
                        "@con_iden:VARCHAR:20", dc_params["coniden"],
                        "@contelefono:VARCHAR:20", dc_params["contelefono"],
                        "@concorreo:VARCHAR:120", dc_params["concorreo"],
                        "@conempresa:VARCHAR:100", dc_params["conempresa"],
                        "@condireccionemp:VARCHAR:250", dc_params["condireccionemp"],
                        "@contelefonoemp:VARCHAR:20", dc_params["contelefonoemp"],
                        "@consalario:NUMERIC", dc_params["consalario"],

                        //INFORMACION LABORAL
                        "@tipoempleo:INT", dc_params["id_tipoempleo"],
                        "@tipoact:INT", dc_params["id_tipoact"],
                        "@empresalab:VARCHAR:250", dc_params["empresalab"],
                        "@direccionem:VARCHAR:250", dc_params["direccionemp"],
                        "@telefonoemp:VARCHAR:20", dc_params["telefonoemp"],
                        "@cargoempr:VARCHAR:50", dc_params["cargo"],
                        "@tiempoemp:INT", dc_params["id_tiempoemp"],
                        "@salarioemp:NUMERIC", dc_params["salarioemp"],
                        "@otrosing:NUMERIC", dc_params["otroingreso"],
                        "@gastos:NUMERIC", dc_params["gastos"],
                        "@concepto:VARCHAR:250", dc_params["concepto"],

                        //REFERENCIA BANCARIA
                        "@banco:VARCHAR:50", dc_params["banco"],
                        "@tipocuenta:BIGINT", dc_params["id_tipocuenta"],
                        "@numcuenta:VARCHAR:50", dc_params["numcuenta"],

                        //COITIZACION
                        "@id_cotizacion:BIGINT", dc_params["id_cotizacion"],

                        //"@id_empresa:BIGINT", dc_params["userID"],
                        //"@id_estacion:BIGINT", dc_params["idestacion"],

                        "@xml:XML", dc_params["xml"],
                        "@xml_id:INT", dc_params["xml_id"],
                        "@id_user:BIGINT", dc_params["userID"]
                        ).RunRow();
            }
            catch (Exception ex)
            {
                return new { Error = true, Message = ex.Message };
            }
        }

        public object AnalisisSaveSeguimiento(Dictionary<string, object> dc_params)
        {
            List<Dictionary<string, object>> list = new List<Dictionary<string, object>>();
            List<object> content;
            Dictionary<string, object> fila;

            Result data = dbase.Procedure("[CRE].[ST_AnalisisSeguimientoSave]",
                    "@id_solicitud:BIGINT", dc_params["id"],
                    "@observaciones:VARCHAR:-1", dc_params["observaciones"],
                    "@visible:BIT", dc_params["visible"],
                    "@id_user:BIGINT", dc_params["userID"]).RunData();

            if (!data.Error)
            {
                foreach (DataRow rows in data.Data.Tables[0].Rows)
                {
                    fila = new Dictionary<string, object>();
                    content = new List<object>();
                    fila.Add("time", rows["time"]);
                    content.Add(new { tag = "p", content = rows["content"] });
                    fila.Add("body", content);
                    list.Add(fila);

                }

                return new { Error = false, Table = list };

            }
            else
            {
                return new { Error = true, Message = data.Message };
            }
        }

        public object AnalisisSaveEvaluation(Dictionary<string, object> dc_params)
        {
            List<Dictionary<string, object>> list = new List<Dictionary<string, object>>();
            List<object> content;
            Dictionary<string, object> fila;

            Result data = dbase.Procedure("[CRE].[ST_AnalisisEvaluacionSave]",
                    "@id_solpersona:BIGINT", dc_params["id"],
                    "@op:CHAR:2", dc_params["op"],
                    "@valor:CHAR:2", dc_params["valor"],
                    "@id_user:INT", dc_params["userID"]).RunData();

            if (!data.Error)
            {
                foreach (DataRow rows in data.Data.Tables[0].Rows)
                {
                    fila = new Dictionary<string, object>();
                    content = new List<object>();
                    fila.Add("time", rows["time"]);
                    content.Add(new { tag = "p", content = rows["content"] });
                    fila.Add("body", content);
                    list.Add(fila);

                }

                return new { Error = false, Table = list };

            }
            else
            {
                return new { Error = true, Message = data.Message };
            }

        }

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


        public Result SolicitudesState(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[CRE].[ST_SolicitudesState]",
                "@id_solicitud:BIGINT", dc_params["id"],
                "@estado:VARCHAR:20", dc_params["estado"],
                "@id_user:BIGINT", dc_params["userID"]).RunRow();
        }

        public object CuotaMensual(Dictionary<string, object> dc_params)
        {
            try
            {
                Result data = dbase.Procedure("[CRE].[ST_MovFacturaRecCuotas]",
                    "@Valor:NUMERIC", dc_params["valor"],
                    "@numcuotas:INT", dc_params["cuota"],
                    "@venini:VARCHAR:10", dc_params["dias"],
                    "@idToken:VARCHAR:255", dc_params["tokenID"],
                    "@SelectCredito:BIGINT", dc_params["lineacredit"]).RunData();

                data.Table = data.Data.Tables[0].ToList();
                data.Data = null;
                return data;
            }
            catch (Exception ex)
            {
                return new { Error = true, Message = ex.Message };
            }
        }


        public object AnalisisUpdateCreditoCuotas(Dictionary<string, object> dc_params)
        {
            try
            {
                Result data = dbase.Procedure("[CRE].[ST_AnalisisUpdate_MOVCotizacion]",
                    "@cuotaini:NUMERIC", dc_params["cuotaini"],
                    "@descuento:NUMERIC", dc_params["descuento"],
                    "@valfinan:NUMERIC", dc_params["valfinan"],
                    "@iva:NUMERIC", dc_params["valoriva"],
                    "@numcuotas:INT", dc_params["cuotas"],
                    "@fecha:VARCHAR:10", dc_params["venc"],
                    "@cuotamen:NUMERIC", dc_params["cuotamen"],
                    "@forma:VARCHAR:10", dc_params["forma"],
                    "@id_solicitud:BIGINT", dc_params["id_solicitud"],
                    "@id_cotizacion:BIGINT", dc_params["id_cotizacion"],
                    "@lineacredir:BIGINT", dc_params["lineacredit"],
                    "@observaciones:VARCHAR:-1", dc_params["observaciones"],
                    "@subtotal:NUMERIC", dc_params["subtotal"],
                    "@idToken:VARCHAR:255" ,dc_params["idToken"],
                    "@id_user:BIGINT", dc_params["userID"]).RunData();

                return new { Error = data.Error , Message = data.Message};
            }
            catch (Exception ex)
            {
                return new { Error = true, Message = ex.Message };
            }
        }

        public object AnalisisGetCreditoInfo(Dictionary<string,object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result data = dbase.Procedure("[CRE].[ST_AnalisisSolicitudCreditoList]",
                    "@page:BIGINT", dc_params.GetString("start"),
                    "@numpage:BIGINT", dc_params.GetString("length"),
                    "@filter:VARCHAR:50", dc_params.GetString("filter"),
                    "@countpage:BIGINT:output", 0,
                    "@id_cotizacion:BIGINT",dc_params["id_cotizacion"],
                    "@id_solicitud:BIGINT", dc_params["id_solicitud"],
                    "@idToken:VARCHAR:255", dc_params["idToken"]).RunData(out outoaram);

                if (!data.Error)
                {
                    return jsSerialize.Serialize(new { Data = Props.table2List(data.Data.Tables[0]), totalpage = outoaram["countpage"] });
                }
                else
                {
                    return new { error = 1, errorMesage = "No hay resultado" };
                }
            }
            catch (Exception ex)
            {
                return new { Error = true, Message = ex.Message };
            }
        }

        public object AnalisisCotizacionRemoveItem(Dictionary<string,object> dc_params)
        {
            try
            {
                Result data = dbase.Procedure("[CRE].[ST_Analisis_RemoveItem_MOVCotizacion]",
                    "@id_solicitud: BIGINT",dc_params["id_solicitud"],
                    "@id_cotizacion:BIGINT",dc_params["id_cotizacion"],
                    "@id_articulo:BIGINT",dc_params["id_articulo"],
                    "@idToken:VARCHAR:255", dc_params["idToken"]).RunData();

                data.Table = data.Data.Tables[0].ToList();

                return new { Error = false , Row = data.Table};

            }catch(Exception ex)
            {
                return new { Error = true, Messsage = ex.Message };
            }
        }


        public object AddArticleFActuraItemTemp(Dictionary<string, object> dc_params)
        {
            try
            {
                Result data = dbase.Procedure("[CRE].[ST_AnalisisSolicitudFacturaTempUpdate]",
                    "@id_solicitud: BIGINT", dc_params["id_solicitud"],
                    "@id_cotizacion:BIGINT", dc_params["id_cotizacion"],
                    "@idToken:VARCHAR:255", dc_params["idToken"],
                    "@id_user:BIGINT", dc_params["userID"]).RunData();

                try
                {
                    data.Table = data.Data.Tables[1].ToList();
                    data.Row = data.Data.Tables[2].Rows[0].ToDictionary();
                    return new { Error = false, Table = data.Table , param = true , Row = data.Row};
                }catch
                {
                    data.Row = data.Data.Tables[0].Rows[0].ToDictionary();
                    return new { Error = false, param = true, Row = data.Row };
                }

            }
            catch (Exception ex)
            {
                return new { Error = true, Messsage = ex.Message };
            }
        }

        public Result CotizacionUpdateArticulo(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[CRE].[ST_AnalisisMovFacturasTempUpdate]",
            "@idToken:VARCHAR:255", dc_params["idToken"],
            "@id_articulo:INT", dc_params["id_article"],
            "@id_bodega:INT", dc_params["id_bodega"],
            "@cantidad:NUMERIC", dc_params["quantity"],
            "@precio:NUMERIC", dc_params["precio"],
            "@id_user:int", dc_params["userID"]).RunRow();
        }

        public Result CotizacionAddArticulo(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[CRE].[ST_AnalisisMovFacturasTempAdd]",
            "@idToken:VARCHAR:255", dc_params["idToken"],
            "@id_articulo:INT", dc_params["id_article"],
            "@id_bodega:INT", dc_params["id_bodega"],
            "@cantidad:NUMERIC", dc_params["quantity"],
            "@precio:NUMERIC", dc_params["precio"],
            "@id_user:int", dc_params["userID"]).RunRow();
        }
    }
}