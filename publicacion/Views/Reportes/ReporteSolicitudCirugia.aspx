<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ReporteSolicitudCirugia.aspx.cs" MasterPageFile="~/Views/Site.Master" Inherits="Portal.Views.Reportes.ReporteSolicitudCirugia" %>

<asp:Content runat="server" ID="ContentTitle" ContentPlaceHolderID="Title">REPORTE SOLICITUDES / PROCEDIMIENTOS | SOLUGLOB IKON</asp:Content>

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
<script src="/Assets/pages/scripts/SolCirugias/OperacionesSolCirugias.js"></script>
        <script>
            window.onload = function () {
                var DataColums = [{ data: "Solicitud" }, { data: "Afilia" }, { data: "Paciente" }, { data: "TipoPaciente" }, { data: "Medico" }, { data: "Diagnostico" }, { data: "FE" }, {data: "Hospital"}];
                CargaCabeceroSolCir("GetTableCabSolCir", $("#TableSolicitudCir"),DataColums,7);
            }

            $('#TableSolicitudCir tbody').on('click', 'tr', function (e) {
              
            e.preventDefault();
            var renglon = $(this);
            var campo1, campo2, campo3, campo4,campo5, campo6,campo7,campo8;
            campo6 = null;
            $(this).children("td").each(function (i) {
                switch (i) {
                    case 0:
                        campo1 = $(this).text();
                        break;
                    case 1:
                        campo2 = $(this).text();
                        break;
                    case 2:
                        campo3 = $(this).text();
                        break;
                    case 3:
                        campo4 = $(this).text();
                        break;
                    case 4:
                        campo5 = $(this).text();
                    case 5:
                        campo6 = $(this).text();
                        break;
                    case 7:
                        campo8 = $(this).text();
                        break;
                }
            })

             
                document.getElementById("txtPacienteSolCir").value = campo3;
                document.getElementById("txtSolCir").value = campo1;
                document.getElementById("txtDiagSolCir").value = campo5;
                document.getElementById("txtMedicoSolCir").value = campo4;
                document.getElementById("txtHosp").value = campo8;
                var DataColums = [{ data: "Clave" }, { data: "DescCpt" }, { data: "Procedimiento" }];
                CargaDetalleSolCir("GetTableDetSolCir", $("#TableDetalleSolCir"), DataColums, 2);
            
                $('.modal-body').load('content.html', function () {
                    //console.log(textoRenglon);
                   
                    //alert(renglon);
                    $('#myModal').modal({ show: true });
                });
            
        });
           
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
                    <span class="caption-subject font-green sbold uppercase">REPORTE SOLICITUD DE CIRUGIA/PROCEDIMIENTO EN CONSULTORIO</span>
                </div>
            </div>
            <div class="portlet-body">
                <div class="form-body" style="padding-top:0px;">
                    <div class="table-toolbar">
                        <div class="row">
                            <div class=" col-md-8">
                                
                            </div>
                              <div class="col-md-3">
                                
                                <div class="btn-group pull-right">
                                    <a class="btn green  btn-outline dropdown-toggle" href="javascript:;" data-toggle="dropdown">
                                        <i class="fa fa-cog"></i>
                                        <span class="hidden-xs">Herramientas</span>
                                        <i class="fa fa-angle-down"></i>
                                    </a>
                                    <ul class="dropdown-menu pull-right" id="TableEntradas_tools">
                                        <li>
                                            <a href="javascript:;" data-action="0" class="tool-action">
                                                <i class="icon-printer"></i>
                                                Imprimir
                                            </a>
                                        </li>
                                        <li>
                                            <a href="javascript:;" data-action="1" class="tool-action">
                                                <i class="fa fa-files-o"></i>
                                                Copiar
                                            </a>
                                        </li>
                                        <li>
                                            <a href="javascript:;" data-action="2" class="tool-action">
                                                <i class="fa fa-file-pdf-o"></i>
                                                Exportar a PDF
                                            </a>
                                        </li>
                                        <li>
                                            <a href="javascript:;" data-action="3" class="tool-action">
                                                <i class="fa fa-file-excel-o"></i>
                                                Exportar a Excel
                                            </a>
                                        </li>
                                    </ul>
                                </div>

                            </div>
                        </div>
                    </div>
                    <div class="table-toolbar">
                          <div class="row">
                    <div id="Contenedor" class="table-container" style="position:relative;">
                        <div class="col-md-12" style="text-align:center">
                        <table id="TableSolicitudCir" class="table table-striped table-bordered table-hover">
                            <thead>
                                <tr>
                                    <th style="width:10%; text-align: center; vertical-align:middle">SOLICITUD</th>
                                    <th style="width:15%; text-align: center; vertical-align:middle">AFILIA</th>
                                    <th style="width:15%; text-align: center; vertical-align:middle">PACIENTE</th>
                                    <th style="width:10%; text-align: center; vertical-align:middle">TIP.PAC.</th>
                                    <th style="width:15%; text-align: center; vertical-align:middle">MEDICO</th>
                                    <th style="width:20%; text-align: center; vertical-align:middle">DIAGNOSTICO</th>
                                    <th style="width:5%; text-align: center; vertical-align:middle">FECHAESTIMADA</th>
                                    <th style="width:10%; text-align: center; vertical-align:middle">HOSP</th>
                                   
                                </tr>
                            </thead>
                            <tbody style="text-align: center; font-size: large; font-weight: bold;">
                            </tbody>
                        </table>
                      </div> 
                       </div>
                      </div>
                    </div>

