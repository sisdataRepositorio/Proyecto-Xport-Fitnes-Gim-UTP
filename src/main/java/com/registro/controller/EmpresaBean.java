package com.registro.controller;

import com.registro.dto.NegocioDTO;
import com.registro.facade.NegocioFACADE;
import jakarta.enterprise.context.RequestScoped;
import jakarta.faces.context.FacesContext;
import jakarta.inject.Named;
import java.io.Serializable;
import java.util.Collections;
import java.util.List;
import java.util.Map;

@Named("empresaBean")
@RequestScoped
public class EmpresaBean implements Serializable {
    private static final long serialVersionUID = 1L;
    private final List<NegocioDTO> empresas;

    public EmpresaBean() {
        List<NegocioDTO> temp;
        try { temp = new NegocioFACADE().obtenerListadoNegocio(); }
        catch (RuntimeException ex) { temp = Collections.emptyList(); }
        empresas = temp == null ? Collections.emptyList() : temp;
    }
    public List<NegocioDTO> getEmpresas() { return empresas; }
    public String getUsuario() { return valorSesion("usuario"); }
    public String getRol() { return valorSesion("rol"); }
    private String valorSesion(String key) {
        Map<String,Object> map = FacesContext.getCurrentInstance().getExternalContext().getSessionMap();
        Object v = map.get(key);
        return v == null ? "No autenticado" : v.toString();
    }
    public boolean isAccesoPermitido() {
        String r = getRol();
        return "ADMIN".equalsIgnoreCase(r) || "USER".equalsIgnoreCase(r)
                || "Administrador".equalsIgnoreCase(r) || "Usuario".equalsIgnoreCase(r);
    }
}
