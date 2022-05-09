function CargaTipoUnidad() {
    var Control = $("#TipoUnidadSolRef");
    //var NameTable = "CitasPoli";
    App.blockUI({ target: "#Entradas_Portlet", boxed: !0, message: "Procesando…" });

    $.ajax({
        cache: false,
        type: "POST",
        url: "/AjaxQuerys/AjaxResponse.aspx/GetTipoUnidad",
        //data: JSON.stringify({ "NameTable": NameTable }),
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

function CargaUnidadSolRef() {
    var ddlTipo = document.getElementById("TipoUnidadSolRef") ? $("#TipoUnidadSolRef").val() : null;
    var Control = $("#UnidadSolRef");
    //var NameTable = "CitasPoli";
    App.blockUI({ target: "#Entradas_Portlet", boxed: !0, message: "Procesando…" });

    $.ajax({
        cache: false,
        type: "POST",
        url: "/AjaxQuerys/AjaxResponse.aspx/GetUnidadRef",
        data: JSON.stringify({ "Tipo": ddlTipo }),
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

function CargaListadoRef() {
    //var ddlTipo = document.getElementById("TipoUnidadSolRef") ? $("#TipoUnidadSolRef").val() : null;
    var Control = $("#CodRefSolRefId");
    var Control2 = $("#DescRefSolRef");
    //var NameTable = "CitasPoli";
    App.blockUI({ target: "#Entradas_Portlet", boxed: !0, message: "Procesando…" });

    $.ajax({
        cache: false,
        type: "POST",
        url: "/AjaxQuerys/AjaxResponse.aspx/GetRefacciones",
        //data: JSON.stringify({ "Tipo": ddlTipo }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {
            Control.html('');
            Control2.html('');
            Control.append($('<option></option>').val("").html("Select"));
            Control2.append($('<option></option>').val("").html("Select"));
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

function CargaUnidadesMedida() {
    //var ddlTipo = document.getElementById("TipoUnidadSolRef") ? $("#TipoUnidadSolRef").val() : null;
    var Control = $("#MedCantSolRef");
    //var NameTable = "CitasPoli";
    App.blockUI({ target: "#Entradas_Portlet", boxed: !0, message: "Procesando…" });

    $.ajax({
        cache: false,
        type: "POST",
        url: "/AjaxQuerys/AjaxResponse.aspx/GetUnidadesMedida",
        //data: JSON.stringify({ "Tipo": ddlTipo }),
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

function SeleccionaRefaccion() {
    var Refa = document.getElementById("CodRefSolRefId") ? $("#CodRefSolRefId").val() : null;
    var DescRefa = document.getElementById("DescRefSolRef") ? $("#DescRefSolRef").val() : null;
    if (Refa != DescRefa)
    {
        if (Refa != "") {
            $("#DescRefSolRef").val(Refa).trigger('change.select2');
        }
        else {
            $("#DescRefSolRef").val("").trigger('change.select2');
        }
    }
}

function SeleccionaDescRefa() {
    var Refa = document.getElementById("CodRefSolRefId") ? $("#CodRefSolRefId").val() : null;
    var DescRefa = document.getElementById("DescRefSolRef") ? $("#DescRefSolRef").val() : null;
    if (Refa != DescRefa)
    {
        if (DescRefa != "") {
            $("#CodRefSolRefId").val(DescRefa).trigger('change.select2');
        }
        else {
            $("#CodRefSolRefId").val("").trigger('change.select2');
        }
    }
}

function AgregarRefacciones() {
    var CodigoRefa = document.getElementById("CodRefSolRefId") ? $("#CodRefSolRefId").val() : null;
    var DescRefa = document.getElementById("DescRefSolRef") ? $("#DescRefSolRef").find('option:selected').text() : null;
    var TipoUnidad = document.getElementById("TipoUnidadSolRef") ? $("#TipoUnidadSolRef").val() : null;
    var Unidad = document.getElementById("UnidadSolRef") ? $("#UnidadSolRef").val() : null;
    var UMed = document.getElementById("MedCantSolRef") ? $("#MedCantSolRef").val() : null;
    var Cantidad = document.getElementById("CantSolRef") ? $("#CantSolRef").val() : null;

    if (CodigoRefa != "") {
        var t = $('#TableListadoRef').DataTable();
        var datas;
        
        t.rows().every(function (rowIdx, tableLoop, rowLoop) {
            datas = this.data();
        });

        var encontrado = false;

        if (datas != null) {
            var filas = t.rows().data();
            filas.each(function (value, index) {
                if (value[0] == CodigoRefa) {
                    encontrado = true;
                }
            });

            if (encontrado == false) {
                t.row.add([
                    CodigoRefa,
                    DescRefa,
                    Unidad,
                    TipoUnidad,
                    Cantidad,
                    UMed
                ]).draw(false);
            }
            else {
                var filas = t.rows().data();
                filas.each(function (value, index) {
                    if (value[0] == CodigoRefa) {
                        value[4] = parseInt(Cantidad)+parseInt(value[4]);
                    }
                });
            }

        }
        else {
            t.row.add([
                CodigoRefa,
                DescRefa,
                Unidad,
                TipoUnidad,
                Cantidad,
                UMed
            ]).draw(false);
        }

        $("#CodRefSolRefId").val("").trigger('change.select2');
        //document.getElementById("ClaveEstudio").value = "";

    }
}