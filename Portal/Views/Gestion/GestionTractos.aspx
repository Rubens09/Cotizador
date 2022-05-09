<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Views/Site.Master" CodeBehind="GestionTractos.aspx.cs" Inherits="Portal.Views.Gestion.GestionTractos" %>

<asp:Content runat="server" ID="ContentTitle" ContentPlaceHolderID="Title">GESTION TRACTO | SOLUGLOB IKON</asp:Content>

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
    <script src="/Assets/pages/scripts/Gestion/AjaxGestTractos.js"></script>
    
    <script>
        $('#TableGestTracto tbody').on('click', 'tr', function (e) {

            e.preventDefault();
            var renglon = $(this);
            var campo1, campo2, campo3, campo4, campo5, campo6, campo7, campo8, campo9;
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
                    case 6:
                        campo7 = $(this).text();
                        break;
                    case 7:
                        campo8 = $(this).text();
                        break;
                    case 8:
                        campo9 = $(this).text();
                        break;
                }
            })
            var permiso = '<%= Session["Permiso"] %>';
            document.getElementById("regionTractos").value = campo1;
            document.getElementById("TractoTracto").value = campo2;
            document.getElementById("MarcaTracto").value = campo3;
            document.getElementById("ModeloTracto").value = campo4;
            document.getElementById("PlacasTracto").value = campo5;
          
               $('.modal-body').load('content.html', function () {
                   //console.log(textoRenglon);
                   
                   var DataColums;
                   if (permiso == "0") {
                       //document.getElementById("lblMonto").removeAttribute("hidden");
                       //document.getElementById("divMonto").removeAttribute("hidden");
                       //document.getElementById("btnAgregaCirugias").removeAttribute("style");
                       //document.getElementById("btnActualizaDiagnostico").removeAttribute("style");
                       //document.getElementById("chkHospitalizado").removeAttribute("hidden");
                       //document.getElementById("chkDefuncion").removeAttribute("hidden");
                       //document.getElementById("dprVerAlta").removeAttribute("disabled");
                       //document.getElementById("btnActualizaAlta").removeAttribute("style");
                       DataColums = [{ data: "Fecha" }, { data: "MOTIVO" }, { data: "DIAGNOSTICO" }, { data: "MEDICO" }, { data: "ESPECIALIDAD" },
                       { data: "TELEFONO" }, { data: "SERVICIO" }, { data: "NOTA" }, { data: "INTERCON" }, { defaultContent: "<button type='button' class='editar btn btn-primary' onclick='muestraEditarDiag(1)'><i class='fa fa-pencil'></i></button><button type='button' class='agregar btn btn-success' onclick='muestraFechaInterConsulta(1);' titla='Agregar InterConsulta'><i class='fa fa-plus'></i></button>" }];
                   }
                   //CargaSelect("GetTipoInterconsulta", $("#TipoInterconsulta"), "");
                   //CargaDetEpisodio("GetConsultaDetIngresados", $("#TableVerEpisodio"), DataColums, 7, campo1, campo2);
                   var DataColums = [{ data: "Fecha" }, { data: "TipoCirugia" }, { data: "Descripcion" }];
                   //VerCirugias("GetTablaCirugia", $("#TableVerCirugia"), DataColums, 2);
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
                    <span class="caption-subject font-green sbold uppercase">GESTION DE TRACTOS </span>
                </div>
            </div>
            <div class="portlet-body">
                <div class="form-body" style="padding-top:0px;">
                    <div class="table-toolbar">
                        <div class="row">
                            
                            <div class="form-group">
                                <div class="col-md-9">
                                
                                <div class="col-md-3">
                                <label class="control-label col-md-2">REGION:</label>
                                  <div class="col-md-10">
                                        <select id="GestTractRegionId" class="form-control select2me ReloadDataTable">
                                            <option value="">Select...</option>
                                    </select>

                                    </div>
                                </div>

                                <div class="col-md-3">
                                    <label class="control-label col-md-2">MARCA:</label>
                                    <div class="col-md-10">
                                        <select id="GestMarcaTractId" class="form-control select2me ReloadDataTable">
                                            <option value="">Select...</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="col-md-3">
                                    <label class="control-label col-md-2">TRACTO:</label>
                                    <div class="col-md-10">
                                        <select id="GestTractTractoId" class="form-control select2me ReloadDataTable">
                                            <option value="">Select...</option>
                                        </select>
                                    </div>
                                </div>

                                    <div class="col-md-3">
                                    <label class="control-label col-md-2">ESTAT:</label>
                                    <div class="col-md-10">
                                        <select id="GestTractEstatusId" class="form-control select2me ReloadDataTable">
                                            <option value="">Select...</option>
                                        </select>
                                    </div>
                                    </div>
                            </div>
                                 <div class="col-md-3">
                                <div class="btn-group pull-center">
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
                            
                            <div class="table-toolbar">
                          <div class="row">
                    <div id="Contenedor" class="table-container" style="position:relative;">
                                 <div class="col-md-12">
                                     <table id="TableGestTracto" class="table table-striped table-bordered table-hover">
                                        <thead>
                                            <tr>
                                                <th style="width:10%; text-align: center; vertical-align:middle">REGION</th>
                                                <th style="width:20%; text-align: center; vertical-align:middle">TRACTO</th>
                                                <th style="width:20%; text-align: center; vertical-align:middle">MARCA</th>
                                                <th style="width:20%; text-align: center; vertical-align:middle">MODELO</th>
                                                <th style="width:10%; text-align: center; vertical-align:middle">PLACAS</th>
                                                <th style="width:10%; text-align: center; vertical-align:middle">ESTATUS</th>
                                                <th style="width:10%; text-align: center; vertical-align:middle">U. ACT.</th>
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
                <button type="button" class="close" data-dismiss="modal">X</button>
                <h4 class="modal-title">Detalle Tracto</h4>
            </div>
            <div class="modal-body">
                <div class="table-toolbar">
                <div class=" col-md-12">
                     <div class="form-group">
                         <div class=" col-md-12">
                          <label class="control-label col-md-1">REG:</label>
                                    <div class="col-md-2">
                                        <input type="text" id="regionTractos" class="form-control" name="regionTractos" readonly>
                                    </div>
                         </div>
                          <div class=" col-md-8"></div>
                         </div>
                                <div class="form-group">
                                    <label class="control-label col-md-1">TRACTO:</label>
                                    <div class="col-md-2">
                                        <input type="text" id="TractoTracto" class="form-control" name="TractoTracto" readonly>
                                    </div>
                                    <label class="control-label col-md-1">MARCA:</label>
                                    <div class="col-md-2">
                                       <input type="text" id="MarcaTracto" class="form-control" name="MarcaTracto" readonly>
                                    </div>
                                     <label class="control-label col-md-1">MODELO:</label>
                                    <div class="col-md-2">
                                        <input type="text" id="ModeloTracto" class="form-control" name="ModeloTracto" readonly>
                                    </div>
                                    <label class="control-label col-md-1">PLACAS:</label>
                                    <div class="col-md-2">
                                       <input type="text" id="PlacasTracto" class="form-control" name="PlacasTracto" readonly>
                                    </div>
                                </div>
                     
                    <div class="form-group">
                        <label class="control-label col-md-2" id="lblMonto">ESTATUS:</label>
                        <div class="col-md-4">
                                        <select id="GestEst" class="form-control select2me ReloadDataTable">
                                            <option value="">Select...</option>
                                        </select>
                                    </div>
                        <div class="col-md-2">
                                <input type="button" id="btnActualizaAlta" name="btnActualizaAlta" class="btn green pull-right" onclick="ActualizaAlta();" value="Actualizar">
                            </div>
                    </div>

                    <div id="ContenedorModal" class="table-container" style="position:relative;">
                        <h3>Historia Tracto</h3>
                    <div class="col-md-12" style="text-align:center">
                        <div class="row">
                        <table id="TableVerEpisodio" class="table table-striped table-bordered table-hover">
                            <thead>
                                <tr>
                                    <th style="width:5%; text-align: center; vertical-align:middle">FECHA</th>
                                    <th style="width:15%; text-align: center; vertical-align:middle">MOTIVO</th>
                                    <th style="width:15%; text-align: center; vertical-align:middle">DIAGNOSTICO</th>
                                    <th style="width:20%; text-align: center; vertical-align:middle">MEDICO</th>
                                    <th style="width:10%; text-align: center; vertical-align:middle">ESPE</th>
                                    <th style="width:5%; text-align: center; vertical-align:middle">TEL</th>
                                    <th style="width:5%; text-align: center; vertical-align:middle">HOSP</th>
                                    <th style="width:15%; text-align: center; vertical-align:middle">NOTA</th>
                                    <th style="width:5%; text-align: center; vertical-align:middle">INTERCON</th>
                                    <th></th>
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
                
                <button type="button" id="BtnAgregaMed" name="BtnAgregaMed" class="btn green" onclick="CambiaServicio(2);">Agregar medico</button>
                
                <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
                
            </div>
        </div>
    </div>
</div>
<%--TERMINA MODAL--%>
                            </div>
                      </div>
                    </div>
                </div>
            </div>
        <!-- END PORTLET -->
        <!-- END PAGE BASE CONTENT -->
    </form>
</asp:Content>
