<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Views/Site.Master" CodeBehind="AgregaIngresosEstudios.aspx.cs" Inherits="Portal.Views.Pacientes.AgregaIngresosEstudios" %>
 
<asp:Content runat="server" ID="ContentTitle" ContentPlaceHolderID="Title">INGRESO ESTUDIO HOSPITALES | SOLUGLOB IKON</asp:Content>

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
    <script src="/Assets/pages/scripts/Modulos/OperIngresosEstudios.js"></script>
    <script>
        window.onload = function () {
            
            CargaSelect("GetServicio", $("#servicioIdEstudios"),"servicio");
            CargaSelect("GetMedicosRelacion", $("#medicoIdEstudio"), "Medico");
            CargaSelect("CargaSelectCitasEspecialidad", $("#EspecialidadIdEstudio"), "Especialidad");
            CargaSelect("GetPacientesRelacion", $("#pacientesEstudiosID"), "Paciente");

            var t = $('#TableEstudios').DataTable({
                "sort": true,
                "aaSorting": [],
                "columnDefs": [{
                    "targets": 0,
                    "orderable": false
                }],
                "paging": false,
                "language": {
                    "decimal": "",
                    "emptyTable": "No hay datos disponibles en la tabla",
                    "info": "Resultado: _START_ al _END_ de _TOTAL_ entradas",
                    "infoEmpty": "Entradas no encontradas",
                    "infoFiltered": "(filtrada de _MAX_ entradas totales)",
                    "infoPostFix": "",
                    "thousands": ",",
                    "lengthMenu": "_MENU_",
                    "loadingRecords": "Cargando...",
                    "processing": "Procesando...",
                    "search": "Buscar:",
                    "zeroRecords": "No se encontraron registros coincidentes",
                    "paginate": {
                        "first": "Primero",
                        "last": "Ultimo",
                        "next": "Próximo",
                        "previous": "Anterior"
                    },
                    "aria": {
                        "sortAscending": ": Activar orden de columna ascendente",
                        "sortDescending": ": Activar orden de columna desendente"
                    }
                }
            });
            
        }
        function CambioEspecialidad()
        {
            var hospi = document.getElementById("medicoIdEstudio").value;
           $("#EspecialidadIdEstudio").val(hospi).trigger('change.select2');
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
                    <span class="caption-subject font-green sbold uppercase">INGRESO ESTUDIOS HOSPITALES</span>
                </div>
            </div>
            <div class="portlet-body">
                <div class="form-body" style="padding-top:0px;">
                    <div class="table-toolbar">
                        <div class="row">
                            <div class="form-group">
                            <div class="col-md-9">
                                <label class="control-label col-md-3">Paciente:</label>
                                <div class="col-md-9">
                                    <select id="pacientesEstudiosID" class="form-control select2me">
                                            <option value="">Select...</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <label class="control-label col-md-3">Episodio:</label>
                                <div class="col-md-9">
                                <input id="episodioEstudiosId" class="form-control" type="text" name="episodioEstudiosId" /> 
                                    </div>
                            </div>
                            </div>
                            <div class="form-group">

                                 <div class="col-md-5">
                                <label class="control-label col-md-3">Fecha:</label>
                                <div class="col-md-9">
                                    <div id="dpRange" class="input-group date-picker input-daterange" data-date-format="dd/mm/yyyy">
                                 <input type="text" id="dprFromEstudios" class="form-control" name="fromEstudios" value="<%= DateTime.Now.ToString("dd/MM/yyyy") %>">
                                   </div>
                                </div>
                            </div>
                            <div class="col-md-5">
                                
                                <label class="control-label col-md-3">Hospital:</label>
                                <div class="col-md-9">
                                    <select id="servicioIdEstudios" class="form-control select2me">
                                            <option value="">Select...</option>
                                    </select>
                                </div>
                            </div>

                            </div>
                             <div class="form-group">
                                
                            <div class="col-md-4">

                                <div class="form-group">
                                <label class="control-label col-md-3">Estudios:</label>
                                <div class="col-md-9">
                                <select id="estudiosIdEstudios" class="form-control select2me">
                                            <option value="">Select...</option>
                                    </select>
                                 </div>
                                    </div>
                                <div class="form-group">
                                    <div class="col-md-3">
                                        </div>
                                    <div class="col-md-9">
                                    <button id="btnAgregarEstudio" class="btn green pull-center" type="button" name="btnAgregarEstudio">Agregar</button>
                                        </div>
                                    </div>

                            </div>
                            <div class="col-md-8">
                               
                                <div id="ContenedorEstudios" class="table-container" style="position:relative;">
                                    <div class="col-md-12">
                                        <table id="TableEstudios" class="table table-striped table-bordered table-hover">
                                            <thead>
                                                <tr>
                                                    <th style="width:10%; text-align: center; vertical-align:middle">IDESTUDIO</th>
                                                    <th style="width:90%; text-align: center; vertical-align:middle">ESTUDIO</th>
                                                </tr>
                                            </thead>
                                            <tbody style="text-align: center; font-size: large; font-weight: bold;">
                                            </tbody>
                                         </table>
                                    </div>  
                                </div>

                            </div>
                                 
                            </div>

                            <div class="form-group">
                                <div class="col-md-5" id="divSoluglob">
                                    <label class="control-label col-md-3">Medico:</label>
                                    
                                <div class="col-md-9">
                                     <select id="medicoIdEstudio" class="form-control select2me" onchange="CambioEspecialidad();">
                                            <option value="">Select...</option>
                                    </select>
                                    </div>
                                </div>
                                <div class="col-md-5">
                                    <label class="control-label col-md-3">Especialidad:</label>
                                    
                                <div class="col-md-9">
                                     <select id="EspecialidadIdEstudio" class="form-control select2me" disabled="disabled">
                                            <option value="">Select...</option>
                                    </select>
                                    </div>
                                </div>
                               <div class="col-md-2">
                                <button type="button" class="btn green pull-center" id="btnGuardarIngreso" name="btnGuardarIngreso" onclick="GuardarIngreso();">Guardar</button>
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
