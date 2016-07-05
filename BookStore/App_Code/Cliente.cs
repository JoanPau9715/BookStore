using System;
using System.Data;
using System.Data.OracleClient;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;

/// <summary>
/// Descripción breve de Cliente
/// </summary>
public class Cliente
{
    private string _nombre;
    private string _apellidos;
    private string _email;
    private string _nick;
    private string _clave;
    private string _intereses;
    private string _tipoaviso;

    public String Nombre
    {
        get { return _nombre; }
        set { _nombre = value; }
    }

    public String Apellidos
    {
        get { return _apellidos; }
        set { _apellidos = value; }
    }

    public String eMail
    {
        get { return _email; }
        set { _email = value; }
    }

    public String Nick
    {
        get { return _nick; }
        set { _nick = value; }
    }

    public String Clave
    {
        get { return _clave; }
        set { _clave = value; }
    }

    public String Intereses
    {
        get { return _intereses; }
        set { _intereses = value; }
    }

    public String TipoAviso
    {
        get { return _tipoaviso; }
        set { _tipoaviso = value; }
    }

    private static OracleConnection conexion;

    private void AbrirConexion()
    {
        conexion = new OracleConnection();
        ConnectionStringSettings setBooks = ConfigurationManager.ConnectionStrings["CadenaBooks"];
        string cadenaConexion = setBooks.ConnectionString;


        conexion.ConnectionString = cadenaConexion;
        conexion.Open();
    }

    private void CerrarConexion()
    {
        if (conexion.State == ConnectionState.Open)
        {
            conexion.Close();
            conexion.Dispose();
        }
    }

    public void Alta(ref int resultado)
    {
        AbrirConexion();
        OracleCommand comando = conexion.CreateCommand();
        OracleTransaction trax_alta_cliente = conexion.BeginTransaction(IsolationLevel.ReadCommitted); 

        try
        {
            comando.Transaction = trax_alta_cliente;
            comando.CommandType = CommandType.StoredProcedure;
            comando.CommandText = "ALTA_CLIENTE";

            comando.Parameters.Add(new OracleParameter("v_Nombre", this.Nombre));
            comando.Parameters.Add(new OracleParameter("v_Apellidos", this.Apellidos));
            comando.Parameters.Add(new OracleParameter("v_eMail", this.eMail));
            comando.Parameters.Add(new OracleParameter("v_Nick", this.Nick));
            comando.Parameters.Add(new OracleParameter("v_Clave", this.Clave));

            OracleParameter spResultado = new OracleParameter();

            spResultado.ParameterName = "v_resultado";
            spResultado.Direction = ParameterDirection.Output;
            spResultado.OracleType = OracleType.Int32;

            comando.Parameters.Add(spResultado);

            comando.ExecuteNonQuery();

            resultado = (int)spResultado.Value;

            if ((resultado > 0) && (this.Intereses != ""))
            {

                String[] intereses = this.Intereses.Split('-');
                int id_cliente = resultado;

                foreach (string interes in intereses)
                {
                    OracleCommand comandoInteres = conexion.CreateCommand();

                    comandoInteres.Transaction = trax_alta_cliente;
                    comandoInteres.CommandType = CommandType.StoredProcedure;
                    comandoInteres.CommandText = "NUEVO_INTERES_CLIENTE";

                    comandoInteres.Parameters.Add(new OracleParameter("v_IdCliente", id_cliente));
                    comandoInteres.Parameters.Add(new OracleParameter("v_DenomInteres", interes));
                    comandoInteres.Parameters.Add(new OracleParameter("v_TipoAviso", this.TipoAviso));

                    comandoInteres.ExecuteNonQuery();
                }
            }
        }
        finally
        {
            if (resultado > 0)
                trax_alta_cliente.Commit();
            else
                trax_alta_cliente.Rollback();

            CerrarConexion();
        }
    }

    public bool NickDisponible()
    {
        bool disponible = true;
        AbrirConexion();

        OracleCommand comando = conexion.CreateCommand();
        OracleParameter pNick = new OracleParameter("v_Nick", this.Nick);
        OracleParameter pRes = new OracleParameter();

        try
        {
            comando.CommandType = CommandType.StoredProcedure;
            comando.CommandText = "CHECK_AVAIL_NICK";

            pRes.Direction = ParameterDirection.ReturnValue;
            pRes.OracleType = OracleType.Int32;

            comando.Parameters.Add(pNick);
            comando.Parameters.Add(pRes);

            comando.ExecuteNonQuery();
            disponible = ((int)comando.Parameters[1].Value == 0);
        }
        finally
        {
            comando.Dispose();
            CerrarConexion();
        }

        return disponible;
    }

    public bool ComprobarLogin()
    {
        bool ok = true;

        AbrirConexion();

        OracleCommand comando = new OracleCommand("COMPROBAR_LOGIN", conexion);
        OracleParameter pNick = new OracleParameter("v_Nick", this.Nick);
        OracleParameter pClave = new OracleParameter("v_Clave", this.Clave);
        OracleParameter pOk = new OracleParameter();

        pOk.ParameterName = "v_Ok";
        pOk.Direction = ParameterDirection.Output;
        pOk.OracleType = OracleType.Int32;

        comando.CommandType = CommandType.StoredProcedure;
        comando.Parameters.Add(pNick);
        comando.Parameters.Add(pClave);
        comando.Parameters.Add(pOk);

        try
        {
            comando.ExecuteNonQuery();

            ok = ((int)pOk.Value == 1);
        }
        finally
        {
            comando.Dispose();
            CerrarConexion();
        }        

        return ok;
    }

	public Cliente()
	{

	}

    public Cliente(string nick)
    {
        _nick = nick;
    }

}
