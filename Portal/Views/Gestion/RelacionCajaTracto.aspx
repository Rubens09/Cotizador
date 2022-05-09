<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Views/Site.Master" CodeBehind="RelacionCajaTracto.aspx.cs" Inherits="Portal.Views.Gestion.RelacionCajaTracto" %>

<asp:Content runat="server" ID="ContentTitle" ContentPlaceHolderID="Title">RELACION TRACTO CAJA | SOLUGLOB IKON</asp:Content>

<asp:Content runat="server" ID="ContectPageLevelPluginsCSS" ContentPlaceHolderID="PageLevelPluginsCSS">
    <link href="/Scripts/DataTablesv2/DataTables-1.10.18/css/jquery.dataTables.min.css" rel="stylesheet" />
    <link href="/Scripts/DataTablesv2/datatables.min.css" rel="stylesheet" />
    <link href="/Scripts/DataTablesv2/Buttons-1.5.4/css/buttons.dataTables.min.css" rel="stylesheet" />
    <link href="/Scripts/DataTablesv2/Buttons-1.5.4/css/buttons.bootstrap.min.css" rel="stylesheet" />
    <link href="/Scripts/DataTablesv2/DataTables-1.10.18/css/dataTables.bootstrap.min.css" rel="stylesheet" />
    <link href="/Assets/global/plugins/select2/css/select2.min.css" rel="stylesheet" type="text/css" />
    <link href="/Assets/global/plugins/select2/css/select2-bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="/Assets/global/plugins/bootstrap-datepicker/css/bootstrap-datepicker3.min.css" rel="stylesheet" type="text/css" />
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
    <%--<script src="/Assets/pages/scripts/AjaxQuerys.min.js" type="text/javascript"></script>--%>
    <%--<script src="/Assets/pages/scripts/Modulos/Modulos.js"></script>--%>
    <script src="/Assets/pages/scripts/Gestion/AjaxRelacion.js"></script>
    <script>
        window.onload = function () {
            CargaSelect("GetRegionRelacion", $("#RelacionRegionId"));
            CargaSelect("GetTipoCajaDisponible", $("#RelacionTipoCajaId"));
            CargaSelect("GetTamanioCajaDisponible", $("#RelacionMedidaCajaId"));
        }
    </script>
</asp:Content>

