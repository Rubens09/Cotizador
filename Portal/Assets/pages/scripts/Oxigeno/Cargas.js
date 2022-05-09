var ddlPaciente, NameTable, ddlCalle, ddlCp, ddlColonia, ddlDelegacion, ddlTelefono, ddlFamiliar, ddlTelFam, ddlCilindro, ddlPortatil;
var ddlConcentrador, ddlFEntrega, ddlPap, ddlFEntregaPap, ddlEntrega, ddlObservacion,ddlNumAutorizacion,ddlFechaFinOxi,ddlFechaFinPap;
var tipo;
function CargaInicial() {
    var tipocarga;
    NameTable = "Nombre";
    ddlPaciente = null;
    ddlPaciente = document.getElementById("txtpacienteOxiId") ? $("#txtpacienteOxiId").val() : null;
    if (ddlPaciente != "") {
        document.getElementById("calleOxiId").setAttribute("readonly", "readonly");
        document.getElementById("coloniaOxiId").setAttribute("readonly", "readonly");
        document.getElementById("cpOxiId").setAttribute("readonly", "readonly");
        document.getElementById("delegacionOxiId").setAttribute("readonly", "readonly");
        document.getElementById("telPacOxiId").setAttribute("readonly", "readonly");
        document.getElementById("famPacOxiId").setAttribute("readonly", "readonly");
        document.getElementById("telFamId").setAttribute("readonly", "readonly");
        document.getElementById("divtxtPaciente").removeAttribute("hidden");
        document.getElementById("divselectPaciente").setAttribute("hidden", "hidden");
        tipocarga = 2;
    }
    else {
        document.getElementById("divselectPaciente").removeAttribute("hidden");
        document.getElementById("divtxtPaciente").setAttribute("hidden", "hidden");
    CargaSelect($("#pacienteOxiId"),"GetPacienteAddOxi");
    }

    CargaSelect($("#cilindroOxiId"), "GetCilindrosAddOxi");
    CargaSelect($("#concentradorOxiId"),"GetSiNoAddOxi");
    CargaSelect($("#portatilOxiId"),"GetSiNoAddOxi");
    CargaSelect($("#papOxiId"),"GetPapAddOxi");
    CargaSelect($("#entregaOxiId"), "GetEntregaAddOxi");
    CargaSelect($("#portatilOxiId"), "GetSiNoAddOxi");
    if (tipocarga == 2) {
        CargaDatos(2);
    }
}
function CargaSelect(Control, Command) {
    App.blockUI({ target: "#Entradas_Portlet", boxed: !0, message: "Procesando…" });
    $.ajax({
        cache: false,
        type: "POST",
        url: "/AjaxQuerys/AjaxResponse.aspx/" + Command,
        data: JSON.stringify({ "NombreTabla": NameTable }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {
            Control.html('');
            Control.append($('<option></option>').val("").html("Select"));
            $.each(response.d, function (id, option) {
                Control.append($('<option></option>').val(option.Id).html(option.Name));
            });
            App.unblockUI("#Entradas_Portlet");
        },
        failure: function (response) {
            alert("Error en la carga");
            App.unblockUI("#Entradas_Portlet");
        }
    });
}

function CargaDatos(opcion) {
    tipo = opcion;
    if (opcion == 1) {
        ddlPaciente = null;
        ddlPaciente = document.getElementById("pacienteOxiId") ? $("#pacienteOxiId").val() : null;
    }

    if (ddlPaciente != "") {
    App.blockUI({ target: "#Entradas_Portlet", boxed: !0, message: "Procesando…" });
    $.ajax({
        cache: false,
        type: "POST",
        url: "/AjaxQuerys/AjaxResponse.aspx/GetDetPacAddOxi" ,
        data: JSON.stringify({ "paciente": ddlPaciente,"tipo":tipo }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {
            $.each(response.d, function (id, option) {
                document.getElementById("calleOxiId").value = option.CALLE; 
                document.getElementById("coloniaOxiId").value = option.COLONIA;
                document.getElementById("cpOxiId").value = option.CP;
                document.getElementById("delegacionOxiId").value = option.DELEGACION;
                document.getElementById("telPacOxiId").value = option.TELEFONO;
                document.getElementById("famPacOxiId").value = option.FAMILIARRESPONSABLE;
                document.getElementById("telFamId").value = option.TELEFONORESPONSABLE;
                document.getElementById("NumAutorizacionOxigeno").value = option.NumAutorizacion;
                if ((option.NumAutorizacion != null))
                document.getElementById("NumAutorizacionOxigeno").setAttribute("disabled", "disabled");

                var hospi = option.IDCILINDRO;
                if (hospi != null) {
                    $("#cilindroOxiId").val(hospi).trigger('change.select2');
                    document.getElementById("cilindroOxiId").setAttribute("disabled", "disabled");
                }
                hospi = "";
                hospi = option.IDPORTATIL;
                if (hospi != null) {
                    $("#portatilOxiId").val(hospi).trigger('change.select2');
                    document.getElementById("portatilOxiId").setAttribute("disabled", "disabled");
                }
                hospi = "";
                hospi = option.CONCENTRADOR;
                if (hospi != null) {
                    $("#concentradorOxiId").val(hospi).trigger('change.select2');
                    document.getElementById("concentradorOxiId").setAttribute("disabled", "disabled");
                }
                hospi = "";
                hospi = option.IDPAP;
                if (hospi != null) {
                    $("#papOxiId").val(hospi).trigger('change.select2');
                    document.getElementById("papOxiId").setAttribute("disabled", "disabled");
                }
                hospi = "";
                hospi = option.IDENTREGA;
                
                //if (hospi != null) {
                //    $("#entregaOxiId").val(hospi).trigger('change.select2');
                //    if (hospi !=3) {
                //        document.getElementById("entregaOxiId").setAttribute("disabled", "disabled");
                //    }
                //}
                
                document.getElementById("fechaEntregaOxi").value = option.FECHAENTREGAOXIGENO;
                document.getElementById("fechaEntregaPap").value = option.FECHAENTREGAPAP;
                document.getElementById("ObservacionId").value = option.COMENTARIOS;

            });

            App.unblockUI("#Entradas_Portlet");
        },
        failure: function (response) {
            alert("Error en la carga");
            App.unblockUI("#Entradas_Portlet");
        }
    });
    }

}

function GuardarPedido() {



    ddlCalle = null;
    ddlCp = null;
    ddlColonia = null;
    ddlDelegacion = null;
    ddlTelefono = null;
    ddlFamiliar = null;
    ddlTelFam = null;
    ddlCilindro = null;
    ddlPortatil=null;
    ddlConcentrador = null;
    ddlFEntrega = null;
    ddlPap = null;
    ddlFEntregaPap = null;
    ddlEntrega = null;
    ddlObservacion = null;
    ddlNumAutorizacion = null;
    ddlFechaFinOxi = null;
    ddlFechaFinPap = null;


    ddlCalle = document.getElementById("calleOxiId") ? $("#calleOxiId").val() : null;
    ddlCp = document.getElementById("cpOxiId") ? $("#cpOxiId").val() : null;
    ddlColonia = document.getElementById("coloniaOxiId") ? $("#coloniaOxiId").val() : null;
    ddlDelegacion = document.getElementById("delegacionOxiId") ? $("#delegacionOxiId").val() : null;
    ddlTelefono = document.getElementById("telPacOxiId") ? $("#telPacOxiId").val() : null;
    ddlFamiliar = document.getElementById("famPacOxiId") ? $("#famPacOxiId").val() : null;
    ddlTelFam = document.getElementById("telFamId") ? $("#telFamId").val() : null;
    ddlCilindro = document.getElementById("cilindroOxiId") ? $("#cilindroOxiId").val() : null;
    ddlPortatil = document.getElementById("portatilOxiId") ? $("#portatilOxiId").val() : null;
    ddlConcentrador = document.getElementById("concentradorOxiId") ? $("#concentradorOxiId").val() : null;
    ddlFEntrega = document.getElementById("fechaEntregaOxi") ? $("#fechaEntregaOxi").val() : null;
    ddlPap = document.getElementById("papOxiId") ? $("#papOxiId").val() : null;
    ddlFEntregaPap = document.getElementById("fechaEntregaPap") ? $("#fechaEntregaPap").val() : null;
    ddlEntrega = document.getElementById("entregaOxiId") ? $("#entregaOxiId").val() : null;
    ddlObservacion = document.getElementById("ObservacionId") ? $("#ObservacionId").val() : null;
    ddlNumAutorizacion = document.getElementById("NumAutorizacionOxigeno") ? $("#NumAutorizacionOxigeno").val() : null;
    ddlFechaFinPap = document.getElementById("fechaFinalPap") ? $("#fechaFinalPap").val() : null;
    ddlFechaFinOxi = document.getElementById("fechaFinalOxi") ? $("#fechaFinalOxi").val() : null;;

    Guardar();
    
}

function Guardar()
{
    App.blockUI({ target: "#Entradas_Portlet", boxed: !0, message: "Procesando…" });
    $.ajax({
        cache: false,
        type: "POST",
        url: "/AjaxQuerys/AjaxResponse.aspx/SetAddOxi",
        data: JSON.stringify({
            "tipo": tipo, "paciente": ddlPaciente, "cilindro": ddlCilindro, "pap": ddlPap, "portatil": ddlPortatil, "concentrado": ddlConcentrador, "entrega": ddlEntrega, "comentarios": ddlObservacion, "fechaoxi": ddlFEntrega, "fechapap": ddlFEntregaPap, "calle": ddlCalle, "colonia": ddlColonia, "cp": ddlCp, "delegacion": ddlDelegacion, "telefono": ddlTelefono, "familiar": ddlFamiliar, "telefonoresp": ddlTelFam, "NumAutorizacion": ddlNumAutorizacion, "FechaFinOxi": ddlFechaFinOxi,"FechaFinPap":ddlFechaFinPap  }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {
            window.location = "/Servicios/VerOxigeno";
                alert("Guardado Exitosamente");
            App.unblockUI("#Entradas_Portlet");
        },
        failure: function (response) {
            alert("Error en la carga");
            App.unblockUI("#Entradas_Portlet");
        }
    });

}