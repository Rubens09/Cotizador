using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Routing;
using Microsoft.AspNet.FriendlyUrls;

namespace Portal
{
    public static class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.MapPageRoute(
               "AccountLogin",
               "Account/Login/",
               "~/Views/Account/Login.aspx"
           );
            
            routes.MapPageRoute(
              "AccountCrearUsuario",
              "Account/CrearUsuario/",
              "~/Views/Account/CrearUsuario.aspx"
          );

            routes.MapPageRoute(
             "ServiciosCrearUsuario",
             "Servicios/CrearUsuario/",
             "~/Views/Servicios/SolicitudDeRefaccion.aspx"
         );

            routes.MapPageRoute(
                "Home",
                string.Empty,
                "~/Views/Home/Index.aspx"
            );

            routes.MapPageRoute(
                "ComprasSolicitudCompra",
                "Compras/SolicitudCompra/",
                "~/Views/Compras/SolicitudCompra.aspx"
            );

            routes.MapPageRoute(
                "ServiciosSolicitudDeRefaccion",
                "Servicios/SolicitudDeRefaccion/",
                "~/Views/Servicios/SolicitudDeRefaccion.aspx"
            );
            routes.MapPageRoute(
                "PacientesVerIngresos",
                "Pacientes/VerIngresos/",
                "~/Views/Pacientes/VerIngresos.aspx"
            );
            routes.MapPageRoute(
               "PacientesAgregaCirugia",
               "Pacientes/AgregaCirugia/",
               "~/Views/Pacientes/AgregaCirugia.aspx"
           );
            routes.MapPageRoute(
               "ServiciosAgregaOxigeno",
               "Servicios/AgregaOxigeno/",
               "~/Views/Servicios/AgregaOxigeno.aspx"
           );
            routes.MapPageRoute(
               "ServiciosVerOxigeno",
               "Servicios/VerOxigeno/",
               "~/Views/Servicios/VerOxigeno.aspx"
           );
            routes.MapPageRoute(
             "ServiciosCatalogo",
             "Servicios/Catalogo/",
                 "~/Views/Servicios/Catalogo.aspx"
         );
            routes.MapPageRoute(
             "Cotizador",
             "Ventas/Cotizador/",
             "~/Views/Ventas/Cotizador.aspx"
         );
            routes.MapPageRoute(
             "Cotizaciones",
             "Ventas/Cotizaciones/",
             "~/Views/Ventas/Cotizaciones.aspx"
         );
            routes.MapPageRoute(
             "PDFCotizacion",
             "Ventas/PDFCotizacion/",
             "~/Views/Ventas/PDFCotizacion.aspx"
         );
            routes.MapPageRoute(
             "VerCotizacion",
             "Ventas/VerCotizacion/",
             "~/Views/Ventas/VerCotizacion.aspx"
         );


            routes.MapPageRoute(
   "GestionCortesInterConsulta",
   "Gestion/CortesInterConsulta/",
       "~/Views/Gestion/CortesInterConsulta.aspx"
);
            routes.MapPageRoute(
            "GestionCortesCirugias",
            "Gestion/CortesCirugias/",
            "~/Views/Gestion/CortesCirugias.aspx"
);
            routes.MapPageRoute(
            "GestionSolicitudCirugia",
            "Gestion/SolicitudCirugia/",
            "~/Views/Gestion/SolicitudCirugia.aspx"
);
            routes.MapPageRoute(
          "GestionAprobacionCirugia",
          "Gestion/AprobacionCirugia/",
          "~/Views/Gestion/AprobacionCirugia.aspx"
);
            routes.MapPageRoute(
            "GestionVerSolPendApro",
            "Gestion/VerSolPendApro/",
            "~/Views/Gestion/VerSolPendApro.aspx"
);
            routes.MapPageRoute(
 "EstudiosCargaDetalleEstudio",
 "Estudios/CargaDetalleEstudio/",
     "~/Views/Estudios/CargaDetalleEstudio.aspx"
);
            routes.MapPageRoute(
 "EstudiosRelacionMedNim",
 "Estudios/RelacionMedNim/",
     "~/Views/Estudios/RelacionMedNim.aspx"
);
            routes.MapPageRoute(
"EstudiosConfirmacionResultados",
"Estudios/ConfirmacionResultados/",
 "~/Views/Estudios/ConfirmacionResultados.aspx"
);
            routes.MapPageRoute(
"EstudiosCargaDetalleNimbo",
"Estudios/CargaDetalleNimbo/",
"~/Views/Estudios/CargaDetalleNimbo.aspx"
);
            routes.MapPageRoute(
"InterconsultasTipoInterconsulta",
"Interconsultas/TipoInterconsulta/",
"~/Views/Interconsultas/TipoInterconsulta.aspx"
);
            routes.MapPageRoute(
"InterconsultasConsultasRealizadas",
"Interconsultas/ConsultasRealizadas/",
"~/Views/Interconsultas/ConsultasRealizadas.aspx"
);
            routes.MapPageRoute(
"InterconsultasConsultasAgendadas",
"Interconsultas/ConsultasAgendadas/",
"~/Views/Interconsultas/ConsultasAgendadas.aspx"
);
            routes.MapPageRoute(
"EnfermeriaControlConsultasPoli",
"Enfermeria/ControlConsultasPoli/",
"~/Views/Enfermeria/ControlConsultasPoli.aspx"
);

            routes.MapPageRoute(
"ResultadoOlab",
"Estudios/ResultadoOlab/",
"~/Views/Estudios/ResultadoOlab.aspx"
);


            routes.MapPageRoute(
                "AjaxQuerys",
                "AjaxQuerys/",
                "~/AjaxQuerys/AjaxResponse.aspx"
            );
          

        }
    }
}
