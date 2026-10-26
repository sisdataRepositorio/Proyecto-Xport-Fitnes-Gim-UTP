
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    if (session.getAttribute("usuarioAutenticado") == null) {
        response.sendRedirect(
            request.getContextPath() + "/UsuarioController?accion=login"
        );
        return;
    }

    String opcionMenu = "listarMarcas";
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Gestión de Marcas | Xport Fitness Gym</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/diseingreso.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/gastos.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/productos-dashboard.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/catalogo.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/menu.css">

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">

    <style>
        .marca-descripcion {
            color: #64748B;
            font-size: 12px;
            max-width: 310px;
            overflow-wrap: anywhere;
        }

        .marca-nombre {
            display: flex;
            align-items: center;
            gap: 10px;
            min-width: 150px;
        }

        .marca-nombre strong {
            color: #10234D;
            font-size: 12px;
        }

        .marca-icono {
            display: inline-flex;
            justify-content: center;
            align-items: center;
            flex-shrink: 0;
            width: 36px;
            height: 36px;
            border-radius: 9px;
            background: #EAF0FF;
            color: #2864F0;
        }

        .marca-pais {
            color: #41516B;
            font-size: 12px;
        }

        .marca-estado {
            display: inline-flex;
            align-items: center;
            gap: 7px;
            color: #168653;
            font-size: 11px;
            font-weight: 700;
            white-space: nowrap;
        }

        .marca-estado .punto {
            width: 7px;
            height: 7px;
            border-radius: 50%;
            background: #18BD70;
        }

        .marca-acciones {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .marca-acciones .accion-btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
        }

        .marca-vacio {
            padding: 28px !important;
            text-align: center;
            color: #75829A !important;
        }

        .marca-mensaje {
            display: none;
            padding: 12px 15px;
            margin-bottom: 18px;
            border-radius: 8px;
            background: #E9FBF2;
            color: #168653;
            font-size: 12px;
        }

        .marca-mensaje.visible {
            display: block;
        }

        .marca-nota {
            margin-top: 18px;
            color: #75829A;
            font-size: 11px;
        }

        .marca-nota i {
            margin-right: 5px;
        }

        @media (max-width: 760px) {
            .marca-acciones {
                flex-wrap: wrap;
            }
        }
    </style>
</head>

<body>

<div class="dashboard-container">

    <!-- MENÚ LATERAL COMPARTIDO -->
    <jsp:include page="/WEB-INF/vistas/menuLateral.jsp">
        <jsp:param name="opcion" value="<%= opcionMenu %>"/>
        <jsp:param name="submenu" value="catalogo"/>
    </jsp:include>

    <!-- CONTENIDO PRINCIPAL -->
    <main class="gastos-main catalogo-main">

        <header class="gastos-header">
            <div>
                <p class="gastos-eyebrow">CONTROL DE INVENTARIO</p>

                <h1>Marcas de productos</h1>

                <p class="gastos-subtitle">
                    Organiza y administra las marcas del catálogo del gimnasio.
                </p>
            </div>

            <a class="periodo productos-nuevo"
               href="${pageContext.request.contextPath}/RegistrarMarca.jsp">
                <i class="fa-solid fa-plus"></i>
                <span>Registrar marca</span>
            </a>
        </header>

        <!-- MENSAJES -->
        <div id="mensajeMarca" class="marca-mensaje" role="status"></div>

        <!-- TARJETAS DE RESUMEN -->
        <section class="resumen-grid catalogo-resumen">

            <article class="resumen-card">
                <div class="resumen-icon">
                    <i class="fa-solid fa-copyright"></i>
                </div>

                <p class="resumen-label">Marcas registradas</p>

                <p class="resumen-value" id="totalMarcas">0</p>

                <span class="resumen-foot">
                    <i class="fa-solid fa-tags"></i>
                    En el catálogo
                </span>
            </article>

            <article class="resumen-card">
                <div class="resumen-icon catalogo-icon-green">
                    <i class="fa-solid fa-circle-check"></i>
                </div>

                <p class="resumen-label">Marcas activas</p>

                <p class="resumen-value" id="totalActivas">0</p>

                <span class="resumen-foot">
                    <i class="fa-solid fa-shield-halved"></i>
                    Disponibles en el catálogo
                </span>
            </article>

            <article class="resumen-card">
                <div class="resumen-icon catalogo-icon-purple">
                    <i class="fa-solid fa-magnifying-glass"></i>
                </div>

                <p class="resumen-label">Búsqueda</p>

                <p class="resumen-value catalogo-value-label">Rápida</p>

                <span class="resumen-foot">
                    <i class="fa-solid fa-filter"></i>
                    Nombre, país y descripción
                </span>
            </article>

        </section>

        <!-- LISTADO DE MARCAS -->
        <section class="contenido-card catalogo-listado">

            <div class="card-heading movimientos-heading">
                <div>
                    <h2>Lista de marcas</h2>
                    <p>Busca, edita y administra las marcas del catálogo.</p>
                </div>

                <span class="movimientos-count" id="cantidadResultados">
                    0 resultados
                </span>
            </div>

            <!-- BUSCADOR -->
            <div class="productos-toolbar">

                <label class="busqueda-productos">
                    <i class="fa-solid fa-magnifying-glass"></i>

                    <input
                        type="search"
                        id="buscarMarca"
                        placeholder="Buscar por nombre, descripción o país..."
                        aria-label="Buscar marcas">
                </label>

                <button type="button"
                        class="catalogo-buscar"
                        id="btnBuscarMarca">
                    Buscar
                </button>

            </div>

            <!-- TABLA -->
            <div class="tabla-scroll">

                <table class="tabla-movimientos tabla-productos catalogo-tabla">

                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Marca</th>
                            <th>Descripción</th>
                            <th>País</th>
                            <th>Estado</th>
                            <th class="acciones-col">Acciones</th>
                        </tr>
                    </thead>

                    <tbody id="filasMarcas">
                        <!-- Las filas se generan mediante JavaScript -->
                    </tbody>

                </table>

                <p id="marcasSinResultados"
                   class="marca-vacio"
                   hidden>
                    No se encontraron marcas con esa búsqueda.
                </p>

            </div>

            <p class="marca-nota">
                <i class="fa-solid fa-circle-info"></i>
                Marcas de demostración. Los cambios se guardan temporalmente
                en este navegador, no en SQL Server.
            </p>

        </section>

    </main>

