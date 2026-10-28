
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

    <title>Almacén | Xport Fitness Gym</title>

    <!-- ESTILOS DEL PROYECTO -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/diseingreso.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/gastos.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/productos-dashboard.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/almacen.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/catalogo.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/menu.css">

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">

    <style>
        /* CONTENIDO PRINCIPAL */

        .almacen-main {
            min-width: 0;
        }

        .almacen-header {
            margin-bottom: 24px;
        }

        .almacen-volver {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 9px;
            white-space: nowrap;
            text-decoration: none;
        }

        /* TARJETAS DE RESUMEN */

        .almacen-resumen .resumen-value {
            font-variant-numeric: tabular-nums;
        }

        .almacen-card-unidades .resumen-icon {
            color: #2864F0;
            background: #EAF0FF;
        }

        .almacen-card-alerta .resumen-icon {
            color: #D97706;
            background: #FFF4DF;
        }

        /* BARRAS DE EXISTENCIAS */

        .almacen-alertas {
            margin-bottom: 24px;
        }

        .almacen-barras {
            display: flex;
            flex-direction: column;
            gap: 21px;
            padding: 20px 22px 24px;
        }

        .almacen-barra-item {
            min-width: 0;
        }

        .almacen-barra-meta {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 8px;
            margin-bottom: 9px;
            color: #41516B;
            font-size: 12px;
        }

        .almacen-barra-meta strong {
            color: #10234D;
            font-size: 12px;
        }

        .almacen-barra-fondo {
            width: 100%;
            height: 9px;
            overflow: hidden;
            border-radius: 20px;
            background: #EDF1F7;
        }

        .almacen-barra {
            display: block;
            height: 100%;
            width: 0;
            border-radius: inherit;
            transition: width .3s ease;
        }

        .almacen-barra-disponible {
            background: #18BD70;
        }

        .almacen-barra-bajo {
            background: #F0AD38;
        }

        .almacen-barra-agotado {
            background: #E35454;
        }

        .almacen-resumen-alerta {
            padding: 0 22px 20px;
            color: #75829A;
            font-size: 11px;
        }

        /* UBICACIONES */

        .almacen-ubicaciones {
            display: flex;
            flex-direction: column;
            gap: 16px;
            padding: 20px 22px 24px;
        }

        .almacen-ubicacion {
            display: flex;
            align-items: center;
            gap: 13px;
        }

        .ubicacion-chip {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
            width: 40px;
            height: 40px;
            border-radius: 10px;
            background: #EAF0FF;
            color: #2864F0;
            font-size: 15px;
            font-weight: 800;
        }

        .ubicacion-chip.verde {
            background: #E5F9EF;
            color: #168653;
        }

        .ubicacion-chip.morado {
            background: #F1EAFE;
            color: #7950C9;
        }

        .almacen-ubicacion strong {
            display: block;
            margin-bottom: 5px;
            color: #10234D;
            font-size: 12px;
        }

        .almacen-ubicacion small {
            display: block;
            color: #75829A;
            font-size: 11px;
        }

        /* BÚSQUEDA Y FILTROS */

        .almacen-toolbar {
            display: flex;
            flex-wrap: wrap;
            align-items: center;
            gap: 10px;
            padding: 0 22px 20px;
        }

        .almacen-toolbar .busqueda-productos {
            flex: 1 1 320px;
            min-width: 180px;
        }

        .almacen-filtro {
            display: flex;
            align-items: center;
            gap: 9px;
            min-width: 180px;
            padding: 0 12px;
            border: 1px solid #D2DCEC;
            border-radius: 8px;
            background: #FFFFFF;
            color: #75829A;
        }

        .almacen-filtro select {
            width: 100%;
            min-height: 42px;
            border: none;
            outline: none;
            background: transparent;
            color: #41516B;
            font: inherit;
            font-size: 12px;
            cursor: pointer;
        }

        .almacen-buscar,
        .almacen-limpiar {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            min-height: 42px;
            padding: 11px 17px;
            border: none;
            border-radius: 8px;
            font-size: 12px;
            font-weight: 700;
            text-decoration: none;
            cursor: pointer;
        }

        .almacen-buscar {
            background: #2864F0;
            color: white;
        }

        .almacen-buscar:hover {
            background: #174CC5;
        }

        .almacen-limpiar {
            background: #EDF1F7;
            color: #34435E;
        }

        .almacen-limpiar:hover {
            background: #DDE5F0;
        }

        /* TABLA */

        .almacen-tabla {
            width: 100%;
            min-width: 850px;
        }

        .almacen-tabla td {
            vertical-align: middle;
        }

        .almacen-producto {
            display: flex;
            align-items: center;
            gap: 11px;
            min-width: 180px;
        }

        .almacen-producto-icon {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
            width: 37px;
            height: 37px;
            border-radius: 9px;
            background: #EAF0FF;
            color: #2864F0;
        }

        .almacen-producto-info strong {
            display: block;
            margin-bottom: 5px;
            color: #10234D;
            font-size: 12px;
        }

        .almacen-producto-info small {
            display: block;
            color: #75829A;
            font-size: 10px;
        }

        .ubicacion-tabla {
            display: inline-flex;
            align-items: center;
            gap: 7px;
            white-space: nowrap;
            color: #41516B;
            font-size: 12px;
        }

        .ubicacion-tabla i {
            color: #2864F0;
        }

        .almacen-stock {
            color: #10234D;
            font-weight: 700;
            white-space: nowrap;
        }

        .almacen-stock.alerta {
            color: #B77908;
        }

        .almacen-stock.agotado {
            color: #C62828;
        }

        .almacen-estado {
            display: inline-flex;
            align-items: center;
            gap: 7px;
            white-space: nowrap;
            font-size: 11px;
            font-weight: 700;
        }

        .almacen-estado::before {
            display: inline-block;
            width: 7px;
            height: 7px;
            border-radius: 50%;
            background: currentColor;
            content: "";
        }

        .almacen-estado.disponible {
            color: #168653;
        }

        .almacen-estado.bajo {
            color: #B77908;
        }

        .almacen-estado.agotado {
            color: #C62828;
        }

        .almacen-vacio {
            padding: 30px !important;
            text-align: center;
            color: #75829A !important;
        }

        .almacen-nota {
            margin: 18px 22px 20px;
            color: #75829A;
            font-size: 11px;
            line-height: 1.6;
        }

        .almacen-nota i {
            margin-right: 5px;
        }

        @media (max-width: 760px) {
            .almacen-toolbar {
                padding-right: 16px;
                padding-left: 16px;
            }

            .almacen-toolbar .busqueda-productos,
            .almacen-filtro {
                flex-basis: 100%;
                width: 100%;
            }

            .almacen-buscar,
            .almacen-limpiar {
                flex: 1;
            }

            .almacen-barras,
            .almacen-ubicaciones {
                padding-right: 16px;
                padding-left: 16px;
            }
        }
    </style>
