/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package com.registro.dto;
import java.time.LocalDate; // Es obligatorio importar la librería de fecha

/**
  VARIABLES DE ROLES
*/
public class RolDTO {
    
    private int rol_id;
    private String nombre_rol;
    private String descripcion;
    private LocalDate fecha_creacion; // Declarada correctamente como LocalDate
    
    public RolDTO() {      
    }
    
    // Corregido: El parámetro del constructor ahora recibe LocalDate en lugar del inexistente 'DateTime'
    public RolDTO(int rol_id, String nombre_rol, String descripcion, LocalDate fecha_creacion) {
        this.rol_id = rol_id;
        this.nombre_rol = nombre_rol; // Corregido: Faltaba el signo '=' aquí
        this.descripcion = descripcion;
        this.fecha_creacion = fecha_creacion;
    }
            
    public int getrol_id() { return rol_id; }      
    public void setrol_id(int rol_id) { this.rol_id = rol_id; }
    
    public String getnombre_rol() { return nombre_rol; }
    public void setnombre_rol(String nombre_rol) { this.nombre_rol = nombre_rol; }
    
    public String getdescripcion() { return descripcion; }
    public void setdescripcion(String descripcion) { this.descripcion = descripcion; }
    
    public LocalDate getfecha_creacion() { return fecha_creacion; }
    public void setfecha_creacion(LocalDate fecha_creacion) { this.fecha_creacion = fecha_creacion; }
}
