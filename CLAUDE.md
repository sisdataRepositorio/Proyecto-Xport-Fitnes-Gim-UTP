# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project overview

Xport Fitness Gym is a Java web app for running a gym (members/"socios", staff users, products, memberships, expenses). Built with Jakarta EE 10 servlets + JSP, deployed to Tomcat as `AplicacionWebGimnasio.war` (context path `/AplicacionWebGimnasio`, see `web/META-INF/context.xml`). Code, comments, identifiers and UI text are in Spanish; keep new code consistent with that.

## Build and run

- This is a NetBeans "Web Application" (Ant) project: Java 21 source/target, `j2ee.platform=10-web`, server type Tomcat. Build/run/deploy is done from NetBeans (Run Project deploys to the configured Tomcat). There is no Maven/Gradle, no lint, and no tests (`test/` is empty).
- The Ant files (`build.xml`, `nbproject/project.properties`, `project.xml`, `build-impl.xml`, etc.) are tracked in git history but may be missing from the working tree; restore them with `git checkout HEAD -- build.xml nbproject` if a command-line build is needed (`ant dist` then produces `dist/AplicacionWebGimnasio.war`).
- Third-party jars live in the repo root and are referenced by relative path from `nbproject/project.properties`: `mssql-jdbc-12.2.0.jre11.jar`, `jakarta.servlet.jsp.jstl-3.0.1.jar`, `jakarta.servlet.jsp.jstl-api-3.0.0.jar`. Servlet/JSP APIs come from Tomcat itself.
- Use `jakarta.servlet.*` imports only — never `javax.servlet.*`.
- Entry point: `web/index.html` meta-refreshes to `UsuarioController?accion=login`.

## Database

- SQL Server (`BDGimnasio`) on a remote host; connection is hardcoded in `src/java/com/registro/config/ConexionBD.java` (`obtenerConexion()` opens a new JDBC connection per call, no pooling).
- All data access goes through **stored procedures** via `CallableStatement` (`{call sp_...}`), e.g. `sp_lista_clientes_Activos`, `sp_Insert_Clientes`, `sp_Actualiza_Cliente`, `sp_Elimina_Cliente`, `sp_autogenera_CodCliente`, `sp_IngresoUsuarioSistema`, `sp_Lista_EmpresaActiva`, `sp_ListaRoles`. Most procedure sources are not in this repo (only `sql/personal_crud.sql`, which must be applied to the DB for the Personal module) — column names read from `ResultSet`s must match what the procedures return. Some procedures return status via `RETURN` codes, read with `{? = call ...}` + `registerOutParameter`.

## Architecture

Layered MVC under `src/java/com/registro/`, one set of classes per entity (Cliente, Usuario/Rol, Negocio):

```
JSP (web/*.jsp)  ->  Controller servlet  ->  *FACADE  ->  *DAO  ->  stored procedure
                                             (thin pass-through)    (JDBC + DTO mapping)
```

- `dto/` — plain beans (`ClienteDTO`, `UsuarioDTO`, `RolDTO`, `NegocioDTO`). Field names mirror DB column names (e.g. `Cliente_ID`, `RazonSocial`).
- `dao/` — opens a connection, calls a stored procedure, maps rows to DTOs, closes resources in `finally`, and swallows `SQLException` with `printStackTrace()` (returns empty list / null / false on failure).
- `facade/` — one-line delegations to the DAO; controllers only talk to facades.
- `controller/` — servlets dispatch on the `accion` request parameter (both GET and POST go to `processRequest`):
  - `ClienteController` (`/ClienteController`): `listar` → `ListaClientes.jsp`; `nuevo`/`editar` → `socios.jsp` with request attrs `socio` and `modo` (`grabar`|`actualizar`); `grabar`/`actualizar`/`eliminar` then redirect to `listar`. Form field names are mapped in `extraerCliente()`.
  - `PersonalController` (`/PersonalController`, Administrador role only): same action set as ClienteController over `UsuarioFACADE`; views `ListaPersonal.jsp` / `personal.jsp`. One stored procedure (`sp_Insert_UsuarioPersonal`) both inserts and updates staff and their `Usuario` login row; delete becomes "Inactivo" when the staff member has history. Write actions require POST.
  - `Controlador.java` is mapped to **`/UsuarioController`** (class name ≠ URL). Handles `login` (loads business name from `NegocioFACADE` for `Login.jsp`), `autenticar` (stores `usuarioAutenticado`, `usuario`, `rol` in the session, redirects to `dashboard.jsp`), `productos` (session-checked forward to `Productos.jsp`), and `listar`/no action → `ListaEmpresa.jsp`. Other actions linked from the dashboard menu (`ventas`, `almacen`, `asistencia`, `configurar`, `cerrarSesion`) are not implemented yet and produce an empty response.
- Views in `web/`: JSPs use EL/JSTL (`${pageContext.request.contextPath}` for links) with a matching `css/<page>.css` and optional `js/<page>.js`. Every page repeats its own sidebar markup (`dashboard.jsp` is the reference); collapsible submenus use the shared `css/menu.css` + `js/menu.js` (`toggleSubmenu`, the submenu containing `li.submenu-activo` starts open). The admin-only Personal submenu is a single fragment, `WEB-INF/vistas/menuPersonal.jsp`, pulled in with `<jsp:include>` + `opcion` param (`listar`|`nuevo`|empty) — add it to any new page's sidebar. Several pages (`membresias.jsp`, `gastos.jsp`, `Productos.jsp`) are currently front-end only with no backing controller/DAO.
- There is no auth filter: only the `productos` action checks the session; JSPs opened directly are not protected.

## Repo notes

- `ObjetosClienteDTO.txt`, `ScriptClienteDAO.txt`, `ScriptClienteFACADE.txt` in the root are scratch copies of class code, not compiled; the real sources are under `src/java`.
- `facade/ficherovacio.java` is an empty placeholder class.
