using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Data.OracleClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;


public partial class Registro : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Master.BodyTag.Attributes.Add("onload", "focoNombre()");

        Libro libro = new Libro();
        OracleDataReader dr;

        try
        {
            dr = libro.ListarGeneros();

            while (dr.Read())
                listaGeneros.Items.Add(new ListItem(dr.GetString(0)));
        }
        finally
        {
            libro.CerrarConexion();
        }
    }
}
