using J_W.Estructura;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;

/// <summary>
/// UCDataPager
/// </summary>
public partial class Solicitud : System.Web.UI.UserControl
{
    private Dbase _dbase;
    private object _iduser;//, _idempresa, _idestacion;
    public Dbase dbase
    {
        get
        {
            return _dbase;
        }
        set { _dbase = value; }
    }

    public object iduser
    {
        get
        {
            return _iduser;
        }
        set { _iduser = value; }
    }

    

    ////Help taken from
    ////http://www.4guysfromrolla.com/articles/031704-1.aspx#postadlink 

    //public int pbTotalRecords = 0;
    //public int pbCountPage = 0;
    //public int pbpagactual = 0;
    //public int pbpagfinal = 0;
    //public int pbnumTabs = 0;
    //public int pbnumTabsFal = 0;
    //public string ajaxaction = "";
    //public string ajaxtarget = "";
    //public string ds_ajaxname = "";

    //#region newvar
    //[Category("Behavior")]
    //[Description("Indice de la Página Actual")]
    //[DefaultValue(1)]
    //private int _PageActual;
    ///// <summary>
    ///// PageIndex
    ///// </summary>
    ///// public int _pbpagactual = 0;
    //public int PageActual
    //{
    //    get
    //    {
    //        return _PageActual;
    //    }
    //    set { _PageActual = value; }
    //}

    //[Category("Behavior")]
    //[Description("Link de Exportar Excel")]
    //private string _Exportar;
    ///// <summary>
    ///// NewRows
    ///// </summary>
    //public string Exportar
    //{
    //    get
    //    {
    //        return _Exportar;
    //    }
    //    set
    //    {
    //        _Exportar = value;
    //    }
    //}

    //[Category("Behavior")]
    //[Description("Exportar a Excel")]
    //private string _ExportAction;
    ///// <summary>
    ///// NewRowAction
    ///// </summary>
    //public string ExportAction
    //{
    //    get
    //    {
    //        return _ExportAction;
    //    }
    //    set
    //    {
    //        _ExportAction = value;
    //    }
    //}

    //[Category("Behavior")]
    //[Description("Exportar a Excel")]
    //private string _AjaxName;
    ///// <summary>
    ///// NewRowAction
    ///// </summary>
    //public string AjaxName
    //{
    //    get
    //    {
    //        return _AjaxName;
    //    }
    //    set
    //    {
    //        _AjaxName = value;
    //    }
    //}
    //#endregion


    //#region "Properties"

    //[Category("Behavior")]
    //[Description("Activar Filter Advanced")]
    //[DefaultValue(0)]
    //private bool _AdvancedFilter;


    ///// <summary>
    ///// AdvancedFilter
    ///// </summary>
    //public bool AdvancedFilter
    //{
    //    get
    //    {
    //        //this.PnlAdvance.Visible = false;
    //        return _AdvancedFilter;
    //    }
    //    set { _AdvancedFilter = value; }
    //}
    //[Category("Behavior")]
    //[Description("Show Filter Advanced")]
    //[DefaultValue(0)]
    //private bool _ShowFilter;
    ///// <summary>
    ///// ShowFilter
    ///// </summary>
    //public bool ShowFilter
    //{
    //    get
    //    {
    //        this.PnlShowFilter.Visible = false;
    //        return _ShowFilter;
    //    }
    //    set { _ShowFilter = value; }
    //}
    //[Category("Behavior")]
    //[Description("Valor Ingresado por el Usuario para filtrar")]
    //[DefaultValue(10)]
    //private string _ValueFilterAdvance;
    ///// <summary>
    ///// ValueFilterAdvance
    ///// </summary>
    //public string ValueFilterAdvance
    //{
    //    get
    //    {
    //        _ValueFilterAdvance = this.ds_search_filter.Text;
    //        return _ValueFilterAdvance;
    //    }
    //    set { _ValueFilterAdvance = value; }
    //}
    //[Category("Behavior")]
    //[Description("Total de Registros..")]
    //[DefaultValue(0)]
    //private int _TotalRecords;
    ///// <summary>
    ///// TotalRecords
    ///// </summary>
    //public int TotalRecords
    //{
    //    get
    //    {
    //        return _TotalRecords;
    //    }
    //    set { _TotalRecords = value; }
    //}
    //[Category("Behavior")]
    //[Description("Url donde el control encontrar el metodo para recagar..")]
    //private string _sUrl;
    ///// <summary>
    ///// Url
    ///// </summary>
    //public string Url
    //{
    //    get
    //    {
    //        return _sUrl;
    //    }
    //    set { _sUrl = value; }
    //}
    //[Category("Behavior")]
    //[Description("Parámetro auxiliar para el Buscador")]
    //private string _sParam;
    ///// <summary>
    ///// Param
    ///// </summary>
    //public string Param
    //{
    //    get
    //    {
    //        return _sParam;
    //    }
    //    set { _sParam = value; }
    //}

