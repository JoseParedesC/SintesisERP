using System;
using System.Collections.Generic;
using System.Data;
using J_W.Vinculation;
using SintesisERP.Pages.Connectors;
using System.Web.Script.Serialization;
using J_W.Estructura;
using J_W.Herramientas;
/// <summary>
/// Descripción breve de Buscadores
/// </summary>
/// 
namespace SintesisERP.App_Data.Model.Financiero
{
    public class ServiciosFinanciero : Session_Entity
    {
        private JavaScriptSerializer jsSerialize;
        public ServiciosFinanciero()
        {
            jsSerialize = new JavaScriptSerializer();
        }
     
        public object CNTServicioFinancieroList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[FIN].[ServicioFinancieroList]", "@page:int", dc_params.GetString("start"), "@numpage:int", dc_params.GetString("length"), "@filter:varchar:50", dc_params.GetString("filter"), "@countpage:int:output", 0).RunData(out outoaram);
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
    
        public Result FinancieroSave(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[FIN].[ServiciosFinancieros]",
            "@id:BIGINT", dc_params["id"],
            "@codigo:VARCHAR:50", dc_params["codigo"],
            "@nombre:VARCHAR:50", dc_params["nombre"],
            "@id_ctaant:BIGINT", dc_params["idctaant"],
            "@id_user:int", dc_params["userID"]
            ).RunRow();
        }

        public Result ServicioDelete(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[FIN].[ServicioFinanDelete]", "@id:BIGINT", dc_params["id"], "@id_user:int", dc_params["userID"]).RunScalar();
        }

        public Result ServicioFinanGet(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[FIN].[ServicioFinaGet]", "@id:BIGINT", dc_params["id"], "@id_user:int", dc_params["userID"]).RunRow();
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