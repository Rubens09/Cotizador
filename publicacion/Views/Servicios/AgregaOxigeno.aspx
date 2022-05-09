<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Views/Site.Master" CodeBehind="AgregaOxigeno.aspx.cs" Inherits="Portal.Views.Servicios.AgregaOxigeno" %>

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
    <script src="/Assets/pages/scripts/Oxigeno/Cargas.js"></script>
    <script>
        window.onload= function () {
            CargaInicial();
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
                    <span class="caption-subject font-green sbold uppercase">AGREGA OXIGENO</span>
                </div>
            </div>
            <div class="portlet-body">
                <div class="form-body" style="padding-top:0px;">
                    <div class="table-toolbar">
                        <div class="row">
                            
                            <div class="form-group">
                            <div class="col-md-3">
                                 <label class="control-label col-md-3">PACIENTE:</label>
                                <div class="col-md-9" id="divtxtPaciente" hidden="hidden">
                                    <input id="txtpacienteOxiId" class="form-control" type="text" name="txtpacienteOxiId" value="<%= Pacientes %>" readonly/> 
                                </div>
                                <div class="col-md-9" id="divselectPaciente">
                                    <select id="pacienteOxiId" class="form-control select2me" onchange="CargaDatos(1);">
                                            <option value="">Select...</option>
                                    </select>
                            </div>
                                </div>
                            <div class="col-md-6">
                                <label class="control-label col-md-3">CALLE Y NÚMERO:</label>
                                <div class="col-md-9">
                                <input id="calleOxiId" class="form-control" type="text" name="calleOxiId"/> 
                                    </div>
                            </div>
                            <div class="col-md-3">
                                 <label class="control-label col-md-3">C.P.:</label>
                                <div class="col-md-9">
                                    <input id="cpOxiId" class="form-control" type="text" name="cpOxiId"/> 
                                </div>
                                
                            </div>
                                </div>

                            <div class="form-group">
                            <div class="col-md-4">
                               <label class="control-label col-md-3">COLONIA:</label>
                                <div class="col-md-9">
                                    <input id="coloniaOxiId" class="form-control" type="text" name="calleOxiId"/> 
                                </div>
                            </div>
                                <div class="col-md-4">
                               <label class="control-label col-md-3">DEL/MUNI:</label>
                                <div class="col-md-9">
                                    <input id="delegacionOxiId" class="form-control" type="text" name="delegacionOxiId"/> 
                                </div>
                            </div>
                                <div class="col-md-4">
                               <label class="control-label col-md-3">TELEFONO:</label>
                                <div class="col-md-9">
                                    <input id="telPacOxiId" class="form-control" type="text" name="telPacOxiId"/> 
                                </div>
                          </div>
                                </div>

                             <div class="form-group">
                            <div class="col-md-4">
                                <label class="control-label col-md-3">FAMILIAR:</label>
                                <div class="col-md-9">
                                <input id="famPacOxiId" class="form-control" type="text" name="famPacOxiId"/> 
                                 </div>
                            </div>
                            <div class="col-md-4">
                                <label class="control-label col-md-3">TEL.FAMILIAR:</label>
                                <div class="col-md-9">
                                <input id="telFamId" class="form-control" type="text" name="telFamId" /> 
                                    </div>
                            </div>                            
                            </div>

                            <div class="form-group">
                                
                                <div class="col-md-2">
                                <label class="control-label col-md-3">CILIND:</label>
                                <div class="col-md-9">
                                 <select id="cilindroOxiId" class="form-control select2me">
                                            <option value="">Select...</option>
                                    </select>
                                 </div>
                            </div>
                            <div class="col-md-3">
                                <label class="control-label col-md-3">PORTATIL:</label>
                                <div class="col-md-9">
                                 <select id="portatilOxiId" class="form-control select2me">
                                            <option value="">Select...</option>
                                    </select>
                                 </div>
                            </div>

                            <div class="col-md-3">
                                <label class="control-label col-md-4">CONCENTRADOR:</label>
                                <div class="col-md-8">
                                 <select id="concentradorOxiId" class="form-control select2me">
                                            <option value="">Select...</option>
                                    </select>
                                 </div>
                            </div>

                            <div class="col-md-2">
                                <label class="control-label col-md-3">F.ENT:</label>
                                <div class="col-md-8">
                                    <div id="dpRange" class="input-group date-picker input-daterange" data-date-format="dd/mm/yyyy">
                                 <input type="text" id="fechaEntregaOxi" class="form-control" name="fechaEntregaOxi" value="">
                                   </div>
                                </div>
                            </div>

                                <div class="col-md-2">
                                <label class="control-label col-md-3">F.FIN</label>
                                <div class="col-md-9">
                                    <div id="dpRange4" class="input-group date-picker input-daterange" data-date-format="dd/mm/yyyy">
                                 <input type="text" id="fechaFinalOxi" class="form-control" name="fechaFinalOxi" value="">
                                   </div>
                                </div>
                            </div>
                                    
                                
                            </div>

                            <div class="form-group">
                                <div class="col-md-4">
                                <label class="control-label col-md-3">PAP:</label>
                                <div class="col-md-9">
                                  <select id="papOxiId" class="form-control select2me">
                                            <option value="">Select...</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <label class="control-label col-md-3">F.ENTREGA:</label>
                                 <div class="col-md-9">
                                    <div id="dpRange1" class="input-group date-picker input-daterange" data-date-format="dd/mm/yyyy">
                                 <input type="text" id="fechaEntregaPap" class="form-control" name="fechaEntregaPap" value="">
                                   </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <label class="control-label col-md-3">F.FINAL:</label>
                                 <div class="col-md-9">
                                    <div id="dpRange2" class="input-group date-picker input-daterange" data-date-format="dd/mm/yyyy">
                                 <input type="text" id="fechaFinalPap" class="form-control" name="fechaFinalPap" value="">
                                   </div>
                                </div>
                            </div>

                                </div>

                            <div class="form-group">
                                <div class="col-md-3">
                                    <label class="control-label col-md-3">ENTREGA:</label>
                                    <div class="col-md-9">
                                  <select id="entregaOxiId" class="form-control select2me">
                                            <option value="">Select...</option>
                                    </select>
                                </div>
                                </div>
                                <div class="col-md-3">
                                    <label class="control-label col-md-5">#AUTORIZACION</label>
                                    <div class="col-md-7">
                                  <input type="text" id="NumAutorizacionOxigeno" class="form-control" name="NumAutorizacionOxigeno" value="">
                                </div>
                                </div>
                                <div class="col-md-5">
                                <label class="control-label col-md-3">OBSERVACIÓN:</label>
                                <div class="col-md-9">
                                <textarea id="ObservacionId" class="form-control" name="ObservacionId" style="height:125px"></textarea>
                                 </div>
                                </div>
                                <div class="col-md-1">
                                    <button type="button" class="btn green pull-left" id="btnGuardarOxigeno" name="btnGuardarOxigeno" onclick="GuardarPedido();">Guardar</button>
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
