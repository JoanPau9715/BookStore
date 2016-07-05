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

public partial class ASPX_manageClient : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string accion = Request.Form["accion"];
        string respuesta = "";

        Cliente miCliente;

        switch (accion)
        {
            case "alta":
                int resultado = 0;

                miCliente = new Cliente();

                miCliente.Nombre = Request.Form["nombre"];
                miCliente.Apellidos = Request.Form["apellidos"];
                miCliente.eMail = Request.Form["email"];
                miCliente.Nick = Request.Form["nick"];
                miCliente.Clave = Request.Form["clave"];
                miCliente.Intereses = Request.Form["intereses"];
                miCliente.TipoAviso = Request.Form["tipoaviso"];

                miCliente.Alta(ref resultado);

                switch (resultado)
                {
                    case -1:
                        respuesta = "nick no disponible";
                        break;

                    case -2:
                        respuesta = "email no disponible";
                        break;

                    case -3:
                        respuesta = "program error";
                        break;

                    default:
                        respuesta = "todo bien";
                        break;
                }
                
                break;

            case "nickdisponible":
                bool nickdisponible;

                miCliente = new Cliente(Request.Form["nick"]);

                nickdisponible = miCliente.NickDisponible();

                if (nickdisponible)
                    respuesta = "si";
                else
                    respuesta = "no";

                break;

        }

        Response.Write(respuesta);
    }
}
