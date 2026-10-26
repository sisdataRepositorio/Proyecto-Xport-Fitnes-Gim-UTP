<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%
    if (session.getAttribute("usuarioAutenticado") == null) {
        response.sendRedirect(request.getContextPath() + "/UsuarioController?accion=login");
        return;
    }
%>
<c:set var="esEdicion" value="${modo == 'actualizar'}"/>
<c:set var="tieneAcceso" value="${personal != null && personal.opcUserSist == 1}"/>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${esEdicion ? 'Edición de Personal' : 'Registro de Personal'} | Xport Fitness Gym</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/socios.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
    <style>
        .campo input[readonly]{background:#f1f5f9;cursor:not-allowed}
        .seccion-titulo{display:flex;align-items:center;gap:8px;margin:6px 0 0;padding-top:14px;border-top:1px solid #E0E6EF;font-size:14px;font-weight:700;color:#10234D}
        .seccion-titulo i{color:var(--blue)}
        .check-acceso{display:flex;align-items:center;gap:8px;font-size:13px;font-weight:600;color:#263B60;cursor:pointer}
        .check-acceso input{width:16px;height:16px;cursor:pointer}
        .datos-acceso[hidden]{display:none}
        .ayuda{font-size:11px;color:#718096}
        .mensaje{display:flex;align-items:center;gap:8px;padding:11px 14px;border-radius:8px;margin-bottom:16px;font-size:13px;font-weight:600;background:#fee2e2;color:#991b1b}
        .resumen-card{border:1px solid #E0E6EF;background:#F8FAFD;border-radius:11px;padding:18px 14px;text-align:center}
        .resumen-card .foto-avatar{margin-top:6px}
        .resumen-nombre{font-weight:700;font-size:14px;margin:4px 0}
        .resumen-dato{font-size:12px;color:#64748B;margin:2px 0}
        .botones-form{grid-template-columns:repeat(3,minmax(0,1fr))}
    </style>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/menu.css">
</head>
<body>
<div class="dashboard-container">
    <jsp:include page="/WEB-INF/vistas/menuLateral.jsp">
        <jsp:param name="opcion" value="nuevoPersonal"/>
        <jsp:param name="submenu" value=""/>
    </jsp:include>

    <main class="main-content">
        <section class="panel">
            <div class="titulo-modulo">
                <i class="fa-solid fa-id-badge"></i>
                <h1>${esEdicion ? 'Edición de Personal' : 'Registro de Personal'}</h1>
            </div>

            <c:if test="${not empty mensaje}">
                <div class="mensaje">
                    <i class="fa-solid fa-triangle-exclamation"></i>
                    <c:out value="${mensaje}"/>
                </div>
            </c:if>

            <form id="formPersonal" action="${pageContext.request.contextPath}/PersonalController" method="post">
                <input type="hidden" id="accion" name="accion" value="${esEdicion ? 'actualizar' : 'grabar'}">

                <div class="contenido-form">
                    <div class="campos-socio">
                        <div class="fila fila-tres">
                            <div class="campo">
                                <label for="codigo"><i class="fa-solid fa-hashtag"></i> Código</label>
                                <input type="text" id="codigo" name="codigo" readonly
                                       value="${personal.personal_ID > 0 ? personal.personal_ID : ''}">
                                <c:if test="${!esEdicion}"><span class="ayuda">Se confirma al grabar.</span></c:if>
                            </div>
                            <div class="campo">
                                <label for="nroDoc"><i class="fa-solid fa-key"></i> DNI / RUC</label>
                                <input type="text" id="nroDoc" name="nroDoc" maxlength="11" inputmode="numeric"
                                       pattern="\d{8}|\d{11}" title="8 dígitos (DNI) u 11 dígitos (RUC)"
                                       value="${fn:escapeXml(personal.rucDNI)}" placeholder="70012717">
                            </div>
                            <div class="campo">
                                <label for="estado"><i class="fa-solid fa-circle-check"></i> Estado</label>
                                <select id="estado" name="estado">
                                    <option value="Activo" ${personal.estadoGene != 'Inactivo' ? 'selected' : ''}>Activo</option>
                                    <option value="Inactivo" ${personal.estadoGene == 'Inactivo' ? 'selected' : ''}>Inactivo</option>
                                </select>
                            </div>
                        </div>

                        <div class="fila fila-tres">
                            <div class="campo">
                                <label for="apellidoPaterno"><i class="fa-solid fa-user"></i> Apellido Paterno</label>
                                <input type="text" id="apellidoPaterno" name="apellidoPaterno" maxlength="50" required
                                       value="${fn:escapeXml(personal.apellidoPaterno)}">
                            </div>
                            <div class="campo">
                                <label for="apellidoMaterno"><i class="fa-solid fa-user"></i> Apellido Materno</label>
                                <input type="text" id="apellidoMaterno" name="apellidoMaterno" maxlength="50" required
                                       value="${fn:escapeXml(personal.apellidoMaterno)}">
                            </div>
                            <div class="campo">
                                <label for="nombres"><i class="fa-solid fa-user"></i> Nombres</label>
                                <input type="text" id="nombres" name="nombres" maxlength="50" required
                                       value="${fn:escapeXml(personal.nombres)}">
                            </div>
                        </div>

                        <div class="campo campo-full">
                            <label for="direccion"><i class="fa-solid fa-location-dot"></i> Dirección</label>
                            <input type="text" id="direccion" name="direccion" maxlength="100"
                                   value="${fn:escapeXml(personal.direccion)}" placeholder="Av. Próceres de la Independencia 1234, Lima">
                        </div>

                        <div class="fila fila-tres">
                            <div class="campo">
                                <label for="telefono"><i class="fa-solid fa-phone"></i> Teléfono</label>
                                <input type="tel" id="telefono" name="telefono" maxlength="20"
                                       value="${fn:escapeXml(personal.telefono1)}" placeholder="976564321">
                            </div>
                            <div class="campo">
                                <label for="correo"><i class="fa-solid fa-envelope"></i> Correo</label>
                                <input type="email" id="correo" name="correo" maxlength="50"
                                       value="${fn:escapeXml(personal.correo)}" placeholder="correo@ejemplo.com">
                            </div>
                            <div class="campo">
                                <label for="sexo"><i class="fa-solid fa-venus-mars"></i> Sexo</label>
                                <select id="sexo" name="sexo">
                                    <option value="MASCULINO" ${personal.sexo != 'FEMENINO' ? 'selected' : ''}>MASCULINO</option>
                                    <option value="FEMENINO" ${personal.sexo == 'FEMENINO' ? 'selected' : ''}>FEMENINO</option>
                                </select>
                            </div>
                        </div>

                        <div class="fila">
                            <div class="campo">
                                <label for="area"><i class="fa-solid fa-sitemap"></i> Área</label>
                                <select id="area" name="area" required>
                                    <option value="">-- Seleccione --</option>
                                    <c:forEach var="a" items="${listaAreas}">
                                        <option value="${a.area_ID}" ${a.area_ID == personal.area_ID ? 'selected' : ''}>
                                            <c:out value="${a.descripcionArea}"/>
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="campo">
                                <label for="referencia"><i class="fa-solid fa-address-book"></i> Referencia</label>
                                <input type="text" id="referencia" name="referencia" maxlength="50"
                                       value="${fn:escapeXml(personal.referencia)}" placeholder="Contacto o referencia">
                            </div>
                        </div>

                        <!-- ACCESO AL SISTEMA -->
                        <div class="seccion-titulo"><i class="fa-solid fa-lock"></i> Acceso al sistema</div>

                        <label class="check-acceso">
                            <input type="checkbox" id="accesoSistema" name="accesoSistema" value="1" ${tieneAcceso ? 'checked' : ''}>
                            Este personal puede iniciar sesión
                        </label>

                        <div class="fila fila-tres datos-acceso" id="datosAcceso" ${tieneAcceso ? '' : 'hidden'}>
                            <div class="campo">
                                <label for="usuario"><i class="fa-solid fa-user-shield"></i> Usuario</label>
                                <input type="text" id="usuario" name="usuario" maxlength="50" autocomplete="off"
                                       value="${fn:escapeXml(personal.usuario)}">
                            </div>
                            <div class="campo">
                                <label for="contrasena"><i class="fa-solid fa-key"></i> Contraseña</label>
                                <input type="password" id="contrasena" name="contrasena" maxlength="50" autocomplete="new-password"
                                       placeholder="${esEdicion && not empty personal.usuario ? 'Dejar vacío para no cambiar' : ''}">
                            </div>
                            <div class="campo">
                                <label for="rol"><i class="fa-solid fa-user-tag"></i> Rol</label>
                                <select id="rol" name="rol">
                                    <option value="">-- Seleccione --</option>
                                    <c:forEach var="r" items="${listaRoles}">
                                        <option value="${r.rol_id}" title="${fn:escapeXml(r.descripcion)}"
                                                ${r.rol_id == personal.rol_ID ? 'selected' : ''}>
                                            <c:out value="${r.nombre_rol}"/>
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                    </div>

                    <aside class="resumen-card">
                        <div class="foto-titulo">PERSONAL</div>
                        <div class="foto-avatar"><i class="fa-solid fa-circle-user"></i></div>
                        <c:if test="${esEdicion}">
                            <p class="resumen-nombre"><c:out value="${personal.nombreCompleto}"/></p>
                            <p class="resumen-dato"><c:out value="${personal.area}"/></p>
                            <p class="resumen-dato"><c:out value="${empty personal.rol ? 'Sin acceso al sistema' : personal.rol}"/></p>
                        </c:if>
                        <c:if test="${!esEdicion}">
                            <p class="resumen-dato">Nuevo registro</p>
                        </c:if>
                    </aside>
                </div>

                <div class="botones-form">
                    <button type="button" class="btn-form btn-nuevo" id="btnNuevo">
                        <i class="fa-solid fa-plus"></i> Nuevo (F2)
                    </button>
                    <button type="submit" class="btn-form ${esEdicion ? 'btn-actualizar' : 'btn-grabar'}" id="btnGuardar">
                        <i class="fa-solid ${esEdicion ? 'fa-rotate' : 'fa-pen'}"></i>
                        ${esEdicion ? 'Actualizar (F4)' : 'Grabar (F3)'}
                    </button>
                    <button type="button" class="btn-form btn-salir" id="btnSalir">
                        <i class="fa-solid fa-right-from-bracket"></i> Salir (Esc)
                    </button>
                </div>
            </form>
        </section>
    </main>
</div>
<script>
    window.PERSONAL_CTX = "${pageContext.request.contextPath}";
    window.PERSONAL_REQUIERE_CLAVE = ${!(esEdicion && not empty personal.usuario)};
</script>
<script src="${pageContext.request.contextPath}/js/personal.js"></script>
<script src="${pageContext.request.contextPath}/js/menu.js"></script>
</body>
</html>