<asp:Content runat="server" ID="ContectContentBody" ContentPlaceHolderID="ContentBody">
   <form class="form-horizontal">
        <!-- BEGIN PAGE BASE CONTENT -->
        <!-- BEGIN PORTLET -->
        <div class="portlet light portlet-fit portlet-form bordered" id="Entradas_Portlet">
            <div class="portlet-title">
                <div class="caption">
                    <i class="fa fa-sign-in font-green"></i>
                    <span class="caption-subject font-green sbold uppercase">RELACION TRACTO x CAJA </span>
                </div>
            </div>
            <div class="portlet-body">
                <div class="form-body" style="padding-top:0px;">
                    <div class="table-toolbar">
                        <div class="row">
                            <div class="form-group">
                                  <div class="col-md-4">
                                <label class="control-label col-md-2">C. PORTE:</label>
                                  <div class="col-md-10">
                                       <input id="CartaPorteTxt" class="form-control placeholder-no-fix" type="text" autocomplete="off" placeholder="Carta Porte" name="CartaPorteTxt" readonly/>
                                    </div>
                                 
                            </div>
                            </div>
                            <div class="form-group">
                                <div class="col-md-4">
                                <label class="control-label col-md-2">REGION:</label>
                                  <div class="col-md-10">
                                        <select id="RelacionRegionId" class="form-control select2me" onchange="EnvioSelectsRegion();">
                                            <option value="">Select...</option>
                                    </select>
                                    </div>
                            </div>

                                  <div class="col-md-4">
                                 <label class="control-label col-md-2">CLIENTE:</label>
                               
                                  <div class="col-md-10">
                                        <select id="RelacionClienteId" class="form-control select2me" onchange="EnvioSelects();">
                                            <option value="">Select...</option>
                                    </select>
                                    </div>
                                 
                            </div>
                            <div class="col-md-4">
                                <label class="control-label col-md-2">TIP. CAJA:</label>
                                  <div class="col-md-10">
                                        <select id="RelacionTipoCajaId" class="form-control select2me" onchange="EnvioSelects();">
                                            <option value="">Select...</option>
                                    </select>
                                    </div>
                            </div>
                            </div>
                            
                            <div class="from-group">
                                 <div class="col-md-4">
                                <label class="control-label col-md-2">TRACTO:</label>
                                  <div class="col-md-10">
                                        <select id="RelacionTractoId" class="form-control select2me">
                                            <option value="">Select...</option>
                                    </select>
                                    </div>
                                 
                            </div>
                            <div class="col-md-4">
                                <label class="control-label col-md-2">CAJA:</label>
                                  <div class="col-md-10">
                                        <select id="RelacionCajaId" class="form-control select2me" >
                                            <option value="">Select...</option>
                                    </select>
                                    </div>
                                
                            </div>
                            <div class="col-md-4">
                                <label class="control-label col-md-2">OPERADOR:</label>
                                  <div class="col-md-10">
                                        <select id="RelacionOperadorId" class="form-control select2me" >
                                            <option value="">Select...</option>
                                    </select>
                                    </div>
                                
                            </div>

                            </div>
                            
                            <br />
                            <br />
                             <div class="from-group">
                                <div class="col-md-4">
                                    <label class="control-label col-md-3">ORIGEN RUTA:</label>
                                    
                                <div class="col-md-9">
                                     <select id="RelacionOrigenRutaId" class="form-control select2me" onchange="EnvioSelectsRutas('Destino');">
                                            <option value="">Select...</option>
                                    </select>
                                    </div>
                                </div>

                                <div class="col-md-4">
                                    <label class="control-label col-md-3">DESTINO RUTA:</label>
                                    <div class="col-md-9">
                                        <select id="RelacionDestinoRutaId" class="form-control select2me" onchange="EnvioSelectsRutas('Ruta');">
                                                <option value="">Select...</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="col-md-4" >
                                    <label class="control-label col-md-3">RUTA:</label>
                                    <div class="col-md-9">
                                        <select id="RelacionRutaId" class="form-control select2me">
                                                <option value="">Select...</option>
                                        </select>
                                    </div>
                                 </div>
                               
                            </div>

                            <br />
                            <br />

                            <div class="from-group">
                                <div class="col-md-3">
                                    <label class="control-label col-md-3">ORIGEN CP:</label>
                                    
                                <div class="col-md-9">
                                     <select id="RelacionOrigenId" class="form-control select2me">
                                            <option value="">Select...</option>
                                    </select>
                                    </div>
                                </div>

                                <div class="col-md-3">
                                    <label class="control-label col-md-3">DESTINO CP:</label>
                                    <div class="col-md-9">
                                        <select id="RelacionDestinoId" class="form-control select2me">
                                                <option value="">Select...</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="col-md-3">
                                <label class="control-label col-md-3">FECHA:</label>
                                <div class="col-md-9">
                                    <div id="dpRange" class="input-group date-picker input-daterange" data-date-format="dd/mm/yyyy">
                                 <input type="text" id="dprSalida" class="form-control" name="dprSalida" value="<%= DateTime.Now.ToString("dd/MM/yyyy") %>">
                                   </div>
                                </div>
                            </div>

                                <div class="col-md-3">
                                
                                 </div>
                               
                            </div>
                            <br />
                            <br />
                                <div class="from-group">

                                <div class="col-md-2">
                                    <label class="control-label col-md-2">CLAVE:</label>
                                     <div class="col-md-10">
                                        <select id="ClaveServId" class="form-control select2me" onchange="EmparejamientoSelects(1);">
                                                <option value="">Select...</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="col-md-2">
                                    <label class="control-label col-md-2">SERV.:</label>
                                    <div class="col-md-10">
                                    <select id="ServicioId" class="form-control select2me" onchange="EmparejamientoSelects(2);">
                                                <option value="">Select...</option>
                                        </select>
                                        </div>
                                </div>

                                <div class="col-md-2">
                                    <label class="control-label col-md-2">CANT.:</label>
                                     <div class="col-md-10">
                                        <input type="number" id="txtCantidad" class="form-control" name="txtCantidad" value="1">
                                    </div>
                                </div>
                                
                                    <div class="col-md-2">
                                  <label class="control-label col-md-2">PRECIO.:</label>
                                 <div class="col-md-10">
                                    <input type="number" id="txtPrecio" class="form-control" name="txtPrecio" readonly>
                                     <input type="hidden" id="txtMoneda" class="form-control" name="txtMoneda">
                                  </div>
                                </div>

                                <div class="col-md-2">
                                <button type="button" class="btn  btn-secondary pull-center" id="btnAgregarItem" name="btnAgregarItem" onclick="AgregaCargaDetalle();">Agregar Articulo</button>
                                </div>

                                 <div class="col-md-2">
                                <button type="button" class="btn btn-success pull-center" id="BtnGuardarRelacion" name="BtnGuardarRelacion" onclick="CargaRelacion();">Crear Relacion</button>
                                </div>

                            </div>
                            



                            <br />
                            <br />
                             <div class="from-group">
                                 <div class="col-md-8">
                                     <table id="TableServicios" class="table table-striped table-bordered table-hover">
                                        <thead>
                                            <tr>
                                                <th style="width:20%; text-align: center; vertical-align:middle">CLAVE</th>
                                                <th style="width:30%; text-align: center; vertical-align:middle">DESCRIPCION</th>
                                                <th style="width:25%; text-align: center; vertical-align:middle">CANTIDAD</th>
                                                <th style="width:25%; text-align: center; vertical-align:middle">PRECIO</th>
                                            </tr>
                                        </thead>
                                        <tbody style="text-align: center; font-size: large; font-weight: bold;">
                                        </tbody>
                                    </table>
                                 </div>

                                 <div class="col-md-4">
                                 <label class="control-label col-md-1">OBSV:</label>
                                 <div class="col-md-11">

                                     <textarea id="txtObservaciones" class="form-control" name="txtObservaciones" style="height:125px"></textarea>

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
