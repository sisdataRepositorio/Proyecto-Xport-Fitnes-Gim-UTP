
package com.registro.report;

import com.registro.config.ConexionBD;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.util.HashMap;
import java.util.Map;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;

@WebServlet("/reportes/clientes.pdf")
public class ReporteClientesServlet extends HttpServlet {

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try (InputStream plantilla =
                getClass().getResourceAsStream(
                        "/reportes/report.jrxml")) {

            // Verificar que se encuentre la plantilla.
            if (plantilla == null) {
                response.sendError(
                        HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                        "No se encontró reportes/report.jrxml.");
                return;
            }

            // Usar la conexión que ya existe en el proyecto.
            try (Connection conexion =
                    ConexionBD.obtenerConexion()) {

                // Compilar el archivo JRXML.
                JasperReport reporte =
                        JasperCompileManager.compileReport(plantilla);

                // Parámetros del informe.
                Map<String, Object> parametros = new HashMap<>();

                // Ejecutar la consulta del JRXML y llenar el informe.
                JasperPrint documento =
                        JasperFillManager.fillReport(
                                reporte,
                                parametros,
                                conexion);

                // Convertir el informe a PDF.
                byte[] pdf =
                        JasperExportManager.exportReportToPdf(documento);

                // Enviar el PDF al navegador.
                response.setContentType("application/pdf");
                response.setHeader(
                        "Content-Disposition",
                        "inline; filename=\"reporte_clientes.pdf\"");

                response.setContentLength(pdf.length);
                response.getOutputStream().write(pdf);

            }

        } catch (Exception e) {
            log("Error al generar el reporte de clientes", e);

            if (!response.isCommitted()) {
                response.sendError(
                        HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                        "No se pudo generar el reporte de clientes. "
                        + "Revisa el registro de Tomcat.");
            }
        }
    }
}