    //[Category("Behavior")]
    //[Description("Numero de Registros por Página")]
    //[DefaultValue(10)]
    //private int _RecordsPerPage;
    ///// <summary>
    ///// RecordsPerPage
    ///// </summary>
    //public int RecordsPerPage
    //{
    //    get
    //    {
    //        return _RecordsPerPage;
    //    }
    //    set { _RecordsPerPage = value; }
    //}
    //private decimal _TotalPages;
    ///// <summary>
    ///// TotalPages
    ///// </summary>
    //private decimal TotalPages
    //{
    //    get
    //    {
    //        return _TotalPages;
    //    }
    //    set { _TotalPages = value; }
    //}
    //[Category("Behavior")]
    //[Description("Contenedor Actualziar.")]
    //private string _TitlePager;
    ///// <summary>
    ///// TitlePager
    ///// </summary>
    //public string TitlePager
    //{
    //    get
    //    {
    //        return _TitlePager;
    //    }
    //    set { _TitlePager = value; }
    //}
    //[Category("Behavior")]
    //[Description("Link de Nuevo Registro")]
    //private string _NewRows;
    ///// <summary>
    ///// NewRows
    ///// </summary>
    //public string NewRows
    //{
    //    get
    //    {
    //        return _NewRows;
    //    }
    //    set
    //    {
    //        _NewRows = value;
    //    }
    //}
    //[Category("Behavior")]
    //[Description("Contenedor de Páginado")]
    //private string _ContainerPager;
    ///// <summary>
    ///// ContainerPager
    ///// </summary>
    //public string ContainerPager
    //{
    //    get
    //    {
    //        return _ContainerPager;
    //    }
    //    set { _ContainerPager = value; }
    //}
    //private string _TargetContainer;
    ///// <summary>
    ///// TargetContainer
    ///// </summary>
    //public string TargetContainer
    //{
    //    get
    //    {
    //        return _TargetContainer;
    //    }
    //    set { _TargetContainer = value; }
    //}


    //[Category("Behavior")]
    //[Description("Contenedor de Páginado")]
    //private string _NewRowAction;
    ///// <summary>
    ///// NewRowAction
    ///// </summary>
    //public string NewRowAction
    //{
    //    get
    //    {
    //        return _NewRowAction;
    //    }
    //    set { _NewRowAction = value; }
    //}
    //private string _TargetNewRow;
    ///// <summary>
    ///// TargetNewRow
    ///// </summary>
    //public string TargetNewRow
    //{
    //    get
    //    {
    //        return _TargetNewRow;
    //    }
    //    set { _TargetNewRow = value; }
    //}

    //[Category("Behavior")]
    //[Description("Manejo Ventana Modal")]
    //private bool _bModal = false;
    ///// <summary>
    ///// ActiveModal
    ///// </summary>
    //public bool ActiveModal
    //{
    //    get
    //    {
    //        return _bModal;
    //    }
    //    set { _bModal = value; }
    //}
    //[Category("Behavior")]
    //[Description("Título de la Ventana Modal")]
    //private string _sTitleModal = "Sin Título";
    ///// <summary>
    ///// TitleModal
    ///// </summary>
    //public string TitleModal
    //{
    //    get
    //    {
    //        return _sTitleModal;
    //    }
    //    set { _sTitleModal = value; }
    //}
    //[Category("Behavior")]
    //[Description("Título de la Ventana Modal")]
    //private string _sModalHeight = "auto";
    ///// <summary>
    ///// ModalHeight
    ///// </summary>
    //public string ModalHeight
    //{
    //    get
    //    {
    //        return _sModalHeight;
    //    }
    //    set { _sModalHeight = value; }
    //}

