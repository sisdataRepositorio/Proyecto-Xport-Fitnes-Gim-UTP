/*
  CRUD de Personal - BDGimnasio
  Ejecutar con: sqlcmd -S <servidor> -d BDGimnasio -U <usuario> -P <clave> -f 65001 -i sql\personal_crud.sql

  - sp_lista_personal / sp_busca_personal / sp_lista_areas: nuevos.
  - sp_Insert_UsuarioPersonal: corregido (usaba la tabla inexistente UsuarioPersonal
    y su INSERT tenia 14 columnas para 16 valores). Sirve para grabar y actualizar.
    Codigos de retorno: 0 = ok, -1 = error, -2 = nombre de usuario ya usado por otro personal.
  - sp_elimina_personal: revisa tambien PersonalPagos e Inventario; si hay historial
    solo inactiva al personal, si no lo borra junto con su usuario.
    Codigos de retorno: 1 = eliminado, 2 = inactivado, -1 = error.
  - sp_IngresoUsuarioSistema: el personal inactivo ya no puede iniciar sesion.
*/

CREATE OR ALTER PROC sp_lista_personal
AS
BEGIN
    SET NOCOUNT ON
    SELECT per.Personal_ID, per.EstadoGene, per.ApellidoPaterno, per.ApellidoMaterno, per.Nombres,
           per.Direccion, per.Sexo, per.RucDNI, per.Telefono1, per.Correo, per.Referencia,
           per.Area_ID, Area = ar.DescripcionArea, per.CodEmp, per.Foto,
           U.Usuario, U.rol_id, Rol = R.nombre_rol
    FROM Personal per
    INNER JOIN Area ar ON per.Area_ID = ar.Area_ID
    LEFT JOIN Usuario U ON per.Personal_ID = U.personal_id
    LEFT JOIN Rol R ON U.rol_id = R.rol_id
    ORDER BY per.ApellidoPaterno, per.ApellidoMaterno, per.Nombres
END
GO

CREATE OR ALTER PROC sp_busca_personal
@Personal_ID int
AS
BEGIN
    SET NOCOUNT ON
    SELECT per.Personal_ID, per.EstadoGene, per.ApellidoPaterno, per.ApellidoMaterno, per.Nombres,
           per.Direccion, per.Sexo, per.RucDNI, per.Telefono1, per.Correo, per.Referencia,
           per.Area_ID, Area = ar.DescripcionArea, per.CodEmp, per.Foto,
           U.Usuario, U.rol_id, Rol = R.nombre_rol
    FROM Personal per
    INNER JOIN Area ar ON per.Area_ID = ar.Area_ID
    LEFT JOIN Usuario U ON per.Personal_ID = U.personal_id
    LEFT JOIN Rol R ON U.rol_id = R.rol_id
    WHERE per.Personal_ID = @Personal_ID
END
GO

CREATE OR ALTER PROC sp_lista_areas
AS
BEGIN
    SET NOCOUNT ON
    SELECT Area_ID, DescripcionArea
    FROM Area
    WHERE ISNULL(EstadoArea, 'Activo') = 'Activo'
    ORDER BY DescripcionArea
END
GO

CREATE OR ALTER PROC sp_Insert_UsuarioPersonal
 @Personal_ID int,
 @EstadoGene varchar(10),
 @ApellidoPaterno varchar(50),
 @ApellidoMaterno varchar(50),
 @Nombres varchar(50),
 @Direccion varchar(100),
 @Sexo varchar(10),
 @RucDNI varchar(12),
 @Telefono1 varchar(20),
 @Correo varchar(50),
 @Referencia varchar(50),
 @Area_ID char(3),
 @Usuario varchar(50),
 @Contraseña varchar(50),
 @CodEmp varchar(2),
 @Foto varchar(250),
 @UsuarioMod int,
 @rol_id int,
 @OpcUserSist int   -- 1 = tiene acceso al sistema, 0 = sin acceso (se quita su usuario)