</div>

<script src="${pageContext.request.contextPath}/js/menu.js"></script>

<script>
document.addEventListener("DOMContentLoaded", function () {

    const contexto = '<%= request.getContextPath() %>';
    const claveMarcas = "marcasCatalogo";

    const filas = document.getElementById("filasMarcas");
    const busqueda = document.getElementById("buscarMarca");
    const total = document.getElementById("totalMarcas");
    const totalActivas = document.getElementById("totalActivas");
    const resultados = document.getElementById("cantidadResultados");
    const sinResultados = document.getElementById("marcasSinResultados");
    const mensaje = document.getElementById("mensajeMarca");

    const marcasIniciales = [
        {
            id: "marca-1",
            nombre: "Nike",
            descripcion: "Marca de ropa y accesorios deportivos",
            pais: "Estados Unidos",
            activa: true
        },
        {
            id: "marca-2",
            nombre: "Adidas",
            descripcion: "Calzado y artículos deportivos",
            pais: "Alemania",
            activa: true
        },
        {
            id: "marca-3",
            nombre: "Puma",
            descripcion: "Ropa y calzado deportivo",
            pais: "Alemania",
            activa: true
        },
        {
            id: "marca-4",
            nombre: "Reebok",
            descripcion: "Productos de entrenamiento",
            pais: "Reino Unido",
            activa: true
        }
    ];

    function obtenerMarcas() {
        const datos = localStorage.getItem(claveMarcas);

        if (datos === null) {
            guardarMarcas(marcasIniciales);
            return marcasIniciales.map(function (marca) {
                return Object.assign({}, marca);
            });
        }

        try {
            const marcas = JSON.parse(datos);

            return Array.isArray(marcas) ? marcas : [];
        } catch (error) {
            guardarMarcas(marcasIniciales);

            return marcasIniciales.map(function (marca) {
                return Object.assign({}, marca);
            });
        }
    }

    function guardarMarcas(marcas) {
        localStorage.setItem(claveMarcas, JSON.stringify(marcas));
    }

    function mostrarMensaje(texto) {
        mensaje.textContent = texto;
        mensaje.classList.add("visible");
    }

    function crearCelda(texto, clase) {
        const celda = document.createElement("td");

        if (clase) {
            celda.className = clase;
        }

        celda.textContent = texto || "—";

        return celda;
    }

    function crearFila(marca, indice) {
        const fila = document.createElement("tr");

        fila.dataset.id = String(marca.id);
        fila.dataset.nombre = marca.nombre || "";
        fila.dataset.descripcion = marca.descripcion || "";
        fila.dataset.pais = marca.pais || "";

        // Identificador visible de la marca
        fila.appendChild(
            crearCelda("MAR-" + String(indice + 1).padStart(3, "0"))
        );

        // Nombre e icono
        const celdaNombre = document.createElement("td");

        const contenedorNombre = document.createElement("div");
        contenedorNombre.className = "marca-nombre";

        const icono = document.createElement("span");
        icono.className = "marca-icono";

        const iconoMarca = document.createElement("i");
        iconoMarca.className = "fa-solid fa-tag";

        icono.appendChild(iconoMarca);

        const nombre = document.createElement("strong");
        nombre.textContent = marca.nombre || "Sin nombre";

        contenedorNombre.appendChild(icono);
        contenedorNombre.appendChild(nombre);
        celdaNombre.appendChild(contenedorNombre);

        fila.appendChild(celdaNombre);

        // Descripción
        fila.appendChild(
            crearCelda(marca.descripcion, "marca-descripcion")
        );

        // País
        fila.appendChild(
            crearCelda(marca.pais, "marca-pais")
        );

        // Estado
        const celdaEstado = document.createElement("td");
        const estado = document.createElement("span");
        estado.className = "marca-estado";

        const punto = document.createElement("span");
        punto.className = "punto";

        estado.appendChild(punto);
        estado.appendChild(
            document.createTextNode(marca.activa === false ? "Inactiva" : "Activa")
        );

        if (marca.activa === false) {
            estado.style.color = "#75829A";
            punto.style.background = "#9CA3AF";
        }

        celdaEstado.appendChild(estado);
        fila.appendChild(celdaEstado);

        // Acciones
        const celdaAcciones = document.createElement("td");
        celdaAcciones.className = "marca-acciones";

        const botonEditar = document.createElement("a");
        botonEditar.className = "accion-btn editar-btn";
        botonEditar.title = "Editar marca";
        botonEditar.setAttribute("aria-label", "Editar marca " + marca.nombre);
        botonEditar.href = contexto + "/RegistrarMarca.jsp?id="
            + encodeURIComponent(String(marca.id));

        const iconoEditar = document.createElement("i");
        iconoEditar.className = "fa-solid fa-pen";

        botonEditar.appendChild(iconoEditar);

        const botonEliminar = document.createElement("button");
        botonEliminar.type = "button";
        botonEliminar.className = "accion-btn eliminar-btn btn-eliminar-marca";
        botonEliminar.title = "Eliminar marca";
        botonEliminar.setAttribute("aria-label", "Eliminar marca " + marca.nombre);

        const iconoEliminar = document.createElement("i");
        iconoEliminar.className = "fa-solid fa-trash";

        botonEliminar.appendChild(iconoEliminar);

        celdaAcciones.appendChild(botonEditar);
        celdaAcciones.appendChild(botonEliminar);

        fila.appendChild(celdaAcciones);

        return fila;
    }

    function actualizarTotales(marcas, cantidadVisibles) {
        total.textContent = marcas.length;

        totalActivas.textContent = marcas.filter(function (marca) {
            return marca.activa !== false;
        }).length;

        resultados.textContent = cantidadVisibles
            + (cantidadVisibles === 1 ? " resultado" : " resultados");

        sinResultados.hidden = cantidadVisibles !== 0;
    }

    function renderizarMarcas() {
        const marcas = obtenerMarcas();

        const texto = busqueda.value
            .trim()
            .toLocaleLowerCase("es");

        const filtradas = marcas.filter(function (marca) {
            const contenido = [
                marca.nombre,
                marca.descripcion,
                marca.pais
            ].join(" ").toLocaleLowerCase("es");

            return contenido.includes(texto);
        });

        filas.replaceChildren();

        filtradas.forEach(function (marca) {
            filas.appendChild(
                crearFila(marca, marcas.indexOf(marca))
            );
        });

        actualizarTotales(marcas, filtradas.length);
    }

    // Búsqueda en tiempo real
    busqueda.addEventListener("input", renderizarMarcas);

    document.getElementById("btnBuscarMarca")
        .addEventListener("click", renderizarMarcas);

    // Eliminar marca
    filas.addEventListener("click", function (evento) {
        const boton = evento.target.closest(".btn-eliminar-marca");

        if (!boton) {
            return;
        }

        const fila = boton.closest("tr");
        const id = fila.dataset.id;
        const nombre = fila.dataset.nombre;

        if (!confirm("¿Deseas eliminar la marca " + nombre + "?")) {
            return;
        }

        const marcas = obtenerMarcas().filter(function (marca) {
            return String(marca.id) !== String(id);
        });

        guardarMarcas(marcas);
        renderizarMarcas();

        mostrarMensaje("La marca se eliminó de la lista de demostración.");
    });

    // Mensajes al regresar del formulario de registro
    const parametros = new URLSearchParams(window.location.search);

    if (parametros.get("guardado") === "1") {
        mostrarMensaje("La marca se registró correctamente.");
    } else if (parametros.get("actualizado") === "1") {
        mostrarMensaje("La marca se actualizó correctamente.");
    }

    // Pintar tabla inicial
    renderizarMarcas();

});
</script>

</body>
</html>
