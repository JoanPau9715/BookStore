using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Xml.Linq;
using Subgurim.Controles;

public partial class Principal : System.Web.UI.MasterPage
{
    public HtmlGenericControl BodyTag
    {
        get { return MyBodyTag; }
        set { MyBodyTag = value; }
    }

    public HtmlGenericControl DivHead
    {
        get { return divhead; }
        set { divhead = value; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Customer"] != null)
        {
            string saludo = (String)Session["Saludo"] + (String)Session["Customer"];

            //ComprobarCookie((String)Session["Customer"], ref saludo);
            
            etqWelcome.Text = saludo;

            menuBAvanzadas.Visible = true;
            menuCuenta.Visible = true;
            menuDesconectar.Visible = true;
            menuLogin.Visible = false;
            menuRegistro.Visible = false;
        }
    }

    //private void ComprobarCookie(string user, ref string saludo)
    //{
    //    HttpCookie cooki = Request.Cookies["ultimoAcceso" + user];
    //    int libros = 0;

    //    if (cooki != null)
    //    {
    //        DateTime ultimaVisita = Convert.ToDateTime(Session["ultimaVisita"]);
    //        libros = (new Libro()).NuevosLibros(ultimaVisita);

    //        if (libros == 0)
    //        {
    //            libros = (new Libro()).TotalLibros();
    //            saludo += ". Tenemos " + Convert.ToString(libros) + " títulos diferentes";
    //        }
    //        else
    //        {
    //            saludo += ". Tenemos <a href=\"javascript:verNuevosLibros('" + Convert.ToString(ultimaVisita) + "')\">";
    //            saludo += Convert.ToString(libros) + " libros nuevos</a> desde tu última visita";
    //        }
    //    }
    //    else
    //    {
    //        libros = (new Libro()).TotalLibros();
    //        saludo += ". Tenemos " + Convert.ToString(libros) + " títulos diferentes";
    //    }
    //}
}
