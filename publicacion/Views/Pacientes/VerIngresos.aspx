<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Views/Site.Master" CodeBehind="VerIngresos.aspx.cs" Inherits="Portal.Views.Pacientes.VerIngresos" %>

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
    <script src="/Assets/pages/scripts//Ingresos/TablaColapso.js" type="text/javascript"></script>
    <script src="/Assets/pages/scripts/Ingresos/ConsultaDetIngresos.js" type="text/javascript"></script>
    <script src="/Assets/pages/scripts/Modulos/Modulos.js"></script>

        <script>
            $('#TablePacienteIngresados tbody').on('click', 'tr', function (e) {
                document.getElementById("dprVerAlta").value = "";
            var campo1 = $(this).find("td:first").html();

            var campo2 = $(this).find("td:last").html();
            e.preventDefault();
            var renglon = $(this);
            var campo1, campo2, campo3, campo4,campo5, campo6,campo7,campo8;
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
                    case 4:
                        campo5 = $(this).text();
                    case 5:
                        campo6 = $(this).text();
                        break;
                    case 6:
                        campo7 = $(this).text();
                        break;
                    case 7:
                        campo8 = $(this).text();
                        break;
                }
            })
                var permiso = '<%= Session["Permiso"] %>';
            document.getElementById("NoCirugias").value = "";
            document.getElementById("pacienteVerId").value = campo1;
                document.getElementById("episodioVerId").value = campo2;
                document.getElementById("motivoVerId").value = campo3;
            document.getElementById("hospitalVerId").value = campo4;
            document.getElementById("montoVer").value = campo7; 
            document.getElementById("NoCirugias").value = campo8; 
            document.getElementById("FechaIngresoOculta").value = campo5;

            if (campo6 != "") {
                document.getElementById("dprVerAlta").setAttribute("readonly", "readonly");
                document.getElementById("dprVerAlta").setAttribute("disabled", "disabled");
                //document.getElementById("montoVer").setAttribute("readonly", "readonly");
                //document.getElementById("btnActualizaAlta").setAttribute("disabled", "disabled");
                if (permiso != "2" && permiso != "0")
                    document.getElementById("BtnAgregaMed").setAttribute("disabled", "disabled");

                document.getElementById("dprVerAlta").value = campo6 ? campo6 : null;
            }
            else {
                document.getElementById("dprVerAlta").removeAttribute("readonly");
                document.getElementById("dprVerAlta").removeAttribute("disabled");
                document.getElementById("montoVer").removeAttribute("readonly");
                document.getElementById("btnActualizaAlta").removeAttribute("disabled");
                document.getElementById("BtnAgregaMed").removeAttribute("disabled");
            }
            
            if (permiso != "5") {
                $('.modal-body').load('content.html', function () {
                    //console.log(textoRenglon);
                    document.getElementById("EditarDiagnostico").setAttribute("hidden", "hidden");
                    document.getElementById("txtDiagnostico").value = "";
                    document.getElementById("txtDiagnosticoOculto").value = "";
                    var DataColums; 
                    if (permiso == "0")
                    {
                        document.getElementById("lblMonto").removeAttribute("hidden");
                        document.getElementById("divMonto").removeAttribute("hidden");
                        document.getElementById("btnAgregaCirugias").removeAttribute("style");
                        document.getElementById("btnActualizaDiagnostico").removeAttribute("style");
                        document.getElementById("chkHospitalizado").removeAttribute("hidden");
                        document.getElementById("chkDefuncion").removeAttribute("hidden");
                        document.getElementById("dprVerAlta").removeAttribute("disabled");
                        document.getElementById("btnActualizaAlta").removeAttribute("style");
                        DataColums = [{ data: "Fecha" }, { data: "MOTIVO" }, { data: "DIAGNOSTICO" }, { data: "MEDICO" }, { data: "ESPECIALIDAD" },
                            { data: "TELEFONO" }, { data: "SERVICIO" }, { data: "NOTA" }, { data: "INTERCON" }, { defaultContent: "<button type='button' class='editar btn btn-primary' onclick='muestraEditarDiag(1)'><i class='fa fa-pencil'></i></button><button type='button' class='agregar btn btn-success' onclick='muestraFechaInterConsulta(1);' titla='Agregar InterConsulta'><i class='fa fa-plus'></i></button>" }];
                    }
                    else
                    {
                        document.getElementById("lblMonto").setAttribute("hidden", "hidden");
                        document.getElementById("divMonto").setAttribute("hidden", "hidden");
                        if ((permiso == "8") || (permiso == "7") || (permiso == "4")) {
                            document.getElementById("btnAgregaCirugias").removeAttribute("style");
                            document.getElementById("btnActualizaDiagnostico").removeAttribute("style");
                            document.getElementById("chkHospitalizado").removeAttribute("hidden");
                            document.getElementById("chkDefuncion").removeAttribute("hidden");
                            document.getElementById("dprVerAlta").removeAttribute("disabled");
                            document.getElementById("btnActualizaAlta").removeAttribute("style");
                        }
                        else
                        {
                            document.getElementById("btnAgregaCirugias").setAttribute("style", "display:none;");
                            document.getElementById("btnActualizaDiagnostico").setAttribute("style", "display:none;");
                            document.getElementById("chkHospitalizado").setAttribute("hidden", "hidden");
                            document.getElementById("chkDefuncion").setAttribute("hidden", "hidden");
                            document.getElementById("dprVerAlta").setAttribute("disabled", "disabled");
                            document.getElementById("btnActualizaAlta").setAttribute("style", "display:none;");
                        }
                        var conte="";
                        if (permiso == "4" || permiso=="8")
                            conte ="<button type='button' class='editar btn btn-primary' onclick='muestraEditarDiag(1)'><i class='fa fa-pencil'></i></button><button type='button' class='agregar btn btn-success' onclick='muestraFechaInterConsulta(1);' titla='Agregar InterConsulta'><i class='fa fa-plus'></i></button>"

                        DataColums = [{ data: "Fecha" }, { data: "MOTIVO" }, { data: "DIAGNOSTICO" }, { data: "MEDICO" }, { data: "ESPECIALIDAD" },
                        { data: "TELEFONO" }, { data: "SERVICIO" }, { data: "NOTA" }, { data: "INTERCON" }, { defaultContent: conte }];
                    }
                    CargaSelect("GetTipoInterconsulta", $("#TipoInterconsulta"),"");
                    CargaDetEpisodio("GetConsultaDetIngresados", $("#TableVerEpisodio"), DataColums, 7, campo1, campo2);
                    var DataColums = [{ data: "Fecha" }, { data: "TipoCirugia" }, { data: "Descripcion" }];
                    VerCirugias("GetTablaCirugia", $("#TableVerCirugia"), DataColums, 2);
                    //alert(renglon);
                    $('#myModal').modal({ show: true });
                });
            }
        });

          
            function Cambiar(i)
            {
                if (i == 2)
                {
                    document.getElementById("ContenedorModalCiru").setAttribute("hidden", "hidden");
                    document.getElementById("ContenedorModal").removeAttribute("hidden");
                    document.getElementById("btnVerCirugias").removeAttribute("style");
                    document.getElementById("btnVerIngresoDet1").setAttribute("style", "display:none;");
                    
                }
                else
                {
                    document.getElementById("ContenedorModal").setAttribute("hidden", "hidden");
                    document.getElementById("ContenedorModalCiru").removeAttribute("hidden");
                    document.getElementById("btnVerIngresoDet1").removeAttribute("style");
                    document.getElementById("btnVerCirugias").setAttribute("style", "display:none;");

                    //var DataColums = [{ data: "Fecha" }, { data: "TipoCirugia" }, { data: "Descripcion" }];
                    //VerCirugias("GetTablaCirugia", $("#TableVerCirugia"), DataColums, 2);

                }
            }

            function ActivaFDefuncion() {
                var activa = $('#chkDefuncion').prop('checked') ? "1" : "0";
                if (activa == "1") {
                    document.getElementById("dprDefuncion").removeAttribute("disabled");
                }
                else {
                    document.getElementById("dprDefuncion").setAttribute("disabled", "disabled");
                }
            }

            function AgregaCirugia() {
                var paci, epi;
                paci = document.getElementById("pacienteVerId").value;
                epi = document.getElementById("episodioVerId").value;
                window.location = "/Pacientes/AgregaCirugia?Pacientes="+paci+"&Episodio="+epi;
            }

            function muestraEditarDiag(x)
            {
                if (x == 1) {
                    document.getElementById("EditarDiagnostico").removeAttribute("hidden");
                    $('#TableVerEpisodio tbody').on('click', 'tr', function (e) {
                        e.preventDefault();
                        var renglon = $(this);
                        var campo3;
                        $(this).children("td").each(function (i) {
                            switch (i) {
                                case 2:
                                    campo3 = $(this).text();
                                    break;
                            }
                        })
                        
                        document.getElementById("txtDiagnostico").value = campo3;
                        document.getElementById("txtDiagnosticoOculto").value = campo3;
                        
                    });
                }
                else {
                    document.getElementById("EditarDiagnostico").setAttribute("hidden","hidden");
                }
            }

            function muestraFechaInterConsulta(x) {

                if (x == 1) {
                    document.getElementById("AgregarInterConsulta").removeAttribute("hidden");
                    $('#TableVerEpisodio tbody').on('click', 'tr', function (e) {
                        e.preventDefault();
                        var renglon = $(this);
                        var campo4, campo5;
                        $(this).children("td").each(function (i) {
                            switch (i) {
                                case 3:
                                    campo4 = $(this).text();
                                    break;
                                case 4:
                                    campo5 = $(this).text();
                                    break;
                            }
                        })
                        if (campo4 == "STAFF URGENCIAS")
                        {
                            document.getElementById("AgregarInterConsulta").setAttribute("hidden", "hidden");
                        }
                        document.getElementById("txtMedicoIntercon").value = campo4;
                        document.getElementById("txtEspecialidadIntercon").value = campo5;


                    });
                }

                else {
                    document.getElementById("AgregarInterConsulta").setAttribute("hidden", "hidden");
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
                    <span class="caption-subject font-green sbold uppercase">INGRESOS</span>
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
                                            <input type="text" id="dprFrom" class="form-control" name="from" value="<%=new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1).ToString("dd/MM/yyyy") %>">
                                            <span class="input-group-addon"> al </span>
                                            <input type="text" id="dprTo" class="form-control" name="to" value="<%=new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1).AddMonths(1).AddDays(-1).ToString("dd/MM/yyyy") %>">

                                            <input type="hidden" id="permisoHidden" name="permisoHidden" runat="server"/>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-3">PACIENTE:</label>
                                    <div class="col-md-9">
                                        <select id="pacienteVerIngresoId" class="form-control select2me ReloadDataTable">
                                            <option value="">Select...</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
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
                        <div class="col-md-12" style="text-align:center">
                        <table id="TablePacienteIngresados" class="table table-striped table-bordered table-hover">
                            <thead>
                                <tr>
                                    <th style="width:25%; text-align: center; vertical-align:middle">PACIENTE</th>
                                    <th style="width:10%; text-align: center; vertical-align:middle">EPISODIO</th>
                                    <th style="width:10%; text-align: center; vertical-align:middle">MOTIVO</th>
                                    <th style="width:10%; text-align: center; vertical-align:middle">HOSPITAL</th>
                                    <th style="width:15%; text-align: center; vertical-align:middle">INGRESO</th>
                                    <th style="width:15%; text-align: center; vertical-align:middle">ALTA</th>
                                    <th style="width:10%; text-align: center; vertical-align:middle">MONTO</th>
                                    <th style="width:5%; text-align: center; vertical-align:middle">NUMCIRUGIAS</th>
                                </tr>
                            </thead>
                            <tbody style="text-align: center; font-size: large; font-weight: bold;">
                            </tbody>
                        </table>
                      </div> 
                       </div>
                      </div>
                    </div>
<%--INICIA MODAL--%>
<div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog" id="mdialTamanio">
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">×</button>
                <h4 class="modal-title">Detalle Ingreso</h4>
            </div>
            <div class="modal-body">
                <div class="table-toolbar">
                <div class=" col-md-12">
                                <div class="form-group">
                                    <label class="control-label col-md-1">PAC:</label>
                                    <div class="col-md-7">
                                        <input type="text" id="pacienteVerId" class="form-control" name="pacienteVerId" readonly>
                                    </div>
                                    <label class="control-label col-md-1">EP:</label>
                                    <div class="col-md-3">
                                       <input type="text" id="episodioVerId" class="form-control" name="episodioVerId" readonly>
                                    </div>
                                </div>
                     <div class="form-group">
                                    <label class="control-label col-md-1">MOTIVO:</label>
                                    <div class="col-md-7">
                                        <input type="text" id="motivoVerId" class="form-control" name="motivoVerId" readonly>
                                    </div>
                                    <label class="control-label col-md-1">HOSPITAL:</label>
                                    <div class="col-md-3">
                                       <input type="text" id="hospitalVerId" class="form-control" name="hospitalVerId" readonly>
                                    </div>
                                </div>
                    <div class="form-group">
                        <label class="control-label col-md-1" id="lblMonto">MONTO:</label>
                        <div class="col-md-2" id="divMonto">
                                   <input type="number" min="0" step="any" id="montoVer" class="form-control" name="montoVer" value="">
                            </div>
                        <label class="control-label col-md-1">ALTA:</label>
                            <div class="col-md-2" id="divAlta">
                                <div id="dpRange1" class="input-group date-picker input-daterange" data-date-format="dd/mm/yyyy">
                                   <input type="text" id="dprVerAlta" class="form-control" name="dprVerAlta" value="">
                                </div>
                            </div>
                         <label class="control-label col-md-1">#CIRUGIAS:</label>
                        <div class="col-md-1">
                                   <input type="text" id="NoCirugias" class="form-control" name="NoCirugias" value="" readonly>
                            </div>
                          <div class="col-md-2">
                                <input type="button" id="btnVerCirugias" name="btnVerCirugias" class="btn green pull-right" onclick="Cambiar(1);" value="Ver Cirugias" />
                              <input type="button" id="btnVerIngresoDet1" name="btnVerIngresoDet1" class="btn blue pull-right" onclick="Cambiar(2);" value="Ver ingresos" style="display:none;" />
                            </div>
                        <div class="col-md-2">
                                <button type="button" id="btnAgregaCirugias" name="btnAgregaCirugias" class="btn green pull-right" onclick="AgregaCirugia();">Agrega Cirugias</button>
                            </div>

                    </div>
                     <div class="form-group">
                         <div class="col-md-2">
                                  <label class="control-label col-md-6">HOSPIT.:</label>
                         <div class="col-md-6" style="text-align:center">
                         <input type="checkbox" id="chkHospitalizado" name="chkHospitalizado" />
                         </div>
                             </div>
                         <div class="col-md-2">
                                  <label class="control-label col-md-6">COVID:</label>
                         <div class="col-md-6" style="text-align:center">
                         <input type="checkbox" id="chkCovid" name="chkCovid" />
                         </div>
                             </div>
                         <div class="col-md-2">
                         <label class="control-label col-md-6">DEFUNCION:</label>
                         <div class="col-md-6" style="text-align:center">
                         <input type="checkbox" id="chkDefuncion" name="chkDefuncion" onchange="ActivaFDefuncion();" />
                         </div>
                             </div>
                         <div class="col-md-3">
                         <label class="control-label col-md-3 pull-left">F. DEFU.:</label>
                         <div class="col-md-9">
                          <div id="dpRange2" class="input-group date-picker input-daterange" data-date-format="dd/mm/yyyy">
                               <input type="text" id="dprDefuncion" class="form-control" name="dprDefuncion" value="" disabled="disabled">
                          </div>
                             </div>
                             
                              
                          </div>
                         <div class="col-md-3">
                             <input type="hidden" name="FechaIngresoOculta" id="FechaIngresoOculta" value="" />
                                <input type="button" id="btnActualizaAlta" name="btnActualizaAlta" class="btn green pull-right" onclick="ActualizaAlta();" value="Actualizar">
                            </div>
                      </div>
                    <div id="EditarDiagnostico" class ="form-group" hidden="hidden">
                         <div class="col-md-8">
                                  <label class="control-label col-md-3">DIAGNOSTICO.:</label>
                         <div class="col-md-9" style="text-align:center">
                         <input type="text" id="txtDiagnostico" name="txtDiagnostico" class="form-control" />

                             <input type="hidden" id="txtDiagnosticoOculto" name="txtDiagnosticoOculto" />
                         </div>
                             </div>
                        <div class="col-md-4">
                            <input type="button" id="btnActualizaDiagnostico" name="btnActualizaDiagnostico" class="btn green pull-right" onclick="ActualizaDiagnostico()" value="Actualizar Diagnostico">
                        </div>
                    </div>
                    <div id="AgregarInterConsulta" class ="form-group" hidden="hidden">
                        
                             <div class="col-md-5">
                             <label class="control-label col-md-2">TIPO:</label>
                         <div class="col-md-10" style="text-align:center">
                               <select id="TipoInterconsulta" class="form-control select2me ReloadDataTable">
                                            <option value="">Select...</option>
                                        </select>
                             </div>
                                 </div>
                             <div class="col-md-5">
                             <label class="control-label col-md-3">F. INTER:</label>
                         <div class="col-md-9" style="text-align:center">
                           <div id="dpRange3" class="input-group date-picker input-daterange" data-date-format="dd/mm/yyyy">
                               <input type="text" id="dprInterConsulta" class="form-control" name="dprInterConsulta" value="" >
                          </div>
                             <input type="hidden" id="txtMedicoIntercon" name="txtMedicoIntercon" />
                             <input type="hidden" id="txtEspecialidadIntercon" name="txtEspecialidadIntercon" />
                         </div>
                        </div>
                             
                        <div class="col-md-2">
                            <input type="button" id="btnGuardarInterConsulta" name="btnGuardarInterConsulta" title="Agregar Interconsulta" class="btn green pull-right" onclick="AgregaInterconsulta()" value="Agregar Interconsulta">
                        </div>
                             
                    </div>

                    <div id="ContenedorModal" class="table-container" style="position:relative;">
                        <h3>Ingresos</h3>
                    <div class="col-md-12" style="text-align:center">
                        <div class="row">
                        <table id="TableVerEpisodio" class="table table-striped table-bordered table-hover">
                            <thead>
                                <tr>
                                    <th style="width:5%; text-align: center; vertical-align:middle">FECHA</th>
                                    <th style="width:15%; text-align: center; vertical-align:middle">MOTIVO</th>
                                    <th style="width:15%; text-align: center; vertical-align:middle">DIAGNOSTICO</th>
                                    <th style="width:20%; text-align: center; vertical-align:middle">MEDICO</th>
                                    <th style="width:10%; text-align: center; vertical-align:middle">ESPE</th>
                                    <th style="width:5%; text-align: center; vertical-align:middle">TEL</th>
                                    <th style="width:5%; text-align: center; vertical-align:middle">HOSP</th>
                                    <th style="width:15%; text-align: center; vertical-align:middle">NOTA</th>
                                    <th style="width:5%; text-align: center; vertical-align:middle">INTERCON</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody style="text-align: center; font-size: large; font-weight: bold;">
                            </tbody>
                        </table>
                      </div> 
                       </div>
                        
                        </div>

                    <div id="ContenedorModalCiru" class="table-container" style="position:relative;" hidden="hidden">
                        <h3>Cirugias</h3>
                    <div class="col-md-12" style="text-align:center">
                        <div class="row">
                        <table id="TableVerCirugia" class="table table-striped table-bordered table-hover">
                            <thead>
                                <tr>
                                    <th style="width:20%; text-align: center; vertical-align:middle">FECHA</th>
                                    <th style="width:30%; text-align: center; vertical-align:middle">TIPO</th>
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
<%--TERMINA MODAL--%>
                 
                    </div>
                </div>
            </div>
        <!-- END PORTLET -->
        <!-- END PAGE BASE CONTENT -->
    </form>
</asp:Content>