    //[Category("Behavior")]
    //[Description("GridView que muestra la información")]
    //private DataTable _DataTable;
    ///// <summary>
    ///// DataTable
    ///// </summary>
    //public DataTable DataTable
    //{
    //    get
    //    {
    //        return _DataTable;
    //    }
    //    set { _DataTable = value; }
    //}

    //[Category("Behavior")]
    //[Description("Ancho de Modal para Nuevo Elemento")]
    //private string _ModalWidth;
    ///// <summary>
    ///// ModalWidth
    ///// </summary>
    //public string ModalWidth
    //{
    //    get
    //    {
    //        return _ModalWidth;
    //    }
    //    set { _ModalWidth = value; }
    //}

    //[Category("Behavior")]
    //[Description("Identificador de boton de refresco")]
    //private string _IdRefresh;

    //public string IdRefresh
    //{
    //    get
    //    {
    //        return _IdRefresh;
    //    }
    //    set { _IdRefresh = value; }
    //}

    //#endregion



    //#region "Page Events"
    ///// <summary>
    ///// Page_Load
    ///// </summary>
    ///// <param name="sender"></param>
    ///// <param name="e"></param>
    protected void Page_Load(object sender, EventArgs e)
    {
        Result data = dbase.FW_LoadSelector("SOLICREDIT", iduser).RunData();

        //idenconyuge.CargarSelect(data.Data.Tables[0], "id", "name", "Seleccione");
        ecivil.CargarSelect(data.Data.Tables[0], "id", "name", "Seleccione", ds_atribute: "param");
        //fraiz.CargarSelect(data.Data.Tables[2], "id", "name", "Seleccione");
        vinmueble.CargarSelect(data.Data.Tables[1], "id", "name", "Seleccione", ds_atribute: "param");
        setiemposer.CargarSelect(data.Data.Tables[2], "id", "name", "Seleccione");
        //tipocuenta.CargarSelect(data.Data.Tables[5], "id", "name", "Seleccione");
        tiporef.CargarSelect(data.Data.Tables[3], "id", "name", "Seleccione");
        estrato.CargarSelect(data.Data.Tables[4], "id", "name", "Seleccione");
        genero.CargarSelect(data.Data.Tables[5], "id", "name", "Seleccione");
        //ndireccion.CargarSelect(data.Data.Tables[10], "id", "name", "Seleccione", ds_atribute:"param");
        TipEmpleo.CargarSelect(data.Data.Tables[6], "id", "name", "Seleccione", ds_atribute: "param");
        //id_parentez.CargarSelect(data.Data.Tables[7], "id", "name", "Seleccione", ds_atribute: "param");
        Selectipoper.CargarSelect(data.Data.Tables[7], "id", "name", "Seleccione", ds_atribute: "param");
        escolaridad.CargarSelect(data.Data.Tables[8], "id", "name", "Seleccione", ds_atribute: "param");
        id_tipoiden.CargarSelect(data.Data.Tables[14], "id", "name", "Seleccione");


        data = dbase.FW_LoadSelector("CITY", iduser).RunData();
        Text_city.CargarSelect(data.Data.Tables[0], "id", "name", "Seleccione");
        //ciudadexp.CargarSelect(data.Data.Tables[0], "id", "name", "Seleccione");
    }



    //#endregion


