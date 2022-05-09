using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.IO;
using Utility;
namespace Portal.Views.Estudios
{
    public partial class PDFOlab : System.Web.UI.Page
    {
        public string sEstudio { set; get; }
        private string sSol = string.Empty;
        private string sFile = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Descarga();
            }
            
        }
        private void Descarga()
        {
            sSol = Request["sEstudio"] != null ? Request["sEstudio"].ToString() : string.Empty;
            //ObtenRes(sSol);
            DescargaArchivo();
        }
        //private string ObtenRes(string sSol)
        //{

             
        //    //NegLotenal oNeg = new NegLotenal();
        //    //List<Utility.EntLotenal> aLot = oNeg.oDoc(sSol);         // Solo debe obtenerse un elemento
        //    //Utility.EntLotenal rLot = aLot[0];
        //    //string sRes = "El archivo no cuenta con vista previa";
        //    //sFile = "Resultado_" + rLot.sDoc + ".pdf";// rLot.sExt;
        //    //Session["Fie"] = sFile;
        //    //sFile = System.IO.Path.Combine(Server.MapPath("~/TemCargas"), sFile);
        //    //System.IO.File.WriteAllBytes(sFile, rLot.Contenido);
        //    //System.Text.StringBuilder strTexto = new System.Text.StringBuilder();

          

        //    //return sRes;

        //}

        private string PDF()
        {
            StringBuilder sbTexto = new StringBuilder();
            string sName = Session["Fie"].ToString();
            sbTexto.Append("<embed src='");
            sbTexto.Append(ResolveClientUrl("~/TemCargas/" + sName));
            sbTexto.Append("' width='100%' height='550' type='application/pdf'></embed>");

            return sbTexto.ToString();
        }
        private void DescargaArchivo()
        {
            string sName = Session["Fie"].ToString();

            string sFileName = Path.Combine(Server.MapPath("~/TemCargas/") + sName);//System.IO.Path.Combine(sPath, sFile);
            System.IO.FileStream fs = new System.IO.FileStream(sFileName, System.IO.FileMode.Open, System.IO.FileAccess.Read);
            byte[] ar = new byte[(int)fs.Length];
            fs.Read(ar, 0, (int)fs.Length);
            fs.Close();

            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("Content-Disposition", "attachment; filename=" +  "Resultado.pdf");
            Response.ContentType = "application/pdf";
            Response.BinaryWrite(ar.ToArray());
            Response.End();
            //Response.Clear();
            ////Response.Buffer = true;
            ////Response.AddHeader("content-disposition", "attachment;filename=" + sFile);
            //Response.AddHeader("content-disposition", "attachment;filename=" + "Resultado.pdf");
            //Response.Charset = "UTF-8";
            ////Response.ContentEncoding = Encoding.Default;
            //Response.ContentType = "application/pdf";
            //Response.Cache.SetCacheability(HttpCacheability.NoCache);
            //Response.BinaryWrite(ar);

            //Response.Flush();
            //Response.Close();
            //Response.End();


        }
    }
}