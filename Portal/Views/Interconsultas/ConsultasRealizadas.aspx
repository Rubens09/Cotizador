<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Views/Site.Master" CodeBehind="ConsultasRealizadas.aspx.cs" Inherits="Portal.Views.Interconsultas.ConsultasRealizadas" %>
<asp:Content runat="server" ID="ContentTitle" ContentPlaceHolderID="Title">CONSULTAS REALIZADAS | SOLUGLOB IKON</asp:Content>

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
    <script src="/Assets/pages/scripts/Interconsultas/AjaxConsultasRealizadas.js"></script>
</asp:Content>

<asp:Content runat="server" ID="ContectContentBody" ContentPlaceHolderID="ContentBody">
   <form class="form-horizontal">
        <!-- BEGIN PAGE BASE CONTENT -->
        <!-- BEGIN PORTLET -->
        <div class="portlet light portlet-fit portlet-form bordered" id="Entradas_Portlet">
            <div class="portlet-title">
                <div class="caption">
                    <i class="fa fa-sign-in font-green"></i>
                    <span class="caption-subject font-green sbold uppercase">CONSULTAS REALIZADAS</span>
                </div>
            </div>
            <div class="portlet-body">
                <div class="form-body" style="padding-top:0px;">
                    <div class="table-toolbar">
                        <div class="row">
                            <div class=" col-md-8">
                                 <div class="form-group">
                                     <label class="control-label col-md-3">Rango de Fecha:</label>
                                    <div class="col-md-9">
                                        <div id="dpRange" class="input-group date-picker input-daterange ReloadDataTable" data-date-format="dd/mm/yyyy">
                                            <input type="text" id="dprFromConsulReal" class="form-control" name="dprFromConsulReal" value="<%=new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1).ToString("dd/MM/yyyy") %>">
                                            <span class="input-group-addon"> al </span>
                                            <input type="text" id="dprToConsulReal" class="form-control" name="dprToConsulReal" value="<%=new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1).AddMonths(1).AddDays(-1).ToString("dd/MM/yyyy") %>">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <%--Boton para descargas de pdf excel--%>
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
                            <div class="col-md-12">
                                <table id="TableConsultaRealizada" class="table table-striped table-bordered table-hover">
                                    <thead>
                                        <tr>
                                            <th style="width:20%; text-align: center; vertical-align:middle">MEDICO</th>
                                            <th style="width:20%; text-align: center; vertical-align:middle">ESPECIALIDAD</th>
                                            <th style="width:10%; text-align: center; vertical-align:middle">FECHA CONSULTA</th>
                                            <th style="width:20%; text-align: center; vertical-align:middle">AFILIACION</th>
                                            <th style="width:20%; text-align: center; vertical-align:middle">PACIENTE</th>
                                            <th style="width:10%; text-align: center; vertical-align:middle">TIPO PAC.</th>
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
