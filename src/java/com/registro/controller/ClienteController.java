/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.registro.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.registro.dto.ClienteDTO;
import com.registro.facade.ClienteFACADE;
import java.util.List;


/**
 *
 * @author Ing
 */
@WebServlet(name = "ClienteController", urlPatterns = {"/ClienteController"})
public class ClienteController extends HttpServlet {

    // CORRECCIÓN: Los atributos de clase van aquí, fuera de los métodos
    private final ClienteFACADE clienteFacade;

    // CORRECCIÓN: El constructor va al nivel de la clase
    public ClienteController() {
        this.clienteFacade = new ClienteFACADE();
    }

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // CORRECCIÓN: Recogemos la acción que envía la vista (por defecto "listar")
        String accion = request.getParameter("accion");
        if (accion == null) {
            accion = "listar";
        }

        switch (accion) {
            case "listar":
                procesarSolicitudListar(request, response);
                break;
            // Aquí puedes agregar más casos en el futuro: "registrar", "eliminar", etc.
            default:
                procesarSolicitudListar(request, response);
                break;
        }
    } // CORRECCIÓN: Se cierra adecuadamente el bloque de processRequest

    // CORRECCIÓN: Pasamos el request y response para poder redirigir a un JSP
    public void procesarSolicitudListar(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        List<ClienteDTO> listaClientes = clienteFacade.ObtenerListadoCliente();
        
        if (listaClientes == null || listaClientes.isEmpty()) {
            System.out.println("No hay clientes activos registrados.");
        } else {
            System.out.println("Clientes cargados exitosamente: " + listaClientes.size());
        }
        
        // ENLACE CON LA VISTA: Adjuntamos la lista a la petición web
        request.setAttribute("listaClientesWeb", listaClientes);
        
        // Redireccionamos los datos hacia tu página JSP que pintará la tabla
        request.getRequestDispatcher("/ListaClientes.jsp")
       .forward(request, response);
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     */
    @Override
    public String getServletInfo() {
        return "Controlador Central de Clientes";
    }// </editor-fold>

}
