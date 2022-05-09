<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/Views/Site.Master" CodeBehind="CargaDetalleEstudio.aspx.cs" Inherits="Portal.Views.Estudios.CargaDetalleEstudio" %>
<asp:Content runat="server" ID="ContentTitle" ContentPlaceHolderID="Title">CARGA DETALLE | SOLUGLOB IKON</asp:Content>

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
    <script src="/Assets/pages/scripts/Estudios/CargasNimbo.js"></script>
    <script>
        $(document).ready(function () {
            CargaSelect("GetNumChopo", $("#NumChopo"));
            CargaSelect("GetCodEstudiosChopo", $("#ClaveEstudio"));
            CargaSelect("GetDescEstudiosChopo", $("#DescEstudio"));
            var t = $('#TableCargaDetalle').DataTable({
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
        });

        function AgregaCargaDetalle() {
            AgregaCargaDetalleJS();
        }
        function CambiaSelect(cmb)
        {
            var cmbClave, cmbDesc;
            cmbClave = document.getElementById("ClaveEstudio") ? $("#ClaveEstudio").val() : null;
            cmbDesc = document.getElementById("DescEstudio") ? $("#DescEstudio").val() : null;
            if (cmbClave != cmbDesc)
            {
                if (cmb == 1)
                    $("#DescEstudio").val(cmbClave).trigger('change.select2');
                else
                    $("#ClaveEstudio").val(cmbDesc).trigger('change.select2');
            }
        }

        function VerDetalleCargaChopo() {
            var DataColums = [{ data: "NumChopo" }, { data: "Clave" }, { data: "Descripcion" }];
            VerCargaDetalleChopo($("#TableVerCargaDetalleNim"), DataColums, 2);
            $('#myModal').modal({ show: true });
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
                    <span class="caption-subject font-green sbold uppercase">CARGA DETALLE</span>
                </div>
            </div>
            
            <div class="portlet-body">
                <div class="form-body" style="padding-top:0px;">
                    <div class="table-toolbar">
                        <div class="row">
                            <div class=" col-md-8">
                                <div class="form-group">
                                     
                                    </div>
                                <div class="form-group">
                                    <label class="control-label col-md-1">#CHOPO:</label>
                                    <div class="col-md-2">
                                        <select id="NumChopo" class="form-control select2me">
                                            <option value="">Select...</option>
                                        </select>
                                        </div>
                                     <label class="control-label col-md-1">CLAVE:</label>
                                    <div class="col-md-2">
                                         <select id="ClaveEstudio" class="form-control select2me" onchange="CambiaSelect(1)">
                                            <option value="">Select...</option>
                                        </select>
                                        </div>
                                    
                            <label class="control-label col-md-2">DESCRIPCION:</label>
                                    <div class="col-md-4">
                                         <select id="DescEstudio" class="form-control select2me" onchange="CambiaSelect(2)">
                                            <option value="">Select...</option>
                                        </select>
                                        </div>
                                    </div>
                                </div>


                            <%--Boton para descargas de pdf excel--%>
                          <div class="col-md-3">
                                <div class="col-md-4">
                             <input type="button" class="btn blue pull-right" value="Agregar" id="AgregaCarga" name="AgregarCarga" onclick="AgregaCargaDetalle()">
                              </div>
                                <div class="col-md-4">
                              <input type="button" class="btn green-dark pull-right" value="Guardar" id="GuardarCargaDetalle" name="GuardarCargaDetalle" onclick="GuardarCargaDetalleJS()">
                                    </div>
                              <div class="col-md-4">
                             <input type="button" class="btn gray pull-right" value="Ver Cargas" id="VerCargaDetChopo" name="VerCargaDetChopo" onclick="VerDetalleCargaChopo()">
                              </div>
                            </div>
                            </div>
                            </div>
                    <div class="table-toolbar">  
                        <div class="row">
                            <div id="Contenedor" class="table-container" style="position:relative;">
                            <div class="col-md-12">
                                <table id="TableCargaDetalle" class="table table-striped table-bordered table-hover">
                                    <thead>
                                        <tr>
                                            <th style="width:10%; text-align: center; vertical-align:middle">#CHOPO</th>
                                            <th style="width:10%; text-align: center; vertical-align:middle">CLAVE</th>
                                            <th style="width:80%; text-align: center; vertical-align:middle">DESCRIPCION</th>
                                            
                                        </tr>
                                    </thead>
                                    <tbody style="text-align: center; font-size: large; font-weight: bold;">
                                    </tbody>
                                </table>
                            </div>  
                            </div>
                        </div>
                    </div>

                    <%--Inicia Modal--%>

<div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog" id="mdialTamanio">
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">×</button>
                <h4 class="modal-title">Detalle Carga Solicitud Estudios Chopo</h4>
            </div>
            <div class="modal-body">
                <div class="table-toolbar">
                <div class=" col-md-12">

                    <div id="ContenedorModal" class="table-container" style="position:relative;">
                        <h3>Ingresos</h3>
                    <div class="col-md-12" style="text-align:center">
                        <div class="row">
                        <table id="TableVerCargaDetalleNim" class="table table-striped table-bordered table-hover">
                            <thead>
                                <tr>
                                    <th style="width:25%; text-align: center; vertical-align:middle">NUMCHOPO</th>
                                    <th style="width:25%; text-align: center; vertical-align:middle">CLAVE</th>
                                    <th style="width:50%; text-align: center; vertical-align:middle">DESCRIPCION</th>
                                    
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

                    <%--Termina Modal--%>

                </div>
                </div>
            </div>
        <!-- END PORTLET -->
        <!-- END PAGE BASE CONTENT -->
    </form>
</asp:Content>

