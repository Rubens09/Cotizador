using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using Utility;
using System.Net;
using Utility.Widget.eraSecurity;

namespace Portal.AjaxQuerys
{
    //System.Web.HttpContext.Current.Session["IDUsuario"].ToString()
    public partial class AjaxResponse : System.Web.UI.Page
    {
        #region SolicitudRefacciones

        [WebMethod]
        public static List<object> GetTipoUnidad()
        {
            List<object> Result = null;

            using (DBQuerys Querys = new DBQuerys())
            {
                DataTable Tabla = Querys.GetTipoUnidad();

                if (Tabla != null)
                {
                    Result = new List<object>();

                    foreach (DataRow Row in Tabla.Rows)
                    {
                        Result.Add(new { Id = Row["DimDesc"], Name = Row["DimDesc"] });
                    }
                }
            }
            return Result;
        }

        [WebMethod]
        public static List<object> GetUnidadRef(string Tipo)
        {
            List<object> Result = null;

            using (DBQuerys Querys = new DBQuerys())
            {
                DataTable Tabla = Querys.GetUnidadRef(Tipo);

                if (Tabla != null)
                {
                    Result = new List<object>();

                    foreach (DataRow Row in Tabla.Rows)
                    {
                        Result.Add(new { Id = Row["PrcCode"], Name = Row["PrcCode"] });
                    }
                }
            }
            return Result;
        }

        [WebMethod]
        public static List<object> GetRefacciones()
        {
            List<object> Result = null;

            using (DBQuerys Querys = new DBQuerys())
            {
                DataTable Tabla = Querys.GetRefacciones();

                if (Tabla != null)
                {
                    Result = new List<object>();

                    foreach (DataRow Row in Tabla.Rows)
                    {
                        Result.Add(new { Id = Row["ItemCode"], Name = Row["ItemName"] });
                    }
                }
            }
            return Result;
        }

        [WebMethod]
        public static List<object> GetUnidadesMedida()
        {
            List<object> Result = null;

            using (DBQuerys Querys = new DBQuerys())
            {
                DataTable Tabla = Querys.GetUnidadMedida();

                if (Tabla != null)
                {
                    Result = new List<object>();

                    foreach (DataRow Row in Tabla.Rows)
                    {
                        Result.Add(new { Id = Row["Descripcion_Unidad"], Name = Row["Descripcion_Unidad"] });
                    }
                }
            }
            return Result;
        }




        #endregion


        #region SolicitudCompra

