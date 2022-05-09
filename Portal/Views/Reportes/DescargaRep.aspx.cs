using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Spire.Xls;
using ClosedXML.Excel;
using Utility;
using System.IO;
using System.Web.Services;

namespace Portal.Views.Reportes
{
    public partial class DescargaRep : System.Web.UI.Page
    {
        public string lvFile { set; get; }


        protected void Page_Load(object sender, EventArgs e)
        {
            //string Folio = Request["lvFile"] != null ? Request["lvFile"].ToString() : string.Empty;


            //int iArchivo = Convert.ToInt32(1);
            //int iModulo = 1;
            //NegReportes oRep = new NegReportes();
            //string sNombre = string.Empty;

            //if (Session["TipoDocumento"].ToString() == "1")
            //    sNombre = Convert.ToString("SolicitudCirugia" + Folio);

            //string sName = sNombre.Replace(".pdf", "");

            //XLWorkbook oData = oRep.GeneraLibro(1, iModulo,"","1900-01-01", Convert.ToInt32(Folio));
            //Workbook workbook = new Workbook();
            //if (oData != null)
            //{

            //    MemoryStream ms = new NegReportes().ObtieneCadena(oData);
            //    MemoryStream memory = new MemoryStream();
            //    workbook.LoadFromStream(ms);
            //    workbook.SaveToStream(memory, FileFormat.PDF);

            //    Response.Clear();
            //    Response.Buffer = true;
            //    Response.AddHeader("Content-Disposition", "attachment; filename=" + sNombre + ".pdf");
            //    Response.ContentType = "application/pdf";
            //    Response.BinaryWrite(memory.ToArray());

            //    Response.End();
            //}
        }
    }
}
