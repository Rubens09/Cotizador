<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/Views/Site.Master" CodeBehind="Cotizador.aspx.cs" Inherits="Portal.Views.Ventas.Cotizador" %>

<asp:Content runat="server" ID="ContentTitle" ContentPlaceHolderID="Title">COTIZADOR VENTA | GRUPO MEDRANO</asp:Content>

<asp:Content runat="server" ID="ContectPageLevelPluginsCSS" ContentPlaceHolderID="PageLevelPluginsCSS">
    <link href="/Scripts/DataTablesv2/DataTables-1.10.18/css/jquery.dataTables.min.css" rel="stylesheet" />
    <link href="/Scripts/DataTablesv2/datatables.min.css" rel="stylesheet" />
    <link href="/Scripts/DataTablesv2/Buttons-1.5.4/css/buttons.dataTables.min.css" rel="stylesheet" />
    <link href="/Scripts/DataTablesv2/Buttons-1.5.4/css/buttons.bootstrap.min.css" rel="stylesheet" />
    <link href="/Scripts/DataTablesv2/DataTables-1.10.18/css/dataTables.bootstrap.min.css" rel="stylesheet" />
    <link href="/Assets/global/plugins/select2/css/select2.min.css" rel="stylesheet" type="text/css" />
    <link href="/Assets/global/plugins/select2/css/select2-bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="/Assets/global/plugins/bootstrap-datepicker/css/bootstrap-datepicker3.min.css" rel="stylesheet" type="text/css" />
    <style>
    #mdialTamanio{
      width: 80% !important;
    }
  </style>
</asp:Content>

<asp:Content runat="server" ID="ContectPageLevelPluginsJS" ContentPlaceHolderID="PageLevelPluginsJS">
    <script src="/Scripts/DataTablesv2/datatables.min.js"></script>
    <script src="/Scripts/DataTablesv2/Buttons-1.5.4/js/buttons.print.min.js"></script>
    <script src="/Scripts/DataTablesv2/Buttons-1.5.4/js/buttons.html5.min.js"></script>
    <script src="/Scripts/DataTablesv2/Buttons-1.5.4/js/dataTables.buttons.min.js"></script>
    <script src="/Scripts/DataTablesv2/Buttons-1.5.4/js/buttons.bootstrap.min.js"></script>
    <script src="/Assets/global/plugins/select2/js/select2.full.min.js" type="text/javascript"></script>
    <script src="/Assets/global/plugins/bootstrap-datepicker/js/bootstrap-datepicker.min.js" type="text/javascript"></script>
</asp:Content>

<asp:Content runat="server" ID="ContectPageLevelScripts" ContentPlaceHolderID="PageLevelScripts">
    <script src="/Assets/pages/scripts/components-date-time-pickers.min.js" type="text/javascript"></script>
    <script src="/Assets/pages/scripts/components-select2.min.js" type="text/javascript"></script>
    <script src="/Assets/pages/scripts/Ventas/AjaxQueryVentas.js"></script>
    <script>window.onload = function () {
    CargaProducto();
    CargaTipoPagoOP();
    CargaOrigen();
        };</script>
