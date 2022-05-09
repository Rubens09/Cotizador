using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using System.Runtime.InteropServices;
using System.Security.Cryptography;
using System.Text;
using Utility.Widget.eraDBConnect;
using Utility.Widget.eraLogger;
using SAPbobsCOM;


namespace Utility
{
    public class DBQuerys : IDisposable
    {
        #region Variables

        private static volatile DBQuerys _Instance;
        //private static string ConnectionStringIssemym2 = @"User=SYSDBA;Password=masterkey;Database=C:\Indicadores\BASES_ISSEMYM.FDB;DataSource=192.168.68.71,1723;Dialect=3;Charset=UTF8;";
        private static string ConnectionStringFarhos = @"USER=SYSDBA; Password=$0lu15; Database=192.168.211.254:/usr/local/ibbases/ibfarm.gdb; datasource=192.168.211.254; Port=3050; Dialect=1;Charset=NONE;Role=USUARIO";
        //private static string ConnectionStringSystem = @"Server=192.168.68.7;Database=DB_IBFarmaLoteNal_Multi;Connection Timeout=2;Pooling=false;User ID=Ikon;Password=Ikon2014;Trusted_Connection=False";
        private static string ConnectionStringSystem = @"Server=192.168.0.245;Database=DB_SIT;Connection Timeout=2;Pooling=false;User ID=sa;Password=Med*8642;Trusted_Connection=False";
        //private static string ConnectionStringISEM = @"USER=SYSDBA; Password=masterkey; Database=C:\Indicadores\BASESFARHOS.FDB; datasource=201812-SIA3.soluglobikon.mx; Port=3050; Dialect=3";
        //private static string ConnectionStringPortalPedidos = @"Server=192.168.68.71\FILLRATE;Database=DB_PortalPedidos;Connection Timeout=2;Pooling=false;User ID=ikon;Password=Ikon2014;Trusted_Connection=False";
        #endregion

        #region Properties

        public static DBQuerys Instance
        {
            get
            {
                if (_Instance == null)
                    _Instance = new DBQuerys();

                return _Instance;
            }
        }

        #endregion

        #region Methods

