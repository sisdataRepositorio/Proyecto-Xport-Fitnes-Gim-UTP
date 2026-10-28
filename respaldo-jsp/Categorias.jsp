
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    if (session.getAttribute("usuarioAutenticado") == null) {
        response.sendRedirect(
            request.getContextPath() + "/UsuarioController?accion=login"
        );
        return;
    }

    String modo = request.getParameter("modo");
    boolean modoRegistro = "registrar".equals(modo);

    String opcionMenu = modoRegistro
            ? "nuevaCategoria"
            : "listarCategorias";
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Gestión de Categorías | Xport Fitness Gym</title>

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
        .categoria-form-grid {
            display: grid;
            grid-template-columns: minmax(0, 1fr) minmax(0, 2fr);
            gap: 18px;
        }

        .categoria-campo {
            display: flex;
            flex-direction: column;
            gap: 8px;
            min-width: 0;
            color: #10234D;
            font-size: 12px;
            font-weight: 700;
        }

        .categoria-campo input,
        .categoria-campo textarea {
            width: 100%;
            min-height: 42px;
            padding: 10px 12px;
            border: 1px solid #D2DCEC;
            border-radius: 8px;
            background: #fff;
            color: #10234D;
            font: inherit;
            font-weight: 400;
            box-sizing: border-box;
        }

        .categoria-campo textarea {
            min-height: 42px;
            resize: vertical;
        }

        .categoria-campo input:focus,
        .categoria-campo textarea:focus {
            outline: none;
            border-color: #2864F0;
            box-shadow: 0 0 0 3px rgba(40, 100, 240, .10);
        }

        .categoria-form-botones {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-top: 20px;
        }

        .categoria-form-botones button,
        .categoria-form-botones a {
            display: inline-flex;
            justify-content: center;
            align-items: center;
            gap: 8px;
            min-height: 40px;
            padding: 10px 16px;
            border: 0;
            border-radius: 8px;
            text-decoration: none;
            font-size: 12px;
            font-weight: 700;
            cursor: pointer;
        }

        .categoria-btn-guardar {
            color: #fff;
            background: #18BD70;
        }

        .categoria-btn-limpiar {
            color: #fff;
            background: #2864F0;
        }

        .categoria-btn-cancelar {
            color: #41516B;
            background: #EDF1F7;
        }

        .categoria-mensaje {
            padding: 12px 15px;
            margin: 0 0 18px;
            border-radius: 8px;
            background: #E9FBF2;
            color: #168653;
            font-size: 12px;
        }

        .categoria-tabla-acciones {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .categoria-estado {
            display: inline-flex;
            align-items: center;
            gap: 7px;
            color: #168653;
            font-size: 11px;
            font-weight: 700;
        }

        .categoria-estado .punto {
            width: 7px;
            height: 7px;
            border-radius: 50%;
            background: #18BD70;
        }

        .categoria-vacio {
            padding: 28px !important;
            text-align: center;
            color: #75829A !important;
        }

        .categoria-seccion-oculta {
            display: none;
        }

        @media (max-width: 760px) {
            .categoria-form-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>

<body>

<div class="dashboard-container">

    <!-- MENU LATERAL COMPARTIDO -->
    <jsp:include page="/WEB-INF/vistas/menuLateral.jsp">
        <jsp:param name="opcion" value="<%= opcionMenu %>"/>
        <jsp:param name="submenu" value="catalogo"/>
    </jsp:include>

    <!-- CONTENIDO PRINCIPAL -->
    <main class="gastos-main catalogo-main">

        <header class="gastos-header">
            <div>
                <p class="gastos-eyebrow">CONTROL DE INVENTARIO</p>
                <h1 id="tituloPagina">
                    <%= modoRegistro ? "Registrar Categoría" : "Ver Categorías" %>
                </h1>
                <p class="gastos-subtitle">
                    Organiza y administra las categorías de productos del gimnasio.
                </p>
            </div>

            <a class="periodo productos-nuevo"
                href="${pageContext.request.contextPath}/RegistrarCategoria.jsp">
                 <i class="fa-solid fa-plus"></i>
                 <span>Nueva categoría</span>
             </a>
        </header>

        

        <!-- RESUMEN -->
        <section class="resumen-grid catalogo-resumen">

            <article class="resumen-card">
                <div class="resumen-icon">
                    <i class="fa-solid fa-tags"></i>
                </div>
                <p class="resumen-label">Categorías registradas</p>
                <p class="resumen-value" id="totalCategorias">4</p>
                <span class="resumen-foot">
                    <i class="fa-solid fa-layer-group"></i>
                    En el catálogo
                </span>
            </article>

            <article class="resumen-card">
                <div class="resumen-icon catalogo-icon-green">
                    <i class="fa-solid fa-circle-check"></i>
                </div>
                <p class="resumen-label">Categorías activas</p>
                <p class="resumen-value" id="totalActivas">4</p>
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
                    Nombre y descripción
                </span>
            </article>

        </section>

        <!-- LISTADO -->
        <section class="contenido-card catalogo-listado">

            <div class="card-heading movimientos-heading">
                <div>
                    <h2>Lista de Categorías</h2>
                    <p>Busca y administra las categorías del catálogo</p>
                </div>

                <span class="movimientos-count" id="cantidadResultados">
                    4 resultados
                </span>
            </div>

            <div class="productos-toolbar">

                <label class="busqueda-productos">
                    <i class="fa-solid fa-magnifying-glass"></i>

                    <input type="search"
                           id="buscarCategoria"
                           placeholder="Buscar por nombre o descripción..."
                           aria-label="Buscar categorías">
                </label>

                <button type="button"
                        class="catalogo-buscar"
                        id="btnBuscarCategoria">
                    Buscar
                </button>

            </div>

            <div class="tabla-scroll">

                <table class="tabla-movimientos tabla-productos catalogo-tabla">

                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Nombre</th>
                            <th>Descripción</th>
                            <th>Estado</th>
                            <th class="acciones-col">Acciones</th>
                        </tr>
                    </thead>

                    <tbody id="filasCategorias">

                        <tr data-id="1"
                            data-nombre="Suplementos"
                            data-descripcion="Proteínas, creatina y complementos deportivos">

                            <td>CAT-001</td>

                            <td>
                                <span class="mov-icon prod-icon catalogo-item-icon">
                                    <i class="fa-solid fa-pills"></i>
                                </span>
                                <span class="mov-info">
                                    <strong>Suplementos</strong>
                                </span>
                            </td>

                            <td class="catalogo-descripcion">
                                Proteínas, creatina y complementos deportivos
                            </td>

                            <td>
                                <span class="categoria-estado">
                                    <span class="punto"></span> Activa
                                </span>
                            </td>

                            <td class="acciones">
                                <button type="button"
                                        class="accion-btn editar-btn btn-editar-categoria"
                                        title="Editar categoría">
                                    <i class="fa-solid fa-pen"></i>
                                </button>

                                <button type="button"
                                        class="accion-btn eliminar-btn btn-eliminar-categoria"
                                        title="Eliminar categoría">
                                    <i class="fa-solid fa-trash"></i>
                                </button>
                            </td>
                        </tr>

                        <tr data-id="2"
                            data-nombre="Accesorios"
                            data-descripcion="Accesorios y artículos para entrenamiento">

                            <td>CAT-002</td>

                            <td>
                                <span class="mov-icon prod-icon catalogo-item-icon">
                                    <i class="fa-solid fa-dumbbell"></i>
                                </span>
                                <span class="mov-info">
                                    <strong>Accesorios</strong>
                                </span>
                            </td>

                            <td class="catalogo-descripcion">
                                Accesorios y artículos para entrenamiento
                            </td>

                            <td>
                                <span class="categoria-estado">
                                    <span class="punto"></span> Activa
                                </span>
                            </td>

                            <td class="acciones">
                                <button type="button"
                                        class="accion-btn editar-btn btn-editar-categoria"
                                        title="Editar categoría">
                                    <i class="fa-solid fa-pen"></i>
                                </button>

                                <button type="button"
                                        class="accion-btn eliminar-btn btn-eliminar-categoria"
                                        title="Eliminar categoría">
                                    <i class="fa-solid fa-trash"></i>
                                </button>
                            </td>
                        </tr>

                        <tr data-id="3"
                            data-nombre="Ropa Deportiva"
                            data-descripcion="Poleras y prendas deportivas">

                            <td>CAT-003</td>

                            <td>
                                <span class="mov-icon prod-icon catalogo-item-icon">
                                    <i class="fa-solid fa-shirt"></i>
                                </span>
                                <span class="mov-info">
                                    <strong>Ropa Deportiva</strong>
                                </span>
                            </td>

                            <td class="catalogo-descripcion">
                                Poleras y prendas deportivas
                            </td>

                            <td>
                                <span class="categoria-estado">
                                    <span class="punto"></span> Activa
                                </span>
                            </td>

                            <td class="acciones">
                                <button type="button"
                                        class="accion-btn editar-btn btn-editar-categoria"
                                        title="Editar categoría">
                                    <i class="fa-solid fa-pen"></i>
                                </button>

                                <button type="button"
                                        class="accion-btn eliminar-btn btn-eliminar-categoria"
                                        title="Eliminar categoría">
                                    <i class="fa-solid fa-trash"></i>
                                </button>
                            </td>
                        </tr>

                        <tr data-id="4"
                            data-nombre="Bebidas"
                            data-descripcion="Agua y bebidas deportivas">

                            <td>CAT-004</td>

                            <td>
                                <span class="mov-icon prod-icon catalogo-item-icon">
                                    <i class="fa-solid fa-bottle-water"></i>
                                </span>
                                <span class="mov-info">
                                    <strong>Bebidas</strong>
                                </span>
                            </td>

                            <td class="catalogo-descripcion">
                                Agua y bebidas deportivas
                            </td>

                            <td>
                                <span class="categoria-estado">
                                    <span class="punto"></span> Activa
                                </span>
                            </td>

                            <td class="acciones">
                                <button type="button"
                                        class="accion-btn editar-btn btn-editar-categoria"
                                        title="Editar categoría">
                                    <i class="fa-solid fa-pen"></i>
                                </button>

                                <button type="button"
                                        class="accion-btn eliminar-btn btn-eliminar-categoria"
                                        title="Eliminar categoría">
                                    <i class="fa-solid fa-trash"></i>
                                </button>
                            </td>
                        </tr>

                    </tbody>

                </table>

                <p id="categoriasSinResultados"
                   class="categoria-vacio"
                   hidden>
                    No se encontraron categorías con esa búsqueda.
                </p>

            </div>

            <p class="nota-demo">
                <i class="fa-solid fa-circle-info"></i>
                Categorías de muestra. Los cambios aún no se guardan en SQL Server.
            </p>

        </section>

    </main>
</div>

<script src="${pageContext.request.contextPath}/js/menu.js"></script>

<script>
document.addEventListener("DOMContentLoaded", function () {

    const formulario = document.getElementById("formCategoria");
    const nombre = document.getElementById("nombreCategoria");
    const descripcion = document.getElementById("descripcionCategoria");
    const id = document.getElementById("categoriaId");
    const filas = document.getElementById("filasCategorias");
    const busqueda = document.getElementById("buscarCategoria");
    const mensaje = document.getElementById("mensajeCategoria");
    const total = document.getElementById("totalCategorias");
    const resultados = document.getElementById("cantidadResultados");
    const sinResultados = document.getElementById("categoriasSinResultados");
    const tituloFormulario = document.getElementById("tituloFormulario");
    const textoGuardar = document.getElementById("textoGuardar");

    let siguienteId = 5;

    function mostrarMensaje(texto) {
        mensaje.textContent = texto;
        mensaje.hidden = false;
    }

    function limpiarFormulario() {
        formulario.reset();
        id.value = "";
        tituloFormulario.textContent = "Registrar Categoría";
        textoGuardar.textContent = "Registrar categoría";
    }

    function actualizarTotales() {
        const todas = Array.from(filas.querySelectorAll("tr"));
        const visibles = todas.filter(function (fila) {
            return fila.style.display !== "none";
        });

        total.textContent = todas.length;
        resultados.textContent = visibles.length +
            (visibles.length === 1 ? " resultado" : " resultados");

        sinResultados.hidden = visibles.length !== 0;
    }

    function filtrarCategorias() {
        const texto = busqueda.value.trim().toLocaleLowerCase("es");

        Array.from(filas.querySelectorAll("tr")).forEach(function (fila) {
            const nombreFila = (fila.dataset.nombre || "").toLocaleLowerCase("es");
            const descripcionFila = (fila.dataset.descripcion || "").toLocaleLowerCase("es");

            fila.style.display =
                nombreFila.includes(texto) || descripcionFila.includes(texto)
                    ? ""
                    : "none";
        });

        actualizarTotales();
    }

    function crearCelda(texto, clase) {
        const td = document.createElement("td");
        if (clase) td.className = clase;
        td.textContent = texto;
        return td;
    }

    function crearFila(categoriaId, categoriaNombre, categoriaDescripcion) {
        const fila = document.createElement("tr");

        fila.dataset.id = categoriaId;
        fila.dataset.nombre = categoriaNombre;
        fila.dataset.descripcion = categoriaDescripcion;

        fila.appendChild(
            crearCelda("CAT-" + String(categoriaId).padStart(3, "0"))
        );

        const celdaNombre = document.createElement("td");

        const icono = document.createElement("span");
        icono.className = "mov-icon prod-icon catalogo-item-icon";

        const i = document.createElement("i");
        i.className = "fa-solid fa-tags";
        icono.appendChild(i);

        const info = document.createElement("span");
        info.className = "mov-info";

        const strong = document.createElement("strong");
        strong.textContent = categoriaNombre;

        info.appendChild(strong);
        celdaNombre.appendChild(icono);
        celdaNombre.appendChild(info);
        fila.appendChild(celdaNombre);

        fila.appendChild(
            crearCelda(categoriaDescripcion || "—", "catalogo-descripcion")
        );

        const celdaEstado = document.createElement("td");
        celdaEstado.innerHTML =
            '<span class="categoria-estado"><span class="punto"></span> Activa</span>';
        fila.appendChild(celdaEstado);

        const celdaAcciones = document.createElement("td");
        celdaAcciones.className = "acciones";

        const btnEditar = document.createElement("button");
        btnEditar.type = "button";
        btnEditar.className = "accion-btn editar-btn btn-editar-categoria";
        btnEditar.title = "Editar categoría";
        btnEditar.innerHTML = '<i class="fa-solid fa-pen"></i>';

        const btnEliminar = document.createElement("button");
        btnEliminar.type = "button";
        btnEliminar.className = "accion-btn eliminar-btn btn-eliminar-categoria";
        btnEliminar.title = "Eliminar categoría";
        btnEliminar.innerHTML = '<i class="fa-solid fa-trash"></i>';

        celdaAcciones.appendChild(btnEditar);
        celdaAcciones.appendChild(btnEliminar);
        fila.appendChild(celdaAcciones);

        return fila;
    }

    formulario.addEventListener("submit", function (evento) {
        evento.preventDefault();

        const nombreCategoria = nombre.value.trim();
        const descripcionCategoria = descripcion.value.trim();

        if (!nombreCategoria) {
            nombre.focus();
            return;
        }

        const filasExistentes = Array.from(filas.querySelectorAll("tr"));
        const duplicada = filasExistentes.some(function (fila) {
            return fila.dataset.nombre.toLocaleLowerCase("es") ===
                    nombreCategoria.toLocaleLowerCase("es") &&
                    fila.dataset.id !== id.value;
        });

        if (duplicada) {
            mostrarMensaje("Ya existe una categoría con ese nombre.");
            return;
        }

        if (id.value) {
            const filaExistente = filas.querySelector(
                'tr[data-id="' + id.value + '"]'
            );

            if (filaExistente) {
                const reemplazo = crearFila(
                    id.value,
                    nombreCategoria,
                    descripcionCategoria
                );
                filaExistente.replaceWith(reemplazo);
                mostrarMensaje("Categoría actualizada en esta vista de demostración.");
            }
        } else {
            const nuevaFila = crearFila(
                siguienteId++,
                nombreCategoria,
                descripcionCategoria
            );
            filas.appendChild(nuevaFila);
            mostrarMensaje("Categoría agregada temporalmente a la lista.");
        }

        limpiarFormulario();
        filtrarCategorias();
    });

    document.getElementById("btnLimpiarCategoria")
        .addEventListener("click", function () {
            limpiarFormulario();
            mensaje.hidden = true;
        });

    document.getElementById("btnBuscarCategoria")
        .addEventListener("click", filtrarCategorias);

    busqueda.addEventListener("input", filtrarCategorias);

    filas.addEventListener("click", function (evento) {
        const botonEditar = evento.target.closest(".btn-editar-categoria");
        const botonEliminar = evento.target.closest(".btn-eliminar-categoria");

        if (botonEditar) {
            const fila = botonEditar.closest("tr");

            id.value = fila.dataset.id;
            nombre.value = fila.dataset.nombre;
            descripcion.value = fila.dataset.descripcion;

            tituloFormulario.textContent = "Editar Categoría";
            textoGuardar.textContent = "Guardar cambios";

            document.getElementById("formulario").scrollIntoView({
                behavior: "smooth",
                block: "start"
            });

            nombre.focus();
        }

        if (botonEliminar) {
            const fila = botonEliminar.closest("tr");

            if (confirm("¿Eliminar la categoría " + fila.dataset.nombre + " de esta vista de demostración?")) {
                fila.remove();
                limpiarFormulario();
                filtrarCategorias();
                mostrarMensaje("Categoría eliminada de la vista de demostración.");
            }
        }
    });

    actualizarTotales();

    // Si se entra desde Registrar Categorías, enfocar el formulario.
    if (new URLSearchParams(window.location.search).get("modo") === "registrar") {
        document.getElementById("formulario").scrollIntoView({
            behavior: "instant",
            block: "start"
        });
        nombre.focus({preventScroll: true});
    }

});
</script>

</body>
</html>
