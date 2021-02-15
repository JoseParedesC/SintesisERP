using System;
using System.Collections.Generic;
using System.Data;
using J_W.Vinculation;
using SintesisERP.Pages.Connectors;
using System.Web.Script.Serialization;
using J_W.Estructura;
using SintesisERP.App_Data.Model.Contabilidad;
/// <summary>
/// Descripción breve de Buscadores
/// </summary>
/// 
namespace SintesisERP.App_Data.Model.Inventario
{
    public class Refinanciacion : Session_Entity
    {
        private JavaScriptSerializer jsSerialize;
        public Refinanciacion()
        {
            jsSerialize = new JavaScriptSerializer();
        }


        public object RefinanciacionListFinan(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[FIN].[ST_MOVRefinanciacionList]", "@page:int", dc_params.GetString("start"), "@numpage:int", dc_params.GetString("length"), "@filter:varchar:50", dc_params.GetString("filter"), "@countpage:int:output", 0).RunData(out outoaram);
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


        public object RefinanciacionCuotasList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[FIN].[ST_RefinanciacionCuotaList]", "@page:int", dc_params.GetString("start"), "@numpage:int", dc_params.GetString("length"),
                    "@filter:varchar:50", dc_params.GetString("filter"), "@countpage:int:output", 0, "@id:int", dc_params.GetString("id")).RunData(out outoaram);
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




        public Result Refinanciacionget(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[FIN].[RefinanciacionFinanGet]", "@id:BIGINT", dc_params["id"], "@op:CHAR:1", dc_params["op"]).RunRow();
        }

 

        public Result FacturasRecalCuotas(Dictionary<string, object> dc_params)
        {
            Result res = dbase.Procedure("[Dbo].[ST_MovFacturaRecCuotas]", "@id:VARCHAR:2", dc_params["op"], "@SelectCredito:BIGINT", dc_params["SelectCredito"], "@valor:NUMERIC", dc_params["valor"],
            "@idToken:VARCHAR:255", dc_params.GetString("idToken"), "@numcuotas:INT", dc_params["cuotas"],
            "@dias:INT", dc_params["dias"], "@venini:VARCHAR:10", dc_params["inicial"], "@vencimiento:INT", dc_params["ven"]).RunData();
            res.Table = res.Data.Tables[0].ToList();
            res.Data = null;
            return res;
        }

        public object ConsultarSaldoGet(Dictionary<string, object> dc_params)
        {
            try
            {
                Result data = dbase.Procedure("[FIN].[ConsultaSalgoGet]", "@idcliente:BIGINT", dc_params.GetString("idcliente"), "@idfact:BIGINT", dc_params.GetString("idfact")).RunRow();
                return data;
            }
            catch (Exception ex)
            {
                return new { Error = true, Message = ex.Message };
            }
        }

        public Result RefinanciacionFactura(Dictionary<string, object> dc_params)
        {
            Result res = dbase.Procedure("[FIN].[ST_RefinanciacionFactura]",
            "@id_tipodoc:BIGINT", dc_params["cd_tipodoc"],
            "@id_ccostos:BIGINT", dc_params["id_ccostos"],
            "@fechadoc:VARCHAR:10", dc_params["fecha"],
            "@id_tercero:BIGINT", dc_params["cd_cliente"],
            "@cd_factu:VARCHAR:30", dc_params["cd_factu"],
            "@totalcredito:NUMERIC", dc_params["totalcredito"],
            "@numcuotas:INT", dc_params["cuotas"],
            "@venini:VARCHAR:10", dc_params["inicial"],
            "@id_formacred:BIGINT", dc_params["id_formacred"],
            "@vrlfianza:NUMERIC", dc_params["vrlfianza"],
            "@id_ctaintmora:BIGINT", dc_params["id_ctamora"],
            "@id_user:INT", dc_params["userID"]
            ).RunRow();

            return res;
        }

        public Result RevertirRefinanciacion(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[FIN].[RevertirRefinanciacion]", "@id:BIGINT", dc_params["id"], "@id_user:int", dc_params["userID"]).RunRow();
        }

    }

}