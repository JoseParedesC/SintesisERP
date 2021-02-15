using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web.UI.WebControls;
using System.Text;
using System.Xml.Linq;
using System.Web.UI.HtmlControls;

/// <summary>
/// Descripción breve de Buscadores
/// </summary>
static class Extension
{
    public static string GetString(this Dictionary<string, object> Dict, string Key)
    {
        try
        {
            if (Dict.ContainsKey(Key))
                return Dict[Key].ToString();
            return "";
        }
        catch (Exception)
        {
            return "";
        }
    }

    public static string ToXml(this Dictionary<string, object> Dic, bool Cdata = false)
    {
        StringBuilder sb = new StringBuilder();
        sb.Append("<item>");
        try
        {
            foreach (var item in Dic)
            {
                sb.Append("<" + item.Key + ">");
                if (Cdata) { sb.Append("<![CDATA["); }
                sb.Append((item.Value != null) ? item.Value.ToString() : "");
                if (Cdata) { sb.Append("]]>"); }
                sb.Append("</" + item.Key + ">");
            }
        }
        catch (Exception e)
        {
        }
        sb.Append("</item>");
        return sb.ToString();
    }
    public static string ToXml(this DataTable table, bool Cdata = false)
    {
        Dictionary<string, object> Dic;
        StringBuilder sb = new StringBuilder();

        try
        {
            foreach (DataRow row in table.Rows)
            {
                sb.Append("<item ");
                Dic = row.ToDictionary();
                foreach (var item in Dic)
                {
                    sb.Append(item.Key + "=\"");
                    sb.Append(((item.Value != null) ? item.Value.ToString() : "") + "\" ");
                }

                sb.Append(" />");
            }

            return sb.ToString();
        }
        catch (Exception e)
        {
            throw new Exception("Error generando el xml de subida.");
        }
    }

    public static string ToXml2(this Dictionary<string, object> Dic)
    {
        StringBuilder sb = new StringBuilder();
        sb.Append("<item ");
        try
        {
            foreach (var item in Dic)
            {
                sb.Append(item.Key + "=\"");
                sb.Append(((item.Value != null) ? item.Value.ToString() : "") + "\" ");
            }
        }
        catch (Exception e)
        {
        }
        sb.Append("/>");
        return sb.ToString();
    }

    public static Dictionary<string, object> ToDictionary(this DataRow Row)
    {
        Dictionary<string, object> d = new Dictionary<string, object>();
        try
        {
            foreach (DataColumn col in Row.Table.Columns)
            {
                d.Add(col.ColumnName, Row[col.ColumnName]);
            }
        }
        catch (Exception e)
        {
        }
        return d;
    }

    public static List<Dictionary<string, object>> ToList(this DataTable Table)
    {
        List<Dictionary<string, object>> List = new List<Dictionary<string, object>>();
        Dictionary<string, object> Dic = new Dictionary<string, object>();
        try
        {
            foreach (DataRow Row in Table.Rows)
            {
                List.Add(Row.ToDictionary());
            }
        }
        catch (Exception e)
        {
        }
        return List;
    }

    public static DataTable ElemToTable(this string Xml)
    {
        XElement Xele = XElement.Parse(Xml);
        DataTable dtable = new DataTable();
        XElement setup = (from p in Xele.Descendants() select p).First();
        try
        {
            foreach (XElement xe in setup.Descendants())
            {
                // add columns to your dt
                dtable.Columns.Add(new DataColumn(xe.Name.ToString(), typeof(string)));
            }

            var all = from p in Xele.Descendants(setup.Name.ToString()) select p;

            foreach (XElement xe in all)
            {
                DataRow dr = dtable.NewRow();
                foreach (XElement xe2 in xe.Descendants())
                {
                    //add in the values
                    dr[xe2.Name.ToString()] = xe2.Value;
                }
                dtable.Rows.Add(dr);
            }
            return dtable;
        }
        catch (Exception ex)
        {
            return new DataTable();
        }
    }

    public static void CargarSelect(this HtmlSelect idSelect, DataTable Dt_Data, string id, string text, string ds_msg = "", string value = null, string ds_atribute = null)
    {
        idSelect.DataSource = Dt_Data;
        idSelect.DataTextField = text;
        idSelect.DataValueField = id;
        idSelect.DataBind();
        if (ds_msg != "")
            idSelect.Items.Insert(0, new ListItem(ds_msg, ""));

        if (value != null)
            idSelect.Value = value;
        int a = 0;
        if (ds_atribute != "" && ds_atribute != null)
        {
            if (ds_msg != "")
            {
                a = 1;
                idSelect.Items[0].Attributes.Add(ds_atribute, "");
            }
            for (int i = 0; i < Dt_Data.Rows.Count; i++)
            {
                idSelect.Items[i + a].Attributes.Add(ds_atribute, Dt_Data.Rows[i][ds_atribute].ToString());

            }
        }
    }
}