<%-- 
    Document   : Almacen.jsp
    Created on : 26 oct. 2026, 09:17:28
    Author     : Ing
--%>

<!DOCTYPE html>
<html lang="es" xmlns:th="http://www.thymeleaf.org">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Almacén | Xport Fitness Gym</title>
    <link rel="stylesheet" th:href="@{/css/diseingreso.css}">
    <link rel="stylesheet" th:href="@{/css/gastos.css}">
    <link rel="stylesheet" th:href="@{/css/productos-dashboard.css}">
    <link rel="stylesheet" th:href="@{/css/almacen.css}">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.3.1/css/all.min.css">
</head>
<body>
<div class="dashboard-container">
    <aside th:replace="~{layout :: sidebar('almacen')}"></aside>
    <main class="gastos-main almacen-main">
        <header class="gastos-header almacen-header">
            <div>
                <p class="gastos-eyebrow">CONTROL DE INVENTARIO</p>
                <h1>Almacén</h1>
                <p class="gastos-subtitle">Consulta las existencias, ubicaciones y alertas de reposición.</p>
            </div>
            <a class="periodo almacen-volver" th:href="@{/productos}"><i class="fa-solid fa-box"></i><span>Ver productos</span></a>
        </header>

        <section class="resumen-grid almacen-resumen" aria-label="Resumen del almacén">
            <article class="resumen-card"><div class="resumen-icon"><i class="fa-solid fa-boxes-stacked"></i></div><p class="resumen-label">Productos registrados</p><p class="resumen-value" th:text="${totalProductos}">0</p><span class="resumen-foot"><i class="fa-solid fa-layer-group"></i> En el inventario</span></article>
            <article class="resumen-card almacen-card-unidades"><div class="resumen-icon"><i class="fa-solid fa-cubes-stacked"></i></div><p class="resumen-label">Unidades disponibles</p><p class="resumen-value" th:text="${unidadesDisponibles}">0</p><span class="resumen-foot"><i class="fa-solid fa-circle-check"></i> Stock total actual</span></article>
            <article class="resumen-card almacen-card-alerta"><div class="resumen-icon"><i class="fa-solid fa-triangle-exclamation"></i></div><p class="resumen-label">Requieren reposición</p><p class="resumen-value" th:text="${stockBajo + agotados}">0</p><span class="resumen-foot"><i class="fa-solid fa-arrow-rotate-right"></i> Bajo stock o agotados</span></article>
        </section>

        <section class="analisis-grid almacen-alertas" aria-label="Estado de existencias">
            <article class="contenido-card">
                <div class="card-heading"><div><h2>Estado de existencias</h2><p>Productos que requieren atención</p></div><i class="fa-solid fa-chart-column heading-icon"></i></div>
                <div class="barras-categorias">
                    <div class="barra-item"><div class="barra-meta"><span>Disponibles</span><strong th:text="${totalProductos - stockBajo - agotados} + ' productos'"></strong></div><div class="barra-fondo"><span class="barra almacen-barra-disponible" th:style="|width: ${disponiblesPct}%|"></span></div></div>
                    <div class="barra-item"><div class="barra-meta"><span>Stock bajo</span><strong th:text="${stockBajo} + ' productos'"></strong></div><div class="barra-fondo"><span class="barra almacen-barra-bajo" th:style="|width: ${stockBajoPct}%|"></span></div></div>
                    <div class="barra-item"><div class="barra-meta"><span>Agotados</span><strong th:text="${agotados} + ' productos'"></strong></div><div class="barra-fondo"><span class="barra almacen-barra-agotado" th:style="|width: ${agotadosPct}%|"></span></div></div>
                </div>
            </article>
            <article class="contenido-card almacen-nota-card">
                <div class="card-heading"><div><h2>Ubicaciones</h2><p>Organización del almacén</p></div><i class="fa-solid fa-warehouse heading-icon"></i></div>
                <div class="almacen-ubicaciones"><div><span class="ubicacion-chip">A</span><span><strong>Suplementos</strong><small>Estantes A-01 a A-03</small></span></div><div><span class="ubicacion-chip verde">B</span><span><strong>Accesorios</strong><small>Estantes B-01 a B-02</small></span></div><div><span class="ubicacion-chip morado">C</span><span><strong>Ropa deportiva</strong><small>Estantes C-01 a C-02</small></span></div></div>
            </article>
        </section>

        <section class="contenido-card almacen-listado">
            <div class="card-heading movimientos-heading"><div><h2>Inventario del almacén</h2><p>Busca productos y revisa su ubicación y nivel de stock</p></div><span class="movimientos-count" th:text="${resultados} + ' resultados'">0 resultados</span></div>
            <form class="productos-toolbar almacen-toolbar" method="get" th:action="@{/almacen}">
                <label class="busqueda-productos"><i class="fa-solid fa-magnifying-glass"></i><input type="search" name="q" th:value="${q}" placeholder="Buscar por producto, código o ubicación..." aria-label="Buscar en almacén"></label>
                <label class="filtro-productos"><i class="fa-solid fa-filter"></i><select name="estado" aria-label="Filtrar por estado"><option value="" th:selected="${estadoFiltro == ''}">Todos los estados</option><option value="disponible" th:selected="${estadoFiltro == 'disponible'}">Disponible</option><option value="bajo" th:selected="${estadoFiltro == 'bajo'}">Stock bajo</option><option value="agotado" th:selected="${estadoFiltro == 'agotado'}">Agotado</option></select></label>
                <button class="almacen-buscar" type="submit">Buscar</button>
                <a class="catalogo-limpiar" th:if="${!strings.isEmpty(q) or !strings.isEmpty(estadoFiltro)}" th:href="@{/almacen}">Limpiar</a>
            </form>
            <div class="tabla-scroll"><table class="tabla-movimientos tabla-productos almacen-tabla"><thead><tr><th>Producto</th><th>Categoría</th><th>Marca</th><th>Ubicación</th><th>Stock</th><th>Estado</th></tr></thead><tbody>
                <tr th:each="item : ${items}"><td><span class="mov-icon prod-icon almacen-producto-icon"><i class="fa-solid fa-box"></i></span><span class="mov-info"><strong th:text="${item.nombre}">Producto</strong><small th:text="${item.codigo} + ' · Código de producto'"></small></span></td><td th:text="${item.categoria}">Categoría</td><td th:text="${item.marca}">Marca</td><td><span class="ubicacion-tabla"><i class="fa-solid fa-location-dot"></i><span th:text="${item.ubicacion}">A-01</span></span></td><td class="almacen-stock" th:text="${item.stock} + ' unidades'"></td><td><span class="estado" th:classappend="${item.estadoClase}" th:text="${item.estado}">Estado</span></td></tr>
                <tr th:if="${lists.isEmpty(items)}"><td colspan="6" class="almacen-vacio">No se encontraron productos con esos filtros.</td></tr>
            </tbody></table></div>
            <p class="nota-demo"><i class="fa-solid fa-circle-info"></i> Existencias de muestra. Los datos del inventario actual no se modifican desde esta vista.</p>
        </section>
    </main>
</div>
</body>
</html>




