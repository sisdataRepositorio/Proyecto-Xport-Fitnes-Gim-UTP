<%@page contentType="text/html" pageEncoding="UTF-8"%>

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
</head>
<body>
<div class="dashboard-container">
    <aside class="sidebar">
        <div class="saludo-admin"><h2>Hola, Administrador</h2></div>
        <ul class="sidebar-menu">
            <li class="active"><a href="${pageContext.request.contextPath}/dashboard.jsp"><i class="fa-solid fa-house-user"></i><span>Inicio</span></a></li>
            <li><a href="${pageContext.request.contextPath}/UsuarioController?accion=asistencia"><i class="fa-solid fa-user-check"></i><span>Asistencia</span></a></li>
            <li><a href="${pageContext.request.contextPath}/membresias.jsp"><i class="fa-solid fa-id-card"></i><span>Membresía</span></a></li>
            <li><a href="${pageContext.request.contextPath}/socios.jsp"><i class="fa-solid fa-users"></i><span>Socios</span></a></li>
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
                                    <td>John Doe</td><td>123456789</td><td>09:00 AM</td>
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
</body>
</html>
