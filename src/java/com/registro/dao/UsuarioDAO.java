/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.registro.dao;

import com.registro.config.ConexionBD;
import com.registro.dto.ClienteDTO;
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
    
    public UsuarioDTO GeneraCodPersonal()
    {
        UsuarioDTO usuario2 = null;
        Connection cn = null;
        CallableStatement cs = null;
        ResultSet rs = null;
        
        try
        {
            cn = ConexionBD.obtenerConexion();
            String sql = "{call sp_GeneraCodigoPersonal(?)}";
            cs = cn.prepareCall(sql);
            
            rs = cs.executeQuery();
            
           if (rs.next()) {
                usuario2 = new UsuarioDTO();

                usuario2.setPersonal_ID(rs.getInt("Personal_ID"));

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
    
    public boolean registrarPersonal(UsuarioDTO usuario) {
    Connection cn = null;
    CallableStatement st = null;
    boolean registroExitoso = false;
    try {
        cn = ConexionBD.obtenerConexion();
        String sql = "{call sp_Insert_UsuarioPersonal(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
        st = cn.prepareCall(sql);
        
        st.setInt(1, usuario.getPersonal_ID());
        st.setString(2, usuario.getEstadoGene());
        st.setString(3, usuario.getApellidoPaterno());
        st.setString(4, usuario.getApellidoMaterno());
        st.setString(5, usuario.getNombres());
        st.setString(6, usuario.getDireccion());
        st.setString(7, usuario.getSexo());
        st.setString(8, usuario.getRucDNI());
        st.setString(9, usuario.getTelefono1());
        st.setString(10, usuario.getCorreo());
        st.setString(11, usuario.getReferencia());
        st.setString(12, usuario.getArea_ID());
        st.setString(13, usuario.getUsuario());
        st.setString(14, usuario.getContraseña());
        st.setString(15, usuario.getCodEmp());
        st.setString(16, usuario.getFoto());
        st.setInt(17, usuario.getUsuarioMod());
        
        int filasAfectadas = st.executeUpdate();
        if (filasAfectadas > 0) registroExitoso = true;
        
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        try 
        { 
            if (st != null) st.close(); 
            if (cn != null) cn.close(); 
        } catch (Exception e) {}
    }
    return registroExitoso;
    }
    
    public boolean EliminarPersonal(UsuarioDTO usuario) {
    Connection cn = null;
    CallableStatement st = null;
    boolean registroExitoso = false;
    try {
        cn = ConexionBD.obtenerConexion();
        String sql = "{call sp_elimina_personal(?)}";
        st = cn.prepareCall(sql);
        
        st.setInt(1, usuario.getPersonal_ID());
       
        int filasAfectadas = st.executeUpdate();
        if (filasAfectadas > 0) registroExitoso = true;
        
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        try 
        { 
            if (st != null) st.close(); 
            if (cn != null) cn.close(); 
        } catch (Exception e) {}
    }
    return registroExitoso;
    }
}
