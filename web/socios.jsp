<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("usuarioAutenticado") == null) {
        response.sendRedirect(request.getContextPath() + "/UsuarioController?accion=login");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro Socios | Xport Fitness Gym</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/socios.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
</head>
<body>
<div class="dashboard-container">
    <aside class="sidebar">
        <div class="saludo-admin"><h2>Hola, Administrador</h2></div>
        <ul class="sidebar-menu">
            <li><a href="${pageContext.request.contextPath}/dashboard.jsp"><i class="fa-solid fa-house-user"></i><span>Inicio</span></a></li>
            <li><a href="${pageContext.request.contextPath}/UsuarioController?accion=asistencia"><i class="fa-solid fa-user-check"></i><span>Asistencia</span></a></li>
            <li><a href="${pageContext.request.contextPath}/membresias.jsp"><i class="fa-solid fa-id-card"></i><span>Membresía</span></a></li>
            <li class="menu-desplegable" id="menuSocios">
                <a href="#" class="menu-enlace"
                   onclick="toggleSubmenu(event, 'submenuSocios')"
                   aria-expanded="false">
                    <i class="fa-solid fa-users"></i>
                    <span>Socios</span>
                    <i class="fa-solid fa-chevron-down flecha-submenu"></i>
                </a>

                <ul class="submenu" id="submenuSocios">
                    <li>
                        <a href="${pageContext.request.contextPath}/ClienteController?accion=listar">
                            <i class="fa-solid fa-list"></i>
                            <span>Ver Socios</span>
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/socios.jsp">
                            <i class="fa-solid fa-user-plus"></i>
                            <span>Registrar Socio</span>
                        </a>
                    </li>
                </ul>
            </li>
            <li><a href="${pageContext.request.contextPath}/UsuarioController?accion=ventas"><i class="fa-solid fa-chart-line"></i><span>Ventas</span></a></li>
            <li><a href="${pageContext.request.contextPath}/UsuarioController?accion=productos"><i class="fa-solid fa-box"></i><span>Productos</span></a></li>
            <li><a href="${pageContext.request.contextPath}/UsuarioController?accion=gastos"><i class="fa-solid fa-money-bill"></i><span>Gastos</span></a></li>
            <li><a href="${pageContext.request.contextPath}/UsuarioController?accion=almacen"><i class="fa-solid fa-warehouse"></i><span>Almacén</span></a></li>
        </ul>
        <ul class="sidebar-menu2">
            <li><a href="${pageContext.request.contextPath}/UsuarioController?accion=configurar"><i class="fa-solid fa-gear"></i><span>Configurar</span></a></li>
            <li><a href="${pageContext.request.contextPath}/UsuarioController?accion=cerrarSesion"><i class="fa-solid fa-right-from-bracket"></i><span>Cerrar sesión</span></a></li>
        </ul>
    </aside>

    <main class="main-content">
        <section class="panel">
            <div class="titulo-modulo">
                <i class="fa-solid fa-users"></i>
                <h1>Registro Socios</h1>
            </div>

            <form class="form-socios" id="formSocios" action="#" method="post">
                <div class="contenido-form">
                    <div class="campos-socio">
                        <div class="fila fila-tres">
                            <div class="campo">
                                <label for="codigo"><i class="fa-solid fa-hashtag"></i> Código</label>
                                <input type="text" id="codigo" name="codigo" placeholder="70012717">
                            </div>
                            <div class="campo">
                                <label for="tipoDocumento"><i class="fa-solid fa-id-card"></i> Tipo Doc.</label>
                                <select id="tipoDocumento" name="tipoDocumento">
                                    <option value="DNI">DNI</option>
                                    <option value="RUC">RUC</option>
                                    <option value="CARNET_EXT">Carnet Ext.</option>
                                </select>
                            </div>
                            <div class="campo">
                                <label for="numeroDocumento"><i class="fa-solid fa-key"></i> Nro Documento</label>
                                <input type="text" id="numeroDocumento" name="numeroDocumento" placeholder="70012717">
                            </div>
                        </div>

                        <div class="campo campo-full">
                            <label for="nombre"><i class="fa-solid fa-user"></i> Nombre o Razón Social</label>
                            <input type="text" id="nombre" name="nombre" placeholder="Nombre completo o razón social">
                        </div>
                        <div class="campo campo-full">
                            <label for="direccion"><i class="fa-solid fa-location-dot"></i> Dirección</label>
                            <input type="text" id="direccion" name="direccion" placeholder="Av. Próceres de la independencia 1234, Lima">
                        </div>

                        <div class="fila">
                            <div class="campo">
                                <label for="telefono1"><i class="fa-solid fa-phone"></i> Teléfono 1</label>
                                <input type="tel" id="telefono1" name="telefono1" placeholder="976564321">
                            </div>
                            <div class="campo">
                                <label for="telefono2"><i class="fa-solid fa-phone"></i> Teléfono 2</label>
                                <input type="tel" id="telefono2" name="telefono2" placeholder="986543210">
                            </div>
                        </div>

                        <div class="fila">
                            <div class="campo">
                                <label for="sexo"><i class="fa-solid fa-venus-mars"></i> Sexo</label>
                                <select id="sexo" name="sexo">
                                    <option value="MASCULINO">MASCULINO</option>
                                    <option value="FEMENINO">FEMENINO</option>
                                </select>
                            </div>
                            <div class="campo">
                                <label for="correo"><i class="fa-solid fa-envelope"></i> Correo</label>
                                <input type="email" id="correo" name="correo" placeholder="correo@ejemplo.com">
                            </div>
                        </div>

                        <div class="fila">
                            <div class="campo">
                                <label for="fechaNacimiento"><i class="fa-solid fa-calendar"></i> Fecha Nacimiento</label>
                                <input type="date" id="fechaNacimiento" name="fechaNacimiento">
                            </div>
                            <div class="campo">
                                <label for="fechaRegistro"><i class="fa-solid fa-calendar-check"></i> Fecha Registro</label>
                                <input type="date" id="fechaRegistro" name="fechaRegistro">
                            </div>
                        </div>

                        <div class="fila">
                            <div class="campo">
                                <label for="estado"><i class="fa-solid fa-circle-check"></i> Estado</label>
                                <select id="estado" name="estado">
                                    <option value="ACTIVO">ACTIVO</option>
                                    <option value="INACTIVO">INACTIVO</option>
                                </select>
                            </div>
                            <div class="campo">
                                <label for="observaciones"><i class="fa-solid fa-note-sticky"></i> Observaciones</label>
                                <input type="text" id="observaciones" name="observaciones" placeholder="Sin observaciones">
                            </div>
                        </div>
                    </div>

                    <aside class="foto-card">
                        <div class="foto-titulo">FOTO DEL SOCIO</div>
                        <div class="foto-avatar" id="fotoAvatar">
                            <i class="fa-solid fa-circle-user"></i>
                        </div>
                        <input type="file" id="fotoSocio" name="fotoSocio" accept="image/*" hidden>
                        <button type="button" class="btn-subir" id="btnSubirFoto">
                            <i class="fa-solid fa-camera"></i> Subir Foto
                        </button>
                        <div class="huella-titulo">HUELLA DACTILAR</div>
                        <div class="huella-box"><i class="fa-solid fa-fingerprint"></i></div>
                        <p class="foto-ayuda">La captura de huella requiere un lector compatible.</p>
                    </aside>
                </div>

                <div class="botones-form">
                    <button type="button" class="btn-form btn-nuevo" id="btnNuevo"><i class="fa-solid fa-plus"></i> Nuevo (F2)</button>
                    <button type="button" class="btn-form btn-grabar" id="btnGrabar"><i class="fa-solid fa-pen"></i> Grabar (F3)</button>
                    <button type="button" class="btn-form btn-actualizar" id="btnActualizar"><i class="fa-solid fa-rotate"></i> Actualizar (F4)</button>
                    <button type="button" class="btn-form btn-salir" id="btnSalir"><i class="fa-solid fa-right-from-bracket"></i> Salir (Esc)</button>
                </div>
                <p class="nota-funcionalidad">Plantilla visual: grabar y actualizar requieren conectar este formulario con el controlador y la base de datos.</p>
            </form>
        </section>
    </main>
</div>
<script src="${pageContext.request.contextPath}/js/socios.js"></script>
</body>
</html>
