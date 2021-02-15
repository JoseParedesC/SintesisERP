using J_W.Estructura;
using System.Data;
using System.Linq;

public partial class Dbase : IDbase
{
    public Procedure FW_LoadSelector(object v_op, object id_user, object v_param = null, object id_otro = null)
    {
        return new Procedure(this.Conexion, "[Dbo].[ST_CargarListado]", "@c_op:varchar:20", v_op, "@v_param:varchar:50", v_param, "@id_user:int", id_user, "@id_otro:BIGINT", id_otro);
    }

    public Procedure FW_ReportSelect(object v_op, object id_user, object v_param = null)
    {
        return new Procedure(this.Conexion, "[Dbo].[ST_CargarListado]", "@c_op:varchar:20", v_op, "@v_param:varchar:50", v_param, "@id_user:int", id_user);
    }

    public Procedure SearchAlert(object id_user)
    {
        return new Procedure(this.Conexion, "[dbo].[ST_NotificacionesGenerales]", "@id_user:BIGINT", id_user);
    }

    public Procedure ListMenus(object menuactive, object id_perfil, object id_user)
    {
        return new Procedure(this.Conexion, "[DBO].[Aspnet_MembershipListMenus]", "@menu:varchar:50", menuactive, "@id_perfil:VARCHAR:255", id_perfil, "@id_user:BIGINT", id_user);
    }
    public Procedure LoadUser(object userId)
    {
        return new Procedure(this.Conexion, "[dbo].[ST_UsuarioLoad]", "@userId:varchar", userId);
    }

    public Procedure GetReport(object id, object userId, object type)
    {
        object id_report = "0";
        if (type.ToString().ToUpper().Equals("ID"))
            id_report = id;

        return new Procedure(this.Conexion, "[dbo].[ST_ReporteGet]", "@id:int", id_report, "@id_user:int", userId, "@type:varchar:20", type, "@codigo:varchar:20", id);

    }

    public Procedure GetDB()
    {
        return new Procedure(this.Conexion, true, "SELECT [description], DB_NAME() as db FROM Dbo.aspnet_Applications WHERE ApplicationName = 'PUNTO DE VENTA';");
    }

    public bool ValidMenu(string activemenu, Result obj)
    {
        DataTable dtb_Menus = obj.Data.Tables[1];
        var parents = from myRow in dtb_Menus.AsEnumerable() where myRow.Field<string>("filepage").ToUpper() == activemenu.ToUpper() select myRow;
        if (parents.Count() > 0 || activemenu.ToUpper().Equals("DEFAULT.ASPX"))
            return true;
        else
            return false;
    }

    public Procedure GetFileToken(object token, object op)
    {
        return new Procedure(this.Conexion, "[CRE].[ST_SolicitudesFileTokenGet]", "@token:varchar:255", token, "@opcion:CHAR:2", op);
    }
}


