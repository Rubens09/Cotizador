var op = 0;
document.addEventListener("DOMContentLoaded", () => {
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
    // Escuchamos el click del botón
    const $boton = document.querySelector("#btnCrearPdf");
    $boton.addEventListener("click", () => {
        const $elementoParaConvertir = document.body; // <-- Aquí puedes elegir cualquier elemento del DOM
        document.querySelector("#btnCrearPdf").style.visibility = "hidden";
        html2pdf()
            .set({
                margin: 1,
                filename: 'Cotizacion_Num_' + valor + '.pdf',
                image: {
                    type: 'jpeg',
                    quality: 0.98
                },
                html2canvas: {
                    scale: 5, // A mayor escala, mejores gráficos, pero más peso
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
    });
});
function CargarPDF() {
    alert("222");
}