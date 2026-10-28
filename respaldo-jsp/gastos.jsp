
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("usuarioAutenticado") == null) {
        response.sendRedirect(
            request.getContextPath() + "/UsuarioController?accion=login"
        );
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gastos | Xport Fitness Gym</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/diseingreso.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/gastos.css">

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/menu.css">
</head>
<body>
<div class="dashboard-container">

    <!-- MENÚ LATERAL -->
    <aside class="sidebar">
        <div class="saludo-admin">
            <h2>Hola, Administrador</h2>
        </div>

        <ul class="sidebar-menu">
            <li>
                <a href="${pageContext.request.contextPath}/dashboard.jsp">
                    <i class="fa-solid fa-house-user"></i>
                    <span>Inicio</span>
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/UsuarioController?accion=asistencia">
                    <i class="fa-solid fa-user-check"></i>
                    <span>Asistencia</span>
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/membresias.jsp">
                    <i class="fa-solid fa-id-card"></i>
                    <span>Membresía</span>
                </a>
            </li>
            
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

            <jsp:include page="/WEB-INF/vistas/menuPersonal.jsp">
                <jsp:param name="opcion" value=""/>
            </jsp:include>
            <li>
                <a href="${pageContext.request.contextPath}/UsuarioController?accion=ventas">
                    <i class="fa-solid fa-chart-line"></i>
                    <span>Ventas</span>
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/UsuarioController?accion=productos">
                    <i class="fa-solid fa-box"></i>
                    <span>Productos</span>
                </a>
            </li>
            <li class="active">
                <a href="${pageContext.request.contextPath}/gastos.jsp"
                   aria-current="page">
                    <i class="fa-solid fa-money-bill"></i>
                    <span>Gastos</span>
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/UsuarioController?accion=almacen">
                    <i class="fa-solid fa-warehouse"></i>
                    <span>Almacén</span>
                </a>
            </li>
        </ul>

        <ul class="sidebar-menu2">
            <li>
                <a href="${pageContext.request.contextPath}/UsuarioController?accion=configurar">
                    <i class="fa-solid fa-gear"></i>
                    <span>Configurar</span>
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/UsuarioController?accion=cerrarSesion">
                    <i class="fa-solid fa-right-from-bracket"></i>
                    <span>Cerrar sesión</span>
                </a>
            </li>
        </ul>
    </aside>

    <!-- CONTENIDO PRINCIPAL -->
    <main class="gastos-main">

        <header class="gastos-header">
            <div>
                <p class="gastos-eyebrow">CONTROL FINANCIERO</p>
                <h1>Dashboard de gastos</h1>
                <p class="gastos-subtitle">
                    Resumen de ingresos, gastos y movimientos del gimnasio.
                </p>
            </div>

            <div class="periodo">
                <i class="fa-regular fa-calendar"></i>
                <span>Este mes · Octubre 2026</span>
            </div>
        </header>

        <!-- TARJETAS DE RESUMEN -->
        <section class="resumen-grid" aria-label="Resumen financiero">

            <article class="resumen-card gastos-card-total">
                <div class="resumen-icon">
                    <i class="fa-solid fa-arrow-trend-down"></i>
                </div>
                <p class="resumen-label">Gastos totales</p>
                <p class="resumen-value">S/ 8,450.00</p>
                <span class="resumen-foot">
                    <i class="fa-solid fa-circle-info"></i>
                    Total registrado este mes
                </span>
            </article>

            <article class="resumen-card ingresos-card">
                <div class="resumen-icon">
                    <i class="fa-solid fa-arrow-trend-up"></i>
                </div>
                <p class="resumen-label">Ingresos</p>
                <p class="resumen-value">S/ 24,800.00</p>
                <span class="resumen-foot">
                    <i class="fa-solid fa-circle-check"></i>
                    Ingresos del periodo
                </span>
            </article>

            <article class="resumen-card saldo-card">
                <div class="resumen-icon">
                    <i class="fa-solid fa-wallet"></i>
                </div>
                <p class="resumen-label">Saldo disponible</p>
                <p class="resumen-value">S/ 16,350.00</p>
                <span class="resumen-foot">
                    <i class="fa-solid fa-chart-pie"></i>
                    Ingresos menos gastos
                </span>
            </article>

        </section>

        <!-- ANÁLISIS FINANCIERO -->
        <section class="analisis-grid" aria-label="Análisis de gastos">

            <!-- GRÁFICO CIRCULAR -->
            <article class="contenido-card categorias-card">
                <div class="card-heading">
                    <div>
                        <h2>Gastos por categoría</h2>
                        <p>Distribución del gasto registrado</p>
                    </div>
                    <span class="total-categorias">S/ 8,450.00</span>
                </div>

                <div class="categorias-contenido">
                    <div class="donut-wrap"
                         role="img"
                         aria-label="Gráfico circular de gastos por categoría">
                        <div class="donut-chart">
                            <div class="donut-hole">
                                <strong>S/ 8,450</strong>
                                <span>Total gastos</span>
                            </div>
                        </div>
                    </div>

                    <ul class="leyenda-categorias">
                        <li>
                            <span class="leyenda-nombre">
                                <i class="dot dot-personal"></i>Personal
                            </span>
                            <strong>S/ 2,957.50 <small>35%</small></strong>
                        </li>
                        <li>
                            <span class="leyenda-nombre">
                                <i class="dot dot-alquiler"></i>Alquiler
                            </span>
                            <strong>S/ 2,366.00 <small>28%</small></strong>
                        </li>
                        <li>
                            <span class="leyenda-nombre">
                                <i class="dot dot-servicios"></i>Servicios
                            </span>
                            <strong>S/ 1,521.00 <small>18%</small></strong>
                        </li>
                        <li>
                            <span class="leyenda-nombre">
                                <i class="dot dot-equipos"></i>Equipos
                            </span>
                            <strong>S/ 1,014.00 <small>12%</small></strong>
                        </li>
                        <li>
                            <span class="leyenda-nombre">
                                <i class="dot dot-otros"></i>Otros
                            </span>
                            <strong>S/ 591.50 <small>7%</small></strong>
                        </li>
                    </ul>
                </div>
            </article>

            <!-- BARRAS COMPARATIVAS -->
            <article class="contenido-card comparativo-card">
                <div class="card-heading">
                    <div>
                        <h2>Detalle por categoría</h2>
                        <p>Participación en el gasto mensual</p>
                    </div>
                    <i class="fa-solid fa-chart-column heading-icon"></i>
                </div>

                <div class="barras-categorias">

                    <div class="barra-item">
                        <div class="barra-meta">
                            <span>Personal</span>
                            <strong>S/ 2,957.50</strong>
                        </div>
                        <div class="barra-fondo">
                            <span class="barra barra-personal"></span>
                        </div>
                    </div>

                    <div class="barra-item">
                        <div class="barra-meta">
                            <span>Alquiler</span>
                            <strong>S/ 2,366.00</strong>
                        </div>
                        <div class="barra-fondo">
                            <span class="barra barra-alquiler"></span>
                        </div>
                    </div>

                    <div class="barra-item">
                        <div class="barra-meta">
                            <span>Servicios</span>
                            <strong>S/ 1,521.00</strong>
                        </div>
                        <div class="barra-fondo">
                            <span class="barra barra-servicios"></span>
                        </div>
                    </div>

                    <div class="barra-item">
                        <div class="barra-meta">
                            <span>Equipos</span>
                            <strong>S/ 1,014.00</strong>
                        </div>
                        <div class="barra-fondo">
                            <span class="barra barra-equipos"></span>
                        </div>
                    </div>

                    <div class="barra-item">
                        <div class="barra-meta">
                            <span>Otros</span>
                            <strong>S/ 591.50</strong>
                        </div>
                        <div class="barra-fondo">
                            <span class="barra barra-otros"></span>
                        </div>
                    </div>

                </div>
            </article>
        </section>

        <!-- HISTORIAL DE MOVIMIENTOS -->
        <section class="contenido-card movimientos-card">

            <div class="card-heading movimientos-heading">
                <div>
                    <h2>Historial de movimientos</h2>
                    <p>Últimos gastos e ingresos registrados</p>
                </div>
                <span class="movimientos-count">5 movimientos</span>
            </div>

            <div class="tabla-scroll">
                <table class="tabla-movimientos">
                    <thead>
                        <tr>
                            <th>Movimiento</th>
                            <th>Categoría</th>
                            <th>Fecha</th>
                            <th>Método</th>
                            <th>Estado</th>
                            <th class="monto-col">Monto</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>
                                <span class="mov-icon mov-gasto">
                                    <i class="fa-solid fa-bolt"></i>
                                </span>
                                <span class="mov-info">
                                    <strong>Recibo de electricidad</strong>
                                    <small>Suministro del local</small>
                                </span>
                            </td>
                            <td>Servicios</td>
                            <td>20 oct 2026</td>
                            <td>Transferencia</td>
                            <td><span class="estado estado-pagado">Pagado</span></td>
                            <td class="monto monto-negativo">− S/ 680.00</td>
                        </tr>

                        <tr>
                            <td>
                                <span class="mov-icon mov-ingreso">
                                    <i class="fa-solid fa-user-group"></i>
                                </span>
                                <span class="mov-info">
                                    <strong>Pago de membresías</strong>
                                    <small>Plan mensual · 12 socios</small>
                                </span>
                            </td>
                            <td>Membresía</td>
                            <td>19 oct 2026</td>
                            <td>Tarjeta</td>
                            <td><span class="estado estado-completado">Completado</span></td>
                            <td class="monto monto-positivo">+ S/ 1,800.00</td>
                        </tr>

                        <tr>
                            <td>
                                <span class="mov-icon mov-gasto">
                                    <i class="fa-solid fa-box"></i>
                                </span>
                                <span class="mov-info">
                                    <strong>Suplementos y limpieza</strong>
                                    <small>Reposición de inventario</small>
                                </span>
                            </td>
                            <td>Otros</td>
                            <td>18 oct 2026</td>
                            <td>Efectivo</td>
                            <td><span class="estado estado-pagado">Pagado</span></td>
                            <td class="monto monto-negativo">− S/ 425.50</td>
                        </tr>

                        <tr>
                            <td>
                                <span class="mov-icon mov-gasto">
                                    <i class="fa-solid fa-screwdriver-wrench"></i>
                                </span>
                                <span class="mov-info">
                                    <strong>Mantenimiento de equipos</strong>
                                    <small>Servicio preventivo</small>
                                </span>
                            </td>
                            <td>Equipos</td>
                            <td>16 oct 2026</td>
                            <td>Transferencia</td>
                            <td><span class="estado estado-pagado">Pagado</span></td>
                            <td class="monto monto-negativo">− S/ 950.00</td>
                        </tr>

                        <tr>
                            <td>
                                <span class="mov-icon mov-ingreso">
                                    <i class="fa-solid fa-cart-shopping"></i>
                                </span>
                                <span class="mov-info">
                                    <strong>Venta de productos</strong>
                                    <small>Accesorios deportivos</small>
                                </span>
                            </td>
                            <td>Ventas</td>
                            <td>15 oct 2026</td>
                            <td>Yape</td>
                            <td><span class="estado estado-completado">Completado</span></td>
                            <td class="monto monto-positivo">+ S/ 620.00</td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <p class="nota-demo">
                <i class="fa-solid fa-circle-info"></i>
                Datos de muestra para el dashboard.
            </p>
        </section>

    </main>
</div>
<script src="${pageContext.request.contextPath}/js/menu.js"></script>
</body>
</html>
