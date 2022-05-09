function CargaPermisos() {
    var Control = $("#PermisoID");
    var NameTable = "CitasPoli";
    App.blockUI({ target: "#Entradas_Portlet", boxed: !0, message: "Procesando…" });

    $.ajax({
        cache: false,
        type: "POST",
        url: "/AjaxQuerys/AjaxResponse.aspx/GetPermisos",
        data: JSON.stringify({ "NameTable": NameTable }),
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

function CargaRegion() {
    var Control = $("#RegionID");
    var NameTable = "CitasPoli";
    App.blockUI({ target: "#Entradas_Portlet", boxed: !0, message: "Procesando…" });

    $.ajax({
        cache: false,
        type: "POST",
        url: "/AjaxQuerys/AjaxResponse.aspx/GetRegion",
        data: JSON.stringify({ "NameTable": NameTable }),
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

function CrearUsuario() {
    var ddlUsuario = null, ddlNombre = null, ddlApellido = null, ddlPassword = null, ddlPermiso = null, ddlRegion = null;
    ddlUsuario = document.getElementById("txtUsuarioCrea") ? $("#txtUsuarioCrea").val() : null;
    ddlNombre = document.getElementById("txtNombre") ? $("#txtNombre").val() : null;
    ddlApellido = document.getElementById("txtApellidos") ? $("#txtApellidos").val() : null;
    ddlPassword = document.getElementById("txtContrasenia") ? $("#txtContrasenia").val() : null;
    ddlPermiso = document.getElementById("PermisoID") ? $("#PermisoID").val() : null;
    ddlRegion = document.getElementById("RegionID") ? $("#RegionID").val() : null;
    
    App.blockUI({ target: "#Entradas_Portlet", boxed: !0, message: "Procesando…" });

    $.ajax({
        cache: false,
        type: "POST",
        url: "/AjaxQuerys/AjaxResponse.aspx/SetUsuario",
        data: JSON.stringify({ "Usuario": ddlUsuario, "Nombre": ddlNombre, "Apellido": ddlApellido, "Password": ddlPassword, "Permiso": ddlPermiso, "Region": ddlRegion}),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {
            App.unblockUI("#Entradas_Portlet");
            alert("Se registro de manera adecuada el nuevo usuario");
            window.location = "/Account/CrearUsuario";
        },
        failure: function (response) {
            App.unblockUI("#Entradas_Portlet");
            alert("Error al cargar tipo cirugia");
        }
    });
}