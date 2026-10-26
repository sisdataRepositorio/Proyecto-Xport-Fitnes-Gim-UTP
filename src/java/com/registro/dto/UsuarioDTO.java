/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.registro.dto;

import java.time.LocalDate;
/**
 *
 * @author Administrator
 */

/**
  VARIABLES DE PERSONAL USUARIO
*/
public class UsuarioDTO {
    
    private int Personal_ID;
    private String EstadoGene;
    private String ApellidoPaterno;
    private String ApellidoMaterno;
    private String Nombres;
    private String Direccion;
    private String Sexo;
    private String RucDNI;
    private String Telefono1;
    private String Correo;
    private String Referencia;
    private String Area_ID;
    private String Usuario;
    private String Contraseña;
    private String CodEmp;
    private String Foto;
    
    private String Area;
    private String Rol;
    
    private int UsuarioMod;
    private int OpcUserSist;
    private int Rol_ID;


    
    public UsuarioDTO()
    {
    }

    public UsuarioDTO(int Personal_ID,String EstadoGene, String ApellidoPaterno,String ApellidoMaterno,String Nombres,String Direccion,String Sexo,String RucDNI,String Telefono1,String Correo,String Referencia,String Area_ID,String Usuario,String Contraseña,String CodEmp,String Foto,int UsuarioMod,String Area, String Rol, int OpcUserSist)
    {
        this.Personal_ID=Personal_ID;
        this.EstadoGene=EstadoGene;
        this.ApellidoPaterno=ApellidoPaterno;
        this.ApellidoMaterno=ApellidoMaterno;
        this.Nombres=Nombres;        
        this.Direccion=Direccion;
        this.Sexo=Sexo;
        this.RucDNI=RucDNI;
        this.Telefono1=Telefono1;        
        this.Correo=Correo;
        this.Referencia=Referencia;
        this.Area_ID=Area_ID;
        this.Usuario=Usuario;        
        this.Contraseña=Contraseña;
        this.CodEmp=CodEmp;
        this.Foto=Foto;
        this.UsuarioMod=UsuarioMod;       
        this.Area = Area;
        this.Rol = Rol;     
        this.OpcUserSist = OpcUserSist;
    }
    
    public int getPersonal_ID() { return  Personal_ID;}
    public void setPersonal_ID(int Personal_ID){this.Personal_ID=Personal_ID;}
    
    public String getEstadoGene(){return EstadoGene;}
    public void setEstadoGene(String EstadoGene){this.EstadoGene=EstadoGene;}
    
    public String getApellidoPaterno(){return ApellidoPaterno;}
    public void setApellidoPaterno(String ApellidoPaterno){this.ApellidoPaterno=ApellidoPaterno;}
    
    public String getApellidoMaterno(){return ApellidoMaterno;}
    public void setApellidoMaterno(String ApellidoMaterno){this.ApellidoMaterno=ApellidoMaterno;}
    
    public String getNombres(){return Nombres;}
    public void setNombres(String Nombres){this.Nombres=Nombres;}
    
    public String getDireccion(){return Direccion;}
    public void setDireccion(String Direccion){this.Direccion=Direccion;}
    
    public String getSexo(){return Sexo;}
    public void setSexo(String Sexo){this.Sexo=Sexo;}
    
    public String getRucDNI(){return RucDNI;}
    public void setRucDNI(String RucDNI){this.RucDNI=RucDNI;}
    
    public String getTelefono1(){return Telefono1;}
    public void setTelefono1(String Telefono1){this.Telefono1=Telefono1;}
    
    public String getCorreo(){return Correo;}
    public void setCorreo(String Correo){this.Correo=Correo;}
    
    public String getReferencia(){return Referencia;}
    public void setReferencia(String Referencia){this.Referencia=Referencia;}
    
    public String getArea_ID(){return Area_ID;}
    public void setArea_ID(String Area_ID){this.Area_ID=Area_ID;}
    
    public String getUsuario(){return Usuario;}
    public void setUsuario(String Usuario){this.Usuario=Usuario;}
    
    public String getContraseña(){return Contraseña;}
    public void setContraseña(String Contraseña){this.Contraseña=Contraseña;}
    
    public String getCodEmp(){return CodEmp;}
    public void setCodEmp(String CodEmp){this.CodEmp=CodEmp;}
    
    public String getFoto(){return Foto;}
    public void setFoto(String Foto){this.Foto=Foto;}
    
    public int getUsuarioMod(){return UsuarioMod;}
    public void setUsuarioMod(int UsuarioMod){this.UsuarioMod=UsuarioMod;}
    
    public String getArea(){return Area;}
    public void setArea(String Area){this.Area=Area;}
    
    public String getRol() {return Rol;}
    public void setRol(String Rol) {this.Rol = Rol;}
    
    public int getOpcUserSist() {return OpcUserSist;}
    public void setOpcUserSist(int OpcUserSist){this.OpcUserSist=OpcUserSist;}

    public int getRol_ID() {return Rol_ID;}
    public void setRol_ID(int Rol_ID){this.Rol_ID=Rol_ID;}

    public String getNombreCompleto() {
        return ((Nombres == null ? "" : Nombres) + " "
                + (ApellidoPaterno == null ? "" : ApellidoPaterno) + " "
                + (ApellidoMaterno == null ? "" : ApellidoMaterno)).trim();
    }
    

}



