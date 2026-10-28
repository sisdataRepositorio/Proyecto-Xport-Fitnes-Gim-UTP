package com.registro.facade;

import com.registro.dao.UsuarioDAO;
import com.registro.dto.AreaDTO;
import com.registro.dto.RolDTO;
import com.registro.dto.UsuarioDTO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author Administrator
 */
public class UsuarioFACADE {

    private final UsuarioDAO usuarioDAO;

    public UsuarioFACADE() {
        this.usuarioDAO = new UsuarioDAO();
    }

    public UsuarioDTO login(String username, String password) {
        return usuarioDAO.ValidaAcceso(username, password);
    }

    public UsuarioDTO GeneraCodPersonal() {
        return usuarioDAO.GeneraCodPersonal();
    }

    public List<UsuarioDTO> ListaPersonal() {
        return usuarioDAO.ListaPersonal();
    }

    /**
     * Totales para el dashboard: total, activos, inactivos y conAcceso
     * (personal activo con usuario para iniciar sesión).
     */
    public Map<String, Integer> resumenPersonal() {
        int total = 0, activos = 0, conAcceso = 0;
        for (UsuarioDTO p : usuarioDAO.ListaPersonal()) {
            total++;
            if (!"Inactivo".equalsIgnoreCase(p.getEstadoGene())) {
                activos++;
                if (p.getOpcUserSist() == 1) conAcceso++;
            }
        }
        Map<String, Integer> resumen = new HashMap<>();
        resumen.put("total", total);
        resumen.put("activos", activos);
        resumen.put("inactivos", total - activos);
        resumen.put("conAcceso", conAcceso);
        return resumen;
    }

    public UsuarioDTO buscarPersonal(int personalId) {
        return usuarioDAO.buscarPersonal(personalId);
    }

    /** Graba un personal nuevo o actualiza uno existente. Ver codigos en UsuarioDAO. */
    public int grabarPersonal(UsuarioDTO usuario) {
        return usuarioDAO.grabarPersonal(usuario);
    }

    public boolean registrarPersonal(UsuarioDTO usuario) {
        return usuarioDAO.registrarPersonal(usuario);
    }

    /** Ver codigos de retorno en UsuarioDAO (eliminado / inactivado / error). */
    public int EliminarUsuario(UsuarioDTO usuario) {
        return usuarioDAO.EliminarPersonal(usuario);
    }

    public List<RolDTO> ListaRoles() {
        return usuarioDAO.MuestraRoles();
    }

    public List<AreaDTO> ListaAreas() {
        return usuarioDAO.ListaAreas();
    }
}
