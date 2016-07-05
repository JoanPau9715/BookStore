using System;
using System.Data;
using System.Data.OracleClient;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Linq;
using System.Xml.Linq;

/// <summary>
/// Descripción breve de Libro
/// </summary>
public class Libro
{
    private static OracleConnection conexion;

    private void AbrirConexion()
    {
        conexion = new OracleConnection();
        
        ConnectionStringSettings setBooks = ConfigurationManager.ConnectionStrings["CadenaBooks"];
        string cadenaConexion = setBooks.ConnectionString;

        conexion.ConnectionString = cadenaConexion;
        conexion.Open();
    }

    public void CerrarConexion()
    {
        if (conexion.State == ConnectionState.Open)
        {
            conexion.Close();
            conexion.Dispose();
        }
    }

    public int TotalLibros()
    {
        int total = 0;

        AbrirConexion();

        OracleCommand comando = conexion.CreateCommand();
        OracleParameter pRes = new OracleParameter();

        try
        {
            comando.CommandType = CommandType.StoredProcedure;
            comando.CommandText = "TOTAL_LIBROS";

            pRes.Direction = ParameterDirection.ReturnValue;
            pRes.OracleType = OracleType.Int32;

            comando.Parameters.Add(pRes);

            comando.ExecuteNonQuery();
            total = (int)comando.Parameters[0].Value;
        }
        finally
        {
            comando.Dispose();
            CerrarConexion();
        }

        return total;
    }

    public int NuevosLibros(DateTime fechaDesde)
    {
        int nuevos = 0;

        AbrirConexion();

        OracleCommand comando = conexion.CreateCommand();
        OracleParameter pFechaDesde = new OracleParameter("v_fechaDesde", fechaDesde);
        OracleParameter pRes = new OracleParameter();

        try
        {
            comando.CommandType = CommandType.StoredProcedure;
            comando.CommandText = "NUEVOS_LIBROS";

            pRes.Direction = ParameterDirection.ReturnValue;
            pRes.OracleType = OracleType.Int32;

            comando.Parameters.Add(pFechaDesde);
            comando.Parameters.Add(pRes);

            comando.ExecuteNonQuery();
            nuevos = (int)comando.Parameters[1].Value;
        }
        finally
        {
            comando.Dispose();
            CerrarConexion();
        }

        return nuevos;
    }

    public OracleDataReader ListarGeneros()
    {
        AbrirConexion();
        OracleDataReader dr;
        OracleCommand comando = new OracleCommand();

        try
        {
            comando.Connection = conexion;
            comando.CommandType = CommandType.StoredProcedure;
            comando.CommandText = "P_SELECT_DENOM_GENEROS";

            OracleParameter pRes = new OracleParameter();

            pRes.ParameterName = "RES";
            pRes.Direction = ParameterDirection.Output;
            pRes.OracleType = OracleType.Cursor;

            comando.Parameters.Add(pRes);

            dr = comando.ExecuteReader(CommandBehavior.SingleResult);
        }
        finally
        {
            comando.Dispose();
        }

        return dr;
    }

	public Libro()
	{

    }
}
