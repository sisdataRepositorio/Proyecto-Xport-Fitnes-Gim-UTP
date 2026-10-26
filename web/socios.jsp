<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
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
    <title>${modo == 'actualizar' ? 'Edición de Socios' : 'Registro Socios'} | Xport Fitness Gym</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/socios.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/menu.css">
</head>
<body>
<div class="dashboard-container">
    <jsp:include page="/WEB-INF/vistas/menuLateral.jsp">
        <jsp:param name="opcion" value="registrarSocio"/>
        <jsp:param name="submenu" value="socios"/>
    </jsp:include>

    <main class="main-content">
        <section class="panel">
            <div class="titulo-modulo">
                <i class="fa-solid fa-users"></i>
                <h1>${modo == 'actualizar' ? 'Edición de Socio' : 'Registro Socios'}</h1>
            </div>

            <!-- FORMULARIO CONECTADO AL CONTROLADOR -->
            <form class="form-socios" id="formSocios" action="${pageContext.request.contextPath}/ClienteController" method="post">
                <!-- Acción enviada al Servlet: grabar o actualizar -->
                <input type="hidden" id="accion" name="accion" value="${modo != null ? modo : 'grabar'}">

                <div class="contenido-form">
                    <div class="campos-socio">
                        <div class="fila fila-tres">
                            <div class="campo">
                                <label for="codigo"><i class="fa-solid fa-hashtag"></i> Código</label>
                                <input type="text" id="codigo" name="codigo" 
                                       value="${socio != null ? socio.cliente_ID : ''}" 
                                       ${modo == 'actualizar' ? 'readonly style="background-color: #f1f5f9; cursor: not-allowed;"' : ''} 
                                       placeholder="70012717" required>
                            </div>
                            <div class="campo">
                                <label for="tipoDocumento"><i class="fa-solid fa-id-card"></i> Tipo Doc.</label>
                                <select id="tipoDocumento" name="tipoDoc">
                                    <option value="DNI" ${socio != null && socio.tipoId == 'DNI' ? 'selected' : ''}>DNI</option>
                                    <option value="RUC" ${socio != null && socio.tipoId == 'RUC' ? 'selected' : ''}>RUC</option>
                                    <option value="CARNET_EXT" ${socio != null && socio.tipoId == 'CARNET_EXT' ? 'selected' : ''}>Carnet Ext.</option>
                                </select>
                            </div>
                            <div class="campo">
                                <label for="numeroDocumento"><i class="fa-solid fa-key"></i> Nro Documento</label>
                                <input type="text" id="numeroDocumento" name="nroDoc" 
                                       value="${socio != null ? socio.rucDNI : ''}" 
                                       placeholder="70012717" required>
                            </div>
                        </div>

                        <div class="campo campo-full">
                            <label for="nombre"><i class="fa-solid fa-user"></i> Nombre o Razón Social</label>
                            <input type="text" id="nombre" name="razonSocial" 
                                   value="${socio != null ? socio.razonSocial : ''}" 
                                   placeholder="Nombre completo o razón social" required>
                        </div>
                        <div class="campo campo-full">
                            <label for="direccion"><i class="fa-solid fa-location-dot"></i> Dirección</label>
                            <input type="text" id="direccion" name="direccion" 
                                   value="${socio != null ? socio.direccion : ''}" 
                                   placeholder="Av. Próceres de la independencia 1234, Lima">
                        </div>

                        <div class="fila">
                            <div class="campo">
                                <label for="telefono1"><i class="fa-solid fa-phone"></i> Teléfono 1</label>
                                <input type="tel" id="telefono1" name="telefono1" 
                                       value="${socio != null ? socio.telefono : ''}" 
                                       placeholder="976564321">
                            </div>
                            <div class="campo">
                                <label for="telefono2"><i class="fa-solid fa-phone"></i> Teléfono 2</label>
                                <input type="tel" id="telefono2" name="telefono2" 
                                       value="${socio != null ? socio.telefono2 : ''}" 
                                       placeholder="986543210">
                            </div>
                        </div>

                        <div class="fila">
                            <div class="campo">
                                <label for="sexo"><i class="fa-solid fa-venus-mars"></i> Sexo</label>
                                <select id="sexo" name="sexo">
                                    <option value="MASCULINO" ${socio != null && socio.sexo == 'MASCULINO' ? 'selected' : ''}>MASCULINO</option>
                                    <option value="FEMENINO" ${socio != null && socio.sexo == 'FEMENINO' ? 'selected' : ''}>FEMENINO</option>
                                </select>
                            </div>
                            <div class="campo">
                                <label for="correo"><i class="fa-solid fa-envelope"></i> Correo</label>
                                <input type="email" id="correo" name="correo" 
                                       value="${socio != null ? socio.correo : ''}" 
                                       placeholder="correo@ejemplo.com">
                            </div>
                        </div>

                        <div class="fila">
                            <div class="campo">
                                <label for="estado"><i class="fa-solid fa-circle-check"></i> Estado</label>
                                <select id="estado" name="estado">
                                    <option value="ACTIVO" ${socio != null && socio.estado == 'ACTIVO' ? 'selected' : ''}>ACTIVO</option>
                                    <option value="INACTIVO" ${socio != null && socio.estado == 'INACTIVO' ? 'selected' : ''}>INACTIVO</option>
                                </select>
                            </div>
                            <div class="campo">
                                <label for="contacto"><i class="fa-solid fa-address-book"></i> Nombre de Contacto</label>
                                <input type="text" id="contacto" name="contacto" 
                                       value="${socio != null ? socio.contacto : ''}" 
                                       placeholder="Familiar o contacto de emergencia">
                            </div>
                        </div>
                    </div>

                    <aside class="foto-card">
                        <div class="foto-titulo">FOTO DEL SOCIO</div>
                        <div class="foto-avatar" id="fotoAvatar">
                            <i class="fa-solid fa-circle-user"></i>
                        </div>
                        <input type="file" id="fotoSocio" name="fotoSocio" accept="image/*" hidden>
                        <input type="hidden" id="fotoUrl" name="fotoUrl" value="${socio != null ? socio.foto : ''}">
                        <button type="button" class="btn-subir" id="btnSubirFoto">
                            <i class="fa-solid fa-camera"></i> Subir Foto
                        </button>
                        <div class="huella-titulo">HUELLA DACTILAR</div>
                        <div class="huella-box"><i class="fa-solid fa-fingerprint"></i></div>
                        <p class="foto-ayuda">La captura de huella requiere un lector compatible.</p>
                    </aside>
                </div>

                <!-- BOTONERA DINÁMICA SEGÚN MODO (NUEVO O EDICIÓN) -->
                <div class="botones-form">
                    <button type="button" class="btn-form btn-nuevo" id="btnNuevo">
                        <i class="fa-solid fa-plus"></i> Nuevo (F2)
                    </button>
                    
                    <button type="button" class="btn-form btn-grabar" id="btnGrabar" 
                            style="${modo == 'actualizar' ? 'display: none;' : ''}">
                        <i class="fa-solid fa-pen"></i> Grabar (F3)
                    </button>

                    <button type="button" class="btn-form btn-actualizar" id="btnActualizar" 
                            style="${modo != 'actualizar' ? 'display: none;' : ''}">
                        <i class="fa-solid fa-rotate"></i> Actualizar (F4)
                    </button>

                    <button type="button" class="btn-form btn-salir" id="btnSalir">
                        <i class="fa-solid fa-right-from-bracket"></i> Salir (Esc)
                    </button>
                </div>
            </form>
        </section>
    </main>
</div>
<script src="${pageContext.request.contextPath}/js/socios.js"></script>
<script src="${pageContext.request.contextPath}/js/menu.js"></script>
</body>
</html>