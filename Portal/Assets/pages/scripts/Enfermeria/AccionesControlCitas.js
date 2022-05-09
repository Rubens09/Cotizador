function BuscaValores()
{
    var t = $('#TableConsultaAgendadaEnferme').DataTable();
    var datas, numFilas, cuenta;
    var numFilas = 0;
    var cuenta = 0;

    t.rows().every(function (rowIdx, tableLoop, rowLoop) {
        datas = this.data();
    });
    if (datas != null) {

        $('#TableConsultaAgendadaEnferme tbody tr').each(function () {
            var fila = $(this).find("select").val();
            //var cm = fila.find(".EstatusCita").val();
            if (fila != null) {
                if (fila != "SELECCIONAR")
                {
                    numFilas = numFilas + 1;
                }
            }

        });
        var filas = t.rows().data();

        var cedulas = new Array(numFilas);
        var afiliacion = new Array(numFilas);
        var Estados = new Array(numFilas);
        var FechaCita = new Array(numFilas);
        var appoint = new Array(numFilas);
        var encounter = new Array(numFilas);

        $('#TableConsultaAgendadaEnferme tbody tr').each(function () {
            var estatus = $(this).find("select").val();
            if (estatus != null)
            {
                if (estatus != "SELECCIONAR") {
                    cedulas[cuenta] = $(this).find('td').eq(0).text();
                    afiliacion[cuenta] = $(this).find('td').eq(4).text();
                    FechaCita[cuenta] = $(this).find('td').eq(3).text();
                    encounter[cuenta] = $(this).find('td').eq(9).text();
                    appoint[cuenta] = $(this).find('td').eq(8).text();
                    Estados[cuenta] = $(this).find("select").val();
                    cuenta = cuenta + 1;
                }
            }
        });
        if (numFilas!=0)
        {
            $.ajax({
                cache: false,
                type: "POST",
                url: "/AjaxQuerys/AjaxResponse.aspx/SetEstatusPaciente",
                data: JSON.stringify({ "cedula": cedulas, "afiliacion": afiliacion, "Estatus": Estados, "FechaCita": FechaCita, "Apoi":appoint, "Encounter":encounter }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {

                    App.unblockUI("#Entradas_Portlet");
                    alert(response.d);
                    window.location = "/Enfermeria/ControlConsultasPoli";

                },
                failure: function (response) {
                    //b(Command, IdControl);
                    alert("Falló la llamada");
                }
            });
        }


    }
}

function AbreModal()
{
    CargaPacientes();
    CargarMedicos();
    CargarEspecialidad();
    $('.modal-body').load('content.html', function () {

        $('#myModal').modal({ show: true });
    });
}

function CargaPacientes()
{
    var Control = $("#pacienteIdControlConsulta");
    var NameTable = "CitasPoli";
    App.blockUI({ target: "#Entradas_Portlet", boxed: !0, message: "Procesando…" });
    
    $.ajax({
        cache: false,
        type: "POST",
        url: "/AjaxQuerys/AjaxResponse.aspx/CargaSelectCitasPacientes",
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
            App.unblockUI("#Entradas_Portlet");
            alert("Error al cargar tipo cirugia");
        }
    });
}
function CargarMedicos()
{
    var Control = $("#MedicoIdControlConsulta");
    var NameTable = "CitasPoli";
    App.blockUI({ target: "#Entradas_Portlet", boxed: !0, message: "Procesando…" });
    
    $.ajax({
        cache: false,
        type: "POST",
        url: "/AjaxQuerys/AjaxResponse.aspx/CargaSelectCitasMedicos",
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
            App.unblockUI("#Entradas_Portlet");
            alert("Error al cargar tipo cirugia");
        }
    });
}

function CargarEspecialidad() {
    var Control = $("#EspecialidadControlConsulta");
    var NameTable = "CitasPoli";
    App.blockUI({ target: "#Entradas_Portlet", boxed: !0, message: "Procesando…" });

    $.ajax({
        cache: false,
        type: "POST",
        url: "/AjaxQuerys/AjaxResponse.aspx/CargaSelectCitasEspecialidad",
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
            App.unblockUI("#Entradas_Portlet");
            alert("Error al cargar tipo cirugia");
        }
    });

}
function SeleccionaMedico()
{
    var Cedula = document.getElementById("MedicoIdControlConsulta") ? $("#MedicoIdControlConsulta").val() : null;
    if (Cedula != "") {
        $("#EspecialidadControlConsulta").val(Cedula).trigger('change.select2');
    }
    else
    {
        $("#EspecialidadControlConsulta").val("").trigger('change.select2');
    }
}

function GuardaCitaEventual() {
    var Afilia = document.getElementById("pacienteIdControlConsulta")? $("#pacienteIdControlConsulta").val(): null;
    var Cedula = document.getElementById("MedicoIdControlConsulta") ? $("#MedicoIdControlConsulta").val(): null;
    
    App.blockUI({ target: "#Entradas_Portlet", boxed: !0, message: "Procesando…" });

    $.ajax({
        cache: false,
        type: "POST",
        url: "/AjaxQuerys/AjaxResponse.aspx/SetCitaEventual",
        data: JSON.stringify({ "Afiliacion": Afilia, "Cedula": Cedula }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {
            App.unblockUI("#Entradas_Portlet");
            alert("Ingreso Exitoso");
            window.location = "/Enfermeria/ControlConsultasPoli";
           
        },
        failure: function (response) {
            App.unblockUI("#Entradas_Portlet");
            alert("Error al cargar cita eventual");
        }
    });

}