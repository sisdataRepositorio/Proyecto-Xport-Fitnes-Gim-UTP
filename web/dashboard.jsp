<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%
    if (session.getAttribute("usuarioAutenticado") == null) {
        response.sendRedirect(
            request.getContextPath()
            + "/UsuarioController?accion=login");
        return;
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inicio | Xport Fitness Gym</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/diseingreso.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/menu.css">
</head>
<body>
<div class="dashboard-container">
   <jsp:include page="/WEB-INF/vistas/menuLateral.jsp">
        <jsp:param name="opcion" value="inicio"/>
        <jsp:param name="submenu" value=""/>
    </jsp:include>
    <main class="dashboard-main">
        <div class="panel">
            <section class="bloques">
                <button type="button" class="btn-registrar"><i class="fa-solid fa-user-plus"></i> Inscribir</button>
                <button type="button" class="btn-renovar"><i class="fa-solid fa-arrows-rotate"></i> Renovar</button>
                <button type="button" class="btn-transaccion"><i class="fa-solid fa-right-left"></i> Transacción</button>
            </section>
            <div class="fila-principal">
                <section class="tabla-thead">
                    <h3>Entradas del día: <span id="fechaActual"></span></h3>
                    <div class="tabla-scroll">
                        <table class="tabla">
                            <thead><tr><th>Nombre</th><th>Documento</th><th>Hora</th><th>Estado</th><th>Expiración</th><th>Intento</th><th>Imagen</th></tr></thead>
                            <tbody>
                                <%-- Fila de ejemplo; después se conectará con la base de datos. --%>
                                <tr>
                                    <td>Michael Cueva</td><td>00000001</td><td>09:00 AM</td>
                                    <td class="celda-estado"><span class="punto verde" id="puntoEstado"></span>
                                        <select class="select-estado" id="estadoEntrada"><option value="verde">Presente</option><option value="rojo">Ausente</option></select>
                                    </td>
                                    <td>2026-10-13</td><td>1</td>
                                    <td class="celda-imagen">
                                        <button type="button" class="btn-accion btn-oscuro" aria-label="Configurar"><i class="fa-solid fa-gear"></i></button>
                                        <button type="button" class="btn-accion btn-verde" aria-label="Renovar"><i class="fa-solid fa-rotate"></i></button>
                                        <button type="button" class="btn-accion btn-celeste" aria-label="Actualizar"><i class="fa-solid fa-rotate"></i></button>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </section>
                <aside class="tarjetas-laterales">
                    <article class="tarjeta-info"><div><p class="titulo-tarjeta">GANANCIAS DEL DÍA</p><p class="valor-tarjeta">S/ 1,285.50</p></div><i class="fa-solid fa-money-bill-wave icono-tarjeta"></i></article>
                    <article class="tarjeta-info"><div><p class="titulo-tarjeta">CLIENTES ACTIVOS</p><p class="valor-tarjeta">248</p></div><i class="fa-solid fa-users icono-tarjeta"></i></article>
                    <article class="tarjeta-info"><div><p class="titulo-tarjeta">CLIENTES POR VENCER</p><p class="valor-tarjeta">12</p></div><i class="fa-solid fa-clock icono-tarjeta"></i></article>
                    <c:if test="${sessionScope.rol == 'Administrador'}">
                        <jsp:useBean id="personalFacade" class="com.registro.facade.UsuarioFACADE" scope="request"/>
                        <c:set var="resumenPersonal" value="${personalFacade.resumenPersonal()}"/>
                        <a class="tarjeta-info tarjeta-link" href="${pageContext.request.contextPath}/PersonalController?accion=listar"
                           title="Ir al módulo de Personal">
                            <div>
                                <p class="titulo-tarjeta">PERSONAL ACTIVO</p>
                                <p class="valor-tarjeta">${resumenPersonal.activos}</p>
                                <p class="detalle-tarjeta">${resumenPersonal.conAcceso} con acceso al sistema</p>
                            </div>
                            <i class="fa-solid fa-id-badge icono-tarjeta"></i>
                        </a>
                    </c:if>
                </aside>
            </div>
            <section class="tarjetas-inferiores">
                <article class="tarjeta-inferior"><i class="fa-solid fa-coins"></i><div><p class="titulo-inferior">TASAS DE CAMBIO DEL DÍA</p><p><strong>USD Compra:</strong> S/ 3.42</p><p><strong>USD Venta:</strong> S/ 3.45</p></div></article>
                <article class="tarjeta-inferior"><i class="fa-solid fa-chart-column"></i><div><p class="titulo-inferior">ENTRADAS POR USUARIOS</p><p><strong>35 entradas</strong> registradas</p></div></article>
                <article class="tarjeta-inferior"><i class="fa-solid fa-cake-candles"></i><div><p class="titulo-inferior">CUMPLEAÑOS DEL DÍA</p><p><strong>3 socios</strong> cumplen años hoy</p></div></article>
            </section>
        </div>
    </main>
</div>
<script src="${pageContext.request.contextPath}/js/diseingreso.js"></script>
<script src="${pageContext.request.contextPath}/js/menu.js"></script>
</body>
</html>
