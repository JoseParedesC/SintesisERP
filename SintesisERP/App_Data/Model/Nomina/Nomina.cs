using J_W.Estructura;
using J_W.Vinculation;
using SintesisERP.Pages.Connectors;
using System;
using System.Collections.Generic;
using System.Web.Script.Serialization;

namespace SintesisERP.App_Data.Model.Nomina
{
    public class Nomina : Session_Entity
    {
        private JavaScriptSerializer jsSerialize;
        public Nomina()
        {
            jsSerialize = new JavaScriptSerializer();
        }

        //Diagnostico
        #region
        public object DiagnosticoList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result data = dbase.Procedure("[NOM].[ST_DiagnosticoList]",
                    "@page:int", dc_params.GetString("start"),
                    "@numpage:int", dc_params.GetString("length"),
                    "@filter:varchar:50", dc_params.GetString("filter"),
                    "@countpage:int:output", 0,
                    "@id_user:BIGINT", dc_params["userID"]).RunData(out outoaram);

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
                return new { error = 1, errorMesage = ex.Message };
            }

        }


        public object DiagnosticoSave(Dictionary<string, object> dc_params)
        {
            Result data = dbase.Procedure("[NOM].[ST_DiagnosticoSave]",
                "@id:BIGINT", dc_params["id"],
                "@code:VARCHAR:20", dc_params["code"],
                "@descripcion:VARCHAR:-1", dc_params["descripcion"],
                "@id_user:BIGINT", dc_params["userID"]).RunRow();

            return new { Error = data.Error, Message = data.Message };
        }


        public object DiagnosticoDelete(Dictionary<string, object> dc_params)
        {
            Result data = dbase.Procedure("[NOM].[ST_DiagnosticoDelete]",
                "@id:BIGINT", dc_params["id"],
                "@id_user:BIGINT", dc_params["userID"]).RunRow();

            return new { Error = data.Error, Message = data.Message };
        }


        public object Diagnosticoget(Dictionary<string, object> dc_params)
        {
            List<Dictionary<string, object>> lista;
            Result data = dbase.Procedure("[NOM].[ST_DiagnosticoGet]",
                "@id:BIGINT", dc_params["id"],
                "@id_user:BIGINT", dc_params["userID"]).RunData();

            lista = data.Data.Tables[0].ToList();

            return new { Error = data.Error, Message = data.Message, Row = lista[0] };
        }

        public object DiagnosticoState(Dictionary<string, object> dc_params)
        {
            Result data = dbase.Procedure("[NOM].[ST_DiagnosticoState]",
                "@id:BIGINT", dc_params["id"],
                "@id_user:BIGINT", dc_params["userID"]).RunRow();

            return new { Error = data.Error, Message = data.Message };
        }
        #endregion

        //Juzgado
        #region
        public object JuzgadosList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result data = dbase.Procedure("[NOM].[ST_JuzgadosList]",
                    "@page:int", dc_params.GetString("start"),
                    "@numpage:int", dc_params.GetString("length"),
                    "@filter:varchar:50", dc_params.GetString("filter"),
                    "@countpage:int:output", 0,
                    "@id_user:BIGINT", dc_params["userID"]).RunData(out outoaram);

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
                return new { error = 1, errorMesage = ex.Message };
            }

        }


        public object JuzgadosSaveUpdate(Dictionary<string, object> dc_params)
        {
            Result data = dbase.Procedure("[NOM].[ST_JuzgadosSave]",
                "@id:BIGINT", dc_params["id"],
                "@code:VARCHAR:20", dc_params["code"],
                "@code_externo:VARCHAR:20", dc_params["code_ext"],
                "@detalle:VARCHAR:-1", dc_params["detalle"],
                "@id_user:BIGINT", dc_params["userID"]).RunRow();

            return new { Error = data.Error, Message = data.Message };
        }


        public object JuzgadosDelete(Dictionary<string, object> dc_params)
        {
            Result data = dbase.Procedure("[NOM].[ST_JuzgadosDelete]",
                "@id:BIGINT", dc_params["id"],
                "@id_user:BIGINT", dc_params["userID"]).RunRow();

            return new { Error = data.Error, Message = data.Message };
        }


        public object JuzgadosGet(Dictionary<string, object> dc_params)
        {
            List<Dictionary<string, object>> lista;
            Result data = dbase.Procedure("[NOM].[ST_JuzgadosGet]",
                "@id:BIGINT", dc_params["id"],
                "@id_user:BIGINT", dc_params["userID"]).RunData();

            lista = data.Data.Tables[0].ToList();

            return new { Error = data.Error, Message = data.Message, Row = lista[0] };
        }

        public object JuzgadosState(Dictionary<string, object> dc_params)
        {
            Result data = dbase.Procedure("[NOM].[ST_JuzgadosState]",
                "@id:BIGINT", dc_params["id"],
                "@id_user:BIGINT", dc_params["userID"]).RunRow();

            return new { Error = data.Error, Message = data.Message };
        }

        #endregion

        //Parametros
        #region

        public object ParametrosList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result data = dbase.Procedure("[NOM].[ST_ParametrosAnualesList]",
                    "@page:int", dc_params.GetString("start"),
                    "@numpage:int", dc_params.GetString("length"),
                    "@filter:varchar:50", dc_params.GetString("filter"),
                    "@countpage:int:output", 0,
                    "@id_user:BIGINT", dc_params["userID"]).RunData(out outoaram);

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
                return new { error = 1, errorMesage = ex.Message };
            }

        }


        public object ParametrosSaveUpdate(Dictionary<string, object> dc_params)
        {
            Result data = dbase.Procedure("[NOM].[ST_ParamsAnualSave]",
                "@id:BIGINT", dc_params["id_param"],
                "@fecha_vigencia:DATE", dc_params["fecha_vigencia"],

                //INFORMACION GENERAL
                "@salarioMinimoLegal:NUMERIC", dc_params["salarioMinimoLegal"],
                "@salIntegral:NUMERIC", dc_params["salIntegral"],
                "@auxTrans:NUMERIC", dc_params["auxTrans"],
                "@int_Ces:BIGINT", dc_params["int_Ces"],
                "@exonerado:BIT", dc_params["exonerado"],

                // PRESTACIONES SOCIALES (Empleados)
                "@porcen_salud_empleado:NUMERIC", dc_params["porcen_salud_empleado"],
                "@porcen_pension_empleado:NUMERIC", dc_params["porcen_pension_empleado"],
                "@num_salmin_icbf:BIGINT", dc_params["num_salmin_icbf"],
                "@num_salmin_sena:BIGINT", dc_params["num_salmin_sena"],
                "@porcen_icbf:NUMERIC", dc_params["porcen_icbf"],
                "@porcen_sena:NUMERIC", dc_params["porcen_sena"],
                "@num_max_seguridasocial:BIGINT", dc_params["num_max_seguridasocial"],
                "@porcen_cajacompensacion:NUMERIC", dc_params["caja_compensacion"],
                "@id_cuentacobrar:BIGINT", dc_params["id_cuenta"],
                "@id_cuenta_arl:BIGINT", dc_params["id_cuenta_arl"],

                // PRESTACIONES SOCIALES (Empleador)
                "@porcen_salud_empleador:NUMERIC", dc_params["porcen_salud_empleador"],
                "@porcen_pension_empleador:NUMERIC", dc_params["porcen_pension_empleador"],
                "@num_salmin_salud_empleador:BIGINT", dc_params["num_salmin_salud_empleador"],

                // PRESTACIONES SOCIALES (Total)
                "@porcen_salud_total:NUMERIC", dc_params["porcen_salud_total"],
                "@porcen_pension_total:NUMERIC", dc_params["porcen_pension_total"],

                // HORAS EXTRA
                "@hediurnas:NUMERIC", dc_params["hediurnas"],
                "@henoctur:NUMERIC", dc_params["henoctur"],
                "@hefdiurnas:NUMERIC", dc_params["hefdiurnas"],
                "@hefnoctur:NUMERIC", dc_params["hefnoctur"],
                "@recnocturno:NUMERIC", dc_params["recnocturno"],
                "@recdomfest:NUMERIC", dc_params["recdomfest"],
                "@recnocdomfest:NUMERIC", dc_params["recnocdomfest"],

                // SOLIDARIDAD PESIONAL
                "@fondo_solidaridad:XML", dc_params["fondo_solidaridad"],

                //RETEFUENTE
                "@uvt:NUMERIC", dc_params["uvt"],

                "@id_user:BIGINT", dc_params["userID"]).RunRow();

            return new { Error = data.Error, Message = data.Message };
        }


        public object ParametrosDelete(Dictionary<string, object> dc_params)
        {
            Result data = dbase.Procedure("[NOM].[]",
                "@id:BIGINT", dc_params["id"],
                "@id_user:BIGINT", dc_params["userID"]).RunRow();

            return new { Error = data.Error, Message = data.Message };
        }


        public object ParametrosGet(Dictionary<string, object> dc_params)
        {
            List<Dictionary<string, object>> lista = null;
            List<Dictionary<string, object>> xml = null;
            Result data = dbase.Procedure("[NOM].[ST_ParametrosAnualesGet]",
                "@id:BIGINT", dc_params["id"],
                "@op:CHAR:1", dc_params["op"],
                "@id_user:BIGINT", dc_params["userID"]).RunData();

            if (data.Data.Tables.Count > 0)
            {
                lista = data.Data.Tables[0].ToList();

                if (data.Data.Tables.Count > 1)
                {
                    xml = data.Data.Tables[1].ToList();
                }
            }

            return new { Error = data.Error, Message = data.Message, Row = lista, List = xml };
        }

        #endregion

        //Sedes
        #region
        public object SedesList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result data = dbase.Procedure("[NOM].[ST_SedesList]",
                    "@page:int", dc_params.GetString("start"),
                    "@numpage:int", dc_params.GetString("length"),
                    "@filter:varchar:50", dc_params.GetString("filter"),
                    "@countpage:int:output", 0,
                    "@id_user:BIGINT", dc_params["userID"]).RunData(out outoaram);

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
                return new { error = 1, errorMesage = ex.Message };
            }

        }

        public object SedesSaveUpdate(Dictionary<string, object> dc_params)
        {
            Result data = dbase.Procedure("[NOM].[ST_SedesSave]",
                "@id:BIGINT", dc_params["id"],
                "@nombre:VARCHAR:20", dc_params["nombre"],
                "@id_ciudad:VARCHAR:-1", dc_params["id_city"],
                "@id_user:BIGINT", dc_params["userID"]).RunRow();

            return new { Error = data.Error, Message = data.Message };
        }

        public object SedesDelete(Dictionary<string, object> dc_params)
        {
            Result data = dbase.Procedure("[NOM].[ST_SedesDelete]",
                "@id:BIGINT", dc_params["id"],
                "@id_user:BIGINT", dc_params["userID"]).RunRow();

            return new { Error = data.Error, Message = data.Message };
        }


        public object SedesGet(Dictionary<string, object> dc_params)
        {
            List<Dictionary<string, object>> lista;
            Result data = dbase.Procedure("[NOM].[ST_SedesGet]",
                "@id:BIGINT", dc_params["id"],
                "@id_user:BIGINT", dc_params["userID"]).RunData();

            lista = data.Data.Tables[0].ToList();

            return new { Error = data.Error, Message = data.Message, Row = lista[0] };
        }

        public object sedesState(Dictionary<string, object> dc_params)
        {
            Result data = dbase.Procedure("[NOM].[ST_SedesState]",
                "@id:BIGINT", dc_params["id"],
                "@id_user:BIGINT", dc_params["userID"]).RunRow();

            return new { Error = data.Error, Message = data.Message };
        }

        #endregion

    }
}