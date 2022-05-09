<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Views/Site.Master" CodeBehind="AgregaCirugia.aspx.cs" Inherits="Portal.Views.Pacientes.AgregaCirugia" %>

<asp:Content runat="server" ID="ContentTitle" ContentPlaceHolderID="Title">AGREGA CIRUGIA | SOLUGLOB IKON</asp:Content>

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
    <script src="/Assets/pages/scripts/Ingresos/Cirugia.js"></script>
    <script>
        window.onload = function () {
            CargaTipoCirugia("GetTipoCirugias", $("#tipoCirugiaId"));
            
            CargaMedicosCirugia("CargaMedicosCirugia", $("#CmbMedicoCirugia"));
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
                    <span class="caption-subject font-green sbold uppercase">AGREGA CIRUGIA</span>
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
                                <input id="pacienteCirugiaId" class="form-control" type="text" name="pacienteCirugiaId" value="<%= Pacientes %>" readonly/> 
                                 </div>
                            </div>
                            <div class="col-md-3">
                                <label class="control-label col-md-3">EPISODIO:</label>
                                <div class="col-md-9">
                                <input id="episodioCirugiaId" class="form-control" type="text" name="episodioCirugiaId" value="<%= Episodio %>" readonly/> 
                                    </div>
                            </div>
                            <div class="col-md-3">
                                <label class="control-label col-md-3">FECHA:</label>
                                <div class="col-md-9">
                                    <div id="dpRange" class="input-group date-picker input-daterange" data-date-format="dd/mm/yyyy">
                                 <input type="text" id="dprFromCirugia" class="form-control" name="dprFromCirugia" value="<%= DateTime.Now.ToString("dd/MM/yyyy") %>">
                                   </div>
                                </div>
                            </div>
                            </div>

                             <div class="form-group">
                                
                                 <div class="col-md-3">
                                     <label class="control-label col-md-3">Médico:</label>
                                <div class="col-md-9">
                                    <select id="CmbMedicoCirugia" class="form-control select2me">
                                            <option value="">Select...</option>
                                    </select>
                                </div>
                                 </div>

                            <div class="col-md-9">
                                <label class="control-label col-md-3">TIPO CIRUGIA:</label>
                                <div class="col-md-9">
                                    <select id="tipoCirugiaId" class="form-control select2me">
                                            <option value="">Select...</option>
                                    </select>
                                </div>
                            </div>
                                 

                            </div>
                            <div class="form-group">
                                 <div class="col-md-12">
                                <label class="control-label col-md-1">DESCRIPCION:</label>
                                <div class="col-md-9">
                                <textarea id="DescripcionId" class="form-control" name="DescripcionId" style="height:125px"></textarea>
                                 </div>
                                      <div class="col-md-2">
                                <button type="button" class="btn green pull-center" id="btnGuardarIngreso" name="btnGuardarIngreso" onclick="AgregaCirugiaEpi();">Guardar</button>
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
