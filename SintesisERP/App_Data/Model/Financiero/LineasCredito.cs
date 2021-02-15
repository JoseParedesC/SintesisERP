using System;
using System.Collections.Generic;
using System.Data;
using J_W.Vinculation;
using SintesisERP.Pages.Connectors;
using System.Web.Script.Serialization;
using J_W.Estructura;
using J_W.Herramientas;
 

namespace SintesisERP.App_Data.Model.Financiero
{
    public class LineasCredito : Session_Entity
    {
        private JavaScriptSerializer jsSerialize;
        public LineasCredito()
        {
            jsSerialize = new JavaScriptSerializer();
        }
      
        public object LineasCreditoList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[FIN].[ST_LineasCreditoList]", "@page:int", dc_params.GetString("start"), "@numpage:int", dc_params.GetString("length"), "@filter:varchar:50", dc_params.GetString("filter"), "@countpage:int:output", 0).RunData(out outoaram);
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

        public object servicioAndCreditoList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[FIN].[ServiciolineacreditoList]", "@page:int", dc_params.GetString("start"), 
                    "@numpage:int", dc_params.GetString("length"), "@filter:varchar:50", dc_params.GetString("filter"), 
                    "@countpage:int:output", 0, "@id_line:BIGINT", dc_params.GetString("idlinecre")).RunData(out outoaram);
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

        public Result LineascreditoServicio(Dictionary<string, object> dc_params)
        {

            return dbase.Procedure("[FIN].[AddServicioCreditos]", 
            "@id_servicios:BIGINT", dc_params["id"],
            "@idservi:BIGINT", dc_params["idservi"],
            "@servicio:VARCHAR(50)", dc_params["servicio"],
            "@porcentaje:NUMERIC", dc_params["porcentaje"],
            "@id_user:int", dc_params["userID"]).RunRow();
        }

        public Result LineasCreditosSave(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[FIN].[LineasCreditosSave]", 
            "@id:BIGINT", dc_params["id"], 
            "@codigo:VARCHAR:50", dc_params["codigo"],
            "@nombre:VARCHAR:50", dc_params["nombre"],
            "@porcentaje:NUMERIC", dc_params["porcentaje"],
            "@TasaAnual:NUMERIC", dc_params["TasaAnual"],
            "@ISIva:INT", dc_params["ISIva"],
            "@ISIvaIncluido:INT", dc_params["ISIvaIncluido"],
            "@id_iva:BIGINT", dc_params["id_iva"],
            "@porcenIva:NUMERIC", dc_params["porcenIva"],
            "@id_ctaantCredito:BIGINT", dc_params["id_ctaantCredito"],
            "@id_ctaantIntCorri:BIGINT", dc_params["id_ctaantIntCorri"],
            "@id_ctaantIntMora:BIGINT", dc_params["id_ctaantIntMora"],
            "@id_ctaantFianza:BIGINT", dc_params["id_ctaantFianza"],
            "@id_user:int", dc_params["userID"]).RunScalar();


        }

        public Result LineasCreditoDelete(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[FIN].[LineasCreditoDelete]", "@id:BIGINT", dc_params["id"], "@id_user:int", dc_params["userID"]).RunScalar();
        }

        public Result ServiciosCreditosDelete(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[FIN].[ServiciosCreditoDelete]", "@id:BIGINT", dc_params["id"], "@id_user:int", dc_params["userID"]).RunScalar();
        }

        public Result LineasCreditoGet(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[FIN].[LineasCreditoGet]", "@id:BIGINT", dc_params["id"], "@id_user:int", dc_params["userID"]).RunRow();
        }

        public Result ServiciosCreditosGet(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[FIN].[ServicioLineaCreditoGet]", "@id:BIGINT", dc_params["id"], "@id_user:int", dc_params["userID"]).RunRow();
        }




        #region
        public object DevAnticiposList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[Dbo].[ST_MOVDevAnticipoList]", "@page:int", dc_params.GetString("start"), "@numpage:int", dc_params.GetString("length"),
                    "@filter:varchar:50", dc_params.GetString("filter"), "@countpage:int:output", 0,
                    "@id_user:INT", dc_params.GetString("userID")).RunData(out outoaram);
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

        public Result DevAnticiposGet(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].ST_MovDevAnticipoGet", "@id:int", dc_params.GetString("id")).RunRow();
        }

        public Result FacturarDevAnticipos(Dictionary<string, object> dc_params)
        {
            //if (!string.IsNullOrEmpty(dc_params["idcaja"].ToString()) && !dc_params["idcaja"].ToString().Equals("0"))
            //{
            return dbase.Procedure("[Dbo].ST_MOVFacturarDevAnticipo",
             "@id_tipodoc:BIGINT", dc_params["id_tipodoc"],
            "@id_centrocostos:BIGINT", dc_params["id_centrocostos"],
            "@fecha:VARCHAR:10", dc_params["fecha"],
            "@descripcion:VARCHAR:500", dc_params["descripcion"],
            "@id_cliente:BIGINT", dc_params["id_cliente"],
            "@id_cta:BIGINT", dc_params["id_cta"],
            "@id_formapago:BIGINT", dc_params["id_forma"],
            "@valor:NUMERIC", dc_params["valor"],
            "@id_user:int", dc_params["userID"]
            ).RunRow();
            //}
            //else
            //    return new Result("No tiene caja seleccionada en esta sesión.", true);
        }

        public Result RevertirDevAnticipos(Dictionary<string, object> dc_params)
        {
            //if (!string.IsNullOrEmpty(dc_params["idcaja"].ToString()) && !dc_params["idcaja"].ToString().Equals("0"))
            //{
            return dbase.Procedure("[Dbo].[ST_MOVRevertirDevAnticipo]", "@id:BIGINT", dc_params["id"], "@id_user:int", dc_params["userID"]).RunRow();
            //}
            //else
            //    return new Result("No tiene caja seleccionada en esta sesión.", true);
        }



        #endregion

 
       
    }
}