</head>

<body>

<div class="dashboard-container">

    <!-- MENÚ LATERAL COMPARTIDO -->
    <jsp:include page="/WEB-INF/vistas/menuLateral.jsp">
        <jsp:param name="opcion" value="almacen"/>
        <jsp:param name="submenu" value=""/>
    </jsp:include>

    <!-- CONTENIDO PRINCIPAL -->
    <main class="gastos-main almacen-main">

        <!-- CABECERA -->
        <header class="gastos-header almacen-header">
            <div>
                <p class="gastos-eyebrow">CONTROL DE INVENTARIO</p>

                <h1>Almacén</h1>

                <p class="gastos-subtitle">
                    Consulta las existencias, ubicaciones y alertas de reposición.
                </p>
            </div>

            <a class="periodo almacen-volver"
               href="${pageContext.request.contextPath}/Productos.jsp">
                <i class="fa-solid fa-box"></i>
                <span>Ver productos</span>
            </a>
        </header>

        <!-- TARJETAS DE RESUMEN -->
        <section class="resumen-grid almacen-resumen"
                 aria-label="Resumen del almacén">

            <article class="resumen-card">
                <div class="resumen-icon">
                    <i class="fa-solid fa-boxes-stacked"></i>
                </div>

                <p class="resumen-label">Productos registrados</p>
                <p class="resumen-value" id="totalProductos">0</p>

                <span class="resumen-foot">
                    <i class="fa-solid fa-layer-group"></i>
                    En el inventario
                </span>
            </article>

            <article class="resumen-card almacen-card-unidades">
                <div class="resumen-icon">
                    <i class="fa-solid fa-cubes-stacked"></i>
                </div>

                <p class="resumen-label">Unidades disponibles</p>
                <p class="resumen-value" id="unidadesDisponibles">0</p>

                <span class="resumen-foot">
                    <i class="fa-solid fa-circle-check"></i>
                    Stock total actual
                </span>
            </article>

            <article class="resumen-card almacen-card-alerta">
                <div class="resumen-icon">
                    <i class="fa-solid fa-triangle-exclamation"></i>
                </div>

                <p class="resumen-label">Requieren reposición</p>
                <p class="resumen-value" id="totalReposicion">0</p>

                <span class="resumen-foot">
                    <i class="fa-solid fa-arrow-rotate-right"></i>
                    Bajo stock o agotados
                </span>
            </article>

        </section>

        <!-- ESTADO Y UBICACIONES -->
        <section class="analisis-grid almacen-alertas"
                 aria-label="Estado de existencias">

            <!-- ESTADO DE EXISTENCIAS -->
            <article class="contenido-card">
                <div class="card-heading">
                    <div>
                        <h2>Estado de existencias</h2>
                        <p>Productos que requieren atención</p>
                    </div>

                    <i class="fa-solid fa-chart-column heading-icon"></i>
                </div>

                <div class="almacen-barras">

                    <div class="almacen-barra-item">
                        <div class="almacen-barra-meta">
                            <span>Disponibles</span>
                            <strong id="cantidadDisponibles">0 productos</strong>
                        </div>

                        <div class="almacen-barra-fondo">
                            <span class="almacen-barra almacen-barra-disponible"
                                  id="barraDisponible"></span>
                        </div>
                    </div>

                    <div class="almacen-barra-item">
                        <div class="almacen-barra-meta">
                            <span>Stock bajo</span>
                            <strong id="cantidadStockBajo">0 productos</strong>
                        </div>

                        <div class="almacen-barra-fondo">
                            <span class="almacen-barra almacen-barra-bajo"
                                  id="barraStockBajo"></span>
                        </div>
                    </div>

                    <div class="almacen-barra-item">
                        <div class="almacen-barra-meta">
                            <span>Agotados</span>
                            <strong id="cantidadAgotados">0 productos</strong>
                        </div>

                        <div class="almacen-barra-fondo">
                            <span class="almacen-barra almacen-barra-agotado"
                                  id="barraAgotados"></span>
                        </div>
                    </div>

                </div>

                <p class="almacen-resumen-alerta">
                    Se considera stock bajo cuando quedan 5 unidades o menos,
                    siempre que el producto no esté agotado.
                </p>
            </article>

            <!-- UBICACIONES DEL ALMACÉN -->
            <article class="contenido-card almacen-nota-card">
                <div class="card-heading">
                    <div>
                        <h2>Ubicaciones</h2>
                        <p>Organización del almacén</p>
                    </div>

                    <i class="fa-solid fa-warehouse heading-icon"></i>
                </div>

                <div class="almacen-ubicaciones">

                    <div class="almacen-ubicacion">
                        <span class="ubicacion-chip">A</span>

                        <span>
                            <strong>Suplementos</strong>
                            <small>Estantes A-01 a A-03</small>
                        </span>
                    </div>

                    <div class="almacen-ubicacion">
                        <span class="ubicacion-chip verde">B</span>

                        <span>
                            <strong>Accesorios</strong>
                            <small>Estantes B-01 a B-02</small>
                        </span>
                    </div>

                    <div class="almacen-ubicacion">
                        <span class="ubicacion-chip morado">C</span>

                        <span>
                            <strong>Ropa deportiva</strong>
                            <small>Estantes C-01 a C-02</small>
                        </span>
                    </div>

                </div>
            </article>

        </section>

        <!-- INVENTARIO -->
        <section class="contenido-card almacen-listado">

            <div class="card-heading movimientos-heading">
                <div>
                    <h2>Inventario del almacén</h2>
                    <p>Busca productos y revisa su ubicación y nivel de stock.</p>
                </div>

                <span class="movimientos-count" id="cantidadResultados">
                    0 resultados
                </span>
            </div>

            <!-- BÚSQUEDA Y FILTROS -->
            <div class="productos-toolbar almacen-toolbar">

                <label class="busqueda-productos">
                    <i class="fa-solid fa-magnifying-glass"></i>

                    <input type="search"
                           id="buscarAlmacen"
                           placeholder="Buscar por producto, código o ubicación..."
                           aria-label="Buscar en almacén">
                </label>

                <label class="almacen-filtro">
                    <i class="fa-solid fa-filter"></i>

                    <select id="filtroEstado"
                            aria-label="Filtrar por estado">

                        <option value="">Todos los estados</option>
                        <option value="disponible">Disponible</option>
                        <option value="bajo">Stock bajo</option>
                        <option value="agotado">Agotado</option>
                    </select>
                </label>

                <button class="almacen-buscar"
                        id="btnBuscarAlmacen"
                        type="button">
                    <i class="fa-solid fa-magnifying-glass"></i>
                    Buscar
                </button>

                <button class="almacen-limpiar"
                        id="btnLimpiarAlmacen"
                        type="button">
                    <i class="fa-solid fa-eraser"></i>
                    Limpiar
                </button>

            </div>

            <!-- TABLA -->
            <div class="tabla-scroll">

                <table class="tabla-movimientos tabla-productos almacen-tabla">

                    <thead>
                        <tr>
                            <th>Producto</th>
                            <th>Categoría</th>
                            <th>Marca</th>
                            <th>Ubicación</th>
                            <th>Stock</th>
                            <th>Estado</th>
                        </tr>
                    </thead>

                    <tbody id="filasAlmacen">
                        <!-- Las filas se generan con JavaScript. -->
                    </tbody>

                </table>

                <p id="almacenSinResultados"
                   class="almacen-vacio"
                   hidden>
                    No se encontraron productos con esos filtros.
                </p>

            </div>

            <p class="almacen-nota">
                <i class="fa-solid fa-circle-info"></i>
                Existencias de demostración. Esta vista es únicamente de consulta:
                los datos no se guardan ni modifican en SQL Server.
            </p>

        </section>

    </main>

