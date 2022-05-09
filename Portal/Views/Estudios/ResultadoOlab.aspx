<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Site.master" AutoEventWireup="true" CodeBehind="ResultadoOlab.aspx.cs" Inherits="Portal.Views.Estudios.ResultadoOlab" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Title" runat="server">
    RESULTADOS OLAB | SOLUGLOB IKON
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="PageLevelPluginsCSS" runat="server">
    <link href="/Scripts/DataTablesv2/DataTables-1.10.18/css/jquery.dataTables.min.css" rel="stylesheet" />
    <link href="/Scripts/DataTablesv2/datatables.min.css" rel="stylesheet" />
    <link href="/Scripts/DataTablesv2/Buttons-1.5.4/css/buttons.dataTables.min.css" rel="stylesheet" />
    <link href="/Scripts/DataTablesv2/Buttons-1.5.4/css/buttons.bootstrap.min.css" rel="stylesheet" />
    <link href="/Scripts/DataTablesv2/DataTables-1.10.18/css/dataTables.bootstrap.min.css" rel="stylesheet" />
    <link href="/Assets/global/plugins/select2/css/select2.min.css" rel="stylesheet" type="text/css" />
    <link href="/Assets/global/plugins/select2/css/select2-bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="/Assets/global/plugins/bootstrap-datepicker/css/bootstrap-datepicker3.min.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageLevelPluginsJS" runat="server">
    <script src="/Scripts/DataTablesv2/datatables.min.js"></script>
    <script src="/Scripts/DataTablesv2/Buttons-1.5.4/js/buttons.print.min.js"></script>
    <script src="/Scripts/DataTablesv2/Buttons-1.5.4/js/buttons.html5.min.js"></script>
    <script src="/Scripts/DataTablesv2/Buttons-1.5.4/js/dataTables.buttons.min.js"></script>
    <script src="/Scripts/DataTablesv2/Buttons-1.5.4/js/buttons.bootstrap.min.js"></script>
    <script src="/Assets/global/plugins/select2/js/select2.full.min.js" type="text/javascript"></script>
    <script src="/Assets/global/plugins/bootstrap-datepicker/js/bootstrap-datepicker.min.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="PageLevelScripts" runat="server">
    <script src="/Assets/pages/scripts/Reportes/CargaDataTables.js"></script>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="ContentBody" runat="server">
    <form class="form-horizontal">
        <div class="portlet light portlet-fit portlet-form bordered" id="Entradas_Portlet">
            <div class="portlet-title">
                <div class="caption">
                    <i class="fa fa-sign-in font-green"></i>
                    <span class="caption-subject font-green sbold uppercase">RESULTADOS OLAB</span>
                </div>
            </div>
            <div class="portlet-body">
                <div class="form-body" style="padding-top: 0px;">
                    <div class="table-toolbar">
                        <div class="row">
                            <div class=" col-md-8">
                                <div class="form-group">
                                    <label class="control-label col-md-3">Estudio</label>
                                    <div class="col-md-9">
                                        <div id="dpRange" class="input-group ">
                                            <input type="text" id="txtFolio" class="form-control" name="txtFolio">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <%--Boton para descargas de pdf excel--%>
                            <div class="col-md-3">
                                <input type="button" class="btn green pull-right" onclick="CargaResultadosOlab()" value="Cargar">
                                <br />
                                <br />
                                <input type="button" class="btn red pull-right" value="Descargar Resultado" id="DesResultadoOlabPdf" name="DescargaPdf" onclick="DescargaResultado();">
                            </div>

                        </div>
                    </div>
                    <div class="col-md-2" id="divcmdDescargaOlab">
                    </div>
                    <div class="table-toolbar">
                        <div class="row">
                            <div id="Contenedor" class="table-container" style="position: relative;">
                                <div class="col-md-12">
                                    <table id="TableResultadoOlab" class="table table-striped table-bordered table-hover">
                                        <thead>
                                            <tr>
                                                <th style="width: 10%; text-align: center; vertical-align: middle">SOLICITUD</th>
                                                <th style="width: 15%; text-align: center; vertical-align: middle">PROVEEDOR</th>
                                                <th style="width: 10%; text-align: center; vertical-align: middle">SUCURSAL</th>
                                                <th style="width: 10%; text-align: center; vertical-align: middle">ESTUDIO</th>
                                                <th style="width: 15%; text-align: center; vertical-align: middle">FECHA_RECEPCIÓN</th>

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
    </form>
</asp:Content>
