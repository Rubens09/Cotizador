function CargaSelect(Control, Command) {
    var NameTable = "Reporte";

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