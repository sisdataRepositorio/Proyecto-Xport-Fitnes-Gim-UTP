package com.registro.controller;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.registro.facade.ClienteFACADE;
import com.registro.dto.ClienteDTO;

@WebServlet(name = "ClienteController", urlPatterns = {"/ClienteController"})
public class ClienteController extends HttpServlet {

    private final ClienteFACADE facade = new ClienteFACADE();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String accion = request.getParameter("accion");
        if (accion == null || accion.isEmpty()) {
            accion = "listar";
        }

        switch (accion) {
            case "listar":
                List<ClienteDTO> lista = facade.ObtenerListadoCliente();
                request.setAttribute("listaClientesWeb", lista);
                request.getRequestDispatcher("ListaClientes.jsp").forward(request, response);
                break;

            case "nuevo":
                ClienteDTO auto = facade.autogenera_CodCliente();
                request.setAttribute("socio", auto);
                request.setAttribute("modo", "grabar");
                request.getRequestDispatcher("socios.jsp").forward(request, response);
                break;

            case "editar":
                String idEditar = request.getParameter("id");
                ClienteDTO socio = facade.buscarCliente(idEditar);
                request.setAttribute("socio", socio);
                request.setAttribute("modo", "actualizar");
                request.getRequestDispatcher("socios.jsp").forward(request, response);
                break;

            case "grabar":
                ClienteDTO nuevo = extraerCliente(request);
                facade.registrarCliente(nuevo);
                response.sendRedirect("ClienteController?accion=listar");
                break;

            case "actualizar":
                ClienteDTO editado = extraerCliente(request);
                facade.actualizarCliente(editado);
                response.sendRedirect("ClienteController?accion=listar");
                break;

            case "eliminar":
                String idEliminar = request.getParameter("id");
                ClienteDTO del = new ClienteDTO();
                del.setCliente_ID(idEliminar);
                facade.EliminarCliente(del);
                response.sendRedirect("ClienteController?accion=listar");
                break;

            default:
                response.sendRedirect("ClienteController?accion=listar");
                break;
        }
    }

    private ClienteDTO extraerCliente(HttpServletRequest request) {
        ClienteDTO c = new ClienteDTO();
        c.setCliente_ID(request.getParameter("codigo"));
        c.setTipoId(request.getParameter("tipoDoc"));
        c.setRucDNI(request.getParameter("nroDoc"));
        c.setRazonSocial(request.getParameter("razonSocial"));
        c.setDireccion(request.getParameter("direccion"));
        c.setTelefono(request.getParameter("telefono1"));
        c.setTelefono2(request.getParameter("telefono2"));
        c.setSexo(request.getParameter("sexo"));
        c.setCorreo(request.getParameter("correo"));
        c.setEstado(request.getParameter("estado"));
        c.setContacto(request.getParameter("contacto"));
        c.setTelefonoCont(request.getParameter("telefonoCont"));
        c.setFoto(request.getParameter("fotoUrl"));
        return c;
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
}