        #region Login
        public DataRow IsValidUser(string User, string Pass)
        {
            try
            {
                using (DBConnect DBConnection = new DBConnect())
                {
                    string Query = string.Empty;

                    List<Parameter> Parameters = new List<Parameter>();
                    Parameters.Add(new Parameter("@User", User.ToLower()));
                    Parameters.Add(new Parameter("@Pass", Pass));
                    Query = @"SELECT * FROM Usuario WHERE NUsuario = @User AND Passw = @Pass and Estatus=1";
                    DataTable Result = DBConnection.ExecuteQuery(TypeDB.SQLServer, ConnectionStringSystem, Query, Parameters);

                    if (Result != null)
                    {
                        if (Result.Rows.Count > 0)
                            return Result.Rows[0];
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteLog(TypeLog.ERROR, "DBQuerys.E.002", ex);
            }

            return null;
        }
        #endregion

        #region SolicitudRefaccion

        public DataTable GetTipoUnidad()
        {
            DataTable Result = new DataTable();
            string Query = string.Empty;
            try
            {
                Query = @"[Consulta_Dimension_Unidad]";

                using (DBConnect DBConnection = new DBConnect())
                {
                    Result = DBConnection.ExecuteQuery(TypeDB.SQLServer, ConnectionStringSystem, Query);
                }

            }
            catch (Exception ex)
            {
                Logger.WriteLog(TypeLog.ERROR, "Error: " + ex.Message, ex);
            }

            return Result;
        }

        public DataTable GetUnidadRef(string Tipo)
        {
            DataTable Result = new DataTable();
            string Query = string.Empty;
            try
            {
                Query = string.Format("[Tipo_dimension] '{0}'",Tipo);

                using (DBConnect DBConnection = new DBConnect())
                {
                    Result = DBConnection.ExecuteQuery(TypeDB.SQLServer, ConnectionStringSystem, Query);
                }

            }
            catch (Exception ex)
            {
                Logger.WriteLog(TypeLog.ERROR, "Error: " + ex.Message, ex);
            }

            return Result;
        }

        public DataTable GetRefacciones()
        {
            DataTable Result = new DataTable();
            string Query = string.Empty;
            try
            {
                Query = @"Articulos";

                using (DBConnect DBConnection = new DBConnect())
                {
                    Result = DBConnection.ExecuteQuery(TypeDB.SQLServer, ConnectionStringSystem, Query);
                }

            }
            catch (Exception ex)
            {
                Logger.WriteLog(TypeLog.ERROR, "Error: " + ex.Message, ex);
            }

            return Result;
        }

        public DataTable GetUnidadMedida()
        {
            DataTable Result = new DataTable();
            string Query = string.Empty;
            try
            {
                Query = @"Listado_Unidades_Medida";

                using (DBConnect DBConnection = new DBConnect())
                {
                    Result = DBConnection.ExecuteQuery(TypeDB.SQLServer, ConnectionStringSystem, Query);
                }

            }
            catch (Exception ex)
            {
                Logger.WriteLog(TypeLog.ERROR, "Error: " + ex.Message, ex);
            }

            return Result;
        }

        #endregion

        #region SolicitudCompra

        public DataTable GetEstatus(string fechaIni, string fechaFin)
        {
            DataTable Result = new DataTable();
            string Query = string.Empty;
            try
            {
                Query = @"Agrupar_Listado @tipodato=0,@fecha_ini='" + fechaIni + "',@fecha_ter='" + fechaFin + "'";

                using (DBConnect DBConnection = new DBConnect())
                {
                    Result = DBConnection.ExecuteQuery(TypeDB.SQLServer, ConnectionStringSystem, Query);
                }

            }
            catch (Exception ex)
            {
                Logger.WriteLog(TypeLog.ERROR, "Error: " + ex.Message, ex);
            }

            return Result;
        }

        public DataTable GetNoSolicitud(string fechaIni, string fechaFin,string estatus)
        {
            DataTable Result = new DataTable();
            string Query = string.Empty;
            try
            {
                Query = @"Agrupar_Listado @tipodato=1,@fecha_ini='" + fechaIni + "',@fecha_ter='" + fechaFin + "'";
                if (estatus != string.Empty)
                {
                    if (estatus != "")
                        Query += @",@estatus='" + estatus+"'";
                }
                using (DBConnect DBConnection = new DBConnect())
                {
                    Result = DBConnection.ExecuteQuery(TypeDB.SQLServer, ConnectionStringSystem, Query);
                }

            }
            catch (Exception ex)
            {
                Logger.WriteLog(TypeLog.ERROR, "Error: " + ex.Message, ex);
            }

            return Result;
        }

        public DataTable GetNUsuario(string fechaIni, string fechaFin, string estatus,string noSolicitud)
        {
            DataTable Result = new DataTable();
            string Query = string.Empty;
            try
            {
                Query = @"Agrupar_Listado @tipodato=2,@fecha_ini='" + fechaIni + "',@fecha_ter='" + fechaFin + "'";
                if (estatus != string.Empty)
                {
                    if (estatus != "")
                        Query += @",@estatus='" + estatus+"'";
                }
                if (noSolicitud != string.Empty)
                {
                    if (noSolicitud != "")
                        Query += @",@no_solic=" + noSolicitud;
                }
                using (DBConnect DBConnection = new DBConnect())
                {
                    Result = DBConnection.ExecuteQuery(TypeDB.SQLServer, ConnectionStringSystem, Query);
                }

            }
            catch (Exception ex)
            {
                Logger.WriteLog(TypeLog.ERROR, "Error: " + ex.Message, ex);
            }

            return Result;
        }


        public DataTable listadoSolicitudes(string fechaIni,string fechaFin,string noSolicitud,string elaboro,string estatus)
        {
            DataTable Result = new DataTable();
            string Query = string.Empty;
            try
            {
                Query = @"Listar_Registro @fecha_inicio='" + fechaIni + "',@fecha_termino='" + fechaFin +"'";

                if(noSolicitud != string.Empty)
                {
                    if (noSolicitud != "")
                        Query += @",@Num_Solicitud=" + noSolicitud;
                }
                
                if (elaboro != string.Empty)
                {
                    if (elaboro != "")
                        Query += @",@nusuario='" + elaboro+"'";
                }

                if (estatus != string.Empty)
                {
                    if (estatus != "")
                        Query += @",@estatus='" + estatus+"'";
                }
                using (DBConnect DBConnection = new DBConnect())
                {
                    Result = DBConnection.ExecuteQuery(TypeDB.SQLServer, ConnectionStringSystem, Query);
                }

            }
            catch(Exception ex)
            {
                Logger.WriteLog(TypeLog.ERROR, "Error: " + ex.Message, ex);
            }

            return Result;
        }
        #endregion
        #region Ventas
        #region Cotizaciones
        public DataTable GetCotizaciones()
        {
            DataTable Result = new DataTable();
            string Query = string.Empty;
            try
            {
                Query = @"[Listar_Cotizaciones]";

                using (DBConnect DBConnection = new DBConnect())
                {
                    Result = DBConnection.ExecuteQuery(TypeDB.SQLServer, ConnectionStringSystem, Query);
                }

            }
            catch (Exception ex)
            {
                Logger.WriteLog(TypeLog.ERROR, "Error: " + ex.Message, ex);
            }

            return Result;
        }
        #endregion
        #region Cotizador

        public DataTable GetOrigen()
        {
            DataTable Result = new DataTable();
            string Query = string.Empty;
            try
            {
                Query = @"[Listar_Origenes]";

                using (DBConnect DBConnection = new DBConnect())
                {
                    Result = DBConnection.ExecuteQuery(TypeDB.SQLServer, ConnectionStringSystem, Query);
                }

            }
            catch (Exception ex)
            {
                Logger.WriteLog(TypeLog.ERROR, "Error: " + ex.Message, ex);
            }

            return Result;
        }
        public DataTable GetProducto()
        {
            DataTable Result = new DataTable();
            string Query = string.Empty;
            try
            {
                Query = @"[Listar_Producto]";

                using (DBConnect DBConnection = new DBConnect())
                {
                    Result = DBConnection.ExecuteQuery(TypeDB.SQLServer, ConnectionStringSystem, Query);
                }

            }
            catch (Exception ex)
            {
                Logger.WriteLog(TypeLog.ERROR, "Error: " + ex.Message, ex);
            }

            return Result;
        }
        public DataTable GetTransporte(Int32 Producto)
        {
            DataTable Result = new DataTable();
            string Query = string.Empty;
            try
            {
                Query = @"[Listar_Caja_Producto] "+Producto;

                using (DBConnect DBConnection = new DBConnect())
                {
                    Result = DBConnection.ExecuteQuery(TypeDB.SQLServer, ConnectionStringSystem, Query);
                }

            }
            catch (Exception ex)
            {
                Logger.WriteLog(TypeLog.ERROR, "Error: " + ex.Message, ex);
            }

            return Result;
        }
        public DataTable GetTipoPagoOP()
        {
            DataTable Result = new DataTable();
            string Query = string.Empty;
            try
            {
                Query = @"[Listar_TipoPago]";

                using (DBConnect DBConnection = new DBConnect())
                {
                    Result = DBConnection.ExecuteQuery(TypeDB.SQLServer, ConnectionStringSystem, Query);
                }

            }
            catch (Exception ex)
            {
                Logger.WriteLog(TypeLog.ERROR, "Error: " + ex.Message, ex);
            }

            return Result;
        }
        public DataTable GetBasePagoOp(Int32 Producto)
        {
            DataTable Result = new DataTable();
            string Query = string.Empty;
            try
            {
                Query = @"[Select_Base_Pago] " + Producto;

                using (DBConnect DBConnection = new DBConnect())
                {
                    Result = DBConnection.ExecuteQuery(TypeDB.SQLServer, ConnectionStringSystem, Query);
                }

            }
            catch (Exception ex)
            {
                Logger.WriteLog(TypeLog.ERROR, "Error: " + ex.Message, ex);
            }

            return Result;
        }
        public DataTable GetClientes()
        {
            DataTable Result = new DataTable();
            string Query = string.Empty;
            try
            {
                Query = @"[Listado_Clientes] ";

                using (DBConnect DBConnection = new DBConnect())
                {
                    Result = DBConnection.ExecuteQuery(TypeDB.SQLServer, ConnectionStringSystem, Query);
                }

            }
            catch (Exception ex)
            {
                Logger.WriteLog(TypeLog.ERROR, "Error: " + ex.Message, ex);
            }

            return Result;
        }
        public DataTable GetKmVacio(float DnoOrigen, float BaseOrigen, float DnoBase)
        {
            DataTable Result = new DataTable();
            string Query = string.Empty;
            try
            {
                Query = @"[Calcular_Km_Vacio] " + DnoOrigen+","+BaseOrigen+","+ DnoBase;

                using (DBConnect DBConnection = new DBConnect())
                {
                    Result = DBConnection.ExecuteQuery(TypeDB.SQLServer, ConnectionStringSystem, Query);
                }

            }
            catch (Exception ex)
            {
                Logger.WriteLog(TypeLog.ERROR, "Error: " + ex.Message, ex);
            }

            return Result;
        }
        public DataTable GetKmRecorrer(float KmCargado, float KmVacio)
        {
            DataTable Result = new DataTable();
            string Query = string.Empty;
            try
            {
                Query = @"[Calcular_Km_Recorrer] " + KmCargado + "," + KmVacio;

                using (DBConnect DBConnection = new DBConnect())
                {
                    Result = DBConnection.ExecuteQuery(TypeDB.SQLServer, ConnectionStringSystem, Query);
                }

            }
            catch (Exception ex)
            {
                Logger.WriteLog(TypeLog.ERROR, "Error: " + ex.Message, ex);
            }

            return Result;
        }
        public DataTable GetCuotaFija(Int32 Destino)
        {
            DataTable Result = new DataTable();
            string Query = string.Empty;
            try
            {
                Query = @"[Calcular_Cuota_Fija] " + Destino;

                using (DBConnect DBConnection = new DBConnect())
                {
                    Result = DBConnection.ExecuteQuery(TypeDB.SQLServer, ConnectionStringSystem, Query);
                }

            }
            catch (Exception ex)
            {
                Logger.WriteLog(TypeLog.ERROR, "Error: " + ex.Message, ex);
            }

            return Result;
        }
        public DataTable GetBasePago(Int32 TipoPago)
        {
            DataTable Result = new DataTable();
            string Query = string.Empty;
            try
            {
                Query = @"[Calcular_Base_Pago] " + TipoPago;

                using (DBConnect DBConnection = new DBConnect())
                {
                    Result = DBConnection.ExecuteQuery(TypeDB.SQLServer, ConnectionStringSystem, Query);
                }

            }
            catch (Exception ex)
            {
                Logger.WriteLog(TypeLog.ERROR, "Error: " + ex.Message, ex);
            }

            return Result;
        }
        public DataTable GetToken()
        {
            DataTable Result = new DataTable();
            string Query = string.Empty;
            try
            {
                Query = @"[Select_Token] ";

                using (DBConnect DBConnection = new DBConnect())
                {
                    Result = DBConnection.ExecuteQuery(TypeDB.SQLServer, ConnectionStringSystem, Query);
                }

            }
            catch (Exception ex)
            {
                Logger.WriteLog(TypeLog.ERROR, "Error: " + ex.Message, ex);
            }

            return Result;
        }
        public DataTable GetDieselMx(float KMRecorrer, float Factor, float PrecioDiesel)
        {

            DataTable Result = new DataTable();
            string Query = string.Empty;
            try
            {
                Query = @"[Calcular_Diesel_Mx] " + KMRecorrer+","+ Factor + ","+PrecioDiesel;

                using (DBConnect DBConnection = new DBConnect())
                {
                    Result = DBConnection.ExecuteQuery(TypeDB.SQLServer, ConnectionStringSystem, Query);
                }

            }
            catch (Exception ex)
            {
                Logger.WriteLog(TypeLog.ERROR, "Error: " + ex.Message, ex);
            }

            return Result;
        }
        public DataTable GetSueldoOp(float KMCargado, float KMVacio, int TipoPagoOP)
        {

            DataTable Result = new DataTable();
            string Query = string.Empty;
            try
            {
                Query = @"[Calcular_Sueldo_Op] " + KMCargado + "," + KMVacio + "," + TipoPagoOP;

                using (DBConnect DBConnection = new DBConnect())
                {
                    Result = DBConnection.ExecuteQuery(TypeDB.SQLServer, ConnectionStringSystem, Query);
                }

            }
            catch (Exception ex)
            {
                Logger.WriteLog(TypeLog.ERROR, "Error: " + ex.Message, ex);
            }

            return Result;
        }
        public DataTable GetTotalGto(float CasetasMXN, float DieselMXN, float SueldoOpMXN)
        {

            DataTable Result = new DataTable();
            string Query = string.Empty;
            try
            {
                Query = @"[Calcular_Total_Gto] " + CasetasMXN + "," + DieselMXN + "," + SueldoOpMXN;

                using (DBConnect DBConnection = new DBConnect())
                {
                    Result = DBConnection.ExecuteQuery(TypeDB.SQLServer, ConnectionStringSystem, Query);
                }

            }
            catch (Exception ex)
            {
                Logger.WriteLog(TypeLog.ERROR, "Error: " + ex.Message, ex);
            }

            return Result;
        }
        public DataTable GetUOP(float TotalGtoMXN, float IngresoMXN)
        {

            DataTable Result = new DataTable();
            string Query = string.Empty;
            try
            {
                Query = @"[Calcular_UOP] " + IngresoMXN + "," + TotalGtoMXN;

                using (DBConnect DBConnection = new DBConnect())
                {
                    Result = DBConnection.ExecuteQuery(TypeDB.SQLServer, ConnectionStringSystem, Query);
                }

            }
            catch (Exception ex)
            {
                Logger.WriteLog(TypeLog.ERROR, "Error: " + ex.Message, ex);
            }

            return Result;
        }
        public DataTable GetDieselUSD(float Factor, float PrecioDiesel, float TipoCambio, float KMCargado)
        {

            DataTable Result = new DataTable();
            string Query = string.Empty;
            try
            {
                Query = @"[Calcular_Diesel_USD] " + Factor + "," + PrecioDiesel+","+ KMCargado + ","+ TipoCambio;

                using (DBConnect DBConnection = new DBConnect())
                {
                    Result = DBConnection.ExecuteQuery(TypeDB.SQLServer, ConnectionStringSystem, Query);
                }

            }
            catch (Exception ex)
            {
                Logger.WriteLog(TypeLog.ERROR, "Error: " + ex.Message, ex);
            }

            return Result;
        }
        public DataTable GetCasetasUSD(float CasetasMXN, float TipoCambio)
        {

            DataTable Result = new DataTable();
            string Query = string.Empty;
            try
            {
                Query = @"[Calcular_Casetas_USD] " + CasetasMXN + "," + TipoCambio;

                using (DBConnect DBConnection = new DBConnect())
                {
                    Result = DBConnection.ExecuteQuery(TypeDB.SQLServer, ConnectionStringSystem, Query);
                }

            }
            catch (Exception ex)
            {
                Logger.WriteLog(TypeLog.ERROR, "Error: " + ex.Message, ex);
            }

            return Result;
        }
        public DataTable GetSueldoOpUSD(float KMCargado, float TipoCambio, float BasePagoOp,float IngresoUSD)
        {

            DataTable Result = new DataTable();
            string Query = string.Empty;
            try
            {
                Query = @"[Calcular_Sueldo_Op_USD] " + TipoCambio + "," + BasePagoOp + ","+ KMCargado + ","+ IngresoUSD;

                using (DBConnect DBConnection = new DBConnect())
                {
                    Result = DBConnection.ExecuteQuery(TypeDB.SQLServer, ConnectionStringSystem, Query);
                }

            }
            catch (Exception ex)
            {
                Logger.WriteLog(TypeLog.ERROR, "Error: " + ex.Message, ex);
            }

            return Result;
        }
        public DataTable GetGastoUSD(float DieselUSD, float CasetasUSD, float SueldoOpUSD)
        {

            DataTable Result = new DataTable();
            string Query = string.Empty;
            try
            {
                Query = @"[Calcular_Gasto_USD] " + DieselUSD + "," + CasetasUSD + "," + SueldoOpUSD;

                using (DBConnect DBConnection = new DBConnect())
                {
                    Result = DBConnection.ExecuteQuery(TypeDB.SQLServer, ConnectionStringSystem, Query);
                }

            }
            catch (Exception ex)
            {
                Logger.WriteLog(TypeLog.ERROR, "Error: " + ex.Message, ex);
            }

            return Result;
        }
        public DataTable GetUOPUSD(float IngresoUSD, float TotalGtoUSD)
        {

            DataTable Result = new DataTable();
            string Query = string.Empty;
            try
            {
                Query = @"[Calcular_UOP_USD] " + IngresoUSD + "," + TotalGtoUSD;

                using (DBConnect DBConnection = new DBConnect())
                {
                    Result = DBConnection.ExecuteQuery(TypeDB.SQLServer, ConnectionStringSystem, Query);
                }

            }
            catch (Exception ex)
            {
                Logger.WriteLog(TypeLog.ERROR, "Error: " + ex.Message, ex);
            }

            return Result;
        }
        public DataTable GetIngresoUSD(float PrecioKM, float KMCargado, float TipoCambio, float CuotaFija)
        {

            DataTable Result = new DataTable();
            string Query = string.Empty;
            try
            {
                Query = @"[Calcular_Ingreso_USD] " + PrecioKM + "," + KMCargado+","+ TipoCambio+","+ CuotaFija;

                using (DBConnect DBConnection = new DBConnect())
                {
                    Result = DBConnection.ExecuteQuery(TypeDB.SQLServer, ConnectionStringSystem, Query);
                }

            }
            catch (Exception ex)
            {
                Logger.WriteLog(TypeLog.ERROR, "Error: " + ex.Message, ex);
            }

            return Result;
        }
        public DataTable GetIngresoMXN(float TipoCambio, float Repartos, float PrecioKM, float KMRecorrer, float KMCargado, float Destino)
        {

            DataTable Result = new DataTable();
            string Query = string.Empty;
            try
            {
                Query = @"[Calcular_Ingresos_MX] " + TipoCambio + "," + Repartos + "," + PrecioKM + "," + KMRecorrer+","+ KMCargado+","+ Destino;

                using (DBConnect DBConnection = new DBConnect())
                {
                    Result = DBConnection.ExecuteQuery(TypeDB.SQLServer, ConnectionStringSystem, Query);
                }

            }
            catch (Exception ex)
            {
                Logger.WriteLog(TypeLog.ERROR, "Error: " + ex.Message, ex);
            }

            return Result;
        }
        public DataTable AltaCotizacion(int id_origen, int id_destino, int id_producto, string clave_cliente, string Nombre_Cliente, float km_dno_origen, float km_base_origen, float km_dno_base, int repartos, float precio_km, float km_cargado, int id_tipo_pago_op, float factor, float precio_diesel, float tipo_cambio, float casetas, string tipo_transporte, float km_vacio, float Km_recorrer, float Cuota_Fija, float ingresos_mx, float costo_diesel, float sueldo_op, float total_gasto_mx, float uop_mx, float uop_porcent, float Ingresos_usd, float Diesel_usd, float Casetas_usd, float Sueldo_Op_usd, float Total_Gto_usd, float UOP_usd, float uop_porcent_usd, float custodia, float custodiaUSD, float multimodal, float multimodalUSD)
        {

            DataTable Result = new DataTable();
            string Query = string.Empty;
            try
            {
                Query = @"[Alta_Cotizacion] " + id_origen+","+id_destino + "," + id_producto + "," + clave_cliente + ",'" + Nombre_Cliente + "'," + km_dno_origen + "," + km_base_origen + "," + km_dno_base + "," + repartos + "," + precio_km + "," + km_cargado + "," + id_tipo_pago_op + "," + factor + "," + precio_diesel + "," + tipo_cambio + "," + casetas + ",'" + tipo_transporte + "'," + km_vacio + "," + Km_recorrer + "," + Cuota_Fija + "," + ingresos_mx + "," + costo_diesel + "," + sueldo_op + "," + total_gasto_mx + "," + uop_mx + "," + uop_porcent + "," + Ingresos_usd + "," + Diesel_usd + "," + Casetas_usd + "," + Sueldo_Op_usd + "," + Total_Gto_usd + "," + UOP_usd + "," + uop_porcent_usd+","+custodia+","+custodiaUSD+","+multimodal+","+multimodalUSD;
                using (DBConnect DBConnection = new DBConnect())
                {
                    Result = DBConnection.ExecuteQuery(TypeDB.SQLServer, ConnectionStringSystem, Query);
                }

            }
            catch (Exception ex)
            {
                Logger.WriteLog(TypeLog.ERROR, "Error: " + ex.Message, ex);
            }

            return Result;
        }
        public DataTable EditarCotizacion(int id_cotizacion,int id_origen, int id_destino, int id_producto, string clave_cliente, string Nombre_Cliente, float km_dno_origen, float km_base_origen, float km_dno_base, int repartos, float precio_km, float km_cargado, int id_tipo_pago_op, float factor, float precio_diesel, float tipo_cambio, float casetas, string tipo_transporte, float km_vacio, float Km_recorrer, float Cuota_Fija, float ingresos_mx, float costo_diesel, float sueldo_op, float total_gasto_mx, float uop_mx, float uop_porcent, float Ingresos_usd, float Diesel_usd, float Casetas_usd, float Sueldo_Op_usd, float Total_Gto_usd, float UOP_usd, float uop_porcent_usd)
        {

            DataTable Result = new DataTable();
            string Query = string.Empty;
            try
            {
                Query = @"[Editar_Cotizacion] "+ id_cotizacion + "," +id_origen + "," + id_destino + "," + id_producto + "," + clave_cliente + ",'" + Nombre_Cliente + "'," + km_dno_origen + "," + km_base_origen + "," + km_dno_base + "," + repartos + "," + precio_km + "," + km_cargado + "," + id_tipo_pago_op + "," + factor + "," + precio_diesel + "," + tipo_cambio + "," + casetas + ",'" + tipo_transporte + "'," + km_vacio + "," + Km_recorrer + "," + Cuota_Fija + "," + ingresos_mx + "," + costo_diesel + "," + sueldo_op + "," + total_gasto_mx + "," + uop_mx + "," + uop_porcent + "," + Ingresos_usd + "," + Diesel_usd + "," + Casetas_usd + "," + Sueldo_Op_usd + "," + Total_Gto_usd + "," + UOP_usd + "," + uop_porcent_usd;

                using (DBConnect DBConnection = new DBConnect())
                {
                    Result = DBConnection.ExecuteQuery(TypeDB.SQLServer, ConnectionStringSystem, Query);
                }
            }
            catch (Exception ex)
            {
                Logger.WriteLog(TypeLog.ERROR, "Error: " + ex.Message, ex);
            }

            return Result;
        }
        public DataTable GetCotizacion(int num_cot)
        {

            DataTable Result = new DataTable();
            string Query = string.Empty;
            try
            {
                Query = @"[Listar_Cot_ID] " + num_cot;

                using (DBConnect DBConnection = new DBConnect())
                {
                    Result = DBConnection.ExecuteQuery(TypeDB.SQLServer, ConnectionStringSystem, Query);
                }

            }
            catch (Exception ex)
            {
                Logger.WriteLog(TypeLog.ERROR, "Error: " + ex.Message, ex);
            }

            return Result;
        }
        public DataTable GetInfoPDF(int num_cot)
        {

            DataTable Result = new DataTable();
            string Query = string.Empty;
            try
            {
                Query = @"[DatosPDF_Cot] " + num_cot;

                using (DBConnect DBConnection = new DBConnect())
                {
                    Result = DBConnection.ExecuteQuery(TypeDB.SQLServer, ConnectionStringSystem, Query);
                }

            }
            catch (Exception ex)
            {
                Logger.WriteLog(TypeLog.ERROR, "Error: " + ex.Message, ex);
            }

            return Result;
        }
        public DataTable CancelarCotizacion(int num_cot)
        {

            DataTable Result = new DataTable();
            string Query = string.Empty;
            try
            {
                Query = @"[CancelarCotizacion] " + num_cot;

                using (DBConnect DBConnection = new DBConnect())
                {
                    Result = DBConnection.ExecuteQuery(TypeDB.SQLServer, ConnectionStringSystem, Query);
                }

            }
            catch (Exception ex)
            {
                Logger.WriteLog(TypeLog.ERROR, "Error: " + ex.Message, ex);
            }

            return Result;
        }
        public DataTable AltaCliente(string nombre_cliente, string correo, string correoa, string celular, string telefono, string direccion)
        {

            DataTable Result = new DataTable();
            string Query = string.Empty;
            try
            {
                Query = @"[AltaCliente] '"+nombre_cliente+"','"+correo+"','"+correoa+"','"+celular+"','"+telefono+"','"+direccion+"'";

                using (DBConnect DBConnection = new DBConnect())
                {
                    Result = DBConnection.ExecuteQuery(TypeDB.SQLServer, ConnectionStringSystem, Query);
                }

            }
            catch (Exception ex)
            {
                Logger.WriteLog(TypeLog.ERROR, "Error: " + ex.Message, ex);
            }

            return Result;
        }
        #endregion
        #endregion

        public void Dispose()
        {
            if (_Instance != null)
                _Instance.Dispose();

            GC.Collect();
            GC.SuppressFinalize(this);
        }

        #endregion

      

       
    }
}