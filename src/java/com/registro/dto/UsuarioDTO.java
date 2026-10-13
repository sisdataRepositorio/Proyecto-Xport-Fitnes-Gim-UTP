/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.registro.dto;

/**
 *
 * @author Administrator
 */
public class UsuarioDTO {
    
    private int Personal_ID;
    private String EstadoGene;
    private String ApellidoPaterno;
    private String ApellidoMaterno;
    private String Nombres;
    private String Area;
    private String Rol;
    
    public UsuarioDTO()
    {
    }

    public UsuarioDTO(int Personal_ID,String ApellidoPaterno,String ApellidoMaterno,String Nombres,String Area)
    {
        this.Personal_ID=Personal_ID;
        this.ApellidoPaterno=ApellidoPaterno;
        this.ApellidoMaterno=ApellidoMaterno;
        this.Nombres=Nombres;
        this.Area=Area;
        
    }
    
    public int getPersonal_ID() { return  Personal_ID;}
    public void setPersonal_ID(int Personal_ID){this.Personal_ID=Personal_ID;}
    
    public String getApellidoPaterno(){return ApellidoPaterno;}
    public void setApellidoPaterno(String ApellidoPaterno){this.ApellidoPaterno=ApellidoPaterno;}
    
    public String getApellidoMaterno(){return ApellidoMaterno;}
    public void setApellidoMaterno(String ApellidoMaterno){this.ApellidoMaterno=ApellidoMaterno;}
    
    public String getNombres(){return Nombres;}
    public void setNombres(String Nombres){this.Nombres=Nombres;}
    
    public String getArea(){return Area;}
    public void setArea(String Area){this.Area=Area;}
    
    public String getRol() {return Rol;}
    public void setRol(String Rol) {this.Rol = Rol;}
    
}
