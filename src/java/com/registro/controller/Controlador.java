/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package com.registro.controller; // O el paquete de tu controlador

import java.io.IOException;
import java.util.List;
// ❌ NADA de javax.servlet.*
// ✅ TODO debe ser jakarta.servlet.*
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.registro.dto.NegocioDTO;
import com.registro.facade.NegocioFACADE;

import com.registro.dto.UsuarioDTO;
import com.registro.facade.UsuarioFACADE;

/**
 *
 * @author Administrator
 */
@WebServlet(name = "UsuarioController", urlPatterns = {"/UsuarioController"})
public class Controlador extends HttpServlet {

    
protected void processRequest(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");
        NegocioFACADE facade = new NegocioFACADE();

        // Mostrar login con el nombre comercial de la base de datos
        if ("login".equals(accion)) {

            List<NegocioDTO> lista = facade.obtenerListadoNegocio();

            String razonComercial = "Sistema Web de Gestión Digital";

            if (lista != null && !lista.isEmpty()
                    && lista.get(0).getRazonComercial() != null) {

                razonComercial = lista.get(0).getRazonComercial();
            }

            request.setAttribute("nombreNegocio", razonComercial);

            request.getRequestDispatcher("/Login.jsp")
                   .forward(request, response);

            return;
        }
        
        
        if ("autenticar".equals(accion)) {

            String usuario = request.getParameter("usuario");
            String contrasena = request.getParameter("contrasena");

            UsuarioFACADE usuarioFacade = new UsuarioFACADE();

            UsuarioDTO usuarioDTO =
                    usuarioFacade.login(usuario, contrasena);

                if (usuarioDTO != null) {

                    // Crear la sesión del usuario autenticado
                    jakarta.servlet.http.HttpSession sesion =
                            request.getSession(true);

                    sesion.setAttribute("usuarioAutenticado", usuarioDTO);
                    sesion.setAttribute("usuario", usuario);
                    sesion.setAttribute("rol", usuarioDTO.getRol());

                    // Redirigir al dashboard después del login exitoso
                    response.sendRedirect(
                            request.getContextPath() + "/dashboard.jsp");

                    return;
                } else {

                // Credenciales incorrectas
                request.setAttribute(
                        "errorLogin",
                        "Usuario o contraseña incorrectos.");

                cargarLogin(request, response, facade);
                return;
            }
        }

        
        
        // Mostrar dashboard de productos
        if ("productos".equals(accion)) {

            // Verificar que el usuario haya iniciado sesión
            if (request.getSession(false) == null
                    || request.getSession(false)
                              .getAttribute("usuarioAutenticado") == null) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/UsuarioController?accion=login"
                );
                return;
            }

            request.getRequestDispatcher("/Productos.jsp")
                   .forward(request, response);

            return;
        }

        

        // Listado de empresas: conservar el comportamiento actual
        if (accion == null || accion.equals("listar")) {

            System.out.println("1. Iniciando listado de empresas");

            List<NegocioDTO> lista = facade.obtenerListadoNegocio();

            System.out.println("2. Resultado: "
                    + (lista == null ? "NULL" : lista.size() + " empresas"));

            if (lista != null) {
                for (NegocioDTO empresa : lista) {
                    System.out.println(
                            empresa.getCodigo_Emp() + " - "
                            + empresa.getRazonSocial() + " - "
                            + empresa.getRazonComercial()
                    );
                }
            }

            request.setAttribute("ListaEmpresa", lista);

            request.getRequestDispatcher("/ListaEmpresa.jsp")
                   .forward(request, response);
        }
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
    
    private void cargarLogin(
            HttpServletRequest request,
            HttpServletResponse response,
            NegocioFACADE facade)
            throws ServletException, IOException {

        List<NegocioDTO> lista = facade.obtenerListadoNegocio();

        String nombre = "Sistema Web de Gestión Digital";

        if (lista != null && !lista.isEmpty()
                && lista.get(0).getRazonComercial() != null) {

            nombre = lista.get(0).getRazonComercial();
        }

        request.setAttribute("nombreNegocio", nombre);

        request.getRequestDispatcher("/Login.jsp")
               .forward(request, response);
    }

}
