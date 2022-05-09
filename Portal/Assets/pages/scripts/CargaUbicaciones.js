function CargaUbicaciones(Control) {
    App.blockUI({ target: "#Entradas_Portlet", boxed: !0, message: "Procesando…" });
    var fechaIni = document.getElementById("dprFromGrafica") ? $("#dprFromGrafica").val() : null;
    var fechaFin = document.getElementById("dprToGrafica") ? $("#dprToGrafica").val() : null;
    var HoraIni = document.getElementById("HorarioIni") ? $("#HorarioIni").val() : null;
    var HoraFin = document.getElementById("HorarioFin") ? $("#HorarioFin").val() : null;


    $.ajax({
        cache: false,
        type: "POST",
        url: "/AjaxQuerys/AjaxResponse.aspx/GetUbicaciones",
        data: JSON.stringify({ "fechaIni": fechaIni, "fechaFin":fechaFin, "HoraIni":HoraIni,"HoraFin": HoraFin}),
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