AS
BEGIN
  SET NOCOUNT ON
  SET XACT_ABORT ON
  DECLARE @usuario_id int

  IF @OpcUserSist = 1 AND EXISTS(SELECT 1 FROM Usuario
                                 WHERE Usuario = @Usuario
                                   AND ISNULL(personal_id, -1) <> @Personal_ID)
     RETURN -2

  BEGIN TRY
  BEGIN TRANSACTION

  IF EXISTS(SELECT 1 FROM Personal WHERE Personal_ID = @Personal_ID)
  BEGIN
     UPDATE Personal SET EstadoGene = @EstadoGene,
                         ApellidoPaterno = @ApellidoPaterno,
                         ApellidoMaterno = @ApellidoMaterno,
                         Nombres = @Nombres,
                         Direccion = @Direccion,
                         Sexo = @Sexo,
                         RucDNI = @RucDNI,
                         Telefono1 = @Telefono1,
                         Correo = @Correo,
                         Referencia = @Referencia,
                         Area_ID = @Area_ID,
                         CodEmp = @CodEmp,
                         Foto = @Foto
     WHERE Personal_ID = @Personal_ID

     INSERT INTO Auditoria_Sistema(fecha_hora, usuario_id, tabla_afectada, accion, registro_id, detalle_cambio)
     VALUES(GETDATE(), @UsuarioMod, 'Personal', 'UPDATE', @Personal_ID, 'Se esta modificando los datos del personal en el Sistema')
  END
  ELSE
  BEGIN
     INSERT INTO Personal(Personal_ID, EstadoGene, ApellidoPaterno, ApellidoMaterno, Nombres, Direccion, Sexo,
                          RucDNI, Telefono1, Correo, Referencia, Area_ID, CodEmp, Foto)
     VALUES(@Personal_ID, @EstadoGene, @ApellidoPaterno, @ApellidoMaterno, @Nombres, @Direccion, @Sexo,
            @RucDNI, @Telefono1, @Correo, @Referencia, @Area_ID, @CodEmp, @Foto)

     INSERT INTO Auditoria_Sistema(fecha_hora, usuario_id, tabla_afectada, accion, registro_id, detalle_cambio)
     VALUES(GETDATE(), @UsuarioMod, 'Personal', 'INSERT', @Personal_ID, 'Se esta creando un nuevo personal en el Sistema')
  END

  IF @OpcUserSist = 1
  BEGIN
     IF EXISTS(SELECT 1 FROM Usuario WHERE personal_id = @Personal_ID)
        -- Contraseña vacia = conservar la actual
        UPDATE Usuario SET Usuario = @Usuario,
                           [Contraseña] = CASE WHEN ISNULL(@Contraseña, '') = '' THEN [Contraseña] ELSE @Contraseña END,
                           rol_id = @rol_id
        WHERE personal_id = @Personal_ID
     ELSE
     BEGIN
        SET @usuario_id = (SELECT ISNULL(MAX(usuario_id) + 1, 1) FROM Usuario)
        INSERT INTO Usuario(usuario_id, personal_id, Usuario, [Contraseña], rol_id)
        VALUES(@usuario_id, @Personal_ID, @Usuario, @Contraseña, @rol_id)
     END
  END
  ELSE
     DELETE FROM Usuario WHERE personal_id = @Personal_ID

  COMMIT TRANSACTION
  RETURN 0
  END TRY
  BEGIN CATCH
     IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION
     RETURN -1
  END CATCH
END
GO

CREATE OR ALTER PROC sp_elimina_personal
@Personal_ID int
AS
BEGIN
  SET NOCOUNT ON
  SET XACT_ABORT ON

  BEGIN TRY
  IF EXISTS(SELECT 1 FROM RegistroPeriodoClases WHERE PersonalID = @Personal_ID)
     OR EXISTS(SELECT 1 FROM CtasXCobrar WHERE Personal_ID = @Personal_ID)
     OR EXISTS(SELECT 1 FROM Cabecera_Ventas WHERE CodPer = @Personal_ID)
     OR EXISTS(SELECT 1 FROM PersonalPagos WHERE Personal_ID = @Personal_ID)
     OR EXISTS(SELECT 1 FROM Inventario WHERE Personal_ID = @Personal_ID)
  BEGIN
     UPDATE Personal SET EstadoGene = 'Inactivo' WHERE Personal_ID = @Personal_ID
     RETURN 2
  END

  BEGIN TRANSACTION
     DELETE FROM Usuario WHERE personal_id = @Personal_ID
     DELETE FROM Personal WHERE Personal_ID = @Personal_ID
  COMMIT TRANSACTION
  RETURN 1
  END TRY
  BEGIN CATCH
     IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION
     RETURN -1
  END CATCH
END
GO

CREATE OR ALTER PROC sp_IngresoUsuarioSistema
@Usuario varchar(50),
@Contraseña varchar(50)
AS
SELECT per.Personal_ID, ApellidoPaterno, ApellidoMaterno, Nombres, per.Area_ID,
       Area = (DescripcionArea), Rol = (nombre_rol), CodEmp
FROM Personal per
INNER JOIN Area ar ON per.Area_ID = ar.Area_ID
INNER JOIN Usuario U ON per.Personal_ID = U.Personal_ID
INNER JOIN Rol R ON U.rol_id = R.rol_id
WHERE Usuario = @Usuario
  AND [Contraseña] = @Contraseña
  AND ISNULL(per.EstadoGene, 'Activo') = 'Activo'
GO
