package com.registro.controller;

import com.registro.dao.UsuarioDAO;
import com.registro.dto.UsuarioDTO;
import com.registro.facade.UsuarioFACADE;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * CRUD de Personal (y su usuario de acceso al sistema).
 * Solo disponible para el rol Administrador.
 */
@WebServlet(name = "PersonalController", urlPatterns = {"/PersonalController"})
public class PersonalController extends HttpServlet {

    private static final String ROL_ADMIN = "Administrador";
    private static final String COD_EMP_DEFECTO = "01";

    private final UsuarioFACADE facade = new UsuarioFACADE();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession sesion = request.getSession(false);
        UsuarioDTO logueado = sesion == null ? null
                : (UsuarioDTO) sesion.getAttribute("usuarioAutenticado");

        if (logueado == null) {
            response.sendRedirect(request.getContextPath() + "/UsuarioController?accion=login");
            return;
        }

        if (!ROL_ADMIN.equalsIgnoreCase(logueado.getRol())) {
            response.sendRedirect(request.getContextPath() + "/dashboard.jsp");
            return;
        }

        String accion = request.getParameter("accion");
        if (accion == null || accion.isEmpty()) {
            accion = "listar";
        }

        // Las acciones que modifican datos solo se aceptan por POST
        boolean esPost = "POST".equalsIgnoreCase(request.getMethod());
        if (!esPost && (accion.equals("grabar") || accion.equals("actualizar") || accion.equals("eliminar"))) {
            accion = "listar";
        }

