# AplicacionWebGimnasio migrado a Jakarta Faces (JSF / Facelets)

## Estructura

- `src/main/webapp/*.xhtml`: vistas Facelets migradas (`login`, `dashboard`, `socios`, `ListaClientes`, `personal`, `ListaPersonal`, `ListaEmpresa`, `Productos`, `Categorias`, `Marcas`, `PuntoVenta`, `Almacen`, `membresias`, `gastos` y sus formularios).
- `WEB-INF/templates/principal.xhtml`: plantilla compartida.
- `resources/components/`: componentes compuestos `menuLateral`, `menuCatalogo` y `menuPersonal`.
- `src/main/java/com/registro/controller/*Bean.java`: beans JSF/CDI para login, socios, personal y dashboard.
- `src/main/java/com/registro/dao`, `dto` y `facade`: lógica de datos original, reutilizada cuando era compatible.
- `respaldo-jsp/`: copias de las vistas JSP originales para consulta/rollback; no se despliegan.

## Requisitos

- JDK 21.
- Apache Tomcat 10.1.x.
- Maven 3.9 o compatible y acceso a Maven Central al menos la primera vez.
- SQL Server accesible desde Tomcat para usar el login y los módulos conectados a la base de datos.

## Ejecutar desde NetBeans

1. Abre esta carpeta como proyecto Maven.
2. Configura el JDK del proyecto en 21.
3. Configura estas variables de entorno para el proceso de Tomcat: `GYM_DB_URL`, `GYM_DB_USER` y `GYM_DB_PASSWORD`.
   - `GYM_DB_URL` puede ser, por ejemplo, `jdbc:sqlserver://aplicacionesutp.ddns.net;instanceName=SQL2016;encrypt=false;trustServerCertificate=true`.
   - `GYM_DB_USER` y `GYM_DB_PASSWORD` deben ser las credenciales SQL Server actuales de tu ambiente; no se guardan en el código fuente.
4. Compila con `mvn clean package` o los comandos Maven equivalentes de NetBeans.
5. Despliega `target/AplicacionWebGimnasio.war` en Tomcat 10.1.
6. Abre `/AplicacionWebGimnasio/` o `/AplicacionWebGimnasio/login.xhtml`.

## Notas de migración

- La app utiliza Jakarta Faces 4.0/Facelets y Weld CDI para Tomcat, además del controlador JDBC de SQL Server.
- Las vistas de login, socios y personal utilizan componentes JSF ligados a beans. Los módulos de catálogo, Punto de Venta, Almacén, gastos y membresías conservan su interacción de demostración en JavaScript/HTML dentro de Facelets; todavía no se conectan a una capa de negocio nueva para todos los CRUD.
- Las rutas de menú no implementadas originalmente (Asistencia, Ventas e inicialmente Configuración) tienen ahora vistas de navegación informativas para que no den 404.
- La compilación y el despliegue deben validarse en tu entorno NetBeans/Tomcat; no se pudo ejecutar Maven en el entorno de preparación.
- La conexión original contenía una contraseña SQL Server incrustada. En esta copia se eliminó y se sustituyó por variables de entorno. Cambia/rota esa contraseña si era real y no la vuelvas a subir al repositorio.
