package com.registro.controller;

import com.registro.dao.UsuarioDAO;
import com.registro.dto.AreaDTO;
import com.registro.dto.RolDTO;
import com.registro.dto.UsuarioDTO;
import com.registro.facade.UsuarioFACADE;
import jakarta.annotation.PostConstruct;
import jakarta.enterprise.context.SessionScoped;
import jakarta.faces.application.FacesMessage;
import jakarta.faces.context.ExternalContext;
import jakarta.faces.context.FacesContext;
import jakarta.inject.Named;
import java.io.Serializable;
import java.util.Collections;
import java.util.List;
import java.util.Map;

/** Controlador de vista JSF para el CRUD de personal, reutilizando UsuarioFACADE. */
@Named("personalBean")
@SessionScoped
public class PersonalBean implements Serializable {
    private static final long serialVersionUID = 1L;
    private static final String COD_EMP_DEFECTO = "001";

    private transient UsuarioFACADE facade = new UsuarioFACADE();

    private UsuarioFACADE getFacade() {
        if (facade == null) facade = new UsuarioFACADE();
        return facade;
    }
    private UsuarioDTO personal;
    private List<UsuarioDTO> listaPersonal;
    private List<AreaDTO> listaAreas;
    private List<RolDTO> listaRoles;
    private String modo = "grabar";
    private String contrasena;
    private boolean requiereAcceso;

    @PostConstruct
    public void init() { crearNuevo(false); }

    public List<UsuarioDTO> getListaPersonal() {
        if (listaPersonal == null) {
            try { listaPersonal = getFacade().ListaPersonal(); }
            catch (RuntimeException ex) { listaPersonal = Collections.emptyList(); }
        }
        return listaPersonal;
    }
    public List<AreaDTO> getListaAreas() {
        if (listaAreas == null) {
            try { listaAreas = getFacade().ListaAreas(); }
            catch (RuntimeException ex) { listaAreas = Collections.emptyList(); }
        }
        return listaAreas;
    }
    public List<RolDTO> getListaRoles() {
        if (listaRoles == null) {
            try { listaRoles = getFacade().ListaRoles(); }
            catch (RuntimeException ex) { listaRoles = Collections.emptyList(); }
        }
        return listaRoles;
    }

    public String nuevo() {
        crearNuevo(true);
        return "/personal.xhtml?faces-redirect=true";
    }

    private void crearNuevo(boolean invalidaLista) {
        personal = new UsuarioDTO();
        UsuarioDTO codigo = getFacade().GeneraCodPersonal();
        if (codigo != null) personal.setPersonal_ID(codigo.getPersonal_ID());
        personal.setEstadoGene("Activo");
        personal.setSexo("MASCULINO");
        personal.setOpcUserSist(0);
        personal.setRol_ID(0);
        contrasena = null;
        requiereAcceso = false;
        modo = "grabar";
        if (invalidaLista) listaPersonal = null;
    }

    public String editar(int id) {
        personal = getFacade().buscarPersonal(id);
        if (personal == null) {
            crearNuevo(false);
            mensaje(FacesMessage.SEVERITY_ERROR, "No se encontró el personal seleccionado.");
            return "/ListaPersonal.xhtml?faces-redirect=true";
        }
        contrasena = null;
        requiereAcceso = personal.getOpcUserSist() == 1;
        modo = "actualizar";
        return "/personal.xhtml?faces-redirect=true";
    }

