/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.registro.dto;

/**
 *
 * @author Ing
 */
public class ClienteDTO {
    
    private String Cliente_ID;
    private String RazonSocial;
    private String Direccion;
    private String Telefono;
    private String Estado;
    private String Telefono2;
    private String Correo;
    private String Sexo;
    private String RucDNI;
    private String TipoId;
    private String Foto;
    private String Contacto;
    private String TelefonoCont;
    private byte[] HuellaDactilar;
    
    public ClienteDTO()
    {
                
    }
    
    public ClienteDTO(String Cliente_ID,String RazonSocial,String Direccion,String Telefono,String Estado,String Telefono2,String Correo,String Sexo,String RucDNI,String TipoId,String Foto,String Contacto,String TelefonoCont,byte[] HuellaDactilar)
    {
        this.Cliente_ID=Cliente_ID;
        this.RazonSocial=RazonSocial;
        this.Direccion=Direccion;
        this.Telefono=Telefono;
        this.Estado=Estado;
        this.Telefono2=Telefono2;
        this.Correo=Correo;
        this.Sexo=Sexo;
        this.RucDNI=RucDNI;
        this.TipoId=TipoId;
        this.Foto = Foto;
        this.Contacto = Contacto;
        this.TelefonoCont = TelefonoCont;
        this.HuellaDactilar = HuellaDactilar;
        
    }
    
    public String getCliente_ID(){ return Cliente_ID;}
    public void setCliente_ID(String Cliente_ID){this.Cliente_ID=Cliente_ID;}
    
    public String getRazonSocial(){return RazonSocial;}
    public void setRazonSocial(String RazonSocial){this.RazonSocial= RazonSocial;}
    
    public String getDireccion() {return Direccion;}
    public void setDireccion(String Direccion){this.Direccion = Direccion;}
    
    public String getTelefono() {return Telefono;}
    public void setTelefono(String Telefono){this.Telefono = Telefono;}
    
    public String getEstado() {return Estado;}
    public void setEstado(String Estado){this.Estado = Estado;}
    
    public String getTelefono2() {return Telefono2;}
    public void setTelefono2(String Telefono2){this.Telefono2 = Telefono2;}
    
    public String getCorreo() {return Correo;}
    public void setCorreo(String Correo){this.Correo = Correo;}
    
    public String getSexo() {return Sexo;}
    public void setSexo(String Sexo){this.Sexo = Sexo;}
    
    public String getRucDNI() {return RucDNI;}
    public void setRucDNI(String RucDNI){this.RucDNI = RucDNI;}
    
    public String getTipoId() {return TipoId;}
    public void setTipoId(String TipoId){this.TipoId = TipoId;}
    
    public String getFoto() {return Foto;}
    public void setFoto(String Foto){this.Foto = Foto;}
    
    public String getContacto() {return Contacto;}
    public void setContacto(String Contacto){this.Contacto = Contacto;}
    
    public String getTelefonoCont() {return TelefonoCont;}
    public void setTelefonoCont(String TelefonoCont){this.TelefonoCont = TelefonoCont;}
    
    public byte[] getHuellaDactilar() {return HuellaDactilar;}
    public void setHuellaDactilar(byte[] HuellaDactilar){this.HuellaDactilar = HuellaDactilar;}
    
    
}