    //#region "Web Methods"
    ///// <summary>
    ///// UpdatePaging
    ///// </summary>
    ///// <param name="pageIndex"></param>
    ///// <param name="pageSize"></param>
    ///// <param name="recordCount"></param>
    //public void UpdatePaging(int pageIndex, int pageSize, int recordCount, int pbnumTabs)
    //{
    //    if (recordCount > 0)
    //    {
    //        int pagini = 0, pagfin = 0;
    //        pagini = (pageIndex == 1) ? 1 : (((pageIndex * pageSize) - pageSize) + 1);
    //        pagfin = ((pageIndex * pageSize) > recordCount) ? recordCount : pageIndex * pageSize;
    //        reginicio.InnerText = string.Format("{0:00}", pagini);
    //        regfinal.InnerText = string.Format("{0:00}", pagfin);
    //        totalreg.InnerText = string.Format("{0:00}", recordCount);
    //        lblTotalRecord.Text = pbnumTabs.ToString();
    //    }
    //    else
    //    {
    //        lblTotalRecord.Text = "No se encontraron registros!";
    //        lblTotalRecord.ForeColor = Color.Red;
    //        this.ValueFilterAdvance = this.ds_search_filter.Text = string.Empty;
    //    }
    //}

    //public string CargarPages(string ds_url, string ds_name)
    //{
    //    string ul = "";
    //    int numt = (pbpagactual == 2 || pbpagactual == 1) ? 1 : ((pbnumTabsFal == 0 && pbpagactual == pbnumTabs) ? pbpagactual - 2 : pbpagactual - 1);

    //    if (pbpagactual > 1)
    //        ul += "<li><a href='" + ds_url + "' onclick='Pager_GetIndex" + ds_name + "(" + (pbpagactual - 1).ToString() + ");' ajaxaction='" + ajaxaction + "' ajaxtarget='" + ajaxtarget + "' class='btn-pag-option btn-pag-option-next-previous'><i class='fa fa-chevron-left'></i></a></li>";

    //    for (int i = 0; i < ((pbnumTabs > 3) ? 3 : pbnumTabs); i++)
    //    {
    //        ul += "<li><a href='" + ds_url + "' onclick='Pager_GetIndex" + ds_name + "(";
    //        ul += numt.ToString() + ");' ajaxaction='" + ajaxaction + "' ajaxtarget='" + ajaxtarget + "'  class='btn-pag-option btn-pag-option-number hidden-xs'";
    //        if (numt == pbpagactual)
    //            ul += "style='pointer-events: none;font-weight:bold;'";

    //        ul += ">" + numt.ToString() + "</a></li>";
    //        numt++;
    //    }

    //    if (pbnumTabsFal > 0)
    //        ul += "<li><a href='" + ds_url + "' onclick='Pager_GetIndex" + ds_name + "(" + numt + ");' ajaxaction='" + ajaxaction + "' ajaxtarget='" + ajaxtarget + "' class='btn-pag-option btn-pag-option-number hidden-xs'>...</a></li>";

    //    if (pbpagactual < pbnumTabs)
    //        ul += "<li><a href='" + ds_url + "' onclick='Pager_GetIndex" + ds_name + "(" + (pbpagactual + 1).ToString() + ");' ajaxaction='" + ajaxaction + "' ajaxtarget='" + ajaxtarget + "' class='btn-pag-option btn-pag-option-next-previous'><i class='fa fa-chevron-right'></i></a></li>";

    //    return ul;
    //}

    //public string CargarSelectCount(int valor)
    //{
    //    string ds_Select = "";
    //    List<int> valores = new List<int>(new int[] { 2, 5, 10, 20, 30, 40, 50, 70, 80, 100 });
    //    foreach (int inval in valores)
    //    {
    //        ds_Select += "<option " + ((inval == valor) ? "selected='selected'" : "") + " value='" + inval + "' >" + inval + "</option>";
    //    }
    //    return ds_Select;
    //}

    //public string MostrarError(int valor)
    //{
    //    if (valor < 1)
    //        return "<div class='col-lg-11 col-md-11 col-sm-11 col-xs-10'><div class='alert alert-warning alert-thin' style='margin: 0;padding: 5px !important;'><table style='width:100%;'><tbody><tr><td style='width: 35px;'><span class='glyphicon glyphicon-exclamation-sign'></span>&nbsp;</td><td>¡No se encontraron registros!</td></tr></tbody></table></div></div>";
    //    else
    //        return "";

    //}
    //#endregion


}