    public String guardar() {
        if (personal == null) personal = new UsuarioDTO();
        UsuarioDTO logueado = usuarioEnSesion();

        if (vacio(personal.getNombres()) || vacio(personal.getApellidoPaterno())
                || vacio(personal.getApellidoMaterno())) {
            mensaje(FacesMessage.SEVERITY_ERROR, "Los nombres y ambos apellidos son obligatorios.");
            return null;
        }
        if (vacio(personal.getArea_ID())) {
            mensaje(FacesMessage.SEVERITY_ERROR, "Seleccione el área del personal.");
            return null;
        }
        if (!vacio(personal.getRucDNI()) && !personal.getRucDNI().matches("\\d{8}|\\d{11}")) {
            mensaje(FacesMessage.SEVERITY_ERROR, "El DNI debe tener 8 dígitos o el RUC 11 dígitos.");
            return null;
        }

        personal.setOpcUserSist(requiereAcceso ? 1 : 0);
        if (requiereAcceso) {
            if (vacio(personal.getUsuario())) {
                mensaje(FacesMessage.SEVERITY_ERROR, "Ingrese el nombre de usuario para el acceso al sistema.");
                return null;
            }
            if (personal.getRol_ID() <= 0) {
                mensaje(FacesMessage.SEVERITY_ERROR, "Seleccione el rol del usuario.");
                return null;
            }
            if ("grabar".equals(modo) && vacio(contrasena)) {
                mensaje(FacesMessage.SEVERITY_ERROR, "Ingrese una contraseña para el nuevo usuario.");
                return null;
            }
            if (!vacio(contrasena)) personal.setContraseña(contrasena);
        } else {
            personal.setUsuario(null);
            personal.setContraseña(null);
            personal.setRol_ID(0);
        }

        if (logueado != null) {
            personal.setUsuarioMod(logueado.getPersonal_ID());
            if ("grabar".equals(modo)) {
                personal.setCodEmp(logueado.getCodEmp() != null ? logueado.getCodEmp() : COD_EMP_DEFECTO);
            } else {
                UsuarioDTO actual = getFacade().buscarPersonal(personal.getPersonal_ID());
                if (actual != null) {
                    personal.setCodEmp(actual.getCodEmp());
                    personal.setFoto(actual.getFoto());
                }
                if (personal.getPersonal_ID() == logueado.getPersonal_ID()
                        && (personal.getOpcUserSist() != 1 || "Inactivo".equalsIgnoreCase(personal.getEstadoGene()))) {
                    mensaje(FacesMessage.SEVERITY_ERROR, "No puede quitarse el acceso ni inactivar su propio usuario.");
                    return null;
                }
            }
        }

        int resultado = getFacade().grabarPersonal(personal);
        if (resultado == UsuarioDAO.USUARIO_DUPLICADO) {
            mensaje(FacesMessage.SEVERITY_ERROR, "Ese nombre de usuario ya está asignado a otro personal.");
            return null;
        }
        if (resultado != UsuarioDAO.GRABADO_OK) {
            mensaje(FacesMessage.SEVERITY_ERROR, "No se pudo guardar el personal. Revise los datos y la conexión.");
            return null;
        }

        listaPersonal = null;
        FacesContext.getCurrentInstance().getExternalContext().getFlash().put(
                "mensajePersonalJSF", "actualizar".equals(modo)
                        ? "Personal actualizado correctamente." : "Personal registrado correctamente.");
        crearNuevo(false);
        return "/ListaPersonal.xhtml?faces-redirect=true";
    }

    public String eliminar(int id) {
        UsuarioDTO logueado = usuarioEnSesion();
        if (logueado != null && logueado.getPersonal_ID() == id) {
            mensaje(FacesMessage.SEVERITY_ERROR, "No puede eliminar su propio registro.");
            return null;
        }
        UsuarioDTO eliminar = new UsuarioDTO();
        eliminar.setPersonal_ID(id);
        int resultado = getFacade().EliminarUsuario(eliminar);
        listaPersonal = null;
        if (resultado == UsuarioDAO.PERSONAL_ELIMINADO) {
            mensaje(FacesMessage.SEVERITY_INFO, "Personal eliminado correctamente.");
        } else if (resultado == UsuarioDAO.PERSONAL_INACTIVADO) {
            mensaje(FacesMessage.SEVERITY_INFO, "El personal tiene movimientos registrados; se marcó como Inactivo.");
        } else {
            mensaje(FacesMessage.SEVERITY_ERROR, "No se pudo eliminar el personal.");
        }
        return null;
    }

    public String cancelar() {
        crearNuevo(false);
        return "/ListaPersonal.xhtml?faces-redirect=true";
    }

    public boolean isEdicion() { return "actualizar".equals(modo); }
    public boolean isRequiereAcceso() { return requiereAcceso; }
    public void setRequiereAcceso(boolean requiereAcceso) { this.requiereAcceso = requiereAcceso; }
    public String getModo() { return modo; }
    public UsuarioDTO getPersonal() { if (personal == null) personal = new UsuarioDTO(); return personal; }
    public void setPersonal(UsuarioDTO personal) { this.personal = personal; }
    public String getContrasena() { return contrasena; }
    public void setContrasena(String contrasena) { this.contrasena = contrasena; }

    private UsuarioDTO usuarioEnSesion() {
        Map<String, Object> session = FacesContext.getCurrentInstance().getExternalContext().getSessionMap();
        Object value = session.get("usuarioAutenticado");
        return value instanceof UsuarioDTO ? (UsuarioDTO) value : null;
    }
    private static boolean vacio(String s) { return s == null || s.trim().isEmpty(); }
    private void mensaje(FacesMessage.Severity severity, String texto) {
        FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(severity, texto, null));
    }
}
