var IDRegion, IDTipo, Tamanio, IDTracto, IDCaja, IDCliente;
var IDCartaPorte, Observaciones, FechaRelacion, IDOrigen, IDDestino,IDOrigenRuta,IDDestinoRuta,Ruta;

function EnvioSelects() {
    $("#RelacionCajaId").val(-1).trigger('change.select2');
    CargaSelect("GetCajaDisponible", $("#RelacionCajaId"));
    EnvioSelectsRutas("Origen");
}

function EnvioSelectsRutas(NameControl) {

    var Control;

    if (NameControl == "Origen") { Control = $("#RelacionOrigenRutaId");}
    if (NameControl == "Destino") { Control = $("#RelacionDestinoRutaId"); }
    if (NameControl == "Ruta") { Control = $("#RelacionRutaId"); }

    CargaSelectRutas(NameControl, "GetDatosRutas", Control);
    CargaPrecios();

}

function EnvioSelectsServicios() {

    CargaSelectServi("GetServiciosSap", $("#ClaveServId"), $("#ServicioId"));

}

function EnvioSelectsRegion() {

    CargaSelect("GetTractoDisponible", $("#RelacionTractoId"));
    CargaSelect("GetClienteRelacion", $("#RelacionClienteId"));
    CargaSelect("GetOrigenDestino", $("#RelacionOrigenId"));
    CargaSelect("GetOrigenDestino", $("#RelacionDestinoId"));
    CargaSelect("GetOrigenDestino", $("#RelacionOrigenRutaId"));
    CargaSelect("GetTipoCajaDisponible", $("#RelacionTipoCajaId"));
    EnvioSelectsServicios();
}

