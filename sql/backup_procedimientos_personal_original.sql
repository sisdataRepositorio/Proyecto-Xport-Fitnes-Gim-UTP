-- Versiones originales (2026-10-24) de los procedimientos reemplazados por personal_crud.sql.
-- Ejecutar este archivo para revertir.

CREATE OR ALTER   proc sp_Insert_UsuarioPersonal
 @Personal_ID int ,
 @EstadoGene varchar(10),
 @ApellidoPaterno varchar(50),
 @ApellidoMaterno varchar(50),
 @Nombres varchar(50),
 @Direccion varchar(100),
 @Sexo varchar(10) ,
 @RucDNI varchar(12),
 @Telefono1 varchar(20),
 @Correo varchar(50),
 @Referencia varchar(50),
 @Area_ID char(3),

 @Usuario varchar(50),
 @Contraseña varchar(50),

 @CodEmp varchar(2),
 @Foto varchar(250),
 @UsuarioMod INT,
 @rol_id INT,
 @OpcUserSist int
 

as  
 BEGIN 
 

 INSERT INTO Auditoria_Sistema(usuario_id,tabla_afectada,accion,registro_id,detalle_cambio)
 VALUES(@UsuarioMod,'Personal','INSERT',@Personal_ID,'Se esta creando un nuevo personal en el Sistema')

 SET NOCOUNT ON
 SET XACT_ABORT ON
  DECLARE @usuario_id INT

  BEGIN TRY
  BEGIN TRANSACTION

  IF EXISTS(select 1  
   FROM Personal  
   WHERE Personal_ID=@Personal_ID)
  BEGIN  
  
  UPDATE UsuarioPersonal set EstadoGene=@EstadoGene,
                             ApellidoPaterno=@ApellidoPaterno,
                             ApellidoMaterno=@ApellidoMaterno,
                             Nombres=@Nombres,
                             Direccion=@Direccion,
                             Sexo=@Sexo,
                             RucDNI=@RucDNI,
                             Telefono1=@Telefono1,
                             Correo=@Correo,
                             Referencia=@Referencia,
                             Area_ID=@Area_ID,
                             CodEmp=@CodEmp,
                             Foto=@Foto
  where Personal_ID=@Personal_ID  

  IF(@OpcUserSist=1)
  BEGIN
  IF NOT EXISTS(SELECT 1 FROM Usuario WHERE Personal_ID=@Personal_ID)
     BEGIN 
	 SET @usuario_id=(SELECT ISNULL(MAX(usuario_id+1),1)FROM Usuario)

	 INSERT INTO Usuario([usuario_id],[personal_id],[Usuario],[Contraseña],[rol_id]) 
	 VALUES(@usuario_id,@Personal_ID,@Usuario,@Contraseña,@rol_id)
    END
  END

   INSERT INTO Auditoria_Sistema([fecha_hora],usuario_id,tabla_afectada,accion,registro_id,detalle_cambio)
   VALUES(GETDATE(),@UsuarioMod,'Personal','UPDATE',@Personal_ID,'Se esta modificando los datos del personal en el Sistema')

   END
  ELSE
  BEGIN
  INSERT INTO UsuarioPersonal(Personal_ID,EstadoGene,ApellidoPaterno,ApellidoMaterno,Nombres,Direccion,Sexo,RucDNI,Telefono1,
                              Correo,Referencia,Area_ID,CodEmp,Foto)   
  values(@Personal_ID,@EstadoGene,@ApellidoPaterno,@ApellidoMaterno,@Nombres,@Direccion,@Sexo,@RucDNI,@Telefono1,@Correo,
         @Referencia,@Area_ID,@Usuario,@Contraseña,@CodEmp,@Foto) 
		 
  IF(@OpcUserSist=1)
  BEGIN

  IF NOT EXISTS(SELECT 1 FROM Usuario WHERE Personal_ID=@Personal_ID)
     BEGIN 
	 SET @usuario_id=(SELECT ISNULL(MAX(usuario_id+1),1)FROM Usuario)

	 INSERT INTO Usuario([usuario_id],[personal_id],[Usuario],[Contraseña],[rol_id]) 
	 VALUES(@usuario_id,@Personal_ID,@Usuario,@Contraseña,@rol_id)
    END
   END

   INSERT INTO Auditoria_Sistema([fecha_hora],usuario_id,tabla_afectada,accion,registro_id,detalle_cambio)
   VALUES(GETDATE(),@UsuarioMod,'Personal','INSERT',@Personal_ID,'Se esta creando un nuevo personal en el Sistema')
  END  
  COMMIT TRANSACTION
   RETURN 0
  END TRY

  BEGIN CATCH
  IF @@TRANCOUNT > 0
  BEGIN
  ROLLBACK TRANSACTION
    END
    RETURN -1
  END CATCH
END



GO

CREATE OR ALTER proc sp_elimina_personal --'16'         
@Personal_ID int        
as        
      
IF(SELECT COUNT(*)FROM RegistroPeriodoClases
   WHERE PersonalID=@Personal_ID)>0
  BEGIN
  UPDATE Personal SET EstadoGene='Inactivo'WHERE Personal_ID=@Personal_ID
    END
  ELSE
IF(SELECT COUNT(*)FROM CtasXCobrar
   WHERE Personal_ID=@Personal_ID)>0
  BEGIN
  UPDATE Personal SET EstadoGene='Inactivo'WHERE Personal_ID=@Personal_ID
  END
  ELSE
IF(SELECT COUNT(*)FROM Cabecera_Ventas
   WHERE CodPer=@Personal_ID)>0
  BEGIN
  UPDATE Personal SET EstadoGene='Inactivo'WHERE Personal_ID=@Personal_ID
    END
 ELSE
BEGIN
DELETE FROM Personal WHERE Personal_ID=@Personal_ID                    
   END            
      
  


GO

CREATE OR ALTER proc sp_IngresoUsuarioSistema
@Usuario varchar(50),
@Contraseña varchar(50)
as

select per.Personal_ID,ApellidoPaterno,ApellidoMaterno,Nombres,per.Area_ID,Area=(DescripcionArea),Rol=(nombre_rol),CodEmp
from Personal per
INNER JOIN Area ar ON per.Area_ID=ar.Area_ID
INNER JOIN Usuario U ON per.Personal_ID=U.Personal_ID
INNER JOIN Rol R ON U.rol_id=R.rol_id
where Usuario=@Usuario
  and Contraseña=@Contraseña



GO

