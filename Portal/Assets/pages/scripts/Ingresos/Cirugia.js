var paciente, episodio, descripcion, fecha;
function CargaTipoCirugia(Command, Control)
{
    App.blockUI({ target: "#Entradas_Portlet", boxed: !0, message: "Procesando…" });
    var NameTable = "Cirugia";
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
                App.unblockUI("#Entradas_Portlet");
                alert("Error al cargar tipo cirugia");
            }
        });

}

function CargaMedicosCirugia(Command, Control) {
    App.blockUI({ target: "#Entradas_Portlet", boxed: !0, message: "Procesando…" });
    var pac = document.getElementById("pacienteCirugiaId") ? $("#pacienteCirugiaId").val() : null; 
    var epi = document.getElementById("episodioCirugiaId") ? $("#episodioCirugiaId").val() : null;

    
    $.ajax({
        cache: false,
        type: "POST",
        url: "/AjaxQuerys/AjaxResponse.aspx/" + Command,
        data: JSON.stringify({ "paciente": pac, "episodio":epi }),
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

function AgregaOtro()
{
    var otro = null,descrip=null;
    otro = document.getElementById("tipoCirugiaId") ? $("#tipoCirugiaId").val() : null;
   
        var result = confirm("¿Estas seguro de agregar este tipo de cirugia?");
        if (result == true)
        {
            descrip = document.getElementById("otroCirugiaId") ? $("#otroCirugiaId").val() : null;
            if (descrip != "") {
                App.blockUI({ target: "#Entradas_Portlet", boxed: !0, message: "Procesando…" });
            $.ajax({
                cache: false,
                type: "POST",
                url: "/AjaxQuerys/AjaxResponse.aspx/setAgregaTipoCiru",
                data: JSON.stringify({ "Otro": descrip }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    $.each(response.d, function (id, option) {
                        otro = option.Id;
                    });
                    App.unblockUI("#Entradas_Portlet");
                    insertaCirugia(otro);
                },
                failure: function (response) {
                    alert("Error al cargar otro tipo cirugia");
                }
            });
            }
        }
        else
        {
            window.location = "/Pacientes/VerIngresos";
        }
  
}

function insertaCirugia(otro)
{
    var result = confirm("¿Estas seguro de agregar la cirugia?");
    if (result == true)
    {
        paciente = null;
        episodio = null;
        descripcion = null;
        fecha = null;
        paciente = document.getElementById("pacienteCirugiaId") ? $("#pacienteCirugiaId").val() : null;
        episodio = document.getElementById("episodioCirugiaId") ? $("#episodioCirugiaId").val() : null;
        descripcion = document.getElementById("DescripcionId") ? $("#DescripcionId").val() : null;
        var cel = document.getElementById("CmbMedicoCirugia") ? $("#CmbMedicoCirugia").val() : null;
        fecha = $("#dprFromCirugia").val();
        if (paciente != "") {
            if (episodio != "" && cel !="") {
                if (descripcion != "") {
                    if (fecha != "") {
                        App.blockUI({ target: "#Entradas_Portlet", boxed: !0, message: "Procesando…" });
                        $.ajax({
                            cache: false,
                            type: "POST",
                            url: "/AjaxQuerys/AjaxResponse.aspx/SetCirugia",
                            data: JSON.stringify({ "Paciente": paciente, "episodio": episodio, "tipoCirugia": otro, "descripcion": descripcion, "fecha": fecha,"cedula":cel }),
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (response) {
                              
                                App.unblockUI("#Entradas_Portlet");
                                var Valido = response.d;

                                if (Valido == true)
                                {
                                    alert("Agregado Exitoso");
                                    window.location = "/Pacientes/VerIngresos";
                                }
                                else
                                {
                                    alert("La fecha esta fuera de rango con el ingreso, Inentenlo nuevamente")
                                }
                                
                            },
                            failure: function (response) {
                                alert("Error al cargar otro tipo cirugia");
                            }
                        });
                    }
                    else {
                        alert("Agregar una fecha disponible");
                    }
                }
                else {
                    alert("Agregar descripción");
                }
            }
            else {
                alert("No se tiene un episodio");
                window.location = "/Pacientes/VerIngresos"
            }
        }
        else
        {
            alert("No se tiene un paciente");
            window.location="/Pacientes/VerIngresos"
        }

      
    }
}

function AgregaCirugiaEpi()
{
    var otro = null, descrip = null;
    otro = document.getElementById("tipoCirugiaId") ? $("#tipoCirugiaId").val() : null;
    if (otro == 9999)
    {
        AgregaOtro();

    }
    else {
        insertaCirugia(otro);
    }


}