function CargaSelect(Command, Control) {
    IDRegion = null;
    IDTipo = null;
    Tamanio = null;

    IDRegion = document.getElementById("RelacionRegionId") ? $("#RelacionRegionId").val() : null; 
    IDTipo = document.getElementById("RelacionTipoCajaId") ? $("#RelacionTipoCajaId").val() : null;

    App.blockUI({ target: "#Entradas_Portlet", boxed: !0, message: "Procesando…" });
    var NameTable = "Cirugia";
    $.ajax({
        cache: false,
        type: "POST",
        url: "/AjaxQuerys/AjaxResponse.aspx/" + Command,
        data: JSON.stringify({ "IDRegion": IDRegion, "IDTipo": IDTipo}),
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

function CargaSelectServi(Command, Control,Control2) {
    IDRegion = null;
    
    IDRegion = document.getElementById("RelacionRegionId") ? $("#RelacionRegionId").val() : null;

    App.blockUI({ target: "#Entradas_Portlet", boxed: !0, message: "Procesando…" });
    var NameTable = "Cirugia";
    $.ajax({
        cache: false,
        type: "POST",
        url: "/AjaxQuerys/AjaxResponse.aspx/" + Command,
        data: JSON.stringify({ "IDRegion": IDRegion}),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {

            Control2.html('');
            Control2.append($('<option></option>').val("").html("Select"));

            Control.html('');
            Control.append($('<option></option>').val("").html("Select"));

            $.each(response.d, function (id, option) {

                Control.append($('<option></option>').val(option.Id).html(option.Id));

                Control2.append($('<option></option>').val(option.Id).html(option.Name));

            });
            App.unblockUI("#Entradas_Portlet");
        },
        failure: function (response) {
            App.unblockUI("#Entradas_Portlet");
            alert("Error al cargar tipo cirugia");
        }
    });

}

function CargaSelectRutas(NameControl,Command, Control) {

    IDRegion = null;
    IDTipo = null;
    IDOrigenRuta = null;
    IDDestinoRuta = null;
    IDCliente = null;


    
    IDRegion = document.getElementById("RelacionRegionId") ? $("#RelacionRegionId").val() : null;
    IDOrigenRuta = document.getElementById("RelacionOrigenRutaId") ? $("#RelacionOrigenRutaId").val() : null;
    IDDestinoRuta = document.getElementById("RelacionDestinoRutaId") ? $("#RelacionDestinoRutaId").val() : null;
    IDTipo = document.getElementById("RelacionTipoCajaId") ? $("#RelacionTipoCajaId").val() : null;
    IDCliente = document.getElementById("RelacionClienteId") ? $("#RelacionClienteId").val() : null;

    App.blockUI({ target: "#Entradas_Portlet", boxed: !0, message: "Procesando…" });
    var NameTable = "Cirugia";
    $.ajax({
        cache: false,
        type: "POST",
        url: "/AjaxQuerys/AjaxResponse.aspx/" + Command,
        data: JSON.stringify({ "Control": NameControl, "IDRegion": IDRegion, "IDTipo": IDTipo, "IDOrigenRuta": IDOrigenRuta, "IDDestinoRuta": IDDestinoRuta, "IDCliente": IDCliente }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {
            Control.html('');
            Control.val(-1).trigger('change.select2');
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


function CargaRelacion() {
    IDRegion = null;
    IDCartaPorte = null;
    Observaciones = null;
    FechaRelacion = null;
    IDOrigen = null;
    IDDestino = null;
    IDTracto = null;
    IDCaja = null;
    IDTipo = null;
    IDCliente = null;

    var numFilas = 0;
    var cuenta = 0;

    IDRegion = document.getElementById("RelacionRegionId") ? $("#RelacionRegionId").val() : null;
    IDCartaPorte = document.getElementById("CartaPorteTxt") ? $("#CartaPorteTxt").val() : null;
    Observaciones = document.getElementById("txtObservaciones") ? $("#txtObservaciones").val() : null;
    FechaRelacion = document.getElementById("dprSalida") ? $("#dprSalida").val() : null;
    IDOrigen = document.getElementById("RelacionOrigenId") ? $("#RelacionOrigenId").val() : null;
    IDDestino = document.getElementById("RelacionDestinoId") ? $("#RelacionDestinoId").val() : null;
    IDTracto = document.getElementById("RelacionTractoId") ? $("#RelacionTractoId").val() : null;
    IDCaja = document.getElementById("RelacionCajaId") ? $("#RelacionCajaId").val() : null;
    IDCliente = document.getElementById("RelacionClienteId") ? $("#RelacionClienteId").val() : null;
    Ruta = document.getElementById("RelacionRutaId") ? $("#RelacionRutaId").val() : null;
    IDOrigenRuta = document.getElementById("RelacionOrigenRutaId") ? $("#RelacionOrigenRutaId").val() : null;
    IDDestinoRuta = document.getElementById("RelacionDestinoRutaId") ? $("#RelacionDestinoRutaId").val() : null;
    IDTipo = document.getElementById("RelacionTipoCajaId") ? $("#RelacionTipoCajaId").val() : null;

    var t = $('#TableServicios').DataTable();
    var filas = t.rows().data();

    filas.each(function (value, index) {
        numFilas = numFilas + 1;
    });

    var Clave = new Array(numFilas);
    var Cantidad = new Array(numFilas);
    var precio = new Array(numFilas);

    filas.each(function (value, index)
    {
        Clave[cuenta] = value[0];
        Cantidad[cuenta] = value[2];
        precio[cuenta] = value[3];
        cuenta = cuenta + 1;
    });



    App.blockUI({ target: "#Entradas_Portlet", boxed: !0, message: "Procesando…" });
    $.ajax({
        cache: false,
        type: "POST",
        url: "/AjaxQuerys/AjaxResponse.aspx/SetRelacion",
        data: JSON.stringify({
            "IDRegion": IDRegion, "IDCartaPorte": IDCartaPorte, "IDTracto": IDTracto, "IDCaja": IDCaja, "IDCliente": IDCliente, "Observaciones": Observaciones, "FechaRelacion": FechaRelacion, "IDOrigen": IDOrigen, "IDDestino": IDDestino, "Ruta": Ruta, "clave": Clave,
            "cantidad": Cantidad, "IDOrigenRuta":IDOrigenRuta,"IDDestinoRuta":IDDestinoRuta,"IDTipo":IDTipo,"Precio" : precio
        }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {
            var msg = response.d;
            if ('RELACIÓN CREADA CON EXITO' == msg) {
                alert(response.d);
                App.unblockUI("#Entradas_Portlet");
                window.location = "/Gestion/RelacionCajaTracto";
            }
            else {
                alert(response.d);
                App.unblockUI("#Entradas_Portlet");
            }
        },
        failure: function (response) {
            App.unblockUI("#Entradas_Portlet");
            alert("Error al crear relacion de cirugia");
        }
    });

}

function EmparejamientoSelects(id)
{
    var serv = $("#ServicioId").val();
    var idserv = $("#ClaveServId").val();

   
    if (serv != idserv) {

        if (id == 1) {
            $("#ServicioId").val(idserv).trigger('change.select2');
        }
        else {
            $("#ClaveServId").val(serv).trigger('change.select2'); 
        }
    }       
}

function AgregaCargaDetalle() {
    var encontrado = false;

    var Clave = document.getElementById("ClaveServId") ? $("#ClaveServId").val() : null;   
    var DescClave = document.getElementById("ServicioId") ? $("#ServicioId").find('option:selected').text() : null;
    var Cantidad = document.getElementById("txtCantidad") ? $("#txtCantidad").val() : null;
    var precio = document.getElementById("txtPrecio") ? $("#txtPrecio").val() : null;

    var Total = 0;

    if (Clave != "") {
        var t = $('#TableServicios').DataTable();
        var datas;

        t.rows().every(function (rowIdx, tableLoop, rowLoop) {
            datas = this.data();
        });

        if (datas != null) {
            var filas = t.rows().data();
            filas.each(function (value, index) {
                if (value[0] == Clave) {
                    encontrado = true;
                }
            });

            if (encontrado == false) {
                t.row.add([
                    Clave,
                    DescClave,
                    Cantidad,
                    precio
                ]).draw(false);
            }
            else {
                alert("La Clave no puede ser agregada más de una vez. Verifique e intente nuevamente");
            }

        }
        else {
            t.row.add([
                Clave,
                DescClave,
                Cantidad,
                precio
            ]).draw(false);
        }

        //var filas = t.rows().data();
        //filas.each(function (value, index) {
        //    Total += parseFloat(value[3]);

        //});
        //$('#TableServicios tfoot tr th').eq(1).text(Total);

        $("#ServicioId").val(-1).trigger('change.select2');
        document.getElementById("txtCantidad").value = "1";

    }
}

function CargaPrecios() {

    IDRegion = null;
    IDTipo = null;
    IDOrigenRuta = null;
    IDDestinoRuta = null;
    IDCliente = null;



    IDRegion = document.getElementById("RelacionRegionId") ? $("#RelacionRegionId").val() : null;
    IDOrigenRuta = document.getElementById("RelacionOrigenRutaId") ? $("#RelacionOrigenRutaId").val() : null;
    IDDestinoRuta = document.getElementById("RelacionDestinoRutaId") ? $("#RelacionDestinoRutaId").val() : null;
    IDTipo = document.getElementById("RelacionTipoCajaId") ? $("#RelacionTipoCajaId").val() : null;
    IDCliente = document.getElementById("RelacionClienteId") ? $("#RelacionClienteId").val() : null;

    App.blockUI({ target: "#Entradas_Portlet", boxed: !0, message: "Procesando…" });
    var NameTable = "Cirugia";
    $.ajax({
        cache: false,
        type: "POST",
        url: "/AjaxQuerys/AjaxResponse.aspx/GetPrecioSap",
        data: JSON.stringify({"IDRegion": IDRegion, "IDTipo": IDTipo, "IDOrigenRuta": IDOrigenRuta, "IDDestinoRuta": IDDestinoRuta, "IDCliente": IDCliente }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {
            
            $.each(response.d, function (id, option) {

                document.getElementById("txtPrecio").value = option.precio;
                document.getElementById("txtMoneda").value = option.Moneda;

            });
            App.unblockUI("#Entradas_Portlet");
        },
        failure: function (response) {
            App.unblockUI("#Entradas_Portlet");
            alert("Error al cargar tipo cirugia");
        }
    });

}