        [WebMethod]
        public static List<object> GetEstatus(string fechaIni, string fechaFin, string estatus,string noSolicitud, string elaboro)
        {
            List<object> Result = null;

            using (DBQuerys Querys = new DBQuerys())
            {
                DataTable Tabla = Querys.GetEstatus(Convert.ToDateTime(fechaIni).ToString("yyyy-MM-dd"), Convert.ToDateTime(fechaFin).ToString("yyyy-MM-dd"));

                if (Tabla != null)
                {
                    Result = new List<object>();

                    foreach (DataRow Row in Tabla.Rows)
                    {
                        Result.Add(new { Id = Row["Descripcion_Estatus"], Name = Row["Descripcion_Estatus"] });
                    }
                }
            }
            return Result;
        }
        [WebMethod]
        public static List<object> GetNumSolicitud(string fechaIni, string fechaFin, string estatus, string noSolicitud, string elaboro)
        {
            List<object> Result = null;

            using (DBQuerys Querys = new DBQuerys())
            {
                DataTable Tabla = Querys.GetNoSolicitud(Convert.ToDateTime(fechaIni).ToString("yyyy-MM-dd"), Convert.ToDateTime(fechaFin).ToString("yyyy-MM-dd"),estatus);

                if (Tabla != null)
                {
                    Result = new List<object>();

                    foreach (DataRow Row in Tabla.Rows)
                    {
                        Result.Add(new { Id = Row["Num_Solicitud"], Name = Row["Num_Solicitud"] });
                    }
                }
            }
            return Result;
        }
        [WebMethod]
        public static List<object> GetNUsuario(string fechaIni, string fechaFin, string estatus, string noSolicitud, string elaboro)
        {
            List<object> Result = null;

            using (DBQuerys Querys = new DBQuerys())
            {
                DataTable Tabla = Querys.GetNUsuario(Convert.ToDateTime(fechaIni).ToString("yyyy-MM-dd"), Convert.ToDateTime(fechaFin).ToString("yyyy-MM-dd"),
                    estatus, noSolicitud);

                if (Tabla != null)
                {
                    Result = new List<object>();

                    foreach (DataRow Row in Tabla.Rows)
                    {
                        Result.Add(new { Id = Row["NUsuario"], Name = Row["NUsuario"] });
                    }
                }
            }
            return Result;
        }



        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static List<object> GetListadoSolicitudes(string fechaIni, string fechaFin, string estatus, string noSolicitud, string elaboro)
        {
            List<object> Result = null;


            using (DBQuerys Querys = new DBQuerys())
            {
                DataTable Tabla = Querys.listadoSolicitudes(Convert.ToDateTime(fechaIni).ToString("yyyy-MM-dd"), Convert.ToDateTime(fechaFin).ToString("yyyy-MM-dd"), 
                    noSolicitud, elaboro,estatus);

                if (Tabla != null)
                {
                    Result = new List<object>();

                    foreach (DataRow Row in Tabla.Rows)
                    {

                        Result.Add(new { NumSolicitud = Row["Num_Solicitud"], Descripcion = Row["Comentario"], FechaSolicitud = ((DateTime)(Row["Fecha_Solicitud"])).ToString("yyyy-MM-dd"), 
                            Usuario = Row["NUsuario"], Estatus = Row["Descripcion_Estatus"]});

                    }
                }
            }
            return Result;
        }

        #endregion
        #region Ventas
        #region Cotizaciones
        [WebMethod]
        public static List<object> GetCotizaciones()
        {
            List<object> Result = null;

            using (DBQuerys Querys = new DBQuerys())
            {
                DataTable Tabla = Querys.GetCotizaciones();

                if (Tabla != null)
                {
                    Result = new List<object>();

                    foreach (DataRow Row in Tabla.Rows)
                    {
                        Result.Add(new { Id_cotizacion = Row["Id_Cabecera_Cot"], Num_clte = Row["Clave_Cliente"], Fecha = Row["Fecha"], TotalMxn = Row["Total_Gto"], TotalUsd = Row["Total_Gto_usd"], Status=Row["Status_Cotizacion"] });
                    }
                }
            }
            return Result;
        }
        #endregion
        #region Cotizador
        [WebMethod]
        public static List<object> GetOrigen()
        {
            List<object> Result = null;

            using (DBQuerys Querys = new DBQuerys())
            {
                DataTable Tabla = Querys.GetOrigen();

                if (Tabla != null)
                {
                    Result = new List<object>();

                    foreach (DataRow Row in Tabla.Rows)
                    {
                        Result.Add(new { Id=Row["Id"],Descripcion = Row["Nombre"] });
                    }
                }
            }
            return Result;
        }
        [WebMethod]
        public static List<object> GetProducto()
        {
            List<object> Result = null;

            using (DBQuerys Querys = new DBQuerys())
            {
                DataTable Tabla = Querys.GetProducto();

                if (Tabla != null)
                {
                    Result = new List<object>();

                    foreach (DataRow Row in Tabla.Rows)
                    {
                        Result.Add(new { Id = Row["Id_Producto"], Descripcion = Row["Nombre_Producto"] });
                    }
                }
            }
            return Result;
        }
        [WebMethod]
        public static List<object> GetTransporte(Int32 Producto)
        {
            List<object> Result = null;

            using (DBQuerys Querys = new DBQuerys())
            {
                DataTable Tabla = Querys.GetTransporte(Producto);

                if (Tabla != null)
                {
                    Result = new List<object>();

                    foreach (DataRow Row in Tabla.Rows)
                    {
                        Result.Add(new { Id = Row["Id_Tipo_Trans"], Descripcion = Row["Nombre_Transporte"] });
                    }
                }
            }
            return Result;
        }
        [WebMethod]
        public static List<object> GetTipoPagoOP()
        {
            List<object> Result = null;

            using (DBQuerys Querys = new DBQuerys())
            {
                DataTable Tabla = Querys.GetTipoPagoOP();

                if (Tabla != null)
                {
                    Result = new List<object>();

                    foreach (DataRow Row in Tabla.Rows)
                    {
                        Result.Add(new { Id = Row["Id_Tipo_Pago"], Descripcion = Row["Descripcion"] });
                    }
                }
            }
            return Result;
        }
        [WebMethod]
        public static List<object> GetBasePagoOp(Int32 Producto)
        {
            List<object> Result = null;

            using (DBQuerys Querys = new DBQuerys())
            {
                DataTable Tabla = Querys.GetBasePagoOp(Producto);

                if (Tabla != null)
                {
                    Result = new List<object>();

                    foreach (DataRow Row in Tabla.Rows)
                    {
                        Result.Add(new { Id = Row["Id_Tipo_Pago"], Descripcion = Row["Base_Pago_Op"] });
                    }
                }
            }
            return Result;
        }

