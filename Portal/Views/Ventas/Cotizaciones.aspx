<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/Views/Site.Master" CodeBehind="Cotizaciones.aspx.cs" Inherits="Portal.Views.Ventas.Cotizador" %>

<asp:Content runat="server" ID="ContentTitle" ContentPlaceHolderID="Title">LISTADO COTIZACIONES | GRUPO MEDRANO</asp:Content>

<asp:Content runat="server" ID="ContectPageLevelPluginsCSS" ContentPlaceHolderID="PageLevelPluginsCSS">
    <link href="/Scripts/DataTablesv2/DataTables-1.10.18/css/jquery.dataTables.min.css" rel="stylesheet" />
    <link href="/Scripts/DataTablesv2/datatables.min.css" rel="stylesheet" />
    <link href="/Scripts/DataTablesv2/Buttons-1.5.4/css/buttons.dataTables.min.css" rel="stylesheet" />
    <link href="/Scripts/DataTablesv2/Buttons-1.5.4/css/buttons.bootstrap.min.css" rel="stylesheet" />
    <link href="/Scripts/DataTablesv2/DataTables-1.10.18/css/dataTables.bootstrap.min.css" rel="stylesheet" />
    <link href="/Assets/global/plugins/select2/css/select2.min.css" rel="stylesheet" type="text/css" />
    <link href="/Assets/global/plugins/select2/css/select2-bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="/Assets/global/plugins/bootstrap-datepicker/css/bootstrap-datepicker3.min.css" rel="stylesheet" type="text/css" />
    <link href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.css" rel="stylesheet" type="text/css" />
    <style>
    #mdialTamanio{
      width: 80% !important;
    }
    .vertical-alignment-helper {
        display:table;
        height: 100%;
        width: 100%;
        pointer-events:none;
    }
    .vertical-align-center {
        /* To center vertically */
        display: table-cell;
        vertical-align: middle;
        pointer-events:none;
    }
    .modal-content {
        /* Bootstrap sets the size of the modal in the modal-dialog class, we need to inherit it */
        width:inherit;
        height:inherit;
        /* To center horizontally */
        margin: 0 auto;
    }
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
    <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.js"></script>

</asp:Content>

<asp:Content runat="server" ID="ContectPageLevelScripts" ContentPlaceHolderID="PageLevelScripts">
    <script src="/Assets/pages/scripts/components-date-time-pickers.min.js" type="text/javascript"></script>
    <script src="/Assets/pages/scripts/components-select2.min.js" type="text/javascript"></script>
    <script src="/Assets/pages/scripts/Ventas/AjaxQueryVentas.js"></script>
    <script>window.onload = function () {
    ListarCotizaciones2();
        };</script>
</asp:Content>
<asp:Content runat="server" ID="ContectContentBody" ContentPlaceHolderID="ContentBody">
        <div class="portlet light portlet-fit portlet-form bordered" id="Entradas_Portlet">
            <div class="portlet-title">
                <div class="caption">
                    <i class="fa fa-sign-in font-red"></i>
                    <span class="caption-subject font-red sbold uppercase">COTIZACIONES</span>
                </div>
            </div>
            <div class="portlet-body">
                <div class="form-body" style="padding-top:0px;">
                    <div class="table-toolbar">
                        <div class="row">
                            <div class=" col-md-20">
                                <div class="form-group">
                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <div class="col-md-1"></div>
                                           <div class="col-md-10">
                                                <table class="table stripe hover nowrap" border="1" style="text-align:center;font-weight:700;font-size:12px;" id="TableCotizaciones">
                                                    <thead>
                                                        <tr style="background:red;color:white;">
                                                            <th>Num Cotización</th>
                                                            <th>Num Cliente</th>
                                                            <th>Fecha Cotización</th>
                                                            <th>Total MXN</th>
                                                            <th>Total USD</th>
                                                            <th>Status</th>
                                                            <th>Acciones</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody id="MostrarCotizaciones">
                                                    </tbody>
                                                </table>
                                           </div>
                                            <div class="col-md-1"></div>
                                       </div>
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
								    <h4 class="modal-title" id="myLargeModalLabel">Cancelar Cotización</h4>
									<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
								</div>
								<div class="modal-body">
									<H4>¿Deseas cancelar la cotización?</H4>
								</div>
								<div class="modal-footer">
					    			<button type="button" class="btn btn-secondary" data-dismiss="modal">Regresar</button>
									<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="CancelarCotizacion()">Aceptar</button>
								</div>
					    	</div>
						</div>
					</div>
                <%-- Fin --%>
            </div>
        </div>
        <!-- END PORTLET -->
        <!-- END PAGE BASE CONTENT -->
</asp:Content>