</asp:Content>
<asp:Content runat="server" ID="ContectContentBody" ContentPlaceHolderID="ContentBody">
   <form class="form-horizontal">
        <div class="portlet light portlet-fit portlet-form bordered" id="Entradas_Portlet">
            <div class="portlet-title">
                <div class="caption">
                    <i class="fa fa-sign-in font-red"></i>
                    <span class="caption-subject font-red sbold uppercase">COTIZADOR</span>
                </div>
            </div>
            <div class="portlet-title">
                <div class="caption">
                    <input type="radio" id="cltnuevo" value="Nuevo" class="" name="ctl" onclick="CtlNuevo()" onchange="CtlNuevo()">
                    <label for="ctlnuevo">Cliente Nuevo</label>
                    <br />
                    <input type="radio" id="ctlexistente" value="Existente" class="" name="ctl" onclick="CtlExistente()" onchange="CtlExistente()" checked>
                    <label for="ctlexistente">Cliente Existente</label>
                </div>
                <div class=" col-md-13" id="CtlOpcion">
                 </div>
            </div>
            <table id='result'>
            </table>
            <div class="portlet-body">
                <div class="form-body" style="padding-top:0px;">
                    <div class="table-toolbar">
                        <div class="row">
                            <div class=" col-md-20">
                                <div class="form-group">
                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <div class="col-md-3">
                                                 <label class="control-label col-md-2">ORIGEN: </label>
                                                <div class="col-md-10">
                                                    <select id="Origen" class="form-control select2me ReloadDataTable" disabled>
                                                        <option value="">Select...</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="col-md-3 col-sm-12">
                                                <label class="control-label col-md-6">KM DNO-ORIGEN: </label>
                                                <div class="col-md-6">
                                                    <input type="number" id="KMDnoOrigen" class="form-control" step=".01" min="0" onchange="CalcularKmVacio()" readonly/>
                                                </div>
                                            </div>
                                            <div class="col-md-3">
                                                <label class="control-label col-md-6">PRECIO POR KM: </label>
                                                <div class="col-md-6" >
                                                    <input type="number" id="PrecioKM" class="form-control" step=".01" min="0" onchange="Calcular_Ingresos_MX()" readonly/>
                                                </div>
                                            </div>
                                            <div class="col-md-3">
                                                <label class="control-label col-md-6">TIPO PAGO OP:</label>
                                                <div class="col-md-6" >
                                                    <select id="TipoPagoOP" class="form-control select2me ReloadDataTable" onchange="ObtenereBasePagoOp()" disabled>
                                                        <option value="">Select...</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                   </div>
                                </div>
                                 <!-- Columna 2-->
                                <div class="form-group">
                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <div class="col-md-3">
                                                 <label class="control-label col-md-3">DESTINO: </label>
                                                <div class="col-md-9">
                                                    <select id="Destino" class="form-control select2me ReloadDataTable" onchange="CalcularCuotaFija()" disabled>
                                                        <option value="">Select...</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="col-md-3 col-sm-12">
                                                <label class="control-label col-md-6">KM BASE-ORIGEN: </label>
                                                <div class="col-md-6">
                                                        <input type="number" id="KMBaseOrigen" class="form-control" step=".01" min="0" onchange="CalcularKmVacio()" readonly/>
                                                </div>
                                            </div>
                                            <div class="col-md-3">
                                                <label class="control-label col-md-6">KM CARGADO: </label>
                                                <div class="col-md-6" >
                                                        <input type="number" id="KMCargado" class="form-control" step=".01" min="0" onchange="CalcularKmRecorrer()" readonly/>
                                                </div>
                                            </div>
                                            <div class="col-md-3">
                                                <label class="control-label col-md-6">BASE PAGO OP:</label>
                                                <div class="col-md-6" >
                                                    <input type="text" id="BasePagoOp" class="form-control" readonly onchange="Calcular_Sueldo_Op()" readonly/>
                                                </div>
                                            </div>
                                        </div>
                                   </div>
                                </div>
                                <!-- Columna 3-->
                                <div class="form-group">
                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <div class="col-md-3">
                                                 <label class="control-label col-md-4">PRODUCTO: </label>
                                                <div class="col-md-8">
                                                    <select id="Producto" class="form-control select2me ReloadDataTable" onchange="ObtenerTransporte()" disabled>
                                                        <option value="">Select...</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="col-md-3 col-sm-12">
                                                <label class="control-label col-md-6">KM DNO-BASE: </label>
                                                <div class="col-md-6">
                                                        <input type="number" id="KMDnoBase" class="form-control" step=".01" min="0" onchange="CalcularKmVacio()" readonly/>
                                                </div>
                                            </div>
                                            <div class="col-md-3">
                                                <label class="control-label col-md-6">KM VACIO: </label>
                                                <div class="col-md-6" >
                                                        <input type="number" id="KMVacio" class="form-control" step=".01" min="0" readonly onchange="CalcularKmRecorrer()" readonly/>
                                                </div>
                                            </div>
                                            <div class="col-md-3">
                                                <label class="control-label col-md-6">FACTOR:</label>
                                                <div class="col-md-6" >
                                                    <input type="number" id="Factor" class="form-control" value="2.7" lang="en-150" step=".1" min="0" onchange="Calcular_Diesel_Mx()" readonly/>
                                                </div>
                                            </div>
                                        </div>
                                   </div>
                                  </div>
                                    <!-- Columna 4-->
                                    <div class="form-group">
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <div class="col-md-3">
                                                     <label class="control-label col-md-4">TRANSPORTE: </label>
                                                    <div class="col-md-8">
                                                        <input type="text" id="Transporte" class="form-control" readonly>
                                                    </div>
                                                </div>
                                                <div class="col-md-3">
                                                    <label class="control-label col-md-6">REPARTOS: </label>
                                                    <div class="col-md-6">
                                                        <select id="Reparto" class="form-control" onchange="Calcular_Ingresos_MX()" disabled>
                                                            <option value="">Select...</option>
                                                            <option value="1">1</option>
                                                            <option value="2">2</option>
                                                            <option value="3">3</option>
                                                            <option value="4">4</option>
                                                            <option value="5">5</option>
                                                            <option value="6">6</option>
                                                            <option value="7">7</option>
                                                            <option value="8">8</option>
                                                            <option value="9">9</option>
                                                            <option value="10">10</option>
                                                            <option value="11">11</option>
                                                            <option value="12">12</option>
                                                            <option value="13">13</option>
                                                            <option value="14">14</option>
                                                            <option value="15">15</option>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="col-md-3">
                                                    <label class="control-label col-md-6">KM A RECORRER: </label>
                                                    <div class="col-md-6" >
                                                            <input type="number" id="KMRecorrer" class="form-control" step=".01" min="0" readonly onchange="GetDieselMx()" readonly/>
                                                    </div>
                                                </div>
                                                <div class="col-md-3">
                                                    <label class="control-label col-md-6">PRECIO DIESEL:</label>
                                                    <div class="col-md-6" >
                                                            <input type="number" id="PrecioDiesel" class="form-control" step=".01" min="0" onchange="Calcular_Diesel_Mx()" readonly/>
                                                    </div>
                                                </div>
                                            </div>
                                       </div>
                                    </div>
                                    <!-- Columna 4-->
                                    <div class="form-group">
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <div class="col-md-3">
                                                    <label class="control-label col-md-6"></label>
                                                    <div class="col-md-6">
                                                        <div class="caption">
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-3">
                                                    <label class="control-label col-md-6"></label>
                                                    <div class="col-md-6">
                                                        <div class="caption">
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-3">
                                                    <label class="control-label col-md-6">CUOTA FIJA: </label>
                                                    <div class="col-md-6" >
                                                        <input type="number" id="CuotaFija" class="form-control" value="0" readonly/>
                                                    </div>
                                                </div>
                                                <div class="col-md-3">
                                                    <label class="control-label col-md-6">TIPO DE CAMBIO:</label>
                                                    <div class="col-md-6" >
                                                        <input type="number" id="TipoCambio" class="form-control" step=".01" min="0" onchange="Calcular_Diesel_USD()" readonly/>
                                                    </div>
                                                </div>
                                            </div>
                                       </div>
                                    </div>
                                 <!-- Cotizador-->
                                    <div class="form-group">
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <div class="col-md-12">
                                                    <div class="col-md-3"></div>
                                                     <label class="control-label col-md-4">COTIZACIÓN</label>
                                                    <div class="col-md-4"></div>
                                                </div>
                                            </div>
                                       </div>
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <div class="col-md-9">
                                                    <div class="col-md-3"></div>
                                                    <div class="col-md-2"></div>
                                                    <div class="col-md-2">
                                                        <div class="col-md-3"></div>
                                                        <label class="control-label col-md-1" style=" vertical-align:baseline;">MXN</label>
                                                    </div>
                                                    <div class="col-md-2"></div>
                                                    <div class="col-md-3">
                                                        <div class="col-md-3"></div>
                                                        <div class="col-md-2"></div>
                                                        <div class="col-md-3"></div>
                                                        <label class="control-label col-md-1" style=" vertical-align:baseline;">USD</label>
                                                    </div>
                                                </div>
                                            </div>
                                       </div>
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <div class="col-md-12">
                                                    <label class="control-label col-md-3">Custodia</label>
                                                     <div class="col-md-3">
                                                        <input id="CustodiaMXN" class="form-control" type="text" value="" readonly/> 
                                                    </div>
                                                    <div class="col-md-1"></div>
                                                    <div class="col-md-3">
                                                        <input id="CustodiaUSD" class="form-control" type="text" value="" readonly/> 
                                                    </div>
                                                </div>
                                            </div>
                                       </div>
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <div class="col-md-12">
                                                    <label class="control-label col-md-3">Multimodal</label>
                                                     <div class="col-md-3">
                                                        <input id="MultimodalMXN" class="form-control" type="text" value="" readonly/> 
                                                    </div>
                                                    <div class="col-md-1"></div>
                                                    <div class="col-md-3">
                                                        <input id="MultimodalUSD" class="form-control" type="text" value="" readonly/> 
                                                    </div>
                                                </div>
                                            </div>
                                       </div>
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <div class="col-md-12">
                                                    <label class="control-label col-md-3">INGRESOS</label>
                                                     <div class="col-md-3">
                                                        <input id="IngresoMXN" class="form-control" type="text" value="" readonly/> 
                                                    </div>
                                                    <div class="col-md-1"></div>
                                                    <div class="col-md-3">
                                                        <input id="IngresoUSD" class="form-control" type="text" value="" readonly/> 
                                                    </div>
                                                </div>
                                            </div>
                                       </div>
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <div class="col-md-12">
                                                    <label class="control-label col-md-3">DIESEL</label>
                                                     <div class="col-md-3">
                                                        <input id="DieselMXN" class="form-control" type="text" value="" readonly/> 
                                                    </div>
                                                    <div class="col-md-1"></div>
                                                    <div class="col-md-3">
                                                        <input id="DieselUSD" class="form-control" type="text" value="" readonly/> 
                                                    </div>
                                                </div>
                                            </div>
                                       </div>
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <div class="col-md-12">
                                                    <label class="control-label col-md-3">CASETAS</label>
                                                     <div class="col-md-3">
                                                        <input id="CasetasMXN" class="form-control" type="text" value="" onchange="Calcular_Total_Gto()" readonly/> 
                                                    </div>
                                                    <div class="col-md-1"></div>
                                                    <div class="col-md-3">
                                                        <input id="CasetasUSD" class="form-control" type="text" value="" readonly/> 
                                                    </div>
                                                </div>
                                            </div>
                                       </div>
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <div class="col-md-12">
                                                    <label class="control-label col-md-3">SUELDO OP</label>
                                                     <div class="col-md-3">
                                                        <input id="SueldoOpMXN" class="form-control" type="text" value="" readonly/> 
                                                    </div>
                                                    <div class="col-md-1"></div>
                                                    <div class="col-md-3">
                                                        <input id="SueldoOpUSD" class="form-control" type="text" value="" readonly/> 
                                                    </div>
                                                </div>
                                            </div>
                                       </div>
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <div class="col-md-12">
                                                    <label class="control-label col-md-3">TOTAL  GTO</label>
                                                     <div class="col-md-3">
                                                        <input id="TotalGtoMXN" class="form-control" type="text" value="" readonly/> 
                                                    </div>
                                                    <div class="col-md-1"></div>
                                                    <div class="col-md-3">
                                                        <input id="TotalGtoUSD" class="form-control" type="text" value="" readonly/> 
                                                    </div>
                                                </div>
                                            </div>
                                       </div>
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <div class="col-md-12">
                                                    <label class="control-label col-md-3">UOP</label>
                                                     <div class="col-md-3">
                                                        <input id="UOPMXN" class="form-control" type="text" value="" readonly/> 
                                                    </div>
                                                    <div class="col-md-1"></div>
                                                    <div class="col-md-3">
                                                        <input id="UOPUSD" class="form-control" type="text" value="" readonly/> 
                                                    </div>
                                                </div>
                                            </div>
                                       </div>
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <div class="col-md-12">
                                                    <label class="control-label col-md-3">% UOP</label>
                                                     <div class="col-md-3">
                                                        <input id="UOPPMXN" class="form-control" type="text" value="" readonly/> 
                                                    </div>
                                                    <div class="col-md-1"></div>
                                                    <div class="col-md-3">
                                                        <input id="UOPPUSD" class="form-control" type="text" value="" readonly/> 
                                                    </div>
                                                </div>
                                            </div>
                                       </div>
                                        <div class="col-md-12" id="MostrarPDF">
                                       </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        <!-- END PORTLET -->
        <!-- END PAGE BASE CONTENT -->
    </form>
</asp:Content>
