package com.registro.controller;

import jakarta.enterprise.context.RequestScoped;
import jakarta.inject.Named;
import java.io.Serializable;

@Named("placeholderBean")
@RequestScoped
public class PlaceholderBean implements Serializable {
    private static final long serialVersionUID = 1L;
    public String getMensaje() {
        return "Esta pantalla está preparada para integrarse con el módulo de datos correspondiente.";
    }
}
