
package com.registro.dao;

import com.registro.dto.NegocioDTO;
import com.registro.config.ConexionBD;
import java.sql.Connection;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class NegocioDAO {

    public List<NegocioDTO> listarNegocio() {

        List<NegocioDTO> lista = new ArrayList<>();

        String sql = "{call sp_Lista_EmpresaActiva}";

        try (Connection con = ConexionBD.obtenerConexion();
             CallableStatement cstmt = con.prepareCall(sql);
             ResultSet rs = cstmt.executeQuery()) {

            System.out.println("Procedimiento ejecutado correctamente.");

            while (rs.next()) {

                NegocioDTO dto = new NegocioDTO();

                dto.setCodigo_Emp(rs.getString("Codigo_Emp"));
                dto.setRazonSocial(rs.getString("RazonSocial"));
                dto.setRazonComercial(rs.getString("RazonComercial"));

                lista.add(dto);
            }

            System.out.println(
                    "Registros obtenidos del procedimiento: "
                    + lista.size()
            );

        } catch (SQLException e) {

            System.err.println("ERROR AL LISTAR EMPRESAS:");
            e.printStackTrace();
        }

        return lista;
    }
}
