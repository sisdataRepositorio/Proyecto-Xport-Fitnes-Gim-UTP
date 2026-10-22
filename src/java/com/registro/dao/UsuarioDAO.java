/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.registro.dao;

import com.registro.config.ConexionBD;
import com.registro.dto.UsuarioDTO;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UsuarioDAO {
    
    public UsuarioDTO ValidaAcceso(String usuario, String pass)
    {
        UsuarioDTO usuario2 = null;
        Connection cn = null;
        CallableStatement cs = null;
        ResultSet rs = null;
        
        try
        {
            cn = ConexionBD.obtenerConexion();
            String sql = "{call sp_IngresoUsuarioSistema(?,?)}";
            cs = cn.prepareCall(sql);
            cs.setString(1, usuario);
            cs.setString(2, pass);
            
            rs = cs.executeQuery();
            
           if (rs.next()) {
                usuario2 = new UsuarioDTO();

                usuario2.setPersonal_ID(rs.getInt("Personal_ID"));
                usuario2.setApellidoPaterno(rs.getString("ApellidoPaterno"));
                usuario2.setApellidoMaterno(rs.getString("ApellidoMaterno"));
                usuario2.setNombres(rs.getString("Nombres"));
                usuario2.setArea(rs.getString("Area"));
                usuario2.setRol(rs.getString("Rol"));
            }
       } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (cs != null) cs.close();
                if (cn != null) cn.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
        return usuario2; 
    }
}
