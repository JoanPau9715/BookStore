using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;

public partial class Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Master.BodyTag.Attributes.Add("onload", "horaCliente(); focoNick();");
    }

    protected void btnAcceder_Click(object sender, EventArgs e)
    {
        bool ok;

        Cliente miCliente = new Cliente();

        miCliente.Nick = txtlogNick.Text;
        miCliente.Clave = txtlogClave.Text;

        ok = miCliente.ComprobarLogin();

        if (ok)
        {
            GuardarCookie(miCliente.Nick);
            Session["Customer"] = miCliente.Nick;
            Response.Redirect("index.aspx");
        }
        else
        {
            checkDatos.Text = "compruebe sus datos";
        }
    }

    private void GuardarCookie(string user)
    {
        HttpCookie oldCooki = Request.Cookies["ultimoAcceso" + user];
        DateTime ultimaVisita;

        if (oldCooki != null)
            ultimaVisita = Convert.ToDateTime(oldCooki.Value);
        else
            ultimaVisita = DateTime.Now;

        Session["ultimaVisita"] = Convert.ToString(ultimaVisita);

        HttpCookie cooki = new HttpCookie("ultimoAcceso" + user);
        cooki.Expires = DateTime.Now.AddDays(30);
        cooki.Value = Convert.ToString(DateTime.Now);

        this.Response.Cookies.Add(cooki);
    }
}
