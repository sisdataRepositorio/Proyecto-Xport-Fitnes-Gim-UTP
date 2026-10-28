package com.registro.controller;

import com.registro.dto.NegocioDTO;
import com.registro.dto.UsuarioDTO;
import com.registro.facade.NegocioFACADE;
import com.registro.facade.UsuarioFACADE;
import jakarta.annotation.PostConstruct;
import jakarta.enterprise.context.RequestScoped;
import jakarta.faces.application.FacesMessage;
import jakarta.faces.context.ExternalContext;
import jakarta.faces.context.FacesContext;
import jakarta.inject.Named;
import java.io.Serializable;
import java.util.List;
import java.util.Map;

/** Controlador de vista JSF para inicio y cierre de sesión. */
@Named("loginBean")
@RequestScoped
public class LoginBean implements Serializable {
    private static final long serialVersionUID = 1L;

    private String usuario;
    private String contrasena;
    private String error;
    private String nombreNegocio = "Xport Fitness Gym";

    @PostConstruct
    public void init() {
        try {
            List<NegocioDTO> negocios = new NegocioFACADE().obtenerListadoNegocio();
            if (negocios != null && !negocios.isEmpty()
                    && negocios.get(0).getRazonComercial() != null
                    && !negocios.get(0).getRazonComercial().isBlank()) {
                nombreNegocio = negocios.get(0).getRazonComercial();
            }
        } catch (RuntimeException ex) {
            // La pantalla de inicio debe seguir apareciendo aunque la BD no esté disponible.
        }
    }

    public String autenticar() {
        error = null;
        if (usuario == null || usuario.isBlank() || contrasena == null || contrasena.isBlank()) {
            error = "Ingrese su usuario y contraseña.";
            return null;
        }

        UsuarioDTO dto = new UsuarioFACADE().login(usuario.trim(), contrasena);
        if (dto == null) {
            error = "Usuario o contraseña incorrectos, o no fue posible validar el acceso.";
            return null;
        }

        ExternalContext external = FacesContext.getCurrentInstance().getExternalContext();
        Map<String, Object> session = external.getSessionMap();
        session.put("usuarioAutenticado", dto);
        session.put("usuario", usuario.trim());
        session.put("rol", dto.getRol());
        return "/dashboard.xhtml?faces-redirect=true";
    }

    public String cerrarSesion() {
        ExternalContext external = FacesContext.getCurrentInstance().getExternalContext();
        external.invalidateSession();
        return "/login.xhtml?faces-redirect=true";
    }

    public String getUsuario() { return usuario; }
    public void setUsuario(String usuario) { this.usuario = usuario; }
    public String getContrasena() { return contrasena; }
    public void setContrasena(String contrasena) { this.contrasena = contrasena; }
    public String getError() { return error; }
    public void setError(String error) { this.error = error; }
    public String getNombreNegocio() { return nombreNegocio; }
}
