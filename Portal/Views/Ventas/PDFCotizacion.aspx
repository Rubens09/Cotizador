<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/Views/Site.Master" CodeBehind="PDFCotizacion.aspx.cs" Inherits="Portal.Views.Ventas.Cotizador" %>

<asp:Content runat="server" ID="ContentTitle" ContentPlaceHolderID="Title">COTIZADOR VENTA | GRUPO MEDRANO</asp:Content>

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
    label{
        font-size:13px;
    }
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
    <script src="/Scripts/PDFV/html2pdf.bundle.min.js" type="text/javascript"></script>
</asp:Content>

<asp:Content runat="server" ID="ContectPageLevelScripts" ContentPlaceHolderID="PageLevelScripts">
    <script src="/Assets/pages/scripts/components-date-time-pickers.min.js" type="text/javascript"></script>
    <script src="/Assets/pages/scripts/components-select2.min.js" type="text/javascript"></script>
    <script src="/Assets/pages/scripts/Ventas/AjaxQueryVentas.js"></script>
    <script>window.onload = function () {
    CargarPDF();
        };</script>
</asp:Content>
<asp:Content runat="server" ID="ContectContentBody" ContentPlaceHolderID="ContentBody">
    <div style="background:white;" id="boton"><button id="btnCrearPdf" onclick="GenerarPDF()" class="form-control btn red" style="width:100px;height:50px;margin-left:2em;margin-block:2em;">Generar PDF</button></div>
   <div class="form-horizontal" style="background:white;">
       <form style="background:white;" id="DocumentPDF"> 
            <center><br><br>
                <table style="line-height:5;">
                    <tr>
                        <td><img src="/Views/Ventas/src/LogoMedrano.jpg" style="width:420px;"/></td>
                    </tr>
                </table>
                <div style="width:700px;line-height: 1.5;">
                    <div style="text-align: right;">
                        <label>Cuautitlán Izcalli, México a </label>
                        <label id="Dia"></label>
                        <label> de </label>
                        <label id="Mes"></label>
                        <label> de </label>
                        <label id="Anio"></label>
                    </div>
                    <div style="text-align: left;line-height: 5;">
                        <label>Atn:</label>
                        <label id="NombreCliente"></label>
                    </div>
                    <div style="text-align: left;line-height: 2;">
                        <label>Presente: </label>
                    </div>
                    <div style="text-align: justify;">
                        A continuación, de acuerdo a su amable solicitud, le hago llegar tarifas en
                servicio terrestre con equipo de 53” con origen y destino como se detallan:
                    </div>
                    <br>
                    <div style="align-items: center;">
                        <table style="width: 650px;text-align: center;" border="1">
                            <tr style="background-color: red;">
                                <td>
                                    <label style="color:white;">Origen</label>
                                </td>
                                <td>
                                    <label style="color: white;">Destino</label>
                                </td>
                                <td>
                                    <label style="color: white;">Costo</label>
                                </td>
                            </tr>
                            <tr>
                                <td><label id="Origen"></label></td>
                                <td><label id="Destino"></label></td>
                                <td><label id="Costo"></label></td>
                            </tr>
                        </table>
                    </div><br><br>
                    <div style="text-align: justify;">
                        <strong><u><label >Ruta: </label></u></strong>
                        <ol>
                            <li> Autopista vía Matías Romero (incluida en la tarifa) </li>
                            <li> vía Las Choapas (USD 100 adicionales), previa autorización y/o notificación del cliente.</li>
                        </ol>
                    </div>
                    <br>
                    <div style="text-align: justify;">
                        <strong><u><label >Incluye: </label></u></strong>
                        <ul type="disc">
                            <li> Rastreo GPS en todo el trayecto. </li>
                            <li> Monitoreo las 24 horas del día. </li>
                            <li> 8 horas para cargar y 8 horas para descarga. </li>
                            <li> 24 hrs. para despacho aduanal en frontera. </li>
                        </ul>
                    </div><br>
                    <div style="text-align: justify;">
                        <strong><u><label >No incluye: </label></u></strong>
                        <ul type="disc">
                            <li> Impuestos. </li>
                            <li> Maniobras de carga y descarga. </li>
                            <li> Demoras y/o estadías. </li>
                            <li> Seguro de mercancía. </li>
                        </ul>
                    </div><br>
                    <div style="text-align: justify;">
                        <strong><u><label >Terminos y condiciones: </label></u></strong>
                        <ul type="disc">
                            <li> Carga a transportar dentro del peso legal permitido (20 ton). </li>
                            <li> Solicitud de unidades para cargar con 48 horas de anticipación. </li>
                            <li> En caso de incurrir en demoras en origen, frontera o destino, se
                                facturarán USD 100 por tractor y USD 150 por el equipo, por concepto
                                de estadía (24 hrs). </li>
                            <li> En caso de cancelación se deberá reportar con 24hrs de anticipación,
                                de lo contrario se considerará movimiento en falso de $5,500 MN. más
                                IVA. </li>
                            <li> carga viaja por cuenta y riesgo del cliente. </li>
                            <li> La presente cotización tiene vigencia hasta el 31 de mayo 2022. </li>
                        </ul>
                    </div><br>
                    <div style="text-align: justify;">
                        <label>Atentamente</label><br>
                        <label>Luis Eduardo Rodríguez</label><br>
                        <label>Coordinador Comercial</label><br>
                    </div><br>
                </div>
            </center>
        </form>
    </div>
</asp:Content>
