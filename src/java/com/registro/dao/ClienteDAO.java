/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.registro.dao;

import com.registro.config.ConexionBD;
import com.registro.dto.ClienteDTO;

import java.sql.*;
import java.util.ArrayList;
import java.util.Arrays;
/**
 *
 * @author Ing
 */
    public class ClienteDAO {
    
    public ArrayList<ClienteDTO> ListaClientes()
    {
        ArrayList<ClienteDTO> lista = new ArrayList<>();
        Connection cn = null;
        CallableStatement st = null;
        ResultSet rs = null;
        
        try
        {
            cn = ConexionBD.obtenerConexion();
            String sql = "{call sp_lista_clientes_Activos}";
            st= cn.prepareCall(sql);
            
            rs = st.executeQuery();
            
            while(rs.next())
            {
                ClienteDTO cliente = new ClienteDTO();
                cliente.setCliente_ID(rs.getString("Cliente_ID"));
                cliente.setRazonSocial(rs.getString("RazonSocial"));
                cliente.setDireccion(rs.getString("Direccion"));
                cliente.setTelefono(rs.getString("Telefono"));
                cliente.setEstado(rs.getString("Estado"));
                cliente.setTelefono2(rs.getString("Telefono2"));
                cliente.setCorreo(rs.getString("Correo"));
                cliente.setSexo(rs.getString("Sexo"));
                cliente.setRucDNI(rs.getString("RucDNI"));
                cliente.setTipoId(rs.getString("TipoId"));               
                cliente.setFoto(rs.getString("Foto"));
                cliente.setContacto(rs.getString("Contacto"));
                cliente.setTelefonoCont(rs.getString("TelefonoCont"));
                cliente.setHuellaDactilar(rs.getBytes("HuellaDactilar"));
                
                lista.add(cliente);
            }
            
            System.out.print("Registros obtenidos con Exito" + lista.size());
          } catch (SQLException e) {
              
              System.out.print("Error a mostrar los datos");
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (st != null) st.close();
                if (cn != null) cn.close();
            } catch (SQLException ex) {
                ex.printStackTrace();               
            }
        }
        
        return lista;
    } 
}
