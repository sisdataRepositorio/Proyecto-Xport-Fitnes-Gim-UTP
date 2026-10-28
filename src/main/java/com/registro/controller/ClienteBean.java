package com.registro.controller;

import com.registro.dto.ClienteDTO;
import com.registro.facade.ClienteFACADE;
import jakarta.annotation.PostConstruct;
import jakarta.enterprise.context.SessionScoped;
import jakarta.faces.application.FacesMessage;
import jakarta.faces.context.FacesContext;
import jakarta.inject.Named;
import java.io.Serializable;
import java.util.Collections;
import java.util.List;

/** Acciones JSF para listar, registrar, editar y eliminar socios/clientes. */
@Named("clienteBean")
@SessionScoped
public class ClienteBean implements Serializable {
    private static final long serialVersionUID = 1L;

    private transient ClienteFACADE facade = new ClienteFACADE();

    private ClienteFACADE getFacade() {
        if (facade == null) facade = new ClienteFACADE();
        return facade;
    }
    private ClienteDTO socio;
    private List<ClienteDTO> listaClientes;
    private String modo = "grabar";

    @PostConstruct
    public void init() {
        prepararNuevo(false);
    }

    public List<ClienteDTO> getListaClientes() {
        if (listaClientes == null) {
            try {
                listaClientes = getFacade().ObtenerListadoCliente();
            } catch (RuntimeException ex) {
                listaClientes = Collections.emptyList();
                mensaje(FacesMessage.SEVERITY_ERROR, "No se pudo cargar la lista de socios.");
            }
        }
        return listaClientes;
    }

    public String nuevo() {
        prepararNuevo(true);
        return "/socios.xhtml?faces-redirect=true";
    }

    private void prepararNuevo(boolean resetList) {
        try {
            socio = getFacade().autogenera_CodCliente();
        } catch (RuntimeException ex) {
            socio = null;
        }
        if (socio == null) socio = new ClienteDTO();
        if (socio.getEstado() == null || socio.getEstado().isBlank()) socio.setEstado("Activo");
        modo = "grabar";
        if (resetList) listaClientes = null;
    }

    public String editar(String id) {
        socio = getFacade().buscarCliente(id);
        if (socio == null) {
            prepararNuevo(false);
            mensaje(FacesMessage.SEVERITY_ERROR, "No se encontró el socio seleccionado.");
            return "/ListaClientes.xhtml?faces-redirect=true";
        }
        modo = "actualizar";
        return "/socios.xhtml?faces-redirect=true";
    }

    public String guardar() {
        if (socio == null || socio.getRazonSocial() == null || socio.getRazonSocial().isBlank()) {
            mensaje(FacesMessage.SEVERITY_ERROR, "Ingrese el nombre o razón social del socio.");
            return null;
        }
        try {
            boolean ok;
            if ("actualizar".equals(modo)) {
                ok = getFacade().actualizarCliente(socio);
            } else {
                ok = getFacade().registrarCliente(socio);
            }
            if (!ok) {
                mensaje(FacesMessage.SEVERITY_ERROR, "No se pudo guardar el socio. Verifique los datos y la conexión.");
                return null;
            }
            listaClientes = null;
            FacesContext.getCurrentInstance().getExternalContext().getFlash()
                    .put("mensajeSocios", "actualizar".equals(modo)
                            ? "Socio actualizado correctamente." : "Socio registrado correctamente.");
            prepararNuevo(false);
            return "/ListaClientes.xhtml?faces-redirect=true";
        } catch (RuntimeException ex) {
            mensaje(FacesMessage.SEVERITY_ERROR, "Ocurrió un error al guardar el socio.");
            return null;
        }
    }

    public String eliminar(String id) {
        ClienteDTO cliente = new ClienteDTO();
        cliente.setCliente_ID(id);
        try {
            if (getFacade().EliminarCliente(cliente)) {
                listaClientes = null;
                mensaje(FacesMessage.SEVERITY_INFO, "Socio eliminado correctamente.");
            } else {
                mensaje(FacesMessage.SEVERITY_ERROR, "No se pudo eliminar el socio.");
            }
        } catch (RuntimeException ex) {
            mensaje(FacesMessage.SEVERITY_ERROR, "Ocurrió un error al eliminar el socio.");
        }
        return null;
    }

    public String cancelar() {
        prepararNuevo(false);
        return "/ListaClientes.xhtml?faces-redirect=true";
    }

    public String getModo() { return modo; }
    public void setModo(String modo) { this.modo = modo; }
    public ClienteDTO getSocio() {
        if (socio == null) socio = new ClienteDTO();
        return socio;
    }
    public void setSocio(ClienteDTO socio) { this.socio = socio; }

    private void mensaje(FacesMessage.Severity severity, String texto) {
        FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(severity, texto, null));
    }
}
