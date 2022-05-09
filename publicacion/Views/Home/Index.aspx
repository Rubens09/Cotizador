 <%@ Page Title="HomePage" Language="C#" Debug="true" MasterPageFile="~/Views/Site.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="Portal.Views.Home.Index" %>

<asp:Content runat="server" ID="ContentTitle" ContentPlaceHolderID="Title">INICIO | SOLUGLOB IKON</asp:Content>

<asp:Content runat="server" ID="ContectPageLevelPluginsCSS" ContentPlaceHolderID="PageLevelPluginsCSS">
    <link href="../../Assets/pages/css/Custom.css" rel="stylesheet" />
     <link href="/Scripts/DataTablesv2/DataTables-1.10.18/css/jquery.dataTables.min.css" rel="stylesheet" />
    <link href="/Scripts/DataTablesv2/datatables.min.css" rel="stylesheet" />
    <link href="/Scripts/DataTablesv2/Buttons-1.5.4/css/buttons.dataTables.min.css" rel="stylesheet" />
    <link href="/Scripts/DataTablesv2/Buttons-1.5.4/css/buttons.bootstrap.min.css" rel="stylesheet" />
    <link href="/Scripts/DataTablesv2/DataTables-1.10.18/css/dataTables.bootstrap.min.css" rel="stylesheet" />
    <link href="/Assets/global/plugins/select2/css/select2.min.css" rel="stylesheet" type="text/css" />
    <link href="/Assets/global/plugins/select2/css/select2-bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="/Assets/global/plugins/bootstrap-datepicker/css/bootstrap-datepicker3.min.css" rel="stylesheet" type="text/css" />
    <link href="/Content/sweetalert.css" rel="stylesheet" />
</asp:Content>

<asp:Content runat="server" ID="ContectPageLevelPluginsJS" ContentPlaceHolderID="PageLevelPluginsJS">
    <script src="/Assets/global/plugins/counterup/jquery.waypoints.min.js" type="text/javascript"></script>
    <script src="/Assets/global/plugins/counterup/jquery.counterup.min.js" type="text/javascript"></script>
    <script src="/Scripts/DataTablesv2/datatables.min.js"></script>
    <script src="/Scripts/DataTablesv2/Buttons-1.5.4/js/buttons.print.min.js"></script>
    <script src="/Scripts/DataTablesv2/Buttons-1.5.4/js/buttons.html5.min.js"></script>
    <script src="/Scripts/DataTablesv2/Buttons-1.5.4/js/dataTables.buttons.min.js"></script>
    <script src="/Scripts/DataTablesv2/Buttons-1.5.4/js/buttons.bootstrap.min.js"></script>
    <script src="/Assets/global/plugins/select2/js/select2.full.min.js" type="text/javascript"></script>
    <script src="/Assets/global/plugins/bootstrap-datepicker/js/bootstrap-datepicker.min.js" type="text/javascript"></script>
    <script src="/Scripts/sweetalert.min.js"></script>
</asp:Content>

<asp:Content runat="server" ID="Content1" ContentPlaceHolderID="PageLevelScripts">
    <script src="/Assets/pages/scripts/Home.min.js" type="text/javascript"></script>
    <script src="/Assets/pages/scripts/components-date-time-pickers.min.js" type="text/javascript"></script>
    <script src="/Assets/pages/scripts/components-select2.min.js" type="text/javascript"></script>
    <script src="/Assets/pages/scripts/components-select2.min.js" type="text/javascript"></script>
    <script src="/Assets/pages/scripts/AjaxQuerys.min.js"></script>
    <script src="/Assets/pages/scripts/Modulos/Modulos.js"></script>
    <script>
        function VerIngreso() {
            window.location = "/Pacientes/VerIngresos";
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
                    <span class="caption-subject font-green sbold uppercase">PADRON DE DERECHOHABIENTES</span>
                </div>
            </div>
            <div class="portlet-body">
                <div class="form-body" style="padding-top:0px;">
                   <div class="table-toolbar">
                        <div class="row">
                            <div class=" col-md-8">
                                <div class="form-group">
                                    <label class="control-label col-md-3">PACIENTE:</label>
                                    <div class="col-md-9">
                                        <select id="pacienteId" class="form-control select2me ReloadDataTable">
                                            <option value="">Select...</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="col-md-6">
                                    <button type="button" class="btn green pull-right" id="btnIngreso" name="btnIngreso" onclick="CambiaServicio(1);">INGRESO</button>    
                                </div>
                                <div class="col-md-6">
                                    <button type="button" class="btn green pull-center" id="btnVerIngreso" name="btnVerIngreso" onclick="VerIngreso();">VER INGRESOS</button>
                                </div>

                                <%--<div class="col-md-6"><button type="button" class="btn green pull-right" id="btnServicio" name="btnServicio" runat="server">SERVICIO</button></div>--%>
                                 <% if (Session["Permiso"]!=null)
                                     {
                                         string permiso = "";
                                         permiso = Session["Permiso"].ToString();
                                          %>
                                     <input type="hidden" name="PermisoId" id="PermisoId" value="<%= permiso %>" />
                                 <%     
                                     }
                                %>
                                
                            </div>
                        </div>
                    </div>
                    <div class="table-toolbar">
                        <div class="row">
                    <div id="Contenedor" class="table-container" style="position:relative;">
                        <div class="col-md-12" style="text-align:center">
                        <table id="TablePaciente" class="table table-striped table-bordered table-hover">
                            <thead>
                                <tr>
                                    <th style="width:10%; text-align: center; vertical-align:middle">AFILIACION</th>
                                    <th style="width:40%; text-align: center; vertical-align:middle">NOMBRE</th>
                                    <th style="width:10%; text-align: center; vertical-align:middle">SEXO</th>
                                    <th style="width:20%; text-align: center; vertical-align:middle">NACIMIENTO</th>
                                    <th style="width:10%; text-align: center; vertical-align:middle">PARENTESCO</th>
                                    <th style="width:20%; text-align: center; vertical-align:middle">TIPO PACIENTE</th>
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
        </div>
        <!-- END PORTLET -->
        <!-- END PAGE BASE CONTENT -->
    </form>
</asp:Content>
