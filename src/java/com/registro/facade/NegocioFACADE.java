/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.registro.facade;

/**
 *
 * @author Administrator
 */

import com.registro.dto.NegocioDTO;
import com.registro.dao.NegocioDAO;
import java.util.List;

public class NegocioFACADE {
    
    private final NegocioDAO dao = new NegocioDAO();
       
    
    public List<NegocioDTO> obtenerListadoNegocio() {
        return dao.listarNegocio();
    }
}