<%--INICIA MODAL--%>
<div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog" id="mdialTamanio">
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">×</button>
                <h4 class="modal-title">Detalle Solicitud</h4>
            </div>
            <div class="modal-body">
                <div class="table-toolbar">
                <div class=" col-md-12">
                                <div class="form-group">
                                    <label class="control-label col-md-1">PAC:</label>
                                    <div class="col-md-7">
                                        <input type="text" id="txtPacienteSolCir" class="form-control" name="pacienteVerId" readonly>
                                    </div>
                                    <label class="control-label col-md-1">SOL:</label>
                                    <div class="col-md-3">
                                       <input type="text" id="txtSolCir" class="form-control" name="TxtSolCir" readonly>
                                    </div>
                                </div>
                     <div class="form-group">
                                    <label class="control-label col-md-1">DIAG:</label>
                                    <div class="col-md-7">
                                        <input type="text" id="txtDiagSolCir" class="form-control" name="txtDiagSolCir" readonly>
                                    </div>
                                    <label class="control-label col-md-1">MED:</label>
                                    <div class="col-md-3">
                                       <input type="text" id="txtMedicoSolCir" class="form-control" name="txtMedicoSolCir" readonly>
                                    </div>
                                </div>
                     <div class="form-group">
                                    <label class="control-label col-md-1">HOSP:</label>
                                    <div class="col-md-7">
                                        <input type="text" id="txtHosp" class="form-control" name="txtHosp" readonly>
                                    </div>
                                    <div class="col-md-4" id="divBtnDescarga" style="align-content:center" >
                                         <input type="button" class="btn red pull-right" value="Descargar Solicitud" id="DescargarPdf" name="DescargarSolicitud" onclick="DescargarSolicitudCir();">
                                    </div>
                                </div>

                    <div id="ContenedorModal" class="table-container" style="position:relative;">
                        <h3>Detalle</h3>
                    <div class="col-md-12" style="text-align:center">
                        <div class="row">
                        <table id="TableDetalleSolCir" class="table table-striped table-bordered table-hover">
                            <thead>
                                <tr>
                                    <th style="width:10%; text-align: center; vertical-align:middle">CLAVE</th>
                                    <th style="width:80%; text-align: center; vertical-align:middle">DESCRIPCION CPT</th>
                                    <th style="width:10%; text-align: center; vertical-align:middle">PROCEDIMIENTO</th>
                                </tr>
                            </thead>
                            <tbody style="text-align: center; font-size: large; font-weight: bold;">
                            </tbody>
                        </table>
                      </div> 
                       </div>
                        </div>
                     </div>
                    </div>
            </div>
           
            <div class="modal-footer">
                
                <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
                
            </div>
        </div>
    </div>
</div>
<%--TERMINA MODAL--%>
                 
                    </div>
                </div>
            </div>
        <!-- END PORTLET -->
        <!-- END PAGE BASE CONTENT -->
    </form>
</asp:Content>
