var num = 0, num1 = 1,valor=0;
var cadena = "",cadena2="",ruta_o="",ruta_l="";
function CargaOrigen() {
    var Control = $("#Origen");
    var Control2 = $("#Destino");
    App.blockUI({ target: "#Entradas_Portlet", boxed: !0, message: "Procesando…" });

    $.ajax({
        cache: false,
        type: "POST",
        url: "/AjaxQuerys/AjaxResponse.aspx/GetOrigen",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {
            Control.html('');
            Control.append($('<option></option>').val("").html("Select"));
            $.each(response.d, function (id, option) {
                Control.append($('<option></option>').val(option.Id).html(option.Descripcion));
                Control2.append($('<option></option>').val(option.Id).html(option.Descripcion));
            });
            UsoPagina();
            App.unblockUI("#Entradas_Portlet");
        },
        failure: function (response) {
            App.unblockUI("#Entradas_Portlet");
            alert("Error al cargar origen");
        }
    });
}//
function CargaProducto() {
    var Control = $("#Producto");
    App.blockUI({ target: "#Entradas_Portlet", boxed: !0, message: "Procesando…" });

    $.ajax({
        cache: false,
        type: "POST",
        url: "/AjaxQuerys/AjaxResponse.aspx/GetProducto",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {
            Control.html('');
            Control.append($('<option></option>').val("").html("Select"));
            $.each(response.d, function (id, option) {
                Control.append($('<option></option>').val(option.Id).html(option.Descripcion));
            });
            App.unblockUI("#Entradas_Portlet");
        },
        failure: function (response) {
            App.unblockUI("#Entradas_Portlet");
            alert("Error al cargar producto");
        }
    });
}//
function ObtenerTransporte() {
            var cod = document.getElementById("Producto") ? $("#Producto").val() : null;
            var Control = $("#Transporte");
            App.blockUI({ target: "#Entradas_Portlet", boxed: !0, message: "Procesando…" });

            $.ajax({
                cache: false,
                type: "POST",
                url: "/AjaxQuerys/AjaxResponse.aspx/GetTransporte",
                data: JSON.stringify({ "Producto": cod}),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    $.each(response.d, function (id, option) {
                        Control.val(option.Descripcion);
                    });
                    App.unblockUI("#Entradas_Portlet");
                },
                failure: function (response) {
                    App.unblockUI("#Entradas_Portlet");
                    alert("Error al cargar producto");
                }
            });
}//
function CargaTipoPagoOP() {
    var Control = $("#TipoPagoOP");
    App.blockUI({ target: "#Entradas_Portlet", boxed: !0, message: "Procesando…" });

    $.ajax({
        cache: false,
        type: "POST",
        url: "/AjaxQuerys/AjaxResponse.aspx/GetTipoPagoOP",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {
            Control.html('');
            Control.append($('<option></option>').val("").html("Select"));
            $.each(response.d, function (id, option) {
                Control.append($('<option></option>').val(option.Id).html(option.Descripcion));
            });

            App.unblockUI("#Entradas_Portlet");
        },
        failure: function (response) {
            App.unblockUI("#Entradas_Portlet");
            alert("Error al cargar producto");
        }
    });
}//
function ObtenereBasePagoOp() {
    var cod1 = document.getElementById("TipoPagoOP") ? $("#TipoPagoOP").val() : null;
    var Control = $("#BasePagoOp");
    App.blockUI({ target: "#Entradas_Portlet", boxed: !0, message: "Procesando…" });

    if ((KMCargado != "") && (TipoCambio != "")) {
        Calcular_Sueldo_Op_USD();
    }
    $.ajax({
        cache: false,
        type: "POST",
        url: "/AjaxQuerys/AjaxResponse.aspx/GetBasePagoOp",
        data: JSON.stringify({ "Producto": cod1 }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {
            $.each(response.d, function (id, option) {
                Control.val(option.Descripcion);
            });
            if (($("#KMCargado").val() != "") && ($("#KMVacio").val() != "")) {
                Calcular_Sueldo_Op();
            }
            App.unblockUI("#Entradas_Portlet");
        },
        failure: function (response) {
            App.unblockUI("#Entradas_Portlet");
            alert("Error al cargar producto");
        }
    });
}//
function CtlNuevo() {
    const myText = document.getElementById('CtlOpcion');
    const myInsertText = "<div class='col-md-6'><label class='control-label col-md-7'>Descripción Cliente:</label><div class='col-md-4'><input type='text' id='NuevoCliente' class='form-control'/></div></div><div class='col-md-12'><label class='control-label col-md-2'> Correo Cliente: </label ><div class='col-md-4'><input type='text' id='CorreoCliente' class='form-control'/></div><label class='control-label col-md-2'> Correo Alternativo: </label ><div class='col-md-4'><input type='text' id='CorreoACliente' class='form-control'/></div></div><div class='col-md-12'><label class='control-label col-md-2'> Celular Cliente: </label ><div class='col-md-4'><input type='text' id='CelularCliente' class='form-control'/></div><label class='control-label col-md-2'> Telefono Cliente: </label ><div class='col-md-4'><input type='text' id='TelefonoCliente' class='form-control'/></div></div><div class='col-md-12'><label class='control-label col-md-2'>Dirección Cliente:</label><div class='col-md-10'><input type='text' id='DireccionCliente' class='form-control'/></div></div>";
    myText.innerHTML = myInsertText;
}//Falta dar de alta
function CtlExistente() {
    const myText = document.getElementById('CtlOpcion');
    const myInsertText = "<div class='form-group'><div class='col-md-4'><label class='control-label col-md-6'>Num Cliente:</label ><div class='col-md-6'><select id='IdCtl' class='form-control select2me' onchange='SeleccionDescClt()'><option value=''>Select...</option></select></div></div ><div class='col-md-4'></div><div class='col-md-6'><label class='control-label col-md-6'>Cliente:</label><div class='col-md-6'><select id='DescCtl' class='form-control select2me' onchange='SeleccionIdClt()'><option value=''>Select...</option></select></div></div></div > ";
    myText.innerHTML = myInsertText;
    CargaClientes();
}//
function CtlVista() {
    const myText = document.getElementById('CtlOpcion');
    const myInsertText = "<div class='form-group'><div class='col-md-4'><label class='control-label col-md-6'>Num Cliente:</label ><div class='col-md-6'><input type='Text' id='IdCtl' class='form-control' readonly /></div></div ><div class='col-md-4'></div><div class='col-md-6'><label class='control-label col-md-6'>Cliente:</label><div class='col-md-6'><input type='text' id='DescCtl' class='form-control' readonly /></div></div></div > ";
    myText.innerHTML = myInsertText;
    CargaClientes();
}
function CargaClientes() {
    var Control = $("#DescCtl");
    var Control2 = $("#IdCtl");
    App.blockUI({ target: "#Entradas_Portlet", boxed: !0, message: "Procesando…" });

    $.ajax({
        cache: false,
        type: "POST",
        url: "/AjaxQuerys/AjaxResponse.aspx/GetClientes",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {
            Control.html('');
            Control.append($('<option></option>').val("").html("Select"));
            $.each(response.d, function (id, option) {
                Control.append($('<option></option>').val(option.Id).html(option.Descripcion));
                Control2.append($('<option></option>').val(option.Id).html(option.Id));
            });
            App.unblockUI("#Entradas_Portlet");
        },
        failure: function (response) {
            App.unblockUI("#Entradas_Portlet");
            alert("Error al cargar producto");
        }
    });

}//
function SeleccionDescClt() {
    var IdCtl = document.getElementById("IdCtl") ? $("#IdCtl").val() : null;
    var DescCtl = document.getElementById("DescCtl") ? $("#DescCtl").val() : null;
    if (IdCtl != DescCtl) {
        if (IdCtl != "") {
            $("#DescCtl").val(IdCtl).trigger('change.select2');
        }
        else {
            $("#DescCtl").val("").trigger('change.select2');
        }
    }
}//
function SeleccionIdClt() {
    var IdCtl = document.getElementById("IdCtl") ? $("#IdCtl").val() : null;
    var DescCtl = document.getElementById("DescCtl") ? $("#DescCtl").val() : null;
    if (IdCtl != DescCtl) {
        if (DescCtl != "") {
            $("#IdCtl").val(DescCtl).trigger('change.select2');
        }
        else {
            $("#IdCtl").val("").trigger('change.select2');
        }
    }
}//
function CalcularKmVacio(){
    var DnoOrigen = document.getElementById("KMDnoOrigen") ? $("#KMDnoOrigen").val() : null;
    var BaseOrigen = document.getElementById("KMBaseOrigen") ? $("#KMBaseOrigen").val() : null;
    var DnoBase = document.getElementById("KMDnoBase") ? $("#KMDnoBase").val() : null;
    var KmVacio = document.getElementById("KMVacio") ? $("#KMVacio").val() : null;
    var KmRecorrer = document.getElementById("KMRecorrer") ? $("#KMRecorrer").val() : null;
    var Control = $("#KMVacio");
    if (KmVacio != "") {
        Control.val("");
    }
    if ((DnoOrigen != "") && (BaseOrigen != "") && (DnoBase != "")) {
        $.ajax({
            cache: false,
            type: "POST",
            url: "/AjaxQuerys/AjaxResponse.aspx/GetKmVacio",
            data: JSON.stringify({ "DnoOrigen": DnoOrigen, "BaseOrigen": BaseOrigen, "DnoBase": DnoBase }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                $.each(response.d, function (id, option) {
                    Control.val(option.Descripcion);
                    num = option.Descripcion;
                });
                if ((DnoOrigen != "") && (BaseOrigen != "") && (DnoBase != "") && $("#KMCargado").val() != "") {
                    CalcularKmRecorrer();
                    if ($("#PrecioDiesel").val() != "") {
                        Calcular_Diesel_Mx();
                    }
                    if ($("#BasePagoOp").val() != "") {
                        Calcular_Sueldo_Op();
                    }
                }
                App.unblockUI("#Entradas_Portlet");
            },
            failure: function (response) {
                App.unblockUI("#Entradas_Portlet");
                alert("Error al cargar producto");
            }
        });
    }
    else {
        $("#KMRecorrer").val("");
        Control.val("");
        $("#DieselMXN").val("");
    }
    num = 0;
}//
function CalcularKmRecorrer() {
    var KmCargado = document.getElementById("KMCargado") ? $("#KMCargado").val() : null;
    var KmVacio = document.getElementById("KMVacio") ? $("#KMVacio").val() : null;
    var KmRecorrer = document.getElementById("KMRecorrer") ? $("#KMRecorrer").val() : null;
    var Control = $("#KMRecorrer");
    if ((TipoPagoOP != "") && (TipoCambio != "") && (IngresoUSD!="")) {
        Calcular_Sueldo_Op_USD();
    }
    if ((PrecioKM != "") && (CuotaFija = !"") && (TipoCambio != "")) {
        Calcular_Ingreso_USD();
    }
    if ((KmRecorrer != "")||(KmVacio == "")||(KmCargado == "")) {
        Control.val("");
    }
    if ((BasePagoOp != "") && (TipoCambio!="")) {
        Calcular_Sueldo_Op_USD();
    }
    if ((KmCargado != "") && (KmVacio != "")){
        $.ajax({
            cache: false,
            type: "POST",
            url: "/AjaxQuerys/AjaxResponse.aspx/GetKmRecorrer",
            data: JSON.stringify({ "KmCargado": KmCargado, "KmVacio": KmVacio}),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                $.each(response.d, function (id, option) {
                    Control.val(option.Descripcion);
                    num = option.Descripcion;
                });
                if ($("#PrecioDiesel").val() != "") {
                    Calcular_Diesel_Mx();
                }
                if (($("#KMVacio").val() != "") && ($("#BasePagoOp").val() != "")) {
                    Calcular_Sueldo_Op();
                }
                if (($("#Reparto").val() != "") && ($("#PrecioKM").val() != "")) {
                    Calcular_Ingresos_MX();
                }
                else { }
                App.unblockUI("#Entradas_Portlet");
            },
            failure: function (response) {
                App.unblockUI("#Entradas_Portlet");
                alert("Error al cargar producto");
            }
        });
    }
    if ((Factor != "") && (PrecioDiesel != "") && (TipoCambio!="")) {
        Calcular_Diesel_USD();
    }
    num = 0;
}//
function CalcularCuotaFija() {
    var Destino = document.getElementById("Destino") ? $("#Destino").val() : null;
    var Control = $("#CuotaFija");
    App.blockUI({ target: "#Entradas_Portlet", boxed: !0, message: "Procesando…" });
        $.ajax({
            cache: false,
            type: "POST",
            url: "/AjaxQuerys/AjaxResponse.aspx/GetCuotaFija",
            data: JSON.stringify({ "Destino": Destino }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                $.each(response.d, function (id, option) {
                    Control.val(option.Descripcion);
                    num = option.Descripcion;
                });
                if ((KMCargado != "") && (PrecioKM = !"") && (TipoCambio != "")) {
                    Calcular_Ingreso_USD();
                }
                if (Control.val() == "") { Control.val(0); }
                App.unblockUI("#Entradas_Portlet");
            },
            failure: function (response) {
                App.unblockUI("#Entradas_Portlet");
                alert("Error al cargar producto");
            }
        });
    num = 0;
}//
function CalcularBasePago() {
    var TipoPago = document.getElementById("TipoPagoOP") ? $("#TipoPagoOP").val() : null;
    var Control = $("#BasePagoOp");
    App.blockUI({ target: "#Entradas_Portlet", boxed: !0, message: "Procesando…" });
    if (TipoPago == "") {
        Control.val("");
    }
    $.ajax({
        cache: false,
        type: "POST",
        url: "/AjaxQuerys/AjaxResponse.aspx/GetBasePago",
        data: JSON.stringify({ "TipoPago": TipoPago }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {
            $.each(response.d, function (id, option) {
                Control.val(option.Descripcion);
            });
            App.unblockUI("#Entradas_Portlet");
        },
        failure: function (response) {
            App.unblockUI("#Entradas_Portlet");
            alert("Error al cargar producto");
        }
    });
}//
function ObtenerTipoCambio() {
    var TipoCambio = document.getElementById("TipoCambio") ? $("#TipoCambio").val() : null;
    var Token = "";
    App.blockUI({ target: "#Entradas_Portlet", boxed: !0, message: "Procesando…" });

    $.ajax({
        cache: false,
        type: "POST",
        url: "/AjaxQuerys/AjaxResponse.aspx/GetToken",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {
            $.each(response.d, function (id, option) {
                Token = option.Token;
            });
            ConsultarDolar(Token);
            App.unblockUI("#Entradas_Portlet");
        },
        failure: function (response) {
            App.unblockUI("#Entradas_Portlet");
            alert("Error al cargar producto");
        }
    });
}//Se consume la API directamente
function ConsultarDolar(Token) {
    var Control = $("#TipoCambio");
    console.log(Token);
    $.ajax({
        url: "https://www.banxico.org.mx/SieAPIRest/service/v1/series/SF43718/datos/oportuno?token=" + Token,
        jsonp: "callback",
        dataType: "json", //Se utiliza JSONP para realizar la consulta cross-site
        success: function (response) {  //Handler de la respuesta
            var series = response.bmx.series;

            //Se carga una tabla con los registros obtenidos
            for (var i in series) {
                var serie = series[i];
                Control.val(serie.datos[0].dato);
            }
        }
    });
}//Pt.2
function Calcular_Diesel_Mx() {
    var KMRecorrer = document.getElementById("KMRecorrer") ? $("#KMRecorrer").val() : null;
    var Factor = document.getElementById("Factor") ? $("#Factor").val() : null;
    var PrecioDiesel = document.getElementById("PrecioDiesel") ? $("#PrecioDiesel").val() : null;
    var Diesel = document.getElementById("DieselMXN") ? $("#DieselMXN").val() : null;
    var DieselMXN = $("#DieselMXN");
    if (KMRecorrer == "") {
        KMRecorrer = num;
        num = 0;
    }
    if ((KMRecorrer != "") || (Factor != "") || (PrecioDiesel != "")) {
        $.ajax({
            cache: false,
            type: "POST",
            url: "/AjaxQuerys/AjaxResponse.aspx/GetDieselMx",
            data: JSON.stringify({
                "KMRecorrer": KMRecorrer, "Factor": Factor, "PrecioDiesel": PrecioDiesel
            }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                $.each(response.d, function (id, option) {
                    DieselMXN.val(option.Diesel.toFixed(2));
                    num = option.Diesel;
                });
                if ((CasetasMXN != "") && (SueldoOpMXN!="")){
                    Calcular_Total_Gto();
                }
                App.unblockUI("#Entradas_Portlet");
            },
            failure: function (response) {
                App.unblockUI("#Entradas_Portlet");
                alert("Error al cargar producto");
            }
        });
    }
    if ((KMCargado != "") && (PrecioDiesel != "") && (TipoCambio!="")) {
        Calcular_Diesel_USD();
    }
    else {
        DieselMXN.val("");
    }
}
function Calcular_Sueldo_Op() {
    var KMCargado = document.getElementById("KMCargado") ? $("#KMCargado").val() : null;
    var KMVacio = document.getElementById("KMVacio") ? $("#KMVacio").val() : null;
    var TipoPagoOP = document.getElementById("TipoPagoOP") ? $("#TipoPagoOP").val() : null;
    var SueldoOpMXN = document.getElementById("SueldoOpMXN") ? $("#SueldoOpMXN").val() : null;
    var SueldoOp = $("#SueldoOpMXN");
    /*App.blockUI({ target: "#Entradas_Portlet", boxed: !0, message: "Procesando…" });
    if ((KMRecorrer == "") || (Factor == "") || (KMRecorrer == "")) {
        Control.val("");
    }*/
    if (SueldoOpMXN != "") {
        SueldoOp.val("");
    }
    if (KMVacio == "") {
        KMVacio = num;
        num = 0;
    }
    if ((KMCargado != "") || (KMVacio != "") || (TipoPagoOP != "")) {
        $.ajax({
            cache: false,
            type: "POST",
            url: "/AjaxQuerys/AjaxResponse.aspx/GetSueldoOp",
            data: JSON.stringify({
                "KMCargado": KMCargado, "KMVacio": KMVacio, "TipoPagoOP": TipoPagoOP
            }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                $.each(response.d, function (id, option) {
                    SueldoOp.val(option.SueldoOp.toFixed(2));
                    num = option.SueldoOp;
                });
                if ((CasetasMXN != "") && (DieselMXN!="")) {
                    Calcular_Total_Gto();
                }
                App.unblockUI("#Entradas_Portlet");
            },
            failure: function (response) {
                App.unblockUI("#Entradas_Portlet");
                alert("Error al cargar producto");
            }
        });
    }
}//
function Calcular_Total_Gto() {
    var CasetasMXN = document.getElementById("CasetasMXN") ? $("#CasetasMXN").val() : null;
    var DieselMXN = document.getElementById("DieselMXN") ? $("#DieselMXN").val() : null;
    var SueldoOpMXN = document.getElementById("SueldoOpMXN") ? $("#SueldoOpMXN").val() : null;
    var TotalGtoMXN = document.getElementById("TotalGtoMXN") ? $("#TotalGtoMXN").val() : null;
    var custodia = document.getElementById("CustodiaMXN") ? $("#CustodiaMXN").val() : null;
    custodia = parseFloat(custodia);
    var modal = document.getElementById("MultimodalMXN") ? $("#MultimodalMXN").val() : null;
    modal = parseFloat(modal);
    var TotalGtoMX = $("#TotalGtoMXN");
    /*App.blockUI({ target: "#Entradas_Portlet", boxed: !0, message: "Procesando…" });
    if ((KMRecorrer == "") || (Factor == "") || (KMRecorrer == "")) {
        Control.val("");
    }*/
    if ($("#TipoCambio").val() != "") {
        num1 = CasetasMXN;
        Calcular_Casetas_USD();
    }
    if (DieselMXN == "") {
        DieselMXN = num;
        num = 0;
    }
    if (SueldoOpMXN == "") {
        SueldoOpMXN = num;
        num = 0;
    }
    if ((CasetasMXN != "") && (SueldoOpMXN != "") && (DieselMXN!="")) {
        $.ajax({
            cache: false,
            type: "POST",
            url: "/AjaxQuerys/AjaxResponse.aspx/GetTotalGto",
            data: JSON.stringify({
                "CasetasMXN": CasetasMXN, "DieselMXN": DieselMXN, "SueldoOpMXN": SueldoOpMXN
            }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                $.each(response.d, function (id, option) {
                    var gto = option.TotalGtoM;
                    gto = gto + custodia + modal;
                    gto = parseFloat(gto);
                    TotalGtoMX.val(gto.toFixed(2));
                    num = option.TotalGtoM;
                });
                if ($("#IngresoMXN").val()!="") {
                    Calcular_UOP();
                }
                App.unblockUI("#Entradas_Portlet");
            },
            failure: function (response) {
                App.unblockUI("#Entradas_Portlet");
                alert("Error al cargar producto");
            }
        });
    }
}
function Calcular_UOP() {
    var TotalGtoMXN = document.getElementById("TotalGtoMXN") ? $("#TotalGtoMXN").val() : null;
    var IngresoMXN = document.getElementById("IngresoMXN") ? $("#IngresoMXN").val() : null;
    var UOPMXN = document.getElementById("UOPMXN") ? $("#UOPMXN").val() : null;
    var UOPPMXN = document.getElementById("UOPPMXN") ? $("#UOPPMXN").val() : null;
    var UOPMX = $("#UOPMXN");
    var UOPPMX = $("#UOPPMXN");
    if (IngresoMXN=="") {
        IngresoMXN = num;
        num = 0;
    }
    if (TotalGtoMXN == "") {
        TotalGtoMXN = num;
        num = 0;
    }
    if ((TotalGtoMXN != "") && (IngresoMXN!="")) {
        $.ajax({
            cache: false,
            type: "POST",
            url: "/AjaxQuerys/AjaxResponse.aspx/GetUOP",
            data: JSON.stringify({
                "TotalGtoMXN": TotalGtoMXN, "IngresoMXN": IngresoMXN
            }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                $.each(response.d, function (id, option) {
                    UOPMX.val(option.UOPMX.toFixed(2));
                    UOPPMX.val(option.UOPPMX.toFixed(2));
                });
                App.unblockUI("#Entradas_Portlet");
            },
            failure: function (response) {
                App.unblockUI("#Entradas_Portlet");
                alert("Error al cargar producto");
            }
        });
    }
}
function Calcular_Diesel_USD() {
    var Factor = document.getElementById("Factor") ? $("#Factor").val() : null;
    var PrecioDiesel = document.getElementById("PrecioDiesel") ? $("#PrecioDiesel").val() : null;
    var TipoCambio = document.getElementById("TipoCambio") ? $("#TipoCambio").val() : null;
    var KMCargado = document.getElementById("KMCargado") ? $("#KMCargado").val() : null;
    var DieselUSD = $("#DieselUSD");
    if ((TipoPagoOP != "") && (KMCargado != "") && (IngresoUSD != "")) {
        Calcular_Sueldo_Op_USD();
    }
    if (CasetasMXN!="") {
        Calcular_Casetas_USD();
    }
    if ((KMCargado != "") && (CuotaFija = !"") && (PrecioKM != "")) {
        Calcular_Ingreso_USD();
    }
    if ((BasePagoOp != "") && (KMCargado != "")) {
        Calcular_Sueldo_Op_USD();
    }
    $.ajax({
        cache: false,
        type: "POST",
        url: "/AjaxQuerys/AjaxResponse.aspx/GetDieselUSD",
        data: JSON.stringify({
            "Factor": Factor, "PrecioDiesel": PrecioDiesel, "TipoCambio": TipoCambio, "KMCargado": KMCargado
        }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {
            $.each(response.d, function (id, option) {
                DieselUSD.val(option.DieselUSD.toFixed(2));
                num = option.DieselUSD;
            });
            if ((CasetasUSD != "") && (SueldoOpUSD != "")) {
                Calcular_Gasto_USD();
            }
            App.unblockUI("#Entradas_Portlet");
            CalcularCustodiaUSD();
            CalcularModalUSD();
        },
        failure: function (response) {
            App.unblockUI("#Entradas_Portlet");
            alert("Error al cargar producto");
        }
    });
}
function Calcular_Casetas_USD() {
    var CasetasMXN = document.getElementById("CasetasMXN") ? $("#CasetasMXN").val() : null;
    var TipoCambio = document.getElementById("TipoCambio") ? $("#TipoCambio").val() : null;
    var CasetasUSD = $("#CasetasUSD");
    /*App.blockUI({ target: "#Entradas_Portlet", boxed: !0, message: "Procesando…" });
    if ((KMRecorrer == "") || (Factor == "") || (KMRecorrer == "")) {
        Control.val("");
    }*/
    if (CasetasMXN != "") {
        CasetasMXN = num1;
    }
    if ((CasetasMXN != "") && (TipoCambio!="")) {
        $.ajax({
            cache: false,
            type: "POST",
            url: "/AjaxQuerys/AjaxResponse.aspx/GetCasetasUSD",
            data: JSON.stringify({
                "CasetasMXN": CasetasMXN, "TipoCambio": TipoCambio
            }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                $.each(response.d, function (id, option) {
                    CasetasUSD.val(option.CasetasUSD.toFixed(2));
                    num = option.CasetasUSD;
                });
                if ((DieselUSD != "") && (SueldoOpUSD != "")) {
                    Calcular_Gasto_USD();
                }
                App.unblockUI("#Entradas_Portlet");
            },
            failure: function (response) {
                App.unblockUI("#Entradas_Portlet");
                alert("Error al cargar producto");
            }
        });
    }
}
function Calcular_Sueldo_Op_USD() {
    var KMCargado = document.getElementById("KMCargado") ? $("#KMCargado").val() : null;
    var TipoCambio = document.getElementById("TipoCambio") ? $("#TipoCambio").val() : null;
    var TipoPagoOP = document.getElementById("TipoPagoOP") ? $("#TipoPagoOP").val() : null;
    var IngresoUSD = document.getElementById("IngresoUSD") ? $("#IngresoUSD").val() : null;
    var SueldoOpUSD = $("#SueldoOpUSD");
    /*App.blockUI({ target: "#Entradas_Portlet", boxed: !0, message: "Procesando…" });
    if ((KMRecorrer == "") || (Factor == "") || (KMRecorrer == "")) {
        Control.val("");
    }*/
    $.ajax({
        cache: false,
        type: "POST",
        url: "/AjaxQuerys/AjaxResponse.aspx/GetSueldoOpUSD",
        data: JSON.stringify({
            "KMCargado": KMCargado, "TipoCambio": TipoCambio, "BasePagoOp": TipoPagoOP, "IngresoUSD": IngresoUSD
        }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {
            $.each(response.d, function (id, option) {
                SueldoOpUSD.val(option.SueldoOpUSD.toFixed(2));
                num = option.SueldoOpUSD;
            });
            if ((DieselUSD != "") && (CasetasUSD != "")) {
                Calcular_Gasto_USD();
            }
            App.unblockUI("#Entradas_Portlet");
        },
        failure: function (response) {
            App.unblockUI("#Entradas_Portlet");
            alert("Error al cargar producto");
        }
    });
}
function Calcular_Gasto_USD() {
    var DieselUSD = document.getElementById("DieselUSD") ? $("#DieselUSD").val() : null;
    var CasetasUSD = document.getElementById("CasetasUSD") ? $("#CasetasUSD").val() : null;
    var SueldoOpUSD = document.getElementById("SueldoOpUSD") ? $("#SueldoOpUSD").val() : null;
    var TotalGtoUSD = document.getElementById("TotalGtoUSD") ? $("#TotalGtoUSD").val() : null;
    var modalUSD = document.getElementById("MultimodalUSD") ? $("#MultimodalUSD").val() : null;
    modalUSD = parseFloat(modalUSD);
    var custodiaUSD = document.getElementById("CustodiaUSD") ? $("#CustodiaUSD").val() : null;
    custodiaUSD = parseFloat(custodiaUSD);
    var TotalGtoUS = $("#TotalGtoUSD");
    if ((DieselUSD != "") && (CasetasUSD != "") && (SueldoOpUSD != "")) {
        $.ajax({
            cache: false,
            type: "POST",
            url: "/AjaxQuerys/AjaxResponse.aspx/GetGastoUSD",
            data: JSON.stringify({
                "DieselUSD": DieselUSD, "CasetasUSD": CasetasUSD, "SueldoOpUSD": SueldoOpUSD
            }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                $.each(response.d, function (id, option) {
                    let numm = parseFloat(option.TotalGtoUSD) + custodiaUSD + modalUSD;
                    TotalGtoUS.val(numm.toFixed(2));
                    num = option.TotalGtoUSD;
                });
                if ($("#IngresoUSD").val() != "") {
                    Calcular_UOP_USD();
                }
                App.unblockUI("#Entradas_Portlet");
            },
            failure: function (response) {
                App.unblockUI("#Entradas_Portlet");
                alert("Error al cargar producto");
            }
        });
    }
}
function Calcular_UOP_USD() {
    var IngresoUSD = document.getElementById("IngresoUSD") ? $("#IngresoUSD").val() : null;
    var TotalGtoUSD = document.getElementById("TotalGtoUSD") ? $("#TotalGtoUSD").val() : null;
    var UOPUSD = document.getElementById("UOPUSD") ? $("#UOPUSD").val() : null;
    var UOPPUSD = document.getElementById("UOPPUSD") ? $("#UOPPUSD").val() : null;
    var UOPUS = $("#UOPUSD");
    var UOPPUS = $("#UOPPUSD");
    if (IngresoUSD == "") {
        IngresoUSD = num;
        num = 0;
    }
    else if (TotalGtoUSD == "") {
        TotalGtoUSD = num;
        num = 0;
    }
    $.ajax({
        cache: false,
        type: "POST",
        url: "/AjaxQuerys/AjaxResponse.aspx/GetUOPUSD",
        data: JSON.stringify({
            "IngresoUSD": IngresoUSD, "TotalGtoUSD": TotalGtoUSD
        }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {
            $.each(response.d, function (id, option) {
                UOPUS.val(option.UOPUSD.toFixed(2));
                UOPPUS.val(option.UOPPUSD.toFixed(2));
            });
            App.unblockUI("#Entradas_Portlet");
        },
        failure: function (response) {
            App.unblockUI("#Entradas_Portlet");
            alert("Error al cargar producto");
        }
    });
}
function Calcular_Ingreso_USD() {
    var PrecioKM = document.getElementById("PrecioKM") ? $("#PrecioKM").val() : null;
    var KMCargado = document.getElementById("KMCargado") ? $("#KMCargado").val() : null;
    var TipoCambio = document.getElementById("TipoCambio") ? $("#TipoCambio").val() : null;
    var CuotaFija = document.getElementById("CuotaFija") ? $("#CuotaFija").val() : null;
    var IngresoUSD = document.getElementById("IngresoUSD") ? $("#IngresoUSD").val() : null;
    var IngresoUS = $("#IngresoUSD");
    $.ajax({
        cache: false,
        type: "POST",
        url: "/AjaxQuerys/AjaxResponse.aspx/GetIngresoUSD",
        data: JSON.stringify({
            "PrecioKM": PrecioKM, "KMCargado": KMCargado, "TipoCambio": TipoCambio, "CuotaFija": CuotaFija
        }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {
            $.each(response.d, function (id, option) {
                IngresoUS.val(option.IngresoUSD.toFixed(2));
                num = option.IngresoUSD;
            });
            if ($("#TotalGtoUSD").val() != "") {
                Calcular_UOP_USD();
            }
            App.unblockUI("#Entradas_Portlet");
        },
        failure: function (response) {
            App.unblockUI("#Entradas_Portlet");
            alert("Error al cargar producto");
        }
    });
}
function Calcular_Ingresos_MX() {
    var TipoCambio = document.getElementById("TipoCambio") ? $("#TipoCambio").val() : null;
    var Repartos = document.getElementById("Reparto") ? $("#Reparto").val() : null;
    var PrecioKM = document.getElementById("PrecioKM") ? $("#PrecioKM").val() : null;
    var KMRecorrer = document.getElementById("KMRecorrer") ? $("#KMRecorrer").val() : null;
    var KMCargado = document.getElementById("KMCargado") ? $("#KMCargado").val() : null;
    var Destino = document.getElementById("Destino") ? $("#Destino").val() : null;
    var IngresoMXN = $("#IngresoMXN");
    if ((KMCargado != "") && (CuotaFija = !"") && (TipoCambio!="")) {
        Calcular_Ingreso_USD();
    }
    if (KMRecorrer == "") {
        KMRecorrer = num;
        num = 0;
    }
    if ((TipoCambio != "") && (Repartos != "") && (PrecioKM != "") && (KMRecorrer != "") && (KMCargado != "") && (Destino!="")) {
        $.ajax({
            cache: false,
            type: "POST",
            url: "/AjaxQuerys/AjaxResponse.aspx/GetIngresoMXN",
            data: JSON.stringify({
                "TipoCambio": TipoCambio, "Repartos": Repartos, "PrecioKM": PrecioKM, "KMRecorrer": KMRecorrer, "KMCargado": KMCargado, "Destino": Destino
            }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                $.each(response.d, function (id, option) {
                    IngresoMXN.val(option.IngresoMXN.toFixed(2));
                    num = option.IngresoMXN;
                });
                if ($("#TotalGtoMXN").val()!="") {
                    Calcular_UOP();
                }
                App.unblockUI("#Entradas_Portlet");
            },
            failure: function (response) {
                App.unblockUI("#Entradas_Portlet");
                alert("Error al cargar producto");
            }
        });
    }
}
function Alta_Cotizacion() {
    var NuevoCliente = document.getElementById("NuevoCliente") ? $("#NuevoCliente").val() : null;
    var IdCtl = document.getElementById("IdCtl") ? $("#IdCtl").val() : null;
    if ((IdCtl == "") || (IdCtl == null)) {
        IdCtl = 0;
    }
    var correo = document.getElementById("CorreoCliente") ? $("#CorreoCliente").val() : null;
    var correoa = document.getElementById("CorreoACliente") ? $("#CorreoACliente").val() : null;
    var celular = document.getElementById("CorreoACliente") ? $("#CorreoACliente").val() : null;
    var telefono = document.getElementById("TelefonoCliente") ? $("#TelefonoCliente").val() : null;
    var direccion = document.getElementById("DireccionCliente") ? $("#DireccionCliente").val() : null;
    var Origen = document.getElementById("Origen") ? $("#Origen").val() : null;
    var KMDnoOrigen = document.getElementById("KMDnoOrigen") ? $("#KMDnoOrigen").val() : null;
    var PrecioKM = document.getElementById("PrecioKM") ? $("#PrecioKM").val() : null;
    var TipoPagoOP = document.getElementById("TipoPagoOP") ? $("#TipoPagoOP").val() : null;
    var Destino = document.getElementById("Destino") ? $("#Destino").val() : null;
    var KMBaseOrigen = document.getElementById("KMBaseOrigen") ? $("#KMBaseOrigen").val() : null;
    var KMCargado = document.getElementById("KMCargado") ? $("#KMCargado").val() : null;
    var Producto = document.getElementById("Producto") ? $("#Producto").val() : null;
    var KMDnoBase = document.getElementById("KMDnoBase") ? $("#KMDnoBase").val() : null;
    var KMVacio = document.getElementById("KMVacio") ? $("#KMVacio").val() : null;
    var Factor = document.getElementById("Factor") ? $("#Factor").val() : null;
    var Transporte = document.getElementById("Transporte") ? $("#Transporte").val() : null;
    var Reparto = document.getElementById("Reparto") ? $("#Reparto").val() : null;
    var KMRecorrer = document.getElementById("KMRecorrer") ? $("#KMRecorrer").val() : null;
    var PrecioDiesel = document.getElementById("PrecioDiesel") ? $("#PrecioDiesel").val() : null;
    var CuotaFija = document.getElementById("CuotaFija") ? $("#CuotaFija").val() : null;
    if ((CuotaFija == "") || (CuotaFija == null)) { CuotaFija = 0; }
    var TipoCambio = document.getElementById("TipoCambio") ? $("#TipoCambio").val() : null;
    var IngresoMXN = document.getElementById("IngresoMXN") ? $("#IngresoMXN").val() : null;
    var IngresoUSD = document.getElementById("IngresoUSD") ? $("#IngresoUSD").val() : null;
    var DieselMXN = document.getElementById("DieselMXN") ? $("#DieselMXN").val() : null;
    var DieselUSD = document.getElementById("DieselUSD") ? $("#DieselUSD").val() : null;
    var CasetasMXN = document.getElementById("CasetasMXN") ? $("#CasetasMXN").val() : null;
    var CasetasUSD = document.getElementById("CasetasUSD") ? $("#CasetasUSD").val() : null;
    var SueldoOpMXN = document.getElementById("SueldoOpMXN") ? $("#SueldoOpMXN").val() : null;
    var SueldoOpUSD = document.getElementById("SueldoOpUSD") ? $("#SueldoOpUSD").val() : null;
    var TotalGtoMXN = document.getElementById("TotalGtoMXN") ? $("#TotalGtoMXN").val() : null;
    var TotalGtoUSD = document.getElementById("TotalGtoUSD") ? $("#TotalGtoUSD").val() : null;
    var UOPMXN = document.getElementById("UOPMXN") ? $("#UOPMXN").val() : null;
    var UOPUSD = document.getElementById("UOPUSD") ? $("#UOPUSD").val() : null;
    var UOPPMXN = document.getElementById("UOPPMXN") ? $("#UOPPMXN").val() : null;
    var UOPPUSD = document.getElementById("UOPPUSD") ? $("#UOPPUSD").val() : null;
    var TipoPagoOP = document.getElementById("TipoPagoOP") ? $("#TipoPagoOP").val() : null;
    var multimodal = document.getElementById("MultimodalMXN") ? $("#MultimodalMXN").val() : null;
    var custodia = document.getElementById("CustodiaMXN") ? $("#CustodiaMXN").val() : null;
    var multimodalUSD = document.getElementById("MultimodalUSD") ? $("#MultimodalUSD").val() : null;
    var custodiaUSD = document.getElementById("CustodiaUSD") ? $("#CustodiaUSD").val() : null;
    App.blockUI({ target: "#Entradas_Portlet", boxed: !0, message: "Procesando…" });
    var remplaza = /\+/gi;
    let v = "";
    var url = window.location.href;
    url = unescape(url);
    url = url.replace(remplaza, " ");
    url = url.toUpperCase();
    function obtener_valor(variable) {
        var variable_may = variable.toUpperCase();
        var variable_pos = url.indexOf(variable_may);
        if (variable_pos != -1) {
            var pos_separador = url.indexOf("&", variable_pos);
            if (pos_separador != -1) {
                return url.substring(variable_pos + variable_may.length + 1, pos_separador);
            } else {
                return url.substring(variable_pos + variable_may.length + 1, url.length);
            }
        } else {
        }
    }
    var valor = obtener_valor("num_cot");
    if ((valor == null) || (valor == "")) {
        valor = 0;
    }
    if (((IngresoMXN == null) || (IngresoMXN == 0)) || ((DieselMXN == null) || (DieselMXN == 0)) || ((SueldoOpMXN == null) || (SueldoOpMXN == 0)) || ((TotalGtoMXN == null) || (TotalGtoMXN == 0)) || ((UOPMXN == null) || (UOPMXN == 0))) {
        alert("Faltan Datos por llenar");
        App.unblockUI("#Entradas_Portlet");
    }
    else {
        if (valor != 0) {
            var DescCtl = $("#DescCtl").val();
            if ((DescCtl == "") || (DescCtl == null)) {
                DescCtl = NuevoCliente;
            }
            $.ajax({
                cache: false,
                type: "POST",
                url: "/AjaxQuerys/AjaxResponse.aspx/EditarCotizacion",
                data: JSON.stringify({
                    "id_cotizacion": valor, "id_origen": Origen, "id_destino": Destino, "id_producto": Producto, "clave_cliente": IdCtl, "Nombre_Cliente": DescCtl, "km_dno_origen": KMDnoOrigen, "km_base_origen": KMBaseOrigen, "km_dno_base": KMDnoBase, "repartos": Reparto, "precio_km": PrecioKM, "km_cargado": KMCargado, "id_tipo_pago_op": TipoPagoOP, "factor": Factor, "precio_diesel": PrecioDiesel, "tipo_cambio": TipoCambio, "casetas": CasetasMXN, "tipo_transporte": Transporte, "km_vacio": KMVacio, "Km_recorrer": KMRecorrer, "Cuota_Fija": CuotaFija, "ingresos_mx": IngresoMXN, "costo_diesel": DieselMXN, "sueldo_op": SueldoOpMXN, "total_gasto_mx": TotalGtoMXN, "uop_mx": UOPMXN, "uop_porcent": UOPPMXN, "Ingresos_usd": IngresoUSD, "Diesel_usd": DieselUSD, "Casetas_usd": CasetasUSD, "Sueldo_Op_usd": SueldoOpUSD, "Total_Gto_usd": TotalGtoUSD, "UOP_usd": UOPUSD, "uop_porcent_usd": UOPPUSD, "custodia": custodia, "custodiaUSD": custodiaUSD, "multimodal": multimodal, "multimodalUSD": multimodalUSD
                }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    $.each(response.d, function (id, option) {
                    });
                    MostrarBotonPDF();
                    App.unblockUI("#Entradas_Portlet");
                },
                failure: function (response) {
                    App.unblockUI("#Entradas_Portlet");
                    alert("Error al cargar producto");
                }
            });
        }
        else {
            var DCtl = document.getElementById("DescCtl");
            var DescCtl = DCtl.options[DCtl.selectedIndex].text;
            if ((DescCtl == "") || (DescCtl == null)) {
                DescCtl = NuevoCliente;
            }
            if (IdCtl == 0) {
                $.ajax({
                    cache: false,
                    type: "POST",
                    url: "/AjaxQuerys/AjaxResponse.aspx/AltaCliente",
                    data: JSON.stringify({
                        "nombre_cliente": DescCtl, "correo": correo, "correoa": correoa, "celular": celular, "telefono": telefono, "direccion": direccion
                    }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        $.each(response.d, function (id, option) {
                            IdCtl = option.id_cliente;
                            $.ajax({
                                cache: false,
                                type: "POST",
                                url: "/AjaxQuerys/AjaxResponse.U/AltaCotizacion",
                                data: JSON.stringify({
                                    "id_origen": Origen, "id_destino": Destino, "id_producto": Producto, "clave_cliente": IdCtl, "Nombre_Cliente": DescCtl, "km_dno_origen": KMDnoOrigen, "km_base_origen": KMBaseOrigen, "km_dno_base": KMDnoBase, "repartos": Reparto, "precio_km": PrecioKM, "km_cargado": KMCargado, "id_tipo_pago_op": TipoPagoOP, "factor": Factor, "precio_diesel": PrecioDiesel, "tipo_cambio": TipoCambio, "casetas": CasetasMXN, "tipo_transporte": Transporte, "km_vacio": KMVacio, "Km_recorrer": KMRecorrer, "Cuota_Fija": CuotaFija, "ingresos_mx": IngresoMXN, "costo_diesel": DieselMXN, "sueldo_op": SueldoOpMXN, "total_gasto_mx": TotalGtoMXN, "uop_mx": UOPMXN, "uop_porcent": UOPPMXN, "Ingresos_usd": IngresoUSD, "Diesel_usd": DieselUSD, "Casetas_usd": CasetasUSD, "Sueldo_Op_usd": SueldoOpUSD, "Total_Gto_usd": TotalGtoUSD, "UOP_usd": UOPUSD, "uop_porcent_usd": UOPPUSD, "custodia": custodia, "custodiaUSD": custodiaUSD, "multimodal": multimodal, "multimodalUSD": multimodalUSD
                                }),
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                success: function (response) {
                                    $.each(response.d, function (id, option) {
                                        v = option.id_nuevo.toString();
                                    });
                                    history.pushState(null, "", "Cotizador?num_cot=" + v);
                                    MostrarBotonPDF();
                                    App.unblockUI("#Entradas_Portlet");
                                },
                                failure: function (response) {
                                    App.unblockUI("#Entradas_Portlet");
                                    alert("Error al cargar producto");
                                }
                            });
                        });
                        App.unblockUI("#Entradas_Portlet");
                    },
                    failure: function (response) {
                        App.unblockUI("#Entradas_Portlet");
                        alert("Error al cargar producto");
                    }
                });
            }
            else {
                $.ajax({
                    cache: false,
                    type: "POST",
                    url: "/AjaxQuerys/AjaxResponse.aspx/AltaCotizacion",
                    data: JSON.stringify({
                        "id_origen": Origen, "id_destino": Destino, "id_producto": Producto, "clave_cliente": IdCtl, "Nombre_Cliente": DescCtl, "km_dno_origen": KMDnoOrigen, "km_base_origen": KMBaseOrigen, "km_dno_base": KMDnoBase, "repartos": Reparto, "precio_km": PrecioKM, "km_cargado": KMCargado, "id_tipo_pago_op": TipoPagoOP, "factor": Factor, "precio_diesel": PrecioDiesel, "tipo_cambio": TipoCambio, "casetas": CasetasMXN, "tipo_transporte": Transporte, "km_vacio": KMVacio, "Km_recorrer": KMRecorrer, "Cuota_Fija": CuotaFija, "ingresos_mx": IngresoMXN, "costo_diesel": DieselMXN, "sueldo_op": SueldoOpMXN, "total_gasto_mx": TotalGtoMXN, "uop_mx": UOPMXN, "uop_porcent": UOPPMXN, "Ingresos_usd": IngresoUSD, "Diesel_usd": DieselUSD, "Casetas_usd": CasetasUSD, "Sueldo_Op_usd": SueldoOpUSD, "Total_Gto_usd": TotalGtoUSD, "UOP_usd": UOPUSD, "uop_porcent_usd": UOPPUSD, "custodia": custodia, "custodiaUSD": custodiaUSD, "multimodal": multimodal, "multimodalUSD": multimodalUSD
                    }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        $.each(response.d, function (id, option) {
                            v = option.id_nuevo.toString();
                        });
                        history.pushState(null, "", "Cotizador?num_cot=" + v);
                        MostrarBotonPDF();
                        App.unblockUI("#Entradas_Portlet");
                    },
                    failure: function (response) {
                        App.unblockUI("#Entradas_Portlet");
                        alert("Error al cargar producto");
                    }
                });
                App.unblockUI("#Entradas_Portlet");
            }
        }
    }
}
function MostrarBotonPDF() {
    App.blockUI({ target: "#Entradas_Portlet", boxed: !0, message: "Procesando…" });
    var remplaza = /\+/gi;
    var url = window.location.href;
    url = unescape(url);
    url = url.replace(remplaza, " ");
    url = url.toUpperCase();
    function obtener_valor(variable) {
        var variable_may = variable.toUpperCase();
        var variable_pos = url.indexOf(variable_may);
        if (variable_pos != -1) {
            var pos_separador = url.indexOf("&", variable_pos);
            if (pos_separador != -1) {
                return url.substring(variable_pos + variable_may.length + 1, pos_separador);
            } else {
                return url.substring(variable_pos + variable_may.length + 1, url.length);
            }
        } else {
        }
    }
    var valor = obtener_valor("num_cot");
    const myText = document.getElementById('MostrarPDF');
    const myInsertText = "<div class='form-group'><div class='col-md-12'><label class='control-label col-md-3'></label><div class='col-md-2'></div><div class='col-md-3'><a href='PDFCotizacion?num_cot="+valor+"' id='VerPDF' class='form-control' type='button' style='text-align:center;' target='blank'>Mostrar PDF</a></div><div class='col-md-3'></div></div></div >";
    myText.innerHTML = myInsertText;
}
function ListarCotizaciones2() {
    const myText = document.getElementById('MostrarCotizaciones');
    var cadena = "";
    App.blockUI({ target: "#Entradas_Portlet", boxed: !0, message: "Procesando…" });
    $.ajax({
        cache: false,
        type: "POST",
        url: "/AjaxQuerys/AjaxResponse.aspx/GetCotizaciones",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {
            $.each(response.d, function (id, option) {
                //var hilera = document.createElement("tr");
                //var celda = document.createElement("td");
                //celda.appendChild(option.Id_cotizacion);
                //hilera.appendChild(celda);
                cadena2 = option.Id_cotizacion.toString();
                var status = "";
                if (option.Status == 0 || option.Status == null) {
                    status = "Inactiva";
                } else {
                    status = "Activa";
                }
                cadena = cadena + "<tr><td>" + option.Id_cotizacion + "</td><td>" + option.Num_clte + "</td><td>" + option.Fecha + "</td><td>" + option.TotalMxn + "</td><td>" + option.TotalUsd + "</td><td>" + status + "</td><td style='width:1%;white-space:nowrap;'><a href='/Ventas/Cotizador?num_cot=" + cadena2 + "' class='' style='width:70px;height:50px;display: inline;margin-left:1em;margin-right:1em;' id='" + option.Id_cotizacion + "'><span class='glyphicon glyphicon-edit'></br>Editar</span></a><a href='/Ventas/VerCotizacion?num_cot=" + cadena2 + "' class='' style='width:80px;height:50px;display: inline;margin-right:1em;' id='" + option.Id_cotizacion + "'><span class='glyphicon glyphicon-align-justify'><br>Cotización</span></a><a href='/Ventas/PDFCotizacion?num_cot=" + cadena2 + "' class='' style='width:70px;height:50px;display: inline;margin-right:1em;' id='" + option.Id_cotizacion + "' target='_blank'><span class='glyphicon glyphicon-file'><br>PDF</span></a><a href='#' class='click' type='button' id='" + option.Id_cotizacion + "' data-toggle='modal' data-target='#mymodal' style='width:70px;height:50px;display: inline;margin-right:1em;' onclick='CancelarCotizacion(" + option.Id_cotizacion + ")'><span class='glyphicon glyphicon-remove'><br>Cancelar</span></a></td></tr>";
            });
            myText.innerHTML = cadena;
            App.unblockUI("#Entradas_Portlet");
            CargarTable();
        },
        failure: function (response) {
            App.unblockUI("#Entradas_Portlet");
            alert("Error al cargar producto");
        }
    });
}
function CargarTable() {
    $(document).ready(function () {
      $('#TableCotizaciones').DataTable();
    });
}
function Proceso() {
    var t;
    $("button").click(function () {
        t = $(this).attr('id');
    });
    console.log(t);
}
function UsoPagina() {
    var remplaza = /\+/gi;
    var url = window.location.href;
    url = unescape(url);
    url = url.replace(remplaza, " ");
    url = url.toUpperCase();
    function obtener_valor(variable) {
        var variable_may = variable.toUpperCase();
        var variable_pos = url.indexOf(variable_may);
        if (variable_pos != -1) {
            var pos_separador = url.indexOf("&", variable_pos);
            if (pos_separador != -1) {
                return url.substring(variable_pos + variable_may.length + 1, pos_separador);
            } else {
                return url.substring(variable_pos + variable_may.length + 1, url.length);
            }
        } else {
        }
    }
    var valor = obtener_valor("num_cot");
    if (valor != null) {
        CtlVista();
        document.querySelector('#ctlexistente').checked = true;
        document.querySelector('#cltnuevo').disabled = true;
        App.blockUI({ target: "#Entradas_Portlet", boxed: !0, message: "Procesando…" });
        $.ajax({
            cache: false,
            type: "POST",
            url: "/AjaxQuerys/AjaxResponse.aspx/GetCotizacion",
            data: JSON.stringify({
                "num_cot": valor
            }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                $.each(response.d, function (id, option) {
                    $("#DescCtl").val(option.Nombre_Cliente);
                    $("#IdCtl").val(option.Clave_Cliente);
                    $("#Transporte").val(option.Tipo_Transporte);
                    $("#KMDnoOrigen").val(option.Km_Dno_Origen);
                    $("#KMBaseOrigen").val(option.Km_Base_Origen);
                    $("#KMDnoBase").val(option.Km_Dno_Base);
                    $("#PrecioKM").val(option.Precio_Km);
                    $("#KMCargado").val(option.Km_Cargado);
                    $("#KMVacio").val(option.Km_Vacio);//
                    $("#KMRecorrer").val(option.Km_Recorrer);
                    if (($("#CuotaFija").val() == 0) || ($("#CuotaFija").val() == null)) { $("#CuotaFija").val("0"); }
                    else { $("#CuotaFija").val(option.Cuota_Fija); }
                    $("#Factor").val(option.Factor);
                    $("#PrecioDiesel").val(option.Precio_Diesel);
                    $("#TipoCambio").val(option.Tipo_Cambio);
                    //
                    $("#IngresoMXN").val(option.Ingresos);
                    $("#IngresoUSD").val(option.Ingresos_usd);
                    $("#DieselMXN").val(option.Diesel);
                    $("#DieselUSD").val(option.Diesel_usd);
                    $("#CasetasMXN").val(option.Casetas);
                    $("#CasetasUSD").val(option.Casetas_usd);
                    $("#SueldoOpMXN").val(option.Sueldo_Op);
                    $("#SueldoOpUSD").val(option.Sueldo_Op_usd);
                    $("#TotalGtoMXN").val(option.Total_Gto);
                    $("#TotalGtoUSD").val(option.Total_Gto_usd);
                    $("#UOPMXN").val(option.UOP);
                    $("#UOPUSD").val(option.UOP_Usd);
                    $("#UOPPMXN").val(option.UOP_Porc);
                    $("#UOPPUSD").val(option.UOP_Usd_Porc);
                    $("#CustodiaMXN").val(option.custodia);
                    $("#CustodiaUSD").val(option.custodia_usd);
                    $("#MultimodalMXN").val(option.multimodal);
                    $("#MultimodalUSD").val(option.multimodal_usd);
                    //option.Destino
                    //$("#Origen").val(option.Destino).html(option.Destino));
                    //document.getElementById("Origen").html = option.Destino;
                    $("#Origen").val(option.Id_Origen).trigger('change.select2');
                    $("#Destino").val(option.Id_Destino).trigger('change.select2');
                    $("#Producto").val(option.Id_Producto).trigger('change.select2');
                    $("#TipoPagoOP").val(option.Id_Tipo_Pago_Op).trigger('change.select2');
                    $("#Reparto").val(option.Repartos).trigger('change.select2');
                });
                App.unblockUI("#Entradas_Portlet");
                CargarTable();
                MostrarBotonPDF();
            },
            failure: function (response) {
                App.unblockUI("#Entradas_Portlet");
                alert("Error al cargar producto");
            }
        });
    }
    else {
        CtlExistente();
        ObtenerTipoCambio();
    }
}
function CargarPDF() {
    var remplaza = /\+/gi;
    App.blockUI({ target: "#Entradas_Portlet", boxed: !0, message: "Procesando…" });
    var url = window.location.href;
    url = unescape(url);
    url = url.replace(remplaza, " ");
    url = url.toUpperCase();
    function obtener_valor(variable) {
        var variable_may = variable.toUpperCase();
        var variable_pos = url.indexOf(variable_may);
        if (variable_pos != -1) {
            var pos_separador = url.indexOf("&", variable_pos);
            if (pos_separador != -1) {
                return url.substring(variable_pos + variable_may.length + 1, pos_separador);
            } else {
                return url.substring(variable_pos + variable_may.length + 1, url.length);
            }
        } else {
        }
    }
    var valor = obtener_valor("num_cot");
    CargarDatos(valor);
    App.blockUI({ target: "#Entradas_Portlet", boxed: !0, message: "Procesando…" });
}
function CargarDatos(valor) {
    App.blockUI({ target: "#Entradas_Portlet", boxed: !0, message: "Procesando…" });
    $.ajax({
        cache: false,
        type: "POST",
        url: "/AjaxQuerys/AjaxResponse.aspx/GetInfoPDF",
        data: JSON.stringify({
            "num_cot": valor
        }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {
            $.each(response.d, function (id, option) {
                document.getElementById("Dia").innerHTML = option.Dia;
                document.getElementById("Mes").innerHTML = option.Mes;
                document.getElementById("Anio").innerHTML = option.Anio;
                document.getElementById("Origen").innerHTML = option.Origen;
                document.getElementById("Destino").innerHTML = option.Destino;
                document.getElementById("Costo").innerHTML = option.Total_Gto_usd;
                document.getElementById("NombreCliente").innerHTML = option.Nombre_Cliente;
            });
            App.unblockUI("#Entradas_Portlet");
        },
        failure: function (response) {
            App.unblockUI("#Entradas_Portlet");
            alert("Error al cargar producto");
        }
    });
}
function GenerarPDF() {
    App.blockUI({ target: "#Entradas_Portlet", boxed: !0, message: "Procesando…" });
    var remplaza = /\+/gi;
    var url = window.location.href;
    url = unescape(url);
    url = url.replace(remplaza, " ");
    url = url.toUpperCase();
    function obtener_valor(variable) {
        var variable_may = variable.toUpperCase();
        var variable_pos = url.indexOf(variable_may);
        if (variable_pos != -1) {
            var pos_separador = url.indexOf("&", variable_pos);
            if (pos_separador != -1) {
                return url.substring(variable_pos + variable_may.length + 1, pos_separador);
            } else {
                return url.substring(variable_pos + variable_may.length + 1, url.length);
            }
        } else {
        }
    }
    var valor = obtener_valor("num_cot");
    const $elementoParaConvertir = document.getElementById("DocumentPDF"); // <-- Aquí puedes elegir cualquier elemento del DOM
    html2pdf()
        .set({
            margin: 1,
            filename: 'Cotizacion_Num_' + valor + '.pdf',
            image: {
                type: 'jpeg',
                quality: 1
            },
            html2canvas: {
                scale: 4, // A mayor escala, mejores gráficos, pero más peso
                letterRendering: true,
            },
            jsPDF: {
                unit: "cm",
                format: "letter",
                orientation: 'portrait' // landscape o portrait
             }
        })
        .from($elementoParaConvertir)
        .save()
        .catch(err => console.log(err));
}
function Mapeo() {
    var id_origen, id_destino;
    //var origen = $("#Origen").val();
    //origen = parseInt(origen, 2);
    var Or = document.getElementById("Origen");
    var origent = Or.options[Or.selectedIndex].text;
    //var origent = origen.options[origen.selectedIndex].text;
    //var destino = $("#Destino").val();
    //destino = parseInt(destino, 2);
    var De = document.getElementById("Destino");
    var destinot = De.options[De.selectedIndex].text;
    //var destinot = destino.options[destino.selectedIndex].text;
    let detalle_casetas = "";
    if (((origent == "Guatemala") || (origent == "San Salvador") || (origent == "San Pedro Sula") || (origent == "Tegucigalpa") || (origent == "Managua") || (origent == "Costa Rica") || (origent == "Panamá")) || ((destinot == "Guatemala") || (destinot == "San Salvador") || (destinot == "San Pedro Sula") || (destinot == "Tegucigalpa") || (destinot == "Managua") || (destinot == "Costa Rica") || (destinot == "Panamá"))) {
        origent = "Ciudad Hidalgo,Chiapas";
    }
    if ((origent != null || origent != "") && (destinot != null || destinot != "")) {
        $.post("https://gaia.inegi.org.mx/sakbe_v3.1/buscadestino",
            {
                type: "json",
                key: "aFQjOyHB-NWNo-ScWt-nBrx-tUdpQgQYPYM6",
                buscar: '"' + origent + '"',
                num: 1
            }).done(function (resultado) {
                id_origen = resultado.data[0].id_dest;
                $.post("https://gaia.inegi.org.mx/sakbe_v3.1/buscadestino",
                    {
                        type: "json",
                        key: "aFQjOyHB-NWNo-ScWt-nBrx-tUdpQgQYPYM6",
                        buscar: '"' + destinot + '"',
                        num: 1
                    }).done(function (resultado) {
                        id_destino = resultado.data[0].id_dest;
                        RutaOptima(id_origen, id_destino);
                    });
            });
    }
}
function RutaOptima(id_origen, id_destino) {
    App.blockUI({ target: "#Entradas_Portlet", boxed: !0, message: "Procesando…" });
    var total_casetas_optima = 0;
    var tiempo_ruta_optima = 0;
    var km_ruta_optima = 0;
    let detalle_casetas = "";
    if ((id_origen != null || id_origen != "") && (id_destino != null || id_destino != "")) {
        $.post("https://gaia.inegi.org.mx/sakbe_v3.1/optima",
        {
            type: "json",
            key: "aFQjOyHB-NWNo-ScWt-nBrx-tUdpQgQYPYM6",
            dest_i: id_origen,
            dest_f: id_destino,
            v: 6,
            proj: "MERC"
        }).done(function (resultado) {
            total_casetas_optima = resultado.data.costo_caseta;
            tiempo_ruta_optima = resultado.data.tiempo_min;
            km_ruta_optima = resultado.data.long_km;
            $.post("https://gaia.inegi.org.mx/sakbe_v3.1/detalle_o",
            {
                type: "json",
                key: "aFQjOyHB-NWNo-ScWt-nBrx-tUdpQgQYPYM6",
                dest_i: id_origen,
                dest_f: id_destino,
                v: 6,
                proj: "MERC"
            }).done(function (resultado) {
                let num_casetas = 0;
                $.each(resultado.data, function (index1, value) {
                    $.each(resultado.data[index1], function (index, value) {
                        if ((index == "costo_caseta") && (value != 0)) {
                            detalle_casetas = detalle_casetas + "<tr><td><label style:'margin-left:1em;margin-right:1em;'>" + JSON.stringify(resultado.data[index1].direccion).substr(16, JSON.stringify(resultado.data[index1].direccion).length).replace(/"/, '') + " </td><td style:'margin-left:1em;margin-right:1em;'>" + value + "</td></tr>";
                            num_casetas += 1;
                        }
                        //if ((index == "direccion") && (value.includes("Carretera"))) {
                        //    ruta_o = ruta_o + JSON.stringify(resultado.data[index1].direccion).substr(JSON.stringify(resultado.data[index1].direccion).indexOf("Carretera"), JSON.stringify(resultado.data[index1].direccion).length).replace(/"/, '') + ",";
                        //}
                        //document.write(ruta_o);
                    });
                });
                RutaLibre(id_origen, id_destino);
                document.getElementById("RutaOptima").innerHTML = "<table class='stripe hover nowrap' border='1' style='text-align: center; font-weight: 700; font-size: 12px;'><thead style='background:#FF5353;'><tr><td>Caseta</td><td>Precio</td></tr></thead><tbody>" + detalle_casetas + "<tr><td style='background:grey;'>Total</td><td>" + total_casetas_optima + "</td></tr></tbody></table>";
                $("#Distancia").val(km_ruta_optima);
                $("#Casetas").val(total_casetas_optima);
                $("#Tiempo").val(tiempo_ruta_optima);
                document.getElementById("MostrarCasetasOptima").innerHTML = "$"+total_casetas_optima;
                document.getElementById("MostrarTiempoOptima").innerHTML = " " + Minute2Hour(tiempo_ruta_optima) + " hrs";
                document.getElementById("MostrarDistanciaOptima").innerHTML = km_ruta_optima + " km";
            });
        });
    }
}
function Minute2Hour(minutos) {
    var hora = Math.floor(minutos / 60);
    hora = (hora < 10) ? '0' + hora : hora;
    var minuto = Math.floor(minutos % 60);
    minuto = (minuto < 10) ? '0' + minuto : minuto;
    return hora + ':' + minuto;
}
function RutaLibre(id_origen, id_destino) {
    var total_casetas_libre = 0;
    var tiempo_ruta_libre = 0;
    var km_ruta_libre = 0;
    let detalle_casetas = "";
    if ((id_origen != null || id_origen != "") && (id_destino != null || id_destino != "")) {
        $.post("https://gaia.inegi.org.mx/sakbe_v3.1/libre",
            {
                type: "json",
                key: "aFQjOyHB-NWNo-ScWt-nBrx-tUdpQgQYPYM6",
                dest_i: id_origen,
                dest_f: id_destino,
                v: 6,
                proj: "MERC"
            }).done(function (resultado) {
                //alert("i");
                //document.write(JSON.stringify(resultado));
                //alert("Casetas: " + resultado.data.costo_caseta + " Tiempo: " + resultado.data.tiempo_min + " Km: " + resultado.data.long_km);
                total_casetas_libre = resultado.data.costo_caseta;
                tiempo_ruta_libre = resultado.data.tiempo_min;
                km_ruta_libre = resultado.data.long_km;
                //alert("Creditos:"+resultado.meta.fuente); //imprime créditos
                $.post("https://gaia.inegi.org.mx/sakbe_v3.1/detalle_l",
                    {
                        type: "json",
                        key: "aFQjOyHB-NWNo-ScWt-nBrx-tUdpQgQYPYM6",
                        dest_i: id_origen,
                        dest_f: id_destino,
                        v: 6,
                        proj: "MERC"
                    }).done(function (resultado) {
                        let num_casetas = 0;
                        //alert("i");
                        $.each(resultado.data, function (index1, value) {
                            $.each(resultado.data[index1], function (index, value) {
                                if ((index == "costo_caseta") && (value != 0)) {
                                    //alert("Caseta: " + JSON.stringify(resultado.data[index1].direccion) + " Costo: " + value);
                                    detalle_casetas = detalle_casetas + "<tr><td>" + JSON.stringify(resultado.data[index1].direccion).substr(16, JSON.stringify(resultado.data[index1].direccion).length).replace(/"/, '') + " </td><td>" + value + "</td></tr>";
                                    num_casetas += 1;
                                }
                                //alert(index + ": " + value);    
                            });
                        });
                        CostoDiesel();
                        //alert("Casetas: " + total_casetas_libre + " Tiempo: " + tiempo_ruta_libre + " Km: " + km_ruta_libre);
                        document.getElementById("RutaLibre").innerHTML = "<table class='stripe hover nowrap' border='1' style='text-align: center; font-weight: 700; font-size: 12px;'><thead style='background:#FF5353;'><tr><td>Caseta</td><td>Precio</td></tr></thead><tbody>" + detalle_casetas + "<tr><td style='background:grey;'>Total</td><td>" + total_casetas_libre + "</td></tr></tbody></table>";
                        $("#DistanciaL").val(km_ruta_libre);
                        $("#CasetasL").val(total_casetas_libre);
                        $("#TiempoL").val(tiempo_ruta_libre);
                        document.getElementById("MostrarCasetasLibre").innerHTML = "$" + total_casetas_libre;
                        document.getElementById("MostrarTiempoLibre").innerHTML = " " + Minute2Hour(tiempo_ruta_libre) + " hrs";
                        document.getElementById("MostrarDistanciaLibre").innerHTML = km_ruta_libre + " km";
                    });
            });
    }
}
function CostoDiesel() {
    $.post("https://gaia.inegi.org.mx/sakbe_v3.1/combustible",
        {
            type: "json",
            key: "aFQjOyHB-NWNo-ScWt-nBrx-tUdpQgQYPYM6"
        }).done(function (resultado) {
            //alert("i");
            $.each(resultado.data, function (index1, value) {
                $.each(resultado.data[index1], function (index, value) {
                    if ((index == "tipo") && (value == "Diésel")) {
                        $("#PrecioDieselC").val(JSON.stringify(resultado.data[index1].costo));
                        $("#PrecioDieselL").val(JSON.stringify(resultado.data[index1].costo));
                    }
                });
            });
            CalcularCombustible();
            CalcularCombustibleL();
            App.unblockUI("#Entradas_Portlet");
        });
}
function CalcularCombustible() {
    var cuota = 0;
    var origen = document.getElementById("Origen") ? $("#Origen").val() : null;
    var destino = document.getElementById("Destino") ? $("#Destino").val() : null;
    if (parseInt(origen) >= 2457) {
        cuota = document.getElementById("CuotaFija") ? $("#CuotaFija").val() : null;
        document.getElementById("CuotaFijaO").innerHTML = "<table class='stripe hover nowrap' border='1' style='text-align: center; font-weight: 700; font-size: 12px;'><thead><tr><td style='background:#FF5353;'>Cuota Fija</td><td>$" + cuota + "</td></tr></thead></tbody></table>";
        document.getElementById("CuotaFijaL").innerHTML = "<table class='stripe hover nowrap' border='1' style='text-align: center; font-weight: 700; font-size: 12px;'><thead><tr><td style='background:#FF5353;'>Cuota Fija</td><td>$" + cuota + "</td></tr></thead></tbody></table>";
    }
    if (parseInt(destino) >= 2457) {
        cuota = document.getElementById("CuotaFija") ? $("#CuotaFija").val() : null;
        document.getElementById("CuotaFijaO").innerHTML = "<table class='stripe hover nowrap' border='1' style='text-align: center; font-weight: 700; font-size: 12px;'><thead><tr><td style='background:#FF5353;'>Cuota Fija</td><td>$" + cuota + "</td></tr></thead></tbody></table>";
        document.getElementById("CuotaFijaL").innerHTML = "<table class='stripe hover nowrap' border='1' style='text-align: center; font-weight: 700; font-size: 12px;'><thead><tr><td style='background:#FF5353;'>Cuota Fija</td><td>$" + cuota + "</td></tr></thead></tbody></table>";
    }
    var PrecioDieselC = document.getElementById("PrecioDieselC") ? $("#PrecioDieselC").val() : null;
    PrecioDieselC = parseFloat(PrecioDieselC);
    var Rendimiento = document.getElementById("Rendimiento") ? $("#Rendimiento").val() : null;
    Rendimiento = parseFloat(Rendimiento);
    var km = document.getElementById("Distancia") ? $("#Distancia").val() : null;
    km = parseFloat(km);
    var casetas = document.getElementById("Casetas") ? $("#Casetas").val() : null;
    casetas = parseFloat(casetas);
    var combustible = ((km / Rendimiento) * PrecioDieselC);
    combustible = parseFloat(combustible);
    var costo = (((km / Rendimiento) * PrecioDieselC) + casetas);
    costo = parseFloat(costo) + parseFloat(cuota);
    $("#Combustible").val(combustible.toFixed(2));
    $("#CostoTotal").val(costo.toFixed(2));
    document.getElementById("MostrarCostoOptima").innerHTML = costo.toFixed(2);
}
function CalcularCombustibleL() {
    var cuota = 0;
    var PrecioDiesel = document.getElementById("PrecioDieselL") ? $("#PrecioDieselL").val() : null;
    PrecioDiesel = parseFloat(PrecioDiesel);
    var Rendimiento = document.getElementById("RendimientoL") ? $("#RendimientoL").val() : null;
    Rendimiento = parseFloat(Rendimiento);
    var km = document.getElementById("DistanciaL") ? $("#DistanciaL").val() : null;
    km = parseFloat(km);
    var casetas = document.getElementById("CasetasL") ? $("#CasetasL").val() : null;
    casetas = parseFloat(casetas);
    var combustible = ((km / Rendimiento) * PrecioDiesel);
    combustible = parseFloat(combustible);
    var costo = (((km / Rendimiento) * PrecioDiesel) + casetas);
    costo = parseFloat(costo) + parseFloat(cuota);
    $("#CombustibleL").val(combustible.toFixed(2));
    $("#CostoTotalL").val(costo.toFixed(2));
    document.getElementById("MostrarCostoLibre").innerHTML = costo.toFixed(2);
    MostrarCotizacionRuta();
}
function CancelarCotizacion(num_cot) {
    if (num_cot != null) {
        num = num_cot;
    }
    else if (num != null) {
        $.ajax({
            cache: false,
            type: "POST",
            url: "/AjaxQuerys/AjaxResponse.aspx/CancelarCotizacion",
            data: JSON.stringify({
                "num_cot": num
            }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                $.each(response.d, function (id, option) {
                });
                App.unblockUI("#Entradas_Portlet");
            },
            failure: function (response) {
                App.unblockUI("#Entradas_Portlet");
                alert("Error al cargar producto");
            }
        });
        num = 0;
        location.reload();
    }
}
function MostrarCotizacionRuta() {
    $('#mymodal').modal('show');
}
function CopiarCotizacion() {
    let op = $('input[name="ruta"]:checked').val();
    if (op == "libre") {
        var PrecioDiesel = document.getElementById("PrecioDieselL") ? $("#PrecioDieselL").val() : null;
        var casetas = document.getElementById("CasetasL") ? $("#CasetasL").val() : null;
        $("#PrecioDiesel").val(PrecioDiesel);
        $("#CasetasMXN").val(casetas);
        Calcular_Diesel_Mx();
        Calcular_Total_Gto();
    }
    else {
        var PrecioDiesel = document.getElementById("PrecioDieselC") ? $("#PrecioDieselC").val() : null;
        var casetas = document.getElementById("Casetas") ? $("#Casetas").val() : null;
        $("#PrecioDiesel").val(PrecioDiesel);
        $("#CasetasMXN").val(casetas);
        Calcular_Diesel_Mx();
        Calcular_Total_Gto();
    }
}
function GenerarMapeo() {
    var origen = document.getElementById("Origen") ? $("#Origen").val() : null;
    var destino = document.getElementById("Destino") ? $("#Destino").val() : null;
    if ((origen != "") && (destino != "")) {
        App.blockUI({ target: "#Entradas_Portlet", boxed: !0, message: "Procesando…" });
        Mapeo();
        App.unblockUI("#Entradas_Portlet");
    }
    else {
        alert("Debes ingresar un origen y un destino");
    }
}
function CalcularCustodiaUSD() {
    var custodia = document.getElementById("CustodiaMXN") ? $("#CustodiaMXN").val() : null;
    var cambio = document.getElementById("TipoCambio") ? $("#TipoCambio").val() : null;
    $("#CustodiaUSD").val(parseFloat(custodia / cambio).toFixed(2));
    Calcular_Total_Gto();
    Calcular_Gasto_USD();
}
function CalcularModalUSD() {
    var custodia = document.getElementById("MultimodalMXN") ? $("#MultimodalMXN").val() : null;
    var cambio = document.getElementById("TipoCambio") ? $("#TipoCambio").val() : null;
    $("#MultimodalUSD").val(parseFloat(custodia / cambio).toFixed(2));
    Calcular_Total_Gto();
    Calcular_Gasto_USD();
}