</div>

<!-- MENÚ LATERAL -->
<script src="${pageContext.request.contextPath}/js/menu.js"></script>

<!-- LÓGICA DE DEMOSTRACIÓN -->
<script>
document.addEventListener("DOMContentLoaded", function () {

    const filas = document.getElementById("filasAlmacen");
    const busqueda = document.getElementById("buscarAlmacen");
    const filtroEstado = document.getElementById("filtroEstado");

    const totalProductos = document.getElementById("totalProductos");
    const unidadesDisponibles = document.getElementById("unidadesDisponibles");
    const totalReposicion = document.getElementById("totalReposicion");

    const cantidadDisponibles = document.getElementById("cantidadDisponibles");
    const cantidadStockBajo = document.getElementById("cantidadStockBajo");
    const cantidadAgotados = document.getElementById("cantidadAgotados");

    const barraDisponible = document.getElementById("barraDisponible");
    const barraStockBajo = document.getElementById("barraStockBajo");
    const barraAgotados = document.getElementById("barraAgotados");

    const cantidadResultados = document.getElementById("cantidadResultados");
    const sinResultados = document.getElementById("almacenSinResultados");

    /*
     * Datos de demostración.
     * El stock mínimo para esta vista se establece en 5 unidades.
     */
    const inventarioDemo = [
        {
            codigo: "PRO-001",
            nombre: "Proteína Whey",
            categoria: "Suplementos",
            marca: "Optimum Nutrition",
            ubicacion: "A-01",
            stock: 18
        },
        {
            codigo: "PRO-002",
            nombre: "Creatina Monohidratada",
            categoria: "Suplementos",
            marca: "Universal Nutrition",
            ubicacion: "A-02",
            stock: 12
        },
        {
            codigo: "PRO-003",
            nombre: "Multivitamínico",
            categoria: "Suplementos",
            marca: "Universal Nutrition",
            ubicacion: "A-03",
            stock: 4
        },
        {
            codigo: "PRO-004",
            nombre: "Guantes de entrenamiento",
            categoria: "Accesorios",
            marca: "Everlast",
            ubicacion: "B-01",
            stock: 8
        },
        {
            codigo: "PRO-005",
            nombre: "Botella deportiva",
            categoria: "Accesorios",
            marca: "Adidas",
            ubicacion: "B-02",
            stock: 0
        },
        {
            codigo: "PRO-006",
            nombre: "Polo deportivo",
            categoria: "Ropa deportiva",
            marca: "Nike",
            ubicacion: "C-01",
            stock: 20
        },
        {
            codigo: "PRO-007",
            nombre: "Short deportivo",
            categoria: "Ropa deportiva",
            marca: "Puma",
            ubicacion: "C-02",
            stock: 3
        },
        {
            codigo: "PRO-008",
            nombre: "Barra de proteína",
            categoria: "Suplementos",
            marca: "Universal Nutrition",
            ubicacion: "A-02",
            stock: 0
        }
    ];

    function obtenerEstado(producto) {
        if (producto.stock === 0) {
            return "agotado";
        }

        if (producto.stock <= 5) {
            return "bajo";
        }

        return "disponible";
    }

    function crearCelda(texto, clase) {
        const celda = document.createElement("td");

        if (clase) {
            celda.className = clase;
        }

        celda.textContent = texto || "—";

        return celda;
    }

    function crearCeldaProducto(producto) {
        const celda = document.createElement("td");

        const contenedor = document.createElement("div");
        contenedor.className = "almacen-producto";

        const icono = document.createElement("span");
        icono.className = "almacen-producto-icon";

        const iconoCaja = document.createElement("i");
        iconoCaja.className = "fa-solid fa-box";

        icono.appendChild(iconoCaja);

        const informacion = document.createElement("span");
        informacion.className = "almacen-producto-info";

        const nombre = document.createElement("strong");
        nombre.textContent = producto.nombre;

        const codigo = document.createElement("small");
        codigo.textContent = producto.codigo + " · Código de producto";

        informacion.appendChild(nombre);
        informacion.appendChild(codigo);

        contenedor.appendChild(icono);
        contenedor.appendChild(informacion);

        celda.appendChild(contenedor);

        return celda;
    }

    function crearCeldaUbicacion(producto) {
        const celda = document.createElement("td");

        const ubicacion = document.createElement("span");
        ubicacion.className = "ubicacion-tabla";

        const icono = document.createElement("i");
        icono.className = "fa-solid fa-location-dot";

        const texto = document.createElement("span");
        texto.textContent = producto.ubicacion;

        ubicacion.appendChild(icono);
        ubicacion.appendChild(texto);

        celda.appendChild(ubicacion);

        return celda;
    }

    function crearCeldaStock(producto) {
        const celda = document.createElement("td");
        const estado = obtenerEstado(producto);

        celda.className = "almacen-stock";
        celda.textContent = producto.stock + " unidades";

        if (estado === "bajo") {
            celda.classList.add("alerta");
        } else if (estado === "agotado") {
            celda.classList.add("agotado");
        }

        return celda;
    }

    function crearCeldaEstado(producto) {
        const celda = document.createElement("td");

        const estado = obtenerEstado(producto);

        const etiqueta = document.createElement("span");
        etiqueta.className = "almacen-estado " + estado;

        if (estado === "disponible") {
            etiqueta.textContent = "Disponible";
        } else if (estado === "bajo") {
            etiqueta.textContent = "Stock bajo";
        } else {
            etiqueta.textContent = "Agotado";
        }

        celda.appendChild(etiqueta);

        return celda;
    }

    function crearFila(producto) {
        const fila = document.createElement("tr");

        fila.appendChild(crearCeldaProducto(producto));
        fila.appendChild(crearCelda(producto.categoria));
        fila.appendChild(crearCelda(producto.marca));
        fila.appendChild(crearCeldaUbicacion(producto));
        fila.appendChild(crearCeldaStock(producto));
        fila.appendChild(crearCeldaEstado(producto));

        return fila;
    }

    function actualizarResumen() {
        const total = inventarioDemo.length;

        let unidades = 0;
        let disponibles = 0;
        let bajo = 0;
        let agotados = 0;

        inventarioDemo.forEach(function (producto) {
            unidades += producto.stock;

            const estado = obtenerEstado(producto);

            if (estado === "disponible") {
                disponibles++;
            } else if (estado === "bajo") {
                bajo++;
            } else {
                agotados++;
            }
        });

        totalProductos.textContent = total;
        unidadesDisponibles.textContent = unidades;
        totalReposicion.textContent = bajo + agotados;

        cantidadDisponibles.textContent =
            disponibles + (disponibles === 1 ? " producto" : " productos");

        cantidadStockBajo.textContent =
            bajo + (bajo === 1 ? " producto" : " productos");

        cantidadAgotados.textContent =
            agotados + (agotados === 1 ? " producto" : " productos");

        const porcentajeDisponible = total ? (disponibles / total) * 100 : 0;
        const porcentajeBajo = total ? (bajo / total) * 100 : 0;
        const porcentajeAgotado = total ? (agotados / total) * 100 : 0;

        barraDisponible.style.width = porcentajeDisponible + "%";
        barraStockBajo.style.width = porcentajeBajo + "%";
        barraAgotados.style.width = porcentajeAgotado + "%";
    }

    function renderizarInventario() {
        const texto = busqueda.value.trim().toLocaleLowerCase("es");
        const estadoSeleccionado = filtroEstado.value;

        const filtrados = inventarioDemo.filter(function (producto) {
            const contenido = [
                producto.nombre,
                producto.codigo,
                producto.categoria,
                producto.marca,
                producto.ubicacion
            ].join(" ").toLocaleLowerCase("es");

            const coincideTexto = contenido.includes(texto);
            const coincideEstado = !estadoSeleccionado
                || obtenerEstado(producto) === estadoSeleccionado;

            return coincideTexto && coincideEstado;
        });

        filas.replaceChildren();

        filtrados.forEach(function (producto) {
            filas.appendChild(crearFila(producto));
        });

        cantidadResultados.textContent =
            filtrados.length
            + (filtrados.length === 1 ? " resultado" : " resultados");

        sinResultados.hidden = filtrados.length !== 0;
    }

    document.getElementById("btnBuscarAlmacen")
        .addEventListener("click", renderizarInventario);

    busqueda.addEventListener("input", renderizarInventario);
    filtroEstado.addEventListener("change", renderizarInventario);

    document.getElementById("btnLimpiarAlmacen")
        .addEventListener("click", function () {
            busqueda.value = "";
            filtroEstado.value = "";

            renderizarInventario();
            busqueda.focus();
        });

    actualizarResumen();
    renderizarInventario();

});
</script>

</body>
</html>
