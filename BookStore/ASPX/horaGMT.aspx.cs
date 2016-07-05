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

public partial class ASPX_horaGMT : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string saludo = "";
        int hora = Convert.ToInt32(Request.Form["hora"]);

        if ((hora >= 6) && (hora <= 12))
            saludo = "Buenos días ";

        if ((hora > 12) && (hora <= 20))
            saludo = "Buenas tardes ";

        if ((hora > 20) || (hora < 6))
            saludo = "Buenas noches ";

        Session["Saludo"] = saludo;
    }
}
