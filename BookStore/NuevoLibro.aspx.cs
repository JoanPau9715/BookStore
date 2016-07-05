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
using Subgurim.Controles;

public partial class Inicio : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (FileUploaderAJAX1.IsPosting)
            this.managePost();
    }

    private void managePost()
    {
        HttpPostedFileAJAX pf = FileUploaderAJAX1.PostedFile;

        if ((pf.Type == HttpPostedFileAJAX.fileType.image) && pf.ContentLength <= 200 * 1024)
            FileUploaderAJAX1.SaveAs("~/images", pf.FileName);
    }
}
