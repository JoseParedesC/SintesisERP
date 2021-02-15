using J_W.Estructura;
using J_W.Vinculation;
using System;
using System.Collections.Generic;
using System.IO;
using System.Web;
using System.Web.Services;

public partial class Solicitudes : Session_Entity
{
    protected void PageLoad()
    {
        solicitud.dbase = dbase;
        solicitud.iduser = Usuario.UserId;
    }

}