function CargaSelect(Command, Control, NameTable) {
    Control.select2("val", "");
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

function AgregarEstudios()
{
    var encontrado = false;
    var CodEstudio = document.getElementById("estudiosIdEstudios") ? $("#estudiosIdEstudios").val() : null;
    var DescEstudio = document.getElementById("estudiosIdEstudios") ? $("#estudiosIdEstudios").find('option:selected').text() : null;

    if (CodEstudio != "") {
        var t = $('#TableEstudios').DataTable();
        var datas;

        t.rows().every(function (rowIdx, tableLoop, rowLoop) {
            datas = this.data();
        });
        if (datas != null) {
            var filas = t.rows().data();
            filas.each(function (value, index) {
                if (value[0] == CodEstudio) {
                    encontrado = true;
                }
            });

            if (encontrado == false) {
                t.row.add([
                    CodEstudio,
                    DescEstudio
                ]).draw(false);
            }
            else {
                alert("La Clave no puede ser agregada más de una vez. Verifique e intente nuevamente");
            }

        }
        else {
            t.row.add([
                CodEstudio,
                DescEstudio
            ]).draw(false);
        }

        $("#estudiosIdEstudios").val("").trigger('change.select2');
        //document.getElementById("ClaveEstudio").value = "";

    }
}

function GuardarEstudio()
{
    var Afiliacion, Episodio, FechaEstudios, Hospital, Cedula;

    Afiliacion = document.getElementById("pacientesEstudiosID").value;
    Episodio = document.getElementById("episodioEstudiosId").value;
    FechaEstudios = document.getElementById("dprFromEstudios").value;
    Hospital = document.getElementById("servicioIdEstudios").value;
    Cedula = document.getElementById("medicoIdEstudio").value;
    
    var encontrado = false;
    var Resultado;
    Resultado = "";
    var numFilas = 0;
    var t = $('#TableEstudios').DataTable();
    var datas;
    var cuenta = 0;
    t.rows().every(function (rowIdx, tableLoop, rowLoop) {
        datas = this.data();
    });

    if (datas != null) {
        var filas = t.rows().data();

        filas.each(function (value, index) {
            numFilas = numFilas + 1;
        });
        var CodEstudios = new Array(numFilas);

        filas.each(function (value, index) {
            CodEstudios[cuenta] = value[0];
            cuenta = cuenta + 1;

        });
        encontrado = true;
    }
    else {
        alert("Tiene que agregar almenos un Diagnostico");
        encontrado = false;

    }
    if (encontrado == true) {
        if (Afiliacion != "" && Episodio != "" && FechaEstudios != "" && Hospital != "" && Cedula != "") {

            $.ajax({
                cache: false,
                type: "POST",
                url: "/AjaxQuerys/AjaxResponse.aspx/AgregaEstudiosHospitales",
                data: JSON.stringify({ "Afilia": Afiliacion, "Episodio": Episodio, "FechaEstudios": FechaEstudios, "Hospital": Hospital, "Cedula": Cedula, "Estudios": CodEstudios }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    App.unblockUI("#Entradas_Portlet");
                    if (response.d == null) {
                        alert("La fecha no puede ser anterior al día de hoy");
                    }
                    $.each(response.d, function (id, option) {
                        alert("Agregado Exitosamente");
                        window.location = "/Gestion/SolicitudCirugia";
                    });
                },
                failure: function (response) {
                    App.unblockUI("#Entradas_Portlet");
                    alert("Falló la llamada");
                }
            });

        }

    }
}
