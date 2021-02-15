using System;
using J_W.Herramientas;
using J_W.Vinculation;

public class Reconexion
{
    static string sCarpeta = String.Format("{0}tokenSystem", System.AppDomain.CurrentDomain.BaseDirectory);
    static Session_Entity Sesion { get; set; }


    public static Session_Entity ReConexion(Session_Entity SessionU, string token)
    {
        if (token.Replace("'", "") == "" || token == null)
        {
            throw new System.ArgumentException("Caduco la sesión, Reconectece...");
        }
        else if (token != "")
        {
            Sesion = (Session_Entity)Serializacion<Session_Entity>.GetIndice(sCarpeta, token.Replace("'", ""));
        }

        return Sesion;
    }
}