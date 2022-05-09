function CargaSelect(Command, Control) {
    var NameTable = "Tabla";
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
            //b(Command, IdControl);
            alert("Falló la llamada");
        }
    });
}
function LeeDatosMedico(Command) {
    var NameTable = "Tabla";
    var Cedula = document.getElementById("CedulaAltaMed") ? $("#CedulaAltaMed").val() : null;

    App.blockUI({ target: "#Entradas_Portlet", boxed: !0, message: "Procesando…" });

    $.ajax({
        cache: false,
        type: "POST",
        url: "/AjaxQuerys/AjaxResponse.aspx/" + Command,
        data: JSON.stringify({ "cedula": Cedula }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {
           
            $.each(response.d, function (id, option) {

                document.getElementById("TelefonoAltaMed").value = option.Telefono;
                document.getElementById("EmailAltaMed").value = option.Correo;
                document.getElementById("DireccionAltaMed").value = option.Direccion;
                document.getElementById("RecadosAltaMed").value = option.Recados;
                document.getElementById("txtHorario").value = option.Horarios;
                $("#TipoMedico").val(option.IdTipo).trigger('change.select2'); 

            });

            App.unblockUI("#Entradas_Portlet");
        },
        failure: function (response) {
            //b(Command, IdControl);
            alert("Falló la llamada");
        }
    });
}

function AltaCatMedicos() {
    var cedula, nombre, telefono, recados, especialidad, email, direccion, activo, tipo, horario;
    cedula = null;
    nombre = null;
    telefono = null;
    recados = null;
    especialidad = null;
    email = null;
    direccion = null;
    activo = null;
    tipo = null;
    horario = null;

    cedula = document.getElementById("CedulaAltaMed") ? $("#CedulaAltaMed").val() : null;
    nombre = document.getElementById("NombreAltaMed") ? $("#NombreAltaMed").val() : null;
    telefono = document.getElementById("TelefonoAltaMed") ? $("#TelefonoAltaMed").val() : null;
    recados = document.getElementById("RecadosAltaMed") ? $("#RecadosAltaMed").val() : null;
    especialidad = document.getElementById("EspecialidadAltaMed") ? $("#EspecialidadAltaMed").val() : null;
    email = document.getElementById("EmailAltaMed") ? $("#EmailAltaMed").val() : null;
    direccion = document.getElementById("DireccionAltaMed") ? $("#DireccionAltaMed").val() : null;
    activo = $('#chkActivo').prop('checked') ? "1" : "0";
    tipo = document.getElementById("TipoMedico") ? $("#TipoMedico").val() : null;
    horario = document.getElementById("txtHorario") ? $("#txtHorario").val() : null;

    if ((cedula != "") && (nombre != "") && (telefono != "") && (especialidad != "") && (direccion != "") && (email != "") && (tipo!=""))
    {
        App.blockUI({ target: "#Entradas_Portlet", boxed: !0, message: "Procesando…" });

        $.ajax({
            cache: false,
            type: "POST",
            url: "/AjaxQuerys/AjaxResponse.aspx/setAltaMedico",
            data: JSON.stringify({ "cedula": cedula, "nombre": nombre, "telefono": telefono, "recados": recados, "especialidad": especialidad, "email": email, "direccion": direccion, "activo": activo,"tipomed": tipo,"Horario":horario }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {

                App.unblockUI("#Entradas_Portlet");
                alert(response.d);
                window.location = "/Gestion/GestionMedicos";
            },
            failure: function (response) {
                //b(Command, IdControl);
                alert("Falló la llamada");
            }
        });
    }
    else {
        alert("Falta ingresar algún dato, verifique todos los campos");
    }

}

function ActualizaCatMedicos() {
    var cedula, activo,tipo;
    cedula = null;
    activo = null;
    tipo = null;

    cedula = document.getElementById("CedulaAltaMed") ? $("#CedulaAltaMed").val() : null;
    activo = $('#chkActivo').prop('checked') ? "1" : "0";
    tipo = document.getElementById("TipoMedico") ? $("#TipoMedico").val() : null;
    
        App.blockUI({ target: "#Entradas_Portlet", boxed: !0, message: "Procesando…" });

        $.ajax({
            cache: false,
            type: "POST",
            url: "/AjaxQuerys/AjaxResponse.aspx/setAtualizaMedico",
            data: JSON.stringify({ "cedula": cedula, "activo": activo,"tipomed":tipo }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {

                App.unblockUI("#Entradas_Portlet");
                alert(response.d);
                window.location = "/Gestion/GestionMedicos";

            },
            failure: function (response) {
                //b(Command, IdControl);
                alert("Falló la llamada");
            }
        });
    

}


   