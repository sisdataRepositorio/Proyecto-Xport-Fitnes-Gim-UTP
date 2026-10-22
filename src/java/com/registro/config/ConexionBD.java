/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.registro.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
/**
 *
 * @author Administrator
 */
public class ConexionBD {
    
    private static final String URL =
        "jdbc:sqlserver://aplicacionesutp.ddns.net;instanceName=SQL2016;"
        + "databaseName=BDGimnasio;"
        + "encrypt=false;"
        + "trustServerCertificate=true";
    
    private static final String USER ="sa";
    private static final String PASSWORD ="UtpGym123";
    
    public static Connection obtenerConexion() throws SQLException
    {
       try {
            Class.forName(
                    "com.microsoft.sqlserver.jdbc.SQLServerDriver"
            );
            
            Connection con = DriverManager.getConnection(URL,USER,PASSWORD);
            
        System.out.println("CONEXION EXITOSA");

        System.out.println(
                    "Servidor: " 
                   + con.getMetaData().getDatabaseProductName()
            );
         
        System.out.println(
                   "Version:"
                   + con.getMetaData().getDatabaseProductVersion()
                           
        );
        
         System.out.println(
                    "Base de datos: "
                    + con.getCatalog()
        );
         
         return con;
            
        } 
        catch (ClassNotFoundException e) {

            throw new SQLException(
                    "No se encontró el driver de SQL Server",e
            );
        }
 
    }
}
