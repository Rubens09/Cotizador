<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Views/Site.Master" CodeBehind="GestionBloqueosPacientes.aspx.cs" Inherits="Portal.Views.Gestion.GestionBloqueosPacientes" %>
<asp:Content runat="server" ID="ContentTitle" ContentPlaceHolderID="Title">GESTION DE BLOQUEOS | SOLUGLOB IKON</asp:Content>

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
    <script src="/Assets/pages/scripts/Gestion/CargaPacienteBloqueos.js"></script>
    <script src="/Assets/pages/scripts/Gestion/CargasMedicos.js"></script>
    <script>
        window.onload = function () {
           //CARGA INICIAL
        }
        $('#TableGesPacientes tbody').on('click', 'tr', function (e) {
            e.preventDefault();
            var renglon = $(this);
            var campo1, campo2, campo3, campo4;
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
                }
            })
            document.getElementById("CedulaAltaMed").value = campo1;
            document.getElementById("NombreAltaMed").value = campo2;

            var sel = document.getElementById("EspecialidadAltaMed");
            for (var i = 0; i < sel.length; i++) {
                var opt = sel[i];
                if (opt.value == campo3) {
                    $("#EspecialidadAltaMed").val(campo3).trigger('change.select2');  
                }
            }

            if (campo4 == "ACTIVO")
            {
                $("#chkActivo").prop('checked', true);
            }


          
            //    document.getElementById("dprVerAlta").setAttribute("readonly", "readonly");
          
            //    document.getElementById("dprVerAlta").removeAttribute("readonly");
           
            var permiso = '<%= Session["Permiso"] %>';
            if (permiso != "6") {
                $('.modal-body').load('content.html', function () {

                    LeeDatosMedico("GetLeeDatosMedico");
                    document.getElementById("CedulaAltaMed").setAttribute("readonly", "readonly");
                    document.getElementById("NombreAltaMed").setAttribute("readonly", "readonly");
                    document.getElementById("TelefonoAltaMed").setAttribute("readonly", "readonly");
                    document.getElementById("RecadosAltaMed").setAttribute("readonly", "readonly");
                    document.getElementById("EspecialidadAltaMed").setAttribute("disabled", "disabled");
                    document.getElementById("DireccionAltaMed").setAttribute("readonly", "readonly");
                    document.getElementById("EmailAltaMed").setAttribute("readonly", "readonly");

                    document.getElementById("divAgregaMed").setAttribute("hidden", "hidden");
                    document.getElementById("divActualizaMed").removeAttribute("hidden");



                    $('#myModal').modal({ show: true });
                });
            }
        });

        function AltaMedico() {
            $('.modal-body').load('content.html', function () {
                document.getElementById("CedulaAltaMed").removeAttribute("readonly");
                document.getElementById("NombreAltaMed").removeAttribute("readonly");
                document.getElementById("TelefonoAltaMed").removeAttribute("readonly");
                document.getElementById("RecadosAltaMed").removeAttribute("readonly");
                document.getElementById("EspecialidadAltaMed").removeAttribute("disabled");
                document.getElementById("DireccionAltaMed").removeAttribute("readonly");
                document.getElementById("EmailAltaMed").removeAttribute("readonly");

                document.getElementById("CedulaAltaMed").value = "";
                document.getElementById("NombreAltaMed").value = "";
                document.getElementById("TelefonoAltaMed").value = "";
                document.getElementById("RecadosAltaMed").value = "";
                document.getElementById("DireccionAltaMed").value = "";
                document.getElementById("EmailAltaMed").value = "";

                document.getElementById("divAgregaMed").removeAttribute("hidden");
                document.getElementById("divActualizaMed").setAttribute("hidden","hidden");

                $('#myModal').modal({ show: true });
            });
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
                    <span class="caption-subject font-green sbold uppercase">GESTION MEDICOS</span>
                </div>
            </div>
            
            <div class="portlet-body">
                <div class="form-body" style="padding-top:0px;">
                    <div class="table-toolbar">
                        <div class="row">
                            <div class=" col-md-8">
                                 
                                <div class="form-group">
                                    <label class="control-label col-md-3">Especialidad:</label>
                                    <div class="col-md-9">
                                        <select id="GestEspeId" class="form-control select2me ReloadDataTable">
                                            <option value="">Select...</option>
                                        </select>
                                    </div>
                                    <input type="hidden" id="permisoHidden1" name="permisoHidden1" runat="server"/>
                                </div>
                                 
                                <div class="form-group">
                                    <label class="control-label col-md-3">Medico:</label>
                                    <div class="col-md-9">
                                        <select id="GestMedId" class="form-control select2me ReloadDataTable">
                                            <option value="">Select...</option>
                                        </select>
                                    </div>
                                </div>
                              
                            </div>
                            <%--Boton para descargas de pdf excel--%>
                          <div class="col-md-3">
                                <input type="button" class="btn green pull-right" value="Alta" id="altaMedMed" name="altaMedMed" onclick="AltaMedico()">
                              <br /><br />
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
                            <div class="col-md-12">
                                <table id="TableGesPacientes" class="table table-striped table-bordered table-hover">
                                    <thead>
                                        <tr>
                                            <th style="width:20%; text-align: center; vertical-align:middle">AFILIACION</th>
                                            <th style="width:30%; text-align: center; vertical-align:middle">PACIENTE</th>
                                            <th style="width:25%; text-align: center; vertical-align:middle">TIPO</th>
                                            <th style="width:25%; text-align: center; vertical-align:middle">ESTATUS</th>
                                        </tr>
                                    </thead>
                                    <tbody style="text-align: center; font-size: large; font-weight: bold;">
                                    </tbody>
                                </table>
                            </div>  
                            </div>
                        </div>
                    </div>

<%--MODAL PARA CARGA DE MEDICO--%>
                    <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog" id="mdialTamanio">
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">×</button>
                <h4 class="modal-title">Medicos</h4>
            </div>
            <div class="modal-body">
                <div class="table-toolbar">
                <div class=" col-md-12">
                                <div class="form-group">
                                    <label class="control-label col-md-1">CEDULA:</label>
                                    <div class="col-md-3">
                                        <input type="text" id="CedulaAltaMed" class="form-control" name="CedulaAlta" readonly>
                                    </div>
                                    <label class="control-label col-md-1">NOMBRE:</label>
                                    <div class="col-md-7">
                                       <input type="text" id="NombreAltaMed" class="form-control" name="NombreAltaMed" readonly>
                                    </div>
                                </div>
                     <div class="form-group">
                                    <label class="control-label col-md-1">TELEFONO:</label>
                                    <div class="col-md-7">
                                        <input type="text" id="TelefonoAltaMed" class="form-control" name="TelefonoAltaMed" readonly>
                                    </div>
                                    <label class="control-label col-md-1">RECADOS:</label>
                                    <div class="col-md-3">
                                       <input type="text" id="RecadosAltaMed" class="form-control" name="RecadosAltaMed" readonly>
                                    </div>
                                </div>
                    <div class="form-group">
                        <label class="control-label col-md-2">ESPECIALIDAD:</label>
                        <div class="col-md-5">
                                   <select id="EspecialidadAltaMed" class="form-control select2me" disabled>
                                            <option value="">Select...</option>
                                   </select>
                            </div>
                        <label class="control-label col-md-1">EMAIL:</label>
                            <div class="col-md-3">
                                <input type="text" id="EmailAltaMed" class="form-control" name="EmailAltaMed" value="" readonly>
                            </div>
                        </div>
                    <div class="form-group">
                        <label class="control-label col-md-1">DIRECCION:</label>
                        <div class="col-md-6">
                                   <input type="text" id="DireccionAltaMed" class="form-control" name="DireccionAltaMed" value="" readonly>
                            </div>
                        <label class="control-label col-md-1">TIPO:</label>
                        <div class="col-md-2">
                             <select id="TipoMedico" class="form-control select2me">
                                            <option value="">Select...</option>
                                   </select>
                        </div>
                        <label class="control-label col-md-1">ACTIVO:</label>
                        <div class="col-md-1">
                                <input type="checkbox" id="chkActivo" name="chkActivo" />
                            </div>
                    </div>
                     </div>
                    </div>
            </div>
           
            <div class="modal-footer">
                <div id="divActualizaMed" hidden="hidden">
                <input type="button" id="BtnActualizarMed" name="BtnActualizarMed" class="btn green" value="Actualizar medico" onclick="ActualizaCatMedicos()" /></div>
                <div id="divAgregaMed">
                <input type="button" id="BtnAgregarMed" name="BtnAgregarMed" class="btn green" value="Agregar medico" onclick="AltaCatMedicos()" /></div>
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
