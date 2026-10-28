package com.registro.controller;

import com.registro.facade.UsuarioFACADE;
import jakarta.enterprise.context.RequestScoped;
import jakarta.inject.Named;
import java.io.Serializable;
import java.util.Collections;
import java.util.Map;

@Named("dashboardBean")
@RequestScoped
public class DashboardBean implements Serializable {
    private static final long serialVersionUID = 1L;
    private Map<String, Integer> resumenPersonal = Collections.emptyMap();

    public DashboardBean() {
        try { resumenPersonal = new UsuarioFACADE().resumenPersonal(); }
        catch (RuntimeException ex) { resumenPersonal = Collections.emptyMap(); }
    }
    public Map<String, Integer> getResumenPersonal() { return resumenPersonal; }
    public int getPersonalActivo() { return resumenPersonal.getOrDefault("activos", 0); }
    public int getPersonalConAcceso() { return resumenPersonal.getOrDefault("conAcceso", 0); }
}
