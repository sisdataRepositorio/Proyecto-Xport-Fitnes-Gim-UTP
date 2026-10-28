
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
    <title>Productos | Xport Fitness Gym</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/diseingreso.css">
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/gastos.css">
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/productos-dashboard.css">
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/menu.css">
    
    <style>
        .foto-producto-avatar {
            border-radius: 12px !important;
            background-color: #f1f5f9 !important;
            border: 2px dashed #cbd5e1 !important;
            color: #94a3b8;
        }

        .tabla-productos-registro {
            overflow-x: auto;
        }

        .nota-productos {
            margin-bottom: 20px;
        }
    </style>

</head>

<body>
<div class="dashboard-container">

     <jsp:include page="/WEB-INF/vistas/menuLateral.jsp">
        <jsp:param name="opcion" value="listarProductos"/>
        <jsp:param name="submenu" value="catalogo"/>
    </jsp:include>
    
    <!-- CONTENIDO PRINCIPAL -->
    <main class="gastos-main productos-main">

        <header class="gastos-header">
            <div>
                <p class="gastos-eyebrow">CONTROL DE INVENTARIO</p>
                <h1>Dashboard de productos</h1>
                <p class="gastos-subtitle">
                    Revisa el catálogo, las categorías y la disponibilidad
                    de tu inventario.
                </p>
            </div>

            <a class="periodo productos-nuevo"
                href="${pageContext.request.contextPath}/RegistrarProducto.jsp">
                 <i class="fa-solid fa-plus"></i>
                 <span>Registrar producto</span>
            </a>
        </header>

        <!-- RESUMEN -->
        <section class="resumen-grid" aria-label="Resumen de productos">

            <article class="resumen-card productos-card-total">
                <div class="resumen-icon">
                    <i class="fa-solid fa-boxes-stacked"></i>
                </div>
                <p class="resumen-label">Productos registrados</p>
                <p class="resumen-value" id="metric-total">8</p>
                <span class="resumen-foot">
                    <i class="fa-solid fa-layer-group"></i>
                    En el catálogo
                </span>
            </article>

            <article class="resumen-card productos-card-stock">
                <div class="resumen-icon">
                    <i class="fa-solid fa-cubes-stacked"></i>
                </div>
                <p class="resumen-label">Unidades disponibles</p>
                <p class="resumen-value" id="metric-stock">168</p>
                <span class="resumen-foot">
                    <i class="fa-solid fa-circle-check"></i>
                    Stock total actual
                </span>
            </article>

            <article class="resumen-card productos-card-agotados">
                <div class="resumen-icon">
                    <i class="fa-solid fa-triangle-exclamation"></i>
                </div>
                <p class="resumen-label">Productos agotados</p>
                <p class="resumen-value" id="metric-agotados">2</p>
                <span class="resumen-foot">
                    <i class="fa-solid fa-arrow-rotate-right"></i>
                    Requieren reposición
                </span>
            </article>

        </section>

        <!-- ANÁLISIS -->
        <section class="analisis-grid productos-analisis">

            <article class="contenido-card categorias-card">
                <div class="card-heading">
                    <div>
                        <h2>Productos por categoría</h2>
                        <p>Distribución del catálogo</p>
                    </div>
                    <i class="fa-solid fa-chart-pie heading-icon"></i>
                </div>

                <div class="categorias-contenido">
                    <div class="donut-wrap">
                        <div class="donut-chart productos-donut">
                            <div class="donut-hole">
                                <strong>8</strong>
                                <span>Productos</span>
                            </div>
                        </div>
                    </div>

                    <ul class="leyenda-categorias">
                        <li>
                            <span class="leyenda-nombre">
                                <i class="dot dot-personal"></i>Suplementos
                            </span>
                            <strong>3 <small>38%</small></strong>
                        </li>
                        <li>
                            <span class="leyenda-nombre">
                                <i class="dot dot-alquiler"></i>Accesorios
                            </span>
                            <strong>2 <small>25%</small></strong>
                        </li>
                        <li>
                            <span class="leyenda-nombre">
                                <i class="dot dot-servicios"></i>Ropa deportiva
                            </span>
                            <strong>2 <small>25%</small></strong>
                        </li>
                        <li>
                            <span class="leyenda-nombre">
                                <i class="dot dot-equipos"></i>Bebidas
                            </span>
                            <strong>1 <small>12%</small></strong>
                        </li>
                    </ul>
                </div>
            </article>

            <article class="contenido-card comparativo-card">
                <div class="card-heading">
                    <div>
                        <h2>Estado del inventario</h2>
                        <p>Disponibilidad y nivel de reposición</p>
                    </div>
                    <i class="fa-solid fa-chart-column heading-icon"></i>
                </div>

                <div class="barras-categorias">
                    <div class="barra-item">
                        <div class="barra-meta">
                            <span>Disponibles</span>
                            <strong>5 productos</strong>
                        </div>
                        <div class="barra-fondo">
                            <span class="barra barra-disponible"></span>
                        </div>
                    </div>

                    <div class="barra-item">
                        <div class="barra-meta">
                            <span>Stock bajo <small>(1–5 unidades)</small></span>
                            <strong>1 producto</strong>
                        </div>
                        <div class="barra-fondo">
                            <span class="barra barra-bajo"></span>
                        </div>
                    </div>

                    <div class="barra-item">
                        <div class="barra-meta">
                            <span>Agotados</span>
                            <strong>2 productos</strong>
                        </div>
                        <div class="barra-fondo">
                            <span class="barra barra-agotado"></span>
                        </div>
                    </div>
                </div>
            </article>

        </section>

        <!-- LISTADO DE PRODUCTOS -->
        <section class="contenido-card movimientos-card productos-listado">

            <div class="card-heading movimientos-heading">
                <div>
                    <h2>Lista de productos</h2>
                    <p>Busca, filtra y administra los productos registrados</p>
                </div>
                <span class="movimientos-count" id="result-count">8 productos</span>
            </div>

            <div class="productos-toolbar">
                <label class="busqueda-productos">
                    <i class="fa-solid fa-magnifying-glass"></i>
                    <input id="product-search" type="search"
                           placeholder="Buscar por nombre o código..."
                           aria-label="Buscar productos">
                </label>

                <label class="filtro-productos">
                    <i class="fa-solid fa-filter"></i>
                    <select id="category-filter" aria-label="Filtrar por categoría">
                        <option value="">Todas las categorías</option>
                        <option>Suplementos</option>
                        <option>Accesorios</option>
                        <option>Ropa deportiva</option>
                        <option>Bebidas</option>
                    </select>
                </label>

                <label class="filtro-productos">
                    <i class="fa-solid fa-boxes-stacked"></i>
                    <select id="stock-filter" aria-label="Filtrar por stock">
                        <option value="">Todos los estados</option>
                        <option value="disponible">Disponible</option>
                        <option value="bajo">Stock bajo</option>
                        <option value="agotado">Agotado</option>
                    </select>
                </label>
            </div>

            <div class="tabla-scroll">
                <table class="tabla-movimientos tabla-productos">
                    <thead>
                        <tr>
                            <th>Producto</th>
                            <th>Categoría</th>
                            <th>Precio</th>
                            <th>Stock</th>
                            <th>Estado</th>
                            <th class="acciones-col">Acciones</th>
                        </tr>
                    </thead>

                    <tbody id="product-rows">

                        <tr data-name="proteina whey 2lb chocolate"
                            data-code="prod-001" data-category="Suplementos"
                            data-stock="15">
                            <td>
                                <span class="mov-icon prod-icon prod-suplemento">
                                    <i class="fa-solid fa-bottle-water"></i>
                                </span>
                                <span class="mov-info">
                                    <strong>Proteína Whey 2lb Chocolate</strong>
                                    <small>PROD-001 · Código de producto</small>
                                </span>
                            </td>
                            <td>Suplementos</td>
                            <td class="precio-producto">S/ 120.00</td>
                            <td>15 unidades</td>
                            <td><span class="estado estado-completado">Disponible</span></td>
                            <td class="acciones">
                                <button type="button" class="accion-btn editar-btn"
                                        title="Editar producto">
                                    <i class="fa-solid fa-pen"></i>
                                </button>
                                <button type="button" class="accion-btn reponer-btn"
                                        title="Registrar reposición">
                                    <i class="fa-solid fa-boxes-stacked"></i>
                                </button>
                                <button type="button" class="accion-btn eliminar-btn"
                                        title="Quitar de la lista">
                                    <i class="fa-solid fa-trash"></i>
                                </button>
                            </td>
                        </tr>

                        <tr data-name="shaker xport azul" data-code="prod-002"
                            data-category="Accesorios" data-stock="40">
                            <td>
                                <span class="mov-icon prod-icon prod-accesorio">
                                    <i class="fa-solid fa-glass-water"></i>
                                </span>
                                <span class="mov-info">
                                    <strong>Shaker Xport Azul</strong>
                                    <small>PROD-002 · Código de producto</small>
                                </span>
                            </td>
                            <td>Accesorios</td>
                            <td class="precio-producto">S/ 25.00</td>
                            <td>40 unidades</td>
                            <td><span class="estado estado-completado">Disponible</span></td>
                            <td class="acciones">
                                <button type="button" class="accion-btn editar-btn" title="Editar producto"><i class="fa-solid fa-pen"></i></button>
                                <button type="button" class="accion-btn reponer-btn" title="Registrar reposición"><i class="fa-solid fa-boxes-stacked"></i></button>
                                <button type="button" class="accion-btn eliminar-btn" title="Quitar de la lista"><i class="fa-solid fa-trash"></i></button>
                            </td>
                        </tr>

                        <tr data-name="polera oversize negra" data-code="prod-003"
                            data-category="Ropa deportiva" data-stock="0">
                            <td>
                                <span class="mov-icon prod-icon prod-ropa">
                                    <i class="fa-solid fa-shirt"></i>
                                </span>
                                <span class="mov-info">
                                    <strong>Polera Oversize Negra</strong>
                                    <small>PROD-003 · Código de producto</small>
                                </span>
                            </td>
                            <td>Ropa deportiva</td>
                            <td class="precio-producto">S/ 65.00</td>
                            <td>0 unidades</td>
                            <td><span class="estado estado-agotado">Agotado</span></td>
                            <td class="acciones">
                                <button type="button" class="accion-btn editar-btn" title="Editar producto"><i class="fa-solid fa-pen"></i></button>
                                <button type="button" class="accion-btn reponer-btn" title="Registrar reposición"><i class="fa-solid fa-boxes-stacked"></i></button>
                                <button type="button" class="accion-btn eliminar-btn" title="Quitar de la lista"><i class="fa-solid fa-trash"></i></button>
                            </td>
                        </tr>

                        <tr data-name="creatina monohidratada" data-code="prod-004"
                            data-category="Suplementos" data-stock="8">
                            <td>
                                <span class="mov-icon prod-icon prod-suplemento">
                                    <i class="fa-solid fa-jar"></i>
                                </span>
                                <span class="mov-info">
                                    <strong>Creatina Monohidratada</strong>
                                    <small>PROD-004 · Código de producto</small>
                                </span>
                            </td>
                            <td>Suplementos</td>
                            <td class="precio-producto">S/ 89.90</td>
                            <td>8 unidades</td>
                            <td><span class="estado estado-completado">Disponible</span></td>
                            <td class="acciones">
                                <button type="button" class="accion-btn editar-btn" title="Editar producto"><i class="fa-solid fa-pen"></i></button>
                                <button type="button" class="accion-btn reponer-btn" title="Registrar reposición"><i class="fa-solid fa-boxes-stacked"></i></button>
                                <button type="button" class="accion-btn eliminar-btn" title="Quitar de la lista"><i class="fa-solid fa-trash"></i></button>
                            </td>
                        </tr>

                        <tr data-name="guantes entrenamiento" data-code="prod-005"
                            data-category="Accesorios" data-stock="3">
                            <td>
                                <span class="mov-icon prod-icon prod-accesorio">
                                    <i class="fa-solid fa-mitten"></i>
                                </span>
                                <span class="mov-info">
                                    <strong>Guantes de Entrenamiento</strong>
                                    <small>PROD-005 · Código de producto</small>
                                </span>
                            </td>
                            <td>Accesorios</td>
                            <td class="precio-producto">S/ 39.90</td>
                            <td>3 unidades</td>
                            <td><span class="estado estado-bajo">Stock bajo</span></td>
                            <td class="acciones">
                                <button type="button" class="accion-btn editar-btn" title="Editar producto"><i class="fa-solid fa-pen"></i></button>
                                <button type="button" class="accion-btn reponer-btn" title="Registrar reposición"><i class="fa-solid fa-boxes-stacked"></i></button>
                                <button type="button" class="accion-btn eliminar-btn" title="Quitar de la lista"><i class="fa-solid fa-trash"></i></button>
                            </td>
                        </tr>

                        <tr data-name="polera oversize gris" data-code="prod-006"
                            data-category="Ropa deportiva" data-stock="12">
                            <td>
                                <span class="mov-icon prod-icon prod-ropa">
                                    <i class="fa-solid fa-shirt"></i>
                                </span>
                                <span class="mov-info">
                                    <strong>Polera Oversize Gris</strong>
                                    <small>PROD-006 · Código de producto</small>
                                </span>
                            </td>
                            <td>Ropa deportiva</td>
                            <td class="precio-producto">S/ 65.00</td>
                            <td>12 unidades</td>
                            <td><span class="estado estado-completado">Disponible</span></td>
                            <td class="acciones">
                                <button type="button" class="accion-btn editar-btn" title="Editar producto"><i class="fa-solid fa-pen"></i></button>
                                <button type="button" class="accion-btn reponer-btn" title="Registrar reposición"><i class="fa-solid fa-boxes-stacked"></i></button>
                                <button type="button" class="accion-btn eliminar-btn" title="Quitar de la lista"><i class="fa-solid fa-trash"></i></button>
                            </td>
                        </tr>

                        <tr data-name="agua mineral xport" data-code="prod-007"
                            data-category="Bebidas" data-stock="0">
                            <td>
                                <span class="mov-icon prod-icon prod-bebida">
                                    <i class="fa-solid fa-bottle-water"></i>
                                </span>
                                <span class="mov-info">
                                    <strong>Agua Mineral Xport</strong>
                                    <small>PROD-007 · Código de producto</small>
                                </span>
                            </td>
                            <td>Bebidas</td>
                            <td class="precio-producto">S/ 3.00</td>
                            <td>0 unidades</td>
                            <td><span class="estado estado-agotado">Agotado</span></td>
                            <td class="acciones">
                                <button type="button" class="accion-btn editar-btn" title="Editar producto"><i class="fa-solid fa-pen"></i></button>
                                <button type="button" class="accion-btn reponer-btn" title="Registrar reposición"><i class="fa-solid fa-boxes-stacked"></i></button>
                                <button type="button" class="accion-btn eliminar-btn" title="Quitar de la lista"><i class="fa-solid fa-trash"></i></button>
                            </td>
                        </tr>

                        <tr data-name="proteina whey 5lb vainilla" data-code="prod-008"
                            data-category="Suplementos" data-stock="90">
                            <td>
                                <span class="mov-icon prod-icon prod-suplemento">
                                    <i class="fa-solid fa-bottle-water"></i>
                                </span>
                                <span class="mov-info">
                                    <strong>Proteína Whey 5lb Vainilla</strong>
                                    <small>PROD-008 · Código de producto</small>
                                </span>
                            </td>
                            <td>Suplementos</td>
                            <td class="precio-producto">S/ 245.00</td>
                            <td>90 unidades</td>
                            <td><span class="estado estado-completado">Disponible</span></td>
                            <td class="acciones">
                                <button type="button" class="accion-btn editar-btn" title="Editar producto"><i class="fa-solid fa-pen"></i></button>
                                <button type="button" class="accion-btn reponer-btn" title="Registrar reposición"><i class="fa-solid fa-boxes-stacked"></i></button>
                                <button type="button" class="accion-btn eliminar-btn" title="Quitar de la lista"><i class="fa-solid fa-trash"></i></button>
                            </td>
                        </tr>

                    </tbody>
                </table>

                <p class="sin-resultados" id="empty-state" hidden>
                    No se encontraron productos con esos filtros.
                </p>
            </div>

            <p class="nota-demo">
                <i class="fa-solid fa-circle-info"></i>
                Datos de muestra para el dashboard.
            </p>
        </section>

    </main>
</div>

<script src="${pageContext.request.contextPath}/js/diseingreso.js"></script>
<script src="${pageContext.request.contextPath}/js/productos-dashboard.js"></script>
<script src="${pageContext.request.contextPath}/js/menu.js"></script>
</body>
</html>
