 <%@ Page Title="MedicoEstudio" Language="C#" MasterPageFile="~/Views/Site.Master" AutoEventWireup="true" CodeBehind="MedicoEstudio.aspx.cs" Inherits="Portal.Views.Pacientes.MedicoEstudio" %>

<asp:Content runat="server" ID="ContentTitle" ContentPlaceHolderID="Title">MEDICO ESTUDIO | SOLUGLOB IKON</asp:Content>

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
    <script src="/Assets/pages/scripts/Modulos/Modulos.js"></script>
    <script>
        window.onload = function () {
            validaEpisodio();
            CargaSelect("GetServicio", $("#servicioId"),"servicio");
            CargaSelect("GetTipo", $("#tipoId"),"tipo");
            CargaSelect("GetEspecialidad", $("#especialidadId"), "especialidad");
            CargaSelect("GetTipoInterconsulta", $("#cmbTipoInterCon"), "");
            document.getElementById("cmbTipoInterCon").setAttribute("disabled", "disabled");
        }
        function CambioCmbInterCon() {
            var intercon = $('#chkInterConsult').prop('checked') ? "1" : "null";
            if (intercon != "null")
            {
                document.getElementById("cmbTipoInterCon").removeAttribute("disabled");
            }
            else
            {
                
                document.getElementById("cmbTipoInterCon").setAttribute("disabled", "disabled");
            }
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
                    <span class="caption-subject font-green sbold uppercase">ASIGNACION MEDICO</span>
                </div>
            </div>
            <div class="portlet-body">
                <div class="form-body" style="padding-top:0px;">
                    <div class="table-toolbar">
                        <div class="row">
                            <div class="form-group">
                            <div class="col-md-3">
                                <label class="control-label col-md-3">PACIENTE:</label>
                                <div class="col-md-9">
                                <input id="pacienteIngresoId" class="form-control" type="text" name="pacienteIngresoId" value="<%= Pacientes %>" readonly/> 
                                 </div>
                            </div>
                            <div class="col-md-3">
                                <label class="control-label col-md-3">EPISODIO:</label>
                                <div class="col-md-9">
                                <input id="episodioId" class="form-control" type="text" name="episodioId" value="<%= Episodio %>"/> 
                                    </div>
                            </div>
                            <div class="col-md-3">
                                <label class="control-label col-md-3">FECHA:</label>
                                <div class="col-md-9">
                                    <div id="dpRange" class="input-group date-picker input-daterange" data-date-format="dd/mm/yyyy">
                                 <input type="text" id="dprFrom" class="form-control" name="from" value="<%= DateTime.Now.ToString("dd/MM/yyyy") %>">
                                   </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <input type="hidden" value="<%= Hospital %>" id="hiddenServicio" name="hiddenServicio"/>
                                <label class="control-label col-md-3">HOSPITAL:</label>
                                <div class="col-md-9">
                                    <select id="servicioId" class="form-control select2me">
                                            <option value="">Select...</option>
                                    </select>
                                </div>
                            </div>
                            </div>

                             <div class="form-group">
                                
                            <div class="col-md-4">
                                <label class="control-label col-md-3">MOTIVO:</label>
                                <div class="col-md-9">
                                <input id="motivoId" class="form-control" type="text" name="motivoId" value="<%= Motivo %>"/> 
                                 </div>
                            </div>
                            <div class="col-md-4">
                                <label class="control-label col-md-3">DIAGNOSTICO:</label>
                                <div class="col-md-9">
                                <input id="diagnosticoId" class="form-control" type="text" name="diagnosticoId" /> 
                                    </div>
                            </div>
                                  <div class="col-md-4">
                                <label class="control-label col-md-3">TIPO:</label>
                                <div class="col-md-9">
                                 <select id="tipoId" class="form-control select2me" onchange="CambiaTipo();">
                                            <option value="">Select...</option>
                                    </select>
                                 </div>
                            </div>
                                 
                                 
                            </div>

                            <div class="form-group">
                                <div class="col-md-4">
                                <label class="control-label col-md-3">ESPECIALIDAD:</label>
                                <div class="col-md-9">
                                 <select id="especialidadId" class="form-control select2me" onchange="CargaMedicos();">
                                            <option value="">Select...</option>
                                    </select>
                                 </div>
                            </div>
                                <div class="col-md-4" id="divSoluglob">
                                    <label class="control-label col-md-3">MEDICO:</label>
                                    
                                <div class="col-md-9">
                                     <select id="medicoId" class="form-control select2me" onchange="CargaTelefono();">
                                            <option value="">Select...</option>
                                    </select>
                                    </div>
                                </div>

                                <div class="col-md-4" hidden="hidden" id="divStaff">
                                    <label class="control-label col-md-3">MEDICO:</label>
                                <div class="col-md-9">
                                    <input id= "medicoStaffId" class="form-control" type="text" name="medicoStaffId" value="STAFF URGENCIAS" readonly /> 
                                    </div>
                                </div>
                                 <div class="col-md-4">
                                    <label class="control-label col-md-3">TELEFONO:</label>
                                <div class="col-md-9">
                                     <input id= "telefonoId" class="form-control" type="text" name="telefonoId" /> 
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-md-4">
                                <label class="control-label col-md-2">ALTA:</label>
                                <div class="col-md-9">
                                    <div id="dpRange1" class="input-group date-picker input-daterange" data-date-format="dd/mm/yyyy">
                                 <input type="text" id="dprAlta" class="form-control" name="from" value="">
                                   </div>
                                </div>
                            </div>
                                <div class="col-md-4">
                                <label class="control-label col-md-2">INTERCONSULTA:</label>
                                <div class="col-md-4">
                                 <input type="checkbox" id="chkInterConsult" class="form-control" name="chkInterConsult" onchange="CambioCmbInterCon();">
                                </div>
                                    <div class="col-md-6">
                                        <select id="cmbTipoInterCon" class="form-control select2me">
                                            <option value="">Select...</option>
                                        </select>
                                    </div>
                            </div>
                                 <div class="col-md-4">
                                <label class="control-label col-md-2">HOSPITALIZADO:</label>
                                <div class="col-md-4">
                                 <input type="checkbox" id="chkHospUrg" class="form-control" name="chkHospUrg">
                                </div>
                            </div>
                                </div>
                           
                            <div class="form-group">
                                 <div class="col-md-12">
                                <label class="control-label col-md-1">NOTA:</label>
                                <div class="col-md-9">
                                <textarea id="notaId" class="form-control" name="notaId" style="height:125px"></textarea>
                                 </div>
                                      <div class="col-md-2">
                                <button type="button" class="btn green pull-center" id="btnGuardarIngreso" name="btnGuardarIngreso" onclick="GuardarIngreso();">Guardar</button>
                                 </div>
                            </div>
                            </div>
                            <div class="form-group">
                                
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
