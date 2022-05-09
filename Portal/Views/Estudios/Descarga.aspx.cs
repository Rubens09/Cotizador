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

namespace Portal.Views.Estudios
{
    public partial class Descarga : System.Web.UI.Page
    {
        public string lvFile { set; get; }
        public string fvalid { set; get; }
        protected void Page_Load(object sender, EventArgs e)
        {
            //string NumCHopo = Request["lvFile"] != null ? Request["lvFile"].ToString() : string.Empty;
            //string fechaValidez= Request["fvalid"] != null ? Request["fvalid"].ToString() : string.Empty;

            //int iArchivo = Convert.ToInt32(1);
            //int iModulo = 3;
            //NegReportes oRep = new NegReportes();
            //string sNombre = Convert.ToString("PASE ESTUDIOS OLAB" + NumCHopo);

            //string sName = sNombre.Replace(".pdf", "");

            //XLWorkbook oData = oRep.GeneraLibro(1, iModulo, NumCHopo,Convert.ToDateTime(fechaValidez).ToString("yyyy-MM-dd"),0);
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