        [WebMethod]
        public static List<object> GetClientes()
        {
            List<object> Result = null;

            using (DBQuerys Querys = new DBQuerys())
            {
                DataTable Tabla = Querys.GetClientes();

                if (Tabla != null)
                {
                    Result = new List<object>();

                    foreach (DataRow Row in Tabla.Rows)
                    {
                        Result.Add(new { Id = Row["CardCode"], Descripcion = Row["CardName"] });
                    }
                }
            }
            return Result;
        }
        [WebMethod]
        public static List<object> GetKmVacio(float DnoOrigen, float BaseOrigen, float DnoBase)
        {
            List<object> Result = null;

            using (DBQuerys Querys = new DBQuerys())
            {
                DataTable Tabla = Querys.GetKmVacio(DnoOrigen,BaseOrigen,DnoBase);

                if (Tabla != null)
                {
                    Result = new List<object>();

                    foreach (DataRow Row in Tabla.Rows)
                    {
                        Result.Add(new {Descripcion = Row["column1"] });
                    }
                }
            }
            return Result;
        }
        [WebMethod]
        public static List<object> GetKmRecorrer(float KmCargado, float KmVacio)
        {
            List<object> Result = null;

            using (DBQuerys Querys = new DBQuerys())
            {
                DataTable Tabla = Querys.GetKmRecorrer(KmCargado,KmVacio);

                if (Tabla != null)
                {
                    Result = new List<object>();

                    foreach (DataRow Row in Tabla.Rows)
                    {
                        Result.Add(new { Descripcion = Row["column1"] });
                    }
                }
            }
            return Result;
        }
        [WebMethod]
        public static List<object> GetCuotaFija(Int32 Destino)
        {
            List<object> Result = null;

            using (DBQuerys Querys = new DBQuerys())
            {
                DataTable Tabla = Querys.GetCuotaFija(Destino);

                if (Tabla != null)
                {
                    Result = new List<object>();

                    foreach (DataRow Row in Tabla.Rows)
                    {
                        Result.Add(new { Descripcion = Row["column1"] });
                    }
                }
            }
            return Result;
        }
        [WebMethod]
        public static List<object> GetBasePago(Int32 TipoPago)
        {
            List<object> Result = null;

            using (DBQuerys Querys = new DBQuerys())
            {
                DataTable Tabla = Querys.GetBasePago(TipoPago);

                if (Tabla != null)
                {
                    Result = new List<object>();

                    foreach (DataRow Row in Tabla.Rows)
                    {
                        Result.Add(new {Id= Row["column1"], Descripcion = Row["column1"] });
                    }
                }
            }
            return Result;
        }
        [WebMethod]
        public static List<object> GetToken()
        {
            List<object> Result = null;

            using (DBQuerys Querys = new DBQuerys())
            {
                DataTable Tabla = Querys.GetToken();

                if (Tabla != null)
                {
                    Result = new List<object>();

                    foreach (DataRow Row in Tabla.Rows)
                    {
                        Result.Add(new { Token = Row["Token"] });
                    }
                }
            }
            return Result;
        }
        [WebMethod]
        public static List<object> GetDieselMx(float KMRecorrer,float Factor,float PrecioDiesel)
        {
            List<object> Result = null;

            using (DBQuerys Querys = new DBQuerys())
            {
                DataTable Tabla = Querys.GetDieselMx(KMRecorrer,Factor,PrecioDiesel);

                if (Tabla != null)
                {
                    Result = new List<object>();

                    foreach (DataRow Row in Tabla.Rows)
                    {
                        Result.Add(new { Diesel = Row["column1"] });
                    }
                }
            }
            return Result;
        }
        [WebMethod]
        public static List<object> GetSueldoOp(float KMCargado, float KMVacio, int TipoPagoOP)
        {
            List<object> Result = null;

            using (DBQuerys Querys = new DBQuerys())
            {
                DataTable Tabla = Querys.GetSueldoOp(KMCargado, KMVacio, TipoPagoOP);

                if (Tabla != null)
                {
                    Result = new List<object>();

                    foreach (DataRow Row in Tabla.Rows)
                    {
                        Result.Add(new { SueldoOp = Row["column1"] });
                    }
                }
            }
            return Result;
        }
        [WebMethod]
        public static List<object> GetTotalGto(float CasetasMXN, float DieselMXN, float SueldoOpMXN)
        {
            List<object> Result = null;

            using (DBQuerys Querys = new DBQuerys())
            {
                DataTable Tabla = Querys.GetTotalGto(CasetasMXN, DieselMXN, SueldoOpMXN);

                if (Tabla != null)
                {
                    Result = new List<object>();

                    foreach (DataRow Row in Tabla.Rows)
                    {
                        Result.Add(new { TotalGtoM = Row["column1"] });
                    }
                }
            }
            return Result;
        }
        [WebMethod]
        public static List<object> GetUOP(float TotalGtoMXN, float IngresoMXN)
        {
            List<object> Result = null;

            using (DBQuerys Querys = new DBQuerys())
            {
                DataTable Tabla = Querys.GetUOP(TotalGtoMXN, IngresoMXN);

                if (Tabla != null)
                {
                    Result = new List<object>();

                    foreach (DataRow Row in Tabla.Rows)
                    {
                        Result.Add(new { UOPMX = Row["column1"], UOPPMX = Row["column2"] });
                    }
                }
            }
            return Result;
        }
        [WebMethod]
        public static List<object> GetDieselUSD(float Factor, float PrecioDiesel, float TipoCambio, float KMCargado)
        {
            List<object> Result = null;

            using (DBQuerys Querys = new DBQuerys())
            {
                DataTable Tabla = Querys.GetDieselUSD(Factor, PrecioDiesel, TipoCambio, KMCargado);

                if (Tabla != null)
                {
                    Result = new List<object>();

                    foreach (DataRow Row in Tabla.Rows)
                    {
                        Result.Add(new { DieselUSD = Row["column1"]});
                    }
                }
            }
            return Result;
        }
        [WebMethod]
        public static List<object> GetCasetasUSD(float CasetasMXN, float TipoCambio)
        {
            List<object> Result = null;

            using (DBQuerys Querys = new DBQuerys())
            {
                DataTable Tabla = Querys.GetCasetasUSD(CasetasMXN, TipoCambio);

                if (Tabla != null)
                {
                    Result = new List<object>();

                    foreach (DataRow Row in Tabla.Rows)
                    {
                        Result.Add(new { CasetasUSD = Row["column1"] });
                    }
                }
            }
            return Result;
        }
        [WebMethod]
        public static List<object> GetSueldoOpUSD(float KMCargado, float TipoCambio, float BasePagoOp,float IngresoUSD)
        {
            List<object> Result = null;

            using (DBQuerys Querys = new DBQuerys())
            {
                DataTable Tabla = Querys.GetSueldoOpUSD(KMCargado, TipoCambio, BasePagoOp, IngresoUSD);

                if (Tabla != null)
                {
                    Result = new List<object>();

                    foreach (DataRow Row in Tabla.Rows)
                    {
                        Result.Add(new { SueldoOpUSD = Row["column1"] });
                    }
                }
            }
            return Result;
        }
        [WebMethod]
        public static List<object> GetGastoUSD(float DieselUSD,float CasetasUSD,float SueldoOpUSD)
        {
            List<object> Result = null;

            using (DBQuerys Querys = new DBQuerys())
            {
                DataTable Tabla = Querys.GetGastoUSD(DieselUSD, CasetasUSD, SueldoOpUSD);

                if (Tabla != null)
                {
                    Result = new List<object>();

                    foreach (DataRow Row in Tabla.Rows)
                    {
                        Result.Add(new { TotalGtoUSD = Row["column1"] });
                    }
                }
            }
            return Result;
        }
        [WebMethod]
        public static List<object> GetUOPUSD(float IngresoUSD,float TotalGtoUSD)
        {
            List<object> Result = null;

            using (DBQuerys Querys = new DBQuerys())
            {
                DataTable Tabla = Querys.GetUOPUSD(IngresoUSD, TotalGtoUSD);

                if (Tabla != null)
                {
                    Result = new List<object>();

                    foreach (DataRow Row in Tabla.Rows)
                    {
                        Result.Add(new { UOPUSD = Row["column1"], UOPPUSD = Row["column2"] });
                    }
                }
            }
            return Result;
        }

