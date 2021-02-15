using J_W.Estructura;
using System;

public partial class Dbase : IDbase
{
    public Dbase()
    {
        base.Connection("Sintesis");
    }

    public Dbase(string con)
    {
        base.Connection(con);
    }

    public override Procedure Procedure(string name, params object[] parameters)
    {
        return new Procedure(this.Conexion, name, parameters);
    }
    public override Procedure Query(string guery, bool dynamic)
    {
        return new Procedure(this.Conexion, dynamic, guery);
    }
}