        switch (accion) {
            case "nuevo": {
                UsuarioDTO nuevo = facade.GeneraCodPersonal();
                if (nuevo == null) nuevo = new UsuarioDTO();
                nuevo.setEstadoGene("Activo");
                nuevo.setOpcUserSist(0);
                mostrarFormulario(request, response, nuevo, "grabar", null);
                break;
            }

            case "editar": {
                UsuarioDTO personal = facade.buscarPersonal(parsearId(request.getParameter("id")));
                if (personal == null) {
                    mensaje(sesion, "error", "No se encontró el personal seleccionado.");
                    redirigirListado(request, response);
                } else {
                    mostrarFormulario(request, response, personal, "actualizar", null);
                }
                break;
            }

            case "grabar":
            case "actualizar":
                grabar(request, response, sesion, logueado, accion.equals("actualizar"));
                break;

            case "eliminar":
                eliminar(request, response, sesion, logueado);
                break;

            case "listar":
            default:
                request.setAttribute("listaPersonal", facade.ListaPersonal());
                moverMensajeARequest(request, sesion);
                request.getRequestDispatcher("ListaPersonal.jsp").forward(request, response);
                break;
        }
    }

    private void grabar(HttpServletRequest request, HttpServletResponse response,
                        HttpSession sesion, UsuarioDTO logueado, boolean esActualizacion)
            throws ServletException, IOException {

        String modo = esActualizacion ? "actualizar" : "grabar";
        UsuarioDTO p = extraerPersonal(request);
        UsuarioDTO existente = null;

        if (esActualizacion) {
            existente = facade.buscarPersonal(p.getPersonal_ID());
            if (existente == null) {
                mensaje(sesion, "error", "El personal que intenta actualizar ya no existe.");
                redirigirListado(request, response);
                return;
            }
            p.setCodEmp(existente.getCodEmp());
            p.setFoto(existente.getFoto());
        } else {
            // El código se genera al grabar para no pisar un registro creado en paralelo
            UsuarioDTO codigo = facade.GeneraCodPersonal();
            if (codigo == null) {
                mostrarFormulario(request, response, p, modo, "No se pudo generar el código del personal.");
                return;
            }
            p.setPersonal_ID(codigo.getPersonal_ID());
            p.setCodEmp(logueado.getCodEmp() != null ? logueado.getCodEmp() : COD_EMP_DEFECTO);
        }

        String error = validar(p, existente, logueado);
        if (error != null) {
            mostrarFormulario(request, response, p, modo, error);
            return;
        }

        p.setUsuarioMod(logueado.getPersonal_ID());

        int resultado = facade.grabarPersonal(p);

        if (resultado == UsuarioDAO.USUARIO_DUPLICADO) {
            mostrarFormulario(request, response, p, modo,
                    "El usuario \"" + p.getUsuario() + "\" ya está asignado a otro personal.");
        } else if (resultado != UsuarioDAO.GRABADO_OK) {
            mostrarFormulario(request, response, p, modo,
                    "No se pudo guardar el personal. Revise los datos e intente nuevamente.");
        } else {
            mensaje(sesion, "ok", esActualizacion
                    ? "Personal actualizado correctamente."
                    : "Personal registrado correctamente con código " + p.getPersonal_ID() + ".");
            redirigirListado(request, response);
        }
    }

    private void eliminar(HttpServletRequest request, HttpServletResponse response,
                          HttpSession sesion, UsuarioDTO logueado) throws IOException {

        int id = parsearId(request.getParameter("id"));

        if (id == logueado.getPersonal_ID()) {
            mensaje(sesion, "error", "No puede eliminar su propio registro.");
            redirigirListado(request, response);
            return;
        }

        UsuarioDTO del = new UsuarioDTO();
        del.setPersonal_ID(id);
        int resultado = facade.EliminarUsuario(del);

        if (resultado == UsuarioDAO.PERSONAL_ELIMINADO) {
            mensaje(sesion, "ok", "Personal eliminado correctamente.");
        } else if (resultado == UsuarioDAO.PERSONAL_INACTIVADO) {
            mensaje(sesion, "ok", "El personal tiene movimientos registrados; se marcó como Inactivo.");
        } else {
            mensaje(sesion, "error", "No se pudo eliminar el personal.");
        }
        redirigirListado(request, response);
    }

    private String validar(UsuarioDTO p, UsuarioDTO existente, UsuarioDTO logueado) {
        if (vacio(p.getNombres()) || vacio(p.getApellidoPaterno()) || vacio(p.getApellidoMaterno())) {
            return "Los nombres y ambos apellidos son obligatorios.";
        }
        if (vacio(p.getArea_ID())) {
            return "Seleccione el área del personal.";
        }
        if (p.getRucDNI() != null && !p.getRucDNI().isEmpty() && !p.getRucDNI().matches("\\d{8}|\\d{11}")) {
            return "El DNI debe tener 8 dígitos o el RUC 11 dígitos.";
        }

        boolean esUnoMismo = p.getPersonal_ID() == logueado.getPersonal_ID();
        if (esUnoMismo && (p.getOpcUserSist() != 1 || !"Activo".equalsIgnoreCase(p.getEstadoGene()))) {
            return "No puede quitarse el acceso ni inactivar su propio usuario.";
        }

        if (p.getOpcUserSist() == 1) {
            if (vacio(p.getUsuario())) {
                return "Ingrese el nombre de usuario para el acceso al sistema.";
            }
            if (p.getRol_ID() <= 0) {
                return "Seleccione el rol del usuario.";
            }
            boolean teniaUsuario = existente != null && existente.getUsuario() != null;
            if (!teniaUsuario && vacio(p.getContraseña())) {
                return "Ingrese una contraseña para el nuevo usuario.";
            }
        }
        return null;
    }

    private UsuarioDTO extraerPersonal(HttpServletRequest request) {
        UsuarioDTO p = new UsuarioDTO();
        p.setPersonal_ID(parsearId(request.getParameter("codigo")));
        p.setEstadoGene(texto(request.getParameter("estado")));
        p.setApellidoPaterno(texto(request.getParameter("apellidoPaterno")));
        p.setApellidoMaterno(texto(request.getParameter("apellidoMaterno")));
        p.setNombres(texto(request.getParameter("nombres")));
        p.setDireccion(texto(request.getParameter("direccion")));
        p.setSexo(texto(request.getParameter("sexo")));
        p.setRucDNI(texto(request.getParameter("nroDoc")));
        p.setTelefono1(texto(request.getParameter("telefono")));
        p.setCorreo(texto(request.getParameter("correo")));
        p.setReferencia(texto(request.getParameter("referencia")));
        p.setArea_ID(texto(request.getParameter("area")));

        boolean acceso = "1".equals(request.getParameter("accesoSistema"));
        p.setOpcUserSist(acceso ? 1 : 0);
        if (acceso) {
            p.setUsuario(texto(request.getParameter("usuario")));
            p.setContraseña(request.getParameter("contrasena"));
            p.setRol_ID(parsearId(request.getParameter("rol")));
        }
        return p;
    }

    private void mostrarFormulario(HttpServletRequest request, HttpServletResponse response,
                                   UsuarioDTO personal, String modo, String error)
            throws ServletException, IOException {
        personal.setContraseña(null); // nunca devolver la contraseña a la vista
        request.setAttribute("personal", personal);
        request.setAttribute("modo", modo);
        request.setAttribute("listaAreas", facade.ListaAreas());
        request.setAttribute("listaRoles", facade.ListaRoles());
        if (error != null) {
            request.setAttribute("tipoMensaje", "error");
            request.setAttribute("mensaje", error);
        }
        request.getRequestDispatcher("personal.jsp").forward(request, response);
    }

    private void redirigirListado(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        response.sendRedirect(request.getContextPath() + "/PersonalController?accion=listar");
    }

    // Mensaje que sobrevive al redirect (se muestra una sola vez en el listado)
    private void mensaje(HttpSession sesion, String tipo, String texto) {
        sesion.setAttribute("tipoMensajePersonal", tipo);
        sesion.setAttribute("mensajePersonal", texto);
    }

    private void moverMensajeARequest(HttpServletRequest request, HttpSession sesion) {
        Object texto = sesion.getAttribute("mensajePersonal");
        if (texto != null) {
            request.setAttribute("mensaje", texto);
            request.setAttribute("tipoMensaje", sesion.getAttribute("tipoMensajePersonal"));
            sesion.removeAttribute("mensajePersonal");
            sesion.removeAttribute("tipoMensajePersonal");
        }
    }

    private static int parsearId(String valor) {
        try {
            return valor == null ? 0 : Integer.parseInt(valor.trim());
        } catch (NumberFormatException e) {
            return 0;
        }
    }

    private static String texto(String valor) {
        return valor == null ? null : valor.trim();
    }

    private static boolean vacio(String valor) {
        return valor == null || valor.trim().isEmpty();
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
