/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.registro.dto;

/**
 *
 * @author Administrator
 */
public class NegocioDTO {
    
    private String Codigo_Emp;
    private String RazonSocial;
    private String RazonComercial;
    /**private String Ruc;
    private String Direccion;
    private String EstadoEmpresa;
    private String CodigoPostal;
    private String Distrito;
    private String Provincia;
    private String Telefono;
    private String Otros;
    private String PaginaWeb;
    private String Correo; */
    
    public NegocioDTO()
    {
    }
    
    public NegocioDTO(String Codigo_Emp,String RazonSocial,String RazonComercial) 
    {
        this.Codigo_Emp=Codigo_Emp;
        this.RazonSocial=RazonSocial;
        this.RazonComercial=RazonComercial;
        /**this.Ruc=Ruc;
        this.Direccion=Direccion;
        this.EstadoEmpresa=EstadoEmpresa;
        this.CodigoPostal=CodigoPostal;
        this.Distrito=Distrito;
        this.Provincia=Provincia;
        this.Telefono=Telefono;
        this.Otros=Otros;
        this.PaginaWeb=PaginaWeb;
        this.Correo=Correo; */

    }
    
    public String getCodigo_Emp() { return Codigo_Emp; }
    public void setCodigo_Emp(String Codigo_Emp) { this.Codigo_Emp = Codigo_Emp; }
    public String getRazonSocial() { return RazonSocial; }
    public void setRazonSocial(String RazonSocial) { this.RazonSocial = RazonSocial; }
    public String getRazonComercial() { return RazonComercial; }
    public void setRazonComercial(String RazonComercial) { this.RazonComercial = RazonComercial; }
}
