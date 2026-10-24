package com.registro.dao;

import com.registro.config.ConexionBD;
import com.registro.dto.ClienteDTO;
import java.sql.*;
import java.util.ArrayList;

public class ClienteDAO {
    
    public ArrayList<ClienteDTO> ListaClientes() {
        ArrayList<ClienteDTO> lista = new ArrayList<>();
        Connection cn = null;
        CallableStatement st = null;
        ResultSet rs = null;
        try {
            cn = ConexionBD.obtenerConexion();
            String sql = "{call sp_lista_clientes_Activos}";
            st = cn.prepareCall(sql);
            rs = st.executeQuery();
            while (rs.next()) {
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
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (st != null) st.close();
                if (cn != null) cn.close();
            } catch (SQLException ex) { ex.printStackTrace(); }
        }
        return lista;
    } 

    // Buscar socio por ID
    public ClienteDTO buscarPorId(String id) {
        ArrayList<ClienteDTO> lista = ListaClientes();
        for (ClienteDTO c : lista) {
            if (c.getCliente_ID() != null && c.getCliente_ID().trim().equalsIgnoreCase(id.trim())) {
                return c;
            }
        }
        return null;
    }

    public ClienteDTO autogenera_CodCliente() {
        ClienteDTO cliente = null;
        Connection cn = null;
        CallableStatement st = null;
        ResultSet rs = null;
        try {
            cn = ConexionBD.obtenerConexion();
            String sql = "{call sp_autogenera_CodCliente(?)}";
            st = cn.prepareCall(sql);
            rs = st.executeQuery();
            if (rs.next()) {
                cliente = new ClienteDTO();
                cliente.setCliente_ID(rs.getString("Cliente_ID"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (st != null) st.close();
                if (cn != null) cn.close();
            } catch (SQLException ex) { ex.printStackTrace(); }
        }
        return cliente; 
    } 
    
    public boolean registrarCliente(ClienteDTO cliente) {
        Connection cn = null;
        CallableStatement st = null;
        boolean registroExitoso = false;
        try {
            cn = ConexionBD.obtenerConexion();
            // Corregido a 14 signos '?'
            String sql = "{call sp_Insert_Clientes(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
            st = cn.prepareCall(sql);
            
            st.setString(1, cliente.getCliente_ID());
            st.setString(2, cliente.getRazonSocial());
            st.setString(3, cliente.getDireccion());
            st.setString(4, cliente.getTelefono());
            st.setString(5, cliente.getEstado());
            st.setString(6, cliente.getTelefono2());
            st.setString(7, cliente.getCorreo());
            st.setString(8, cliente.getSexo());
            st.setString(9, cliente.getRucDNI());
            st.setString(10, cliente.getTipoId());
            st.setString(11, cliente.getFoto());
            st.setString(12, cliente.getContacto());
            st.setString(13, cliente.getTelefonoCont());
            st.setBytes(14, cliente.getHuellaDactilar());

            int filasAfectadas = st.executeUpdate();
            if (filasAfectadas > 0) registroExitoso = true;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try { 
                if (st != null) st.close(); 
                if (cn != null) cn.close(); 
            } catch (Exception e) {}
        }
        return registroExitoso;
    }

    public boolean actualizarCliente(ClienteDTO cliente) {
        Connection cn = null;
        CallableStatement st = null;
        boolean exito = false;
        try {
            cn = ConexionBD.obtenerConexion();
            // Stored procedure para actualizar cliente
            String sql = "{call sp_Actualiza_Cliente(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
            st = cn.prepareCall(sql);
            
            st.setString(1, cliente.getCliente_ID());
            st.setString(2, cliente.getRazonSocial());
            st.setString(3, cliente.getDireccion());
            st.setString(4, cliente.getTelefono());
            st.setString(5, cliente.getEstado());
            st.setString(6, cliente.getTelefono2());
            st.setString(7, cliente.getCorreo());
            st.setString(8, cliente.getSexo());
            st.setString(9, cliente.getRucDNI());
            st.setString(10, cliente.getTipoId());
            st.setString(11, cliente.getFoto());
            st.setString(12, cliente.getContacto());
            st.setString(13, cliente.getTelefonoCont());
            st.setBytes(14, cliente.getHuellaDactilar());

            int filas = st.executeUpdate();
            if (filas > 0) exito = true;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (st != null) st.close();
                if (cn != null) cn.close();
            } catch (Exception e) {}
        }
        return exito;
    }

    public boolean EliminaCliente(ClienteDTO Cliente) {
        Connection cn = null;
        CallableStatement st = null;
        boolean EliminacionCorrecta = false;
        try {
            cn = ConexionBD.obtenerConexion();
            String sql = "{call sp_Elimina_Cliente(?)}";
            st = cn.prepareCall(sql);
            st.setString(1, Cliente.getCliente_ID());
            int filasAfectadas = st.executeUpdate();
            if (filasAfectadas > 0) EliminacionCorrecta = true;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (st != null) st.close();
                if (cn != null) cn.close();
            } catch (Exception e) {}
        }
        return EliminacionCorrecta;
    }
}