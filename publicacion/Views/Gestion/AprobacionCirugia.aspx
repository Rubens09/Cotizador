<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Views/Site.Master" CodeBehind="AprobacionCirugia.aspx.cs" Inherits="Portal.Views.Gestion.AprobacionCirugia" %>
<asp:Content runat="server" ID="ContentTitle" ContentPlaceHolderID="Title">APROBACION CIRUGIA| SOLUGLOB IKON</asp:Content>

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
</asp:Content>

<asp:Content runat="server" ID="ContectContentBody" ContentPlaceHolderID="ContentBody">
   <form class="form-horizontal">
        <!-- BEGIN PAGE BASE CONTENT -->
        <!-- BEGIN PORTLET -->
        <div class="portlet light portlet-fit portlet-form bordered" id="Entradas_Portlet">
            <div class="portlet-title">
                <div class="caption">
                    <i class="fa fa-sign-in font-green"></i>
                    <span class="caption-subject font-green sbold uppercase">Aprobación Cirugía</span>
                </div>
            </div>
            
            <div class="portlet-body">
                <div class="form-body" style="padding-top:0px;">
                    <div class="table-toolbar">
                        <div class="row">
                           <div class=" col-md-12">
                             
                                <div class="form-group">
                            <div class="col-md-4">
                            </div>
                            <div class="col-md-4">
                                <center>
                                    <input type="button" id="btnCancelarAuto" name="btnCancelarAuto" class="btn red" value="Cancelar" onclick="" />
                                    <input type="button" id="BtnAprobarAuto" name="BtnAprobarAuto" class="btn green" value="Aprobar" onclick="" /> 
                                </center>
                            </div>
                            <div class="col-md-4">
                            </div>
                        </div>
                                  <div class="form-group">
                                    
                                    <div class="col-md-12">
                                       <textarea id="txtDescripcionAprobacion" class="form-control" name="txtDescripcionAprobacion" style="height:125px"></textarea>
                                    </div>

                                </div>
                                <div class="form-group">
                                    <h1>Datos de Cirugia</h1>
                                    <h3>Paciente</h3>
                                    <div class="col-md-4">
                                        <label class="control-label col-md-3">Hospital:</label>
                                        <div class="col-md-9">
                                            <select id="cmbHospSolCir" class="form-control select2me" disabled="disabled">
                                                <option value="">Select...</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <label class="control-label col-md-3">Cirugía:</label>
                                        <div class="col-md-9">
                                            <select id="cmbCirSolCir" class="form-control select2me" disabled="disabled">
                                                <option value="">Select...</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <label class="control-label col-md-3">Causa:</label>
                                        <div class="col-md-9">
                                            <select id="cmbCausaSolCir" class="form-control select2me" disabled="disabled">
                                                <option value="">Select...</option>
                                            </select>
                                        </div>
                                    </div>

                                </div>

                                <div class="form-group">
                                    <div class="col-md-4">
                                        <label class="control-label col-md-3">Apellido Paterno Responsable:</label>
                                        <div class="col-md-9">
                                           <input id="txtApelliPatRespSolCir" class="form-control" type="text" name="txtApelliPatRespSolCir" value="" readonly /> 
                                        </div>
                                    </div>
                                      <div class="col-md-4">
                                        <label class="control-label col-md-3">Apellido Materno Responsable:</label>
                                        <div class="col-md-9">
                                            <input id="txtApelliMatRespSolCir" class="form-control" type="text" name="txtApelliMatRespSolCir" value="" readonly/> 

                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <label class="control-label col-md-3">Nombre Responsable:</label>
                                        <div class="col-md-9">
                                            <input id="txtNombreRespSolCir" class="form-control" type="text" name="txtNombreRespSolCir" value="" readonly/> 
                                        </div>
                                    </div>
                                </div>
                                 
                                <div class="form-group">
                                    <div class="col-md-7">
                                        <label class="control-label col-md-3">Paciente:</label>
                                        <div class="col-md-9">
                                            <select id="cmbPacienteSolCir" class="form-control select2me" disabled>
                                                <option value="">Select...</option>
                                            </select>
                                        </div>
                                    </div>
                                      <div class="col-md-3" id="EpisodioDiv">
                                        <label class="control-label col-md-3">Episodio:</label>
                                        <div class="col-md-9">
                                            <input id="txtEpisodioSolCir" class="form-control" type="text" name="txtEpisodioSolCir" value="" readonly/> 
                                        </div>
                                    </div>
                                    <div class="col-md-2">

                                    </div>

                                </div>
                               <div class="form-group">
                                   <div class="col-md-12">
                                       <h3>Diagnósticos y procedimientos Quirúrgicos</h3>
                                       <br/> <br />

                                            </div>
                                            </div>

                                       </div>

                                     </div>
                               <div class="form-group">
                                       <div class="col-md-6">
                                           <div id="ContenedorDiag" class="table-container" style="position:relative;">
                                                <div class="col-md-12">
                                                    <h4>Diagnostico</h4>
                                                    <table id="TableDiag" class="table table-striped table-bordered table-hover">
                                                        <thead>
                                                            <tr>
                                                            <th style="width:10%; text-align: center; vertical-align:middle">CIE10</th>
                                                            <th style="width:90%; text-align: center; vertical-align:middle">Descripcion</th>
                                                            </tr>
                                                        </thead>
                                                    <tbody style="text-align: center; font-size: large; font-weight: bold;">
                                                    </tbody>
                                                    </table>
                            </div>  
                            </div>
      
                                       </div>

                                    <div class="col-md-6">
                                           
                                        <div id="ContenedorCpt" class="table-container" style="position:relative;">
                                                <div class="col-md-12">
                                                    <h4>Procedimiento Quirurgico</h4>
                                                    <table id="TableCpt" class="table table-striped table-bordered table-hover">
                                                        <thead>
                                                            <tr>
                                                            <th style="width:10%; text-align: center; vertical-align:middle">Clave</th>
                                                            <th style="width:90%; text-align: center; vertical-align:middle">Descripcion</th>
                                                            </tr>
                                                        </thead>
                                                    <tbody style="text-align: center; font-size: large; font-weight: bold;">
                                                    </tbody>
                                                    </table>
                                                </div>  
                                        </div>
      
                                       </div>


                                   </div>
                        <div class="form-group">
                            <h4>Médico Tratante</h4>
                            <div class="col-md-12" style="border-style: solid; border-width: .5px; border-color: gray">
                                <div class="form-group">
                                    <div class="col-md-3">
                                         <label class="control-label col-md-3">Cédula:</label>
                                        <div class="col-md-9" >
                                            <input id="txtCedulaMedicoTratante" class="form-control" type="text" name="txtCedulaMedicoTratante" value="" readonly/> 
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <label class="control-label col-md-3">Médico:</label>
                                        <div class="col-md-9" >
                                            <input id="txtNombreMedicoTratante" class="form-control" type="text" name="txtNombreMedicoTratante" value="" readonly/> 
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <label class="control-label col-md-3">Especialidad:</label>
                                        <div class="col-md-9" >
                                             <select id="cmbEspecialidadCiru" class="form-control select2me" disabled>
                                                <option value="">Select...</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <label class="control-label col-md-3">Telefono:</label>
                                        <div class="col-md-9" >
                                            <input id="txtTelefonoCiru" class="form-control" type="text" name="txtTelefonoCiru" value="" readonly/> 
                                        </div>
                                    </div>
                                </div>
                           </div>
                        </div>
                       <div class="form-group">
                            <h4>Anestesiologo</h4>
                            <div class="col-md-12" style="border-style: solid; border-width: .5px; border-color: gray">
                                <div class="form-group">
                                    <div class="col-md-3">
                                         <label class="control-label col-md-3">Cédula:</label>
                                        <div class="col-md-9" >
                                            <input id="txtCedulaAnestesiologo" class="form-control" type="text" name="txtCedulaAnestesiologo" value="" readonly /> 
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <label class="control-label col-md-3">Anestesiologo:</label>
                                        <div class="col-md-9" >
                                             <input id="txtAnestesiologo" class="form-control" type="text" name="txtAnestesiologo" value="" readonly/> 
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <label class="control-label col-md-3">Telefono:</label>
                                        <div class="col-md-9" >
                                            <input id="txtTelefonoAnestesiologo" class="form-control" type="text" name="txtTelefonoAnestesiologo" value="" readonly/> 
                                        </div>
                                    </div>
                                </div>
                           </div>
                        </div>
                        <div class="form-group">
                            <h4>Primer Ayudante</h4>
                            <div class="col-md-12" style="border-style: solid; border-width: .5px; border-color: gray">
                                <div class="form-group">
                                    <div class="col-md-3">
                                         <label class="control-label col-md-3">Cédula:</label>
                                        <div class="col-md-9" >
                                            <input id="txtCedulaPrimerA" class="form-control" type="text" name="txtCedulaPrimerA" value="" readonly/> 
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <label class="control-label col-md-3">Ayudante:</label>
                                        <div class="col-md-9" >
                                             <input id="txtPrimerAyudante" class="form-control" type="text" name="txtPrimerAyudante" value="" readonly/> 
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <label class="control-label col-md-3">Telefono:</label>
                                        <div class="col-md-9" >
                                            <input id="txtTelefonoPrimerA" class="form-control" type="text" name="txtTelefonoPrimerA" value="" readonly/> 
                                        </div>
                                    </div>
                                </div>
                           </div>
                        </div>
                        
                        <div class="form-group">
                            <h4>Segundo Ayudante</h4>
                            <div class="col-md-12" style="border-style: solid; border-width: .5px; border-color: gray">
                                <div class="form-group">
                                    <div class="col-md-3">
                                         <label class="control-label col-md-3">Cédula:</label>
                                        <div class="col-md-9" >
                                            <input id="txtCedulaSegundoAyudante" class="form-control" type="text" name="txtCedulaSegundoAyudante" value="" readonly/> 
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <label class="control-label col-md-3">Ayudante:</label>
                                        <div class="col-md-9" >
                                             <input id="txtSegundoAyudante" class="form-control" type="text" name="txtSegundoAyudante" value="" readonly/> 
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <label class="control-label col-md-3">Telefono:</label>
                                        <div class="col-md-9" >
                                            <input id="txtTelefonoSegundoA" class="form-control" type="text" name="txtTelefonoSegundoA" value="" readonly/> 
                                        </div>
                                    </div>
                                </div>
                           </div>
                        </div>
                           <div class="form-group">
                                    <h3>Nota Médica</h3>
                                    <div class="col-md-12">
                                       <textarea id="txtNotaMedica" class="form-control" name="txtNotaMedica" style="height:125px" readonly></textarea>
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
