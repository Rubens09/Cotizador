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
                  </div >
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
                                                 <label class="control-label col-md-3">ORIGEN: </label>
                                                <div class="col-md-9">
                                                    <select id="Origen" class="form-control select2me ReloadDataTable" onchange="">
                                                        <option value="">Select...</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="col-md-3 col-sm-12">
                                                <label class="control-label col-md-6">KM DNO-ORIGEN: </label>
                                                <div class="col-md-6">
                                                    <input type="number" id="KMDnoOrigen" class="form-control" step=".01" min="0" onchange="CalcularKmVacio()" value="0"/>
                                                </div>
                                            </div>
                                            <div class="col-md-3">
                                                <label class="control-label col-md-6">PRECIO POR KM: </label>
                                                <div class="col-md-6" >
                                                    <input type="number" id="PrecioKM" class="form-control" step=".01" min="0" onchange="Calcular_Ingresos_MX()" value="0"/>
                                                </div>
                                            </div>
                                            <div class="col-md-3">
                                                <label class="control-label col-md-6">TIPO PAGO OP:</label>
                                                <div class="col-md-6" >
                                                    <select id="TipoPagoOP" class="form-control select2me ReloadDataTable" onchange="ObtenereBasePagoOp()">
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
                                                    <select id="Destino" class="form-control select2me ReloadDataTable" onchange="CalcularCuotaFija()">
                                                        <option value="">Select...</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="col-md-3 col-sm-12">
                                                <label class="control-label col-md-6">KM BASE-ORIGEN: </label>
                                                <div class="col-md-6">
                                                        <input type="number" id="KMBaseOrigen" class="form-control" step=".01" min="0" onchange="CalcularKmVacio()" value="0"/>
                                                </div>
                                            </div>
                                            <div class="col-md-3">
                                                <label class="control-label col-md-6">KM CARGADO: </label>
                                                <div class="col-md-6" >
                                                        <input type="number" id="KMCargado" class="form-control" step=".01" min="0" onchange="CalcularKmRecorrer()" value="0"/>
                                                </div>
                                            </div>
                                            <div class="col-md-3">
                                                <label class="control-label col-md-6">BASE PAGO OP:</label>
                                                <div class="col-md-6" >
                                                    <input type="text" id="BasePagoOp" class="form-control" readonly onchange="Calcular_Sueldo_Op()" />
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
                                                    <select id="Producto" class="form-control select2me ReloadDataTable" onchange="ObtenerTransporte()">
                                                        <option value="">Select...</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="col-md-3 col-sm-12">
                                                <label class="control-label col-md-6">KM DNO-BASE: </label>
                                                <div class="col-md-6">
                                                        <input type="number" id="KMDnoBase" class="form-control" step=".01" min="0" onchange="CalcularKmVacio()" value="0"/>
                                                </div>
                                            </div>
                                            <div class="col-md-3">
                                                <label class="control-label col-md-6">KM VACIO: </label>
                                                <div class="col-md-6" >
                                                        <input type="number" id="KMVacio" class="form-control" step=".01" min="0" readonly onchange="CalcularKmRecorrer()"/>
                                                </div>
                                            </div>
                                            <div class="col-md-3">
                                                <label class="control-label col-md-6">FACTOR:</label>
                                                <div class="col-md-6" >
                                                    <input type="number" id="Factor" class="form-control" value="2.7" lang="en-150" step=".1" min="0" onchange="Calcular_Diesel_Mx()"/>
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
                                                        <select id="Reparto" class="form-control" onchange="Calcular_Ingresos_MX()">
                                                            <option value="0">0</option>
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
                                                            <input type="number" id="KMRecorrer" class="form-control" step=".01" min="0" readonly onchange="GetDieselMx()"/>
                                                    </div>
                                                </div>
                                                <div class="col-md-3">
                                                    <label class="control-label col-md-6">PRECIO DIESEL:</label>
                                                    <div class="col-md-6" >
                                                            <input type="number" id="PrecioDiesel" class="form-control" step=".01" min="0" onchange="Calcular_Diesel_Mx()" value="0"/>
                                                    </div>
                                                </div>
                                            </div>
                                       </div>
                                    </div>
                                    <!-- Columna 5-->
                                    <div class="form-group">
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <div class="col-md-3">
                                                    <label class="control-label col-md-6"></label>
                                                    <div class="col-md-6">
                                                        <div class="caption">
                                                            <!--<input type="radio" id="CustodiaSi" value="Si" class="" name="custodia" onclick="">
                                                            <label for="ctlnuevo">Si</label>
                                                            <br />
                                                            <input type="radio" id="CustodiaNo" value="No" class="" name="custodia" onclick="" checked>
                                                            <label for="ctlexistente">No</label>-->
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-3">
                                                    <label class="control-label col-md-6"></label>
                                                    <div class="col-md-6">
                                                        <div class="caption">
                                                            <!--<input type="radio" id="MultimodalSi" value="Si" class="" name="multimodal" onclick="">
                                                            <label for="ctlnuevo">Si</label>
                                                            <br />
                                                            <input type="radio" id="MultimodalNo" value="No" class="" name="multimodal" onclick="" checked>
                                                            <label for="ctlexistente">No</label>-->
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
                                                        <input type="number" id="TipoCambio" class="form-control" step=".0001" min="0" onchange="Calcular_Diesel_USD()"/>
                                                    </div>
                                                </div>
                                            </div>
                                       </div>
                                    </div>
                                    <!-- Columna 6-->
                                    <div class="form-group">
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <div class="col-md-3">
                                                    <div class="col-md-9">
                                                        <a href="#" class="form-control btn red" type="button" id="" data-toggle="modal" data-target="" style="width:70px;height:50px;display: inline;margin-right:1em;" onclick="GenerarMapeo()">Generar Cotizaciones de Ruta</a>
                                                    </div>
                                                </div>
                                                <div class="col-md-3">
                                                    <div class="col-md-6">
                                                    </div>
                                                </div>
                                                <div class="col-md-3">
                                                </div>
                                                <div class="col-md-3">
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
                                                        <input id="CustodiaMXN" class="form-control" type="number" value="0" min="0" onchange="CalcularCustodiaUSD()" required/> 
                                                    </div>
                                                    <div class="col-md-1"></div>
                                                    <div class="col-md-3">
                                                        <input id="CustodiaUSD" class="form-control" type="number" value="" readonly required/> 
                                                    </div>
                                                </div>
                                            </div>
                                       </div>
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <div class="col-md-12">
                                                    <label class="control-label col-md-3">Multimodal</label>
                                                     <div class="col-md-3">
                                                        <input id="MultimodalMXN" class="form-control" type="number" value="0" min="0" onchange="CalcularModalUSD()" required/> 
                                                    </div>
                                                    <div class="col-md-1"></div>
                                                    <div class="col-md-3">
                                                        <input id="MultimodalUSD" class="form-control" type="number" readonly required/> 
                                                    </div>
                                                </div>
                                            </div>
                                       </div>
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <div class="col-md-12">
                                                    <label class="control-label col-md-3">INGRESOS</label>
                                                     <div class="col-md-3">
                                                        <input id="IngresoMXN" class="form-control" type="text" value="" readonly required/> 
                                                    </div>
                                                    <div class="col-md-1"></div>
                                                    <div class="col-md-3">
                                                        <input id="IngresoUSD" class="form-control" type="text" value="" readonly required/> 
                                                    </div>
                                                </div>
                                            </div>
                                       </div>
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <div class="col-md-12">
                                                    <label class="control-label col-md-3">DIESEL</label>
                                                     <div class="col-md-3">
                                                        <input id="DieselMXN" class="form-control" type="text" value="" readonly required/> 
                                                    </div>
                                                    <div class="col-md-1"></div>
                                                    <div class="col-md-3">
                                                        <input id="DieselUSD" class="form-control" type="text" value="" readonly required/> 
                                                    </div>
                                                </div>
                                            </div>
                                       </div>
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <div class="col-md-12">
                                                    <label class="control-label col-md-3">CASETAS</label>
                                                     <div class="col-md-3">
                                                        <input id="CasetasMXN" class="form-control" type="number" value="0" min="0" onchange="Calcular_Total_Gto()" required/> 
                                                    </div>
                                                    <div class="col-md-1"></div>
                                                    <div class="col-md-3">
                                                        <input id="CasetasUSD" class="form-control" type="number" value="" readonly required/> 
                                                    </div>
                                                </div>
                                            </div>
                                       </div>
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <div class="col-md-12">
                                                    <label class="control-label col-md-3">SUELDO OP</label>
                                                     <div class="col-md-3">
                                                        <input id="SueldoOpMXN" class="form-control" type="text" value="" readonly required/> 
                                                    </div>
                                                    <div class="col-md-1"></div>
                                                    <div class="col-md-3">
                                                        <input id="SueldoOpUSD" class="form-control" type="text" value="" readonly required/> 
                                                    </div>
                                                </div>
                                            </div>
                                       </div>
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <div class="col-md-12">
                                                    <label class="control-label col-md-3">TOTAL  GTO</label>
                                                     <div class="col-md-3">
                                                        <input id="TotalGtoMXN" class="form-control" type="text" value="" readonly required/> 
                                                    </div>
                                                    <div class="col-md-1"></div>
                                                    <div class="col-md-3">
                                                        <input id="TotalGtoUSD" class="form-control" type="text" value="" readonly required/> 
                                                    </div>
                                                </div>
                                            </div>
                                       </div>
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <div class="col-md-12">
                                                    <label class="control-label col-md-3">UOP</label>
                                                     <div class="col-md-3">
                                                        <input id="UOPMXN" class="form-control" type="text" value="" readonly required/> 
                                                    </div>
                                                    <div class="col-md-1"></div>
                                                    <div class="col-md-3">
                                                        <input id="UOPUSD" class="form-control" type="text" value="" readonly required/> 
                                                    </div>
                                                </div>
                                            </div>
                                       </div>
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <div class="col-md-12">
                                                    <label class="control-label col-md-3">% UOP</label>
                                                     <div class="col-md-3">
                                                        <input id="UOPPMXN" class="form-control" type="text" value="" readonly required/> 
                                                    </div>
                                                    <div class="col-md-1"></div>
                                                    <div class="col-md-3">
                                                        <input id="UOPPUSD" class="form-control" type="text" value="" readonly required/> 
                                                    </div>
                                                </div>
                                            </div>
                                       </div>
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <div class="col-md-12">
                                                    <label class="control-label col-md-3"></label>
                                                     <div class="col-md-3">
                                                        <input id="GuardarCotizacion" class="form-control" type="button" value="Guardar Cotizacion" onclick="Alta_Cotizacion()"> 
                                                    </div>
                                                    <div class="col-md-1"></div>
                                                    <div class="col-md-3">
                                                        <input id="limpiar" class="form-control" type="reset" value="Limpiar"> 
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
                <%-- Inicio --%>
                <div class="modal fade bs-example-modal-lg" id="mymodal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-lg modal-dialog-centered">
					    <div class="modal-content">
						    <div class="modal-header">
							    <h4 class="modal-title" id="myLargeModalLabel">Cotización a Detalle</h4>
								<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
							</div>
							<div class="modal-body" style="font-size:15px;">
                                <label>Selecciona la cotización para copiar sus valores</label>
								<div class="caption">
                                    <input type="radio" id="optima" value="optima" class="" name="ruta" style="margin-left:1em;">
                                    <label for="ctlnuevo" style="margin-right:1em;">Ruta Optima</label>
                                    <input type="radio" id="libre" value="libre" class="" name="ruta">
                                    <label for="ctlexistente" style="margin-right:1em;">Ruta Libre</label>
                                </div>
                                <br />
                                    <details style="line-height:1.5;display: inline;">
                                        <summary class="nuevo">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrows-expand" viewBox="0 0 16 16" style="display: inline;margin-right:1em;line-height:1.5;">
                                            <path fill-rule="evenodd" d="M1 8a.5.5 0 0 1 .5-.5h13a.5.5 0 0 1 0 1h-13A.5.5 0 0 1 1 8zM7.646.146a.5.5 0 0 1 .708 0l2 2a.5.5 0 0 1-.708.708L8.5 1.707V5.5a.5.5 0 0 1-1 0V1.707L6.354 2.854a.5.5 0 1 1-.708-.708l2-2zM8 10a.5.5 0 0 1 .5.5v3.793l1.146-1.147a.5.5 0 0 1 .708.708l-2 2a.5.5 0 0 1-.708 0l-2-2a.5.5 0 0 1 .708-.708L7.5 14.293V10.5A.5.5 0 0 1 8 10z"/>
                                            </svg>Resumen Ruta Optima
                                        </summary>
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <div class="col-md-12">
                                                     <div class="col-md-4">
                                                         <center><label>Listado Casetas</label></center>
                                                        <div id="RutaOptima"></div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <center><label>Factores</label></center>
                                                        <table class='stripe hover nowrap' border='1' style='text-align: center; font-weight: 700; font-size: 12px;'>
                                                            <thead>
                                                                <!-- style='background:#FF5353;' -->
                                                                <tr>
                                                                    <td></td>
                                                                    <td></td>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <tr style="line-height:normal;">
                                                                    <td style="background:#FF5353;">Precio Diesel</td>
                                                                    <td><input type="number" style="border:1px;text-align:center;" align="center" id="PrecioDieselC" onchange="CalcularCombustible()"/></td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="background:#FF5353;">Rendimiento</td>
                                                                    <td><input type="number" value="2" style="border:1px;text-align:center;" align="center" id="Rendimiento" onchange="CalcularCombustible()"/></td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <center><label>Datos</label></center>
                                                        <table class='stripe hover nowrap' border='1' style='text-align: center; font-weight: 700; font-size: 12px;'>
                                                            <tbody>
                                                                <tr style="line-height:normal;">
                                                                    <td style="background:#FF5353;">Distancia</td>
                                                                    <td><input type="number" id="Distancia" readonly style="border:1px;text-align:center;"/></td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="background:#FF5353;">Tiempo</td>
                                                                    <td><input type="number" id="Tiempo" readonly style="border:1px;text-align:center;"/></td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="background:#FF5353;">Casetas</td>
                                                                    <td><input type="number" id="Casetas" readonly style="border:1px;text-align:center;"/></td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                        <center><label>Costos</label></center>
                                                        <table class='stripe hover nowrap' border='1' style='text-align: center; font-weight: 700; font-size: 12px;'>
                                                            <tbody>
                                                                <tr>
                                                                    <td style="background:#FF5353;">Combustible</td>
                                                                    <td><input type="number" id="Combustible" readonly style="border:1px;text-align:center;"/></td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="background:#FF5353;">Costo Total</td>
                                                                    <td><input type="number" id="CostoTotal" readonly style="border:1px;text-align:center;"/></td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div id="CuotaFijaO"></div>
                                                    </div>
                                                </div>
                                            </div>
                                       </div>
                                    </details>
                                    <label style="color:grey;margin-left:1em;">   Costo Total: </label><label id="MostrarCostoOptima" style="margin-right:1em;"></label>
                                    <label style="color:grey;margin-left:1em;">   Tiempo: </label><label id="MostrarTiempoOptima" style="margin-right:1em;"></label>
                                    <label style="color:grey;margin-left:1em;">   Casetas: </label><label id="MostrarCasetasOptima" style="margin-right:1em;"></label>
                                    <label style="color:grey;margin-left:1em;">   Distancia: </label><label id="MostrarDistanciaOptima" style="margin-right:1em;"></label>
                                    <br />
                                    <details style="line-height:1.5;display: inline;">
                                        <summary class="nuevo">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrows-expand" viewBox="0 0 16 16" style="display: inline;margin-right:1em;line-height:1.5;">
                                            <path fill-rule="evenodd" d="M1 8a.5.5 0 0 1 .5-.5h13a.5.5 0 0 1 0 1h-13A.5.5 0 0 1 1 8zM7.646.146a.5.5 0 0 1 .708 0l2 2a.5.5 0 0 1-.708.708L8.5 1.707V5.5a.5.5 0 0 1-1 0V1.707L6.354 2.854a.5.5 0 1 1-.708-.708l2-2zM8 10a.5.5 0 0 1 .5.5v3.793l1.146-1.147a.5.5 0 0 1 .708.708l-2 2a.5.5 0 0 1-.708 0l-2-2a.5.5 0 0 1 .708-.708L7.5 14.293V10.5A.5.5 0 0 1 8 10z"/>
                                            </svg>Resumen Ruta Libre
                                        </summary>
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <div class="col-md-12">
                                                     <div class="col-md-4">
                                                         <center><label>Listado Casetas</label></center>
                                                        <div id="RutaLibre"></div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <center><label>Factores</label></center>
                                                        <table class='stripe hover nowrap' border='1' style='text-align: center; font-weight: 700; font-size: 12px;'>
                                                            <thead>
                                                                <!-- style='background:#FF5353;' -->
                                                                <tr>
                                                                    <td></td>
                                                                    <td></td>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <tr style="line-height:normal;">
                                                                    <td style="background:#FF5353;">Precio Diesel</td>
                                                                    <td><input type="number" style="border:1px;text-align:center;" align="center" id="PrecioDieselL" onchange="CalcularCombustibleL()"/></td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="background:#FF5353;">Rendimiento</td>
                                                                    <td><input type="number" value="2" style="border:1px;text-align:center;" align="center" id="RendimientoL" onchange="CalcularCombustibleL()"/></td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <center><label>Datos</label></center>
                                                        <table class='stripe hover nowrap' border='1' style='text-align: center; font-weight: 700; font-size: 12px;'>
                                                            <tbody>
                                                                <tr style="line-height:normal;">
                                                                    <td style="background:#FF5353;">Distancia</td>
                                                                    <td><input type="number" id="DistanciaL" readonly style="border:1px;text-align:center;"/></td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="background:#FF5353;">Tiempo</td>
                                                                    <td><input type="number" id="TiempoL" readonly style="border:1px;text-align:center;"/></td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="background:#FF5353;">Casetas</td>
                                                                    <td><input type="number" id="CasetasL" readonly style="border:1px;text-align:center;"/></td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                        <center><label>Costos</label></center>
                                                        <table class='stripe hover nowrap' border='1' style='text-align: center; font-weight: 700; font-size: 12px;'>
                                                            <tbody>
                                                                <tr>
                                                                    <td style="background:#FF5353;">Combustible</td>
                                                                    <td><input type="number" id="CombustibleL" readonly style="border:1px;text-align:center;"/></td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="background:#FF5353;">Costo Total</td>
                                                                    <td><input type="number" id="CostoTotalL" readonly style="border:1px;text-align:center;"/></td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div id="CuotaFijaL"></div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </details>
                                    <label style="color:grey;margin-left:2em;">   Costo Total: </label><label id="MostrarCostoLibre" style="margin-right:1em;"></label>
                                    <label style="color:grey;margin-left:1em;">   Tiempo: </label><label id="MostrarTiempoLibre" style="margin-right:1em;"></label>
                                    <label style="color:grey;margin-left:1em;">   Casetas: </label><label id="MostrarCasetasLibre" style="margin-right:1em;"></label>
                                    <label style="color:grey;margin-left:1em;">   Distancia: </label><label id="MostrarDistanciaLibre" style="margin-right:1em;"></label>
                                    <br />
							</div>
							<div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                                <a href="#" class="form-control btn red" type="button" id="" style="width:70px;height:50px;display: inline;margin-right:1em;" onclick="CopiarCotizacion()"  data-dismiss="modal">Aceptar</a>
							</div>
						</div>
					</div>
				</div>
                <%-- Fin --%>
                </div>
            </div>
        <!-- END PORTLET -->
        <!-- END PAGE BASE CONTENT -->
    </form>
</asp:Content>
