package com.registro.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public final class ConexionBD {

    // Configuración directa de la conexión a SQL Server
    private static final String URL =
            "jdbc:sqlserver://aplicacionesutp.ddns.net;"
            + "instanceName=SQL2016;"
            + "databaseName=BDGimnasio;"
            + "encrypt=false;"
            + "trustServerCertificate=true";

    private static final String USER = "sa";
    private static final String PASSWORD = "UtpGym123";

    private ConexionBD() {
    }

    public static Connection obtenerConexion() throws SQLException {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

            return DriverManager.getConnection(URL, USER, PASSWORD);

        } catch (ClassNotFoundException e) {
            throw new SQLException(
                    "No se encontró el driver JDBC de SQL Server.", e);
        }
    }
}