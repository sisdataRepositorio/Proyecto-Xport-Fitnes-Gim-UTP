/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.registro.facade;

import com.registro.dto.ClienteDTO;
import com.registro.dao.ClienteDAO;
import java.util.List;
/**
 *
 * @author Ing
 */
public class ClienteFACADE {
    
    private final ClienteDAO dao=new ClienteDAO();
    
    public List<ClienteDTO> ObtenerListadoCliente()
    {
        return dao.ListaClientes();
    }
}