        [WebMethod]
        public static List<object> GetIngresoUSD(float PrecioKM,float KMCargado,float TipoCambio,float CuotaFija)
        {
            List<object> Result = null;

            using (DBQuerys Querys = new DBQuerys())
            {
                DataTable Tabla = Querys.GetIngresoUSD(PrecioKM, KMCargado, TipoCambio, CuotaFija);

                if (Tabla != null)
                {
                    Result = new List<object>();

                    foreach (DataRow Row in Tabla.Rows)
                    {
                        Result.Add(new { IngresoUSD = Row["column1"]});
                    }
                }
            }
            return Result;
        }
        [WebMethod]
        public static List<object> GetIngresoMXN(float TipoCambio,float Repartos,float PrecioKM,float KMRecorrer,float KMCargado,float Destino)
        {
            List<object> Result = null;

            using (DBQuerys Querys = new DBQuerys())
            {
                DataTable Tabla = Querys.GetIngresoMXN(TipoCambio, Repartos, PrecioKM, KMRecorrer, KMCargado,Destino);

                if (Tabla != null)
                {
                    Result = new List<object>();

                    foreach (DataRow Row in Tabla.Rows)
                    {
                        Result.Add(new { IngresoMXN = Row["column1"] });
                    }
                }
            }
            return Result;
        }
        [WebMethod]
        public static List<object> AltaCotizacion(int id_origen, int id_destino, int id_producto, string clave_cliente, string Nombre_Cliente, float km_dno_origen, float km_base_origen, float km_dno_base, int repartos, float precio_km, float km_cargado, int id_tipo_pago_op, float factor, float precio_diesel, float tipo_cambio, float casetas, string tipo_transporte, float km_vacio, float Km_recorrer, float Cuota_Fija, float ingresos_mx, float costo_diesel, float sueldo_op, float total_gasto_mx, float uop_mx, float uop_porcent, float Ingresos_usd, float Diesel_usd, float Casetas_usd, float Sueldo_Op_usd, float Total_Gto_usd, float UOP_usd, float uop_porcent_usd, float custodia, float custodiaUSD, float multimodal,float multimodalUSD)
        {
            List<object> Result = null;

            using (DBQuerys Querys = new DBQuerys())
            {
                DataTable Tabla = Querys.AltaCotizacion(id_origen,id_destino,id_producto,clave_cliente,Nombre_Cliente,km_dno_origen,km_base_origen,km_dno_base,repartos,precio_km,km_cargado,id_tipo_pago_op,factor,precio_diesel,tipo_cambio,casetas,tipo_transporte,km_vacio,Km_recorrer,Cuota_Fija,ingresos_mx,costo_diesel,sueldo_op,total_gasto_mx,uop_mx,uop_porcent,Ingresos_usd,Diesel_usd,Casetas_usd,Sueldo_Op_usd,Total_Gto_usd,UOP_usd,uop_porcent_usd,custodia,custodiaUSD, multimodal,multimodalUSD);

                if (Tabla != null)
                {
                    Result = new List<object>();

                    foreach (DataRow Row in Tabla.Rows)
                    {
                        Result.Add(new { id_nuevo = Row["column1"] });
                    }
                }
            }
            return Result;
        }
        [WebMethod]
        public static List<object> GetCotizacion(int num_cot)
        {
            List<object> Result = null;

            using (DBQuerys Querys = new DBQuerys())
            {
                DataTable Tabla = Querys.GetCotizacion(num_cot);

                if (Tabla != null)
                {
                    Result = new List<object>();

                    foreach (DataRow Row in Tabla.Rows)
                    {
                        Result.Add(new { Id_Origen = Row["Id_Origen"], Id_Destino = Row["Id_Destino"], Id_Tipo_Pago_Op = Row["Id_Tipo_Pago_Op"], Id_Producto = Row["Id_Producto"], Origen = Row["Origen"], Destino = Row["Destino"], Nombre_Producto = Row["Nombre_Producto"],Clave_Cliente = Row["Clave_Cliente"], Nombre_Cliente = Row["Nombre_Cliente"], Tipo_Transporte = Row["Tipo_Transporte"], Km_Dno_Origen = Row["Km_Dno_Origen"], Km_Base_Origen = Row["Km_Base_Origen"], Km_Dno_Base = Row["Km_Dno_Base"], Repartos = Row["Repartos"], Precio_Km = Row["Precio_Km"], Km_Cargado = Row["Km_Cargado"], Km_Vacio = Row["Km_Vacio"], Km_Recorrer = Row["Km_Recorrer"], Cuota_Fija = Row["Cuota_Fija"], Descripcion = Row["Descripcion"], Factor = Row["Factor"], Precio_Diesel = Row["Precio_Diesel"], Tipo_Cambio = Row["Tipo_Cambio"], Ingresos = Row["Ingresos"], Diesel = Row["Diesel"], Casetas = Row["Casetas"], Sueldo_Op = Row["Sueldo_Op"], Total_Gto = Row["Total_Gto"], UOP = Row["UOP"], UOP_Porc = Row["UOP_Porc"], Ingresos_usd = Row["Ingresos_usd"], Diesel_usd = Row["Diesel_usd"], Casetas_usd = Row["Casetas_usd"], Sueldo_Op_usd = Row["Sueldo_Op_usd"], Total_Gto_usd = Row["Total_Gto_usd"], UOP_Usd = Row["UOP_Usd"], UOP_Usd_Porc = Row["UOP_Usd_Porc"],custodia = Row["custodia"],custodia_usd = Row["custodia_usd"],multimodal= Row["multimodal"],multimodal_usd = Row["multimodal_usd"] });
                    }
                }
            }
            return Result;
        }
        [WebMethod]
        public static List<object> GetInfoPDF(int num_cot)
        {
            List<object> Result = null;

            using (DBQuerys Querys = new DBQuerys())
            {
                DataTable Tabla = Querys.GetInfoPDF(num_cot);

                if (Tabla != null)
                {
                    Result = new List<object>();

                    foreach (DataRow Row in Tabla.Rows)
                    {
                        Result.Add(new { Origen = Row["Origen"] , Nombre_Cliente = Row["Nombre_Cliente"],Destino = Row["Destino"], Total_Gto_usd = Row["Total_Gto_usd"], Dia = Row["Dia"], Mes = Row["Mes"], Anio = Row["anio"] });
                    }
                }
            }
            return Result;
        }
        [WebMethod]
        public static List<object> EditarCotizacion(int id_cotizacion, int id_origen, int id_destino, int id_producto, string clave_cliente, string Nombre_Cliente, float km_dno_origen, float km_base_origen, float km_dno_base, int repartos, float precio_km, float km_cargado, int id_tipo_pago_op, float factor, float precio_diesel, float tipo_cambio, float casetas, string tipo_transporte, float km_vacio, float Km_recorrer, float Cuota_Fija, float ingresos_mx, float costo_diesel, float sueldo_op, float total_gasto_mx, float uop_mx, float uop_porcent, float Ingresos_usd, float Diesel_usd, float Casetas_usd, float Sueldo_Op_usd, float Total_Gto_usd, float UOP_usd, float uop_porcent_usd)
        {
            List<object> Result = null;

            using (DBQuerys Querys = new DBQuerys())
            {
                DataTable Tabla = Querys.EditarCotizacion(id_cotizacion,id_origen, id_destino, id_producto, clave_cliente, Nombre_Cliente, km_dno_origen, km_base_origen, km_dno_base, repartos, precio_km, km_cargado, id_tipo_pago_op, factor, precio_diesel, tipo_cambio, casetas, tipo_transporte, km_vacio, Km_recorrer, Cuota_Fija, ingresos_mx, costo_diesel, sueldo_op, total_gasto_mx, uop_mx, uop_porcent, Ingresos_usd, Diesel_usd, Casetas_usd, Sueldo_Op_usd, Total_Gto_usd, UOP_usd, uop_porcent_usd);

                if (Tabla != null)
                {
                    Result = new List<object>();

                    foreach (DataRow Row in Tabla.Rows)
                    {
                        Result.Add(new { IngresoMXN = Row["column1"] });
                    }
                }
            }
            return Result;
        }
        [WebMethod]
        public static List<object> CancelarCotizacion(int num_cot)
        {
            List<object> Result = null;

            using (DBQuerys Querys = new DBQuerys())
            {
                DataTable Tabla = Querys.CancelarCotizacion(num_cot);

                if (Tabla != null)
                {
                    Result = new List<object>();

                    foreach (DataRow Row in Tabla.Rows)
                    {
                        Result.Add(new { IngresoMXN = Row["column1"] });
                    }
                }
            }
            return Result;
        }
        [WebMethod]
        public static List<object> AltaCliente(string nombre_cliente,string correo,string correoa,string celular,string telefono,string direccion)
        {
            List<object> Result = null;

            using (DBQuerys Querys = new DBQuerys())
            {
                DataTable Tabla = Querys.AltaCliente(nombre_cliente,correo,correoa,celular,telefono,direccion);

                if (Tabla != null)
                {
                    Result = new List<object>();

                    foreach (DataRow Row in Tabla.Rows)
                    {
                        Result.Add(new { id_cliente = Row["Column1"] });
                    }
                }
            }
            return Result;
        }
        #endregion
        #endregion

    }
    }
