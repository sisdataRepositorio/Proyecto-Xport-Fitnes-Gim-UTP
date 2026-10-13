/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.registro.facade;
import com.registro.dto.UsuarioDTO;
import com.registro.dao.UsuarioDAO;

/**
 *
 *
 * 22:44
 *
 *
 * @author Administrator
 */
public class UsuarioFACADE {
    
    private UsuarioDAO usuarioDAO;

    public UsuarioFACADE() {
        this.usuarioDAO = new UsuarioDAO();
      
    }

    public UsuarioDTO login(String username, String password) {
        // Aquí se podría agregar lógica de negocio adicional si fuera necesario
        return usuarioDAO.ValidaAcceso(username, password);
    }
}
