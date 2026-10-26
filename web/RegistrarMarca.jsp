
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

    <title>Registrar Marca | Xport Fitness Gym</title>

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
        .registro-marca-card {
            margin-bottom: 24px;
        }

        .registro-marca-form {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .registro-marca-campos {
            display: grid;
            grid-template-columns: minmax(0, 1fr) minmax(0, 1fr);
            gap: 20px;
        }

        .registro-marca-campo {
            display: flex;
            flex-direction: column;
            gap: 8px;
            min-width: 0;
            color: #10234D;
            font-size: 12px;
            font-weight: 700;
        }

        .registro-marca-campo label {
            line-height: 1.5;
        }

        .registro-marca-campo label i {
            margin-right: 5px;
            color: #2864F0;
        }

        .registro-marca-campo input,
        .registro-marca-campo textarea {
            width: 100%;
            min-height: 44px;
            padding: 11px 13px;
            border: 1px solid #D2DCEC;
            border-radius: 8px;
            background: #FFFFFF;
            color: #10234D;
            font-family: Arial, Helvetica, sans-serif;
            font-size: 13px;
            font-weight: 400;
            box-sizing: border-box;
        }

        .registro-marca-campo textarea {
            min-height: 110px;
            resize: vertical;
            line-height: 1.6;
        }

        .registro-marca-campo input:focus,
        .registro-marca-campo textarea:focus {
            outline: none;
            border-color: #2864F0;
            box-shadow: 0 0 0 3px rgba(40, 100, 240, 0.10);
        }

        .registro-marca-campo-completo {
            grid-column: 1 / -1;
        }

        .registro-marca-ayuda {
            color: #75829A;
            font-size: 11px;
            font-weight: 400;
            line-height: 1.5;
        }

        .registro-marca-botones {
            display: flex;
            flex-wrap: wrap;
            gap: 12px;
            padding-top: 20px;
            border-top: 1px solid #DFE6F0;
        }

        .registro-marca-botones button,
        .registro-marca-botones a {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            min-height: 42px;
            padding: 11px 18px;
            border: none;
            border-radius: 8px;
            font-size: 12px;
            font-weight: 700;
            text-decoration: none;
            cursor: pointer;
            box-sizing: border-box;
        }

        .btn-registrar-marca {
            background: #18BD70;
            color: #FFFFFF;
        }

        .btn-registrar-marca:hover {
            background: #11995A;
        }

        .btn-limpiar-marca {
            background: #2864F0;
            color: #FFFFFF;
        }

        .btn-limpiar-marca:hover {
            background: #174CC5;
        }

        .btn-volver-marcas {
            background: #EDF1F7;
            color: #34435E;
        }

        .btn-volver-marcas:hover {
            background: #DDE5F0;
        }

        .registro-marca-aviso {
            display: none;
            padding: 13px 15px;
            border-radius: 8px;
            background: #FFF5E5;
            color: #946200;
            font-size: 12px;
            line-height: 1.6;
        }

        .registro-marca-aviso.visible {
            display: block;
        }

        .registro-marca-aviso.exito {
            background: #E9FBF2;
            color: #168653;
        }

        .registro-marca-pasos {
            display: grid;
            grid-template-columns: repeat(3, minmax(0, 1fr));
            gap: 18px;
        }

        .registro-marca-paso {
            display: flex;
            align-items: flex-start;
            gap: 12px;
            padding: 18px;
            border: 1px solid #DFE6F0;
            border-radius: 12px;
            background: #FFFFFF;
        }

        .registro-marca-paso > i {
            color: #2864F0;
            font-size: 20px;
        }

        .registro-marca-paso strong {
            display: block;
            margin-bottom: 6px;
            color: #10234D;
            font-size: 12px;
        }

        .registro-marca-paso p {
            margin: 0;
            color: #75829A;
            font-size: 11px;
            line-height: 1.6;
        }

        .registro-marca-nota {
            margin-top: 18px;
            color: #75829A;
            font-size: 11px;
            line-height: 1.6;
        }

        .registro-marca-nota i {
            margin-right: 5px;
        }

        @media (max-width: 900px) {
            .registro-marca-pasos {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 700px) {
            .registro-marca-campos {
                grid-template-columns: 1fr;
            }

            .registro-marca-campo-completo {
                grid-column: auto;
            }

            .registro-marca-botones {
                flex-direction: column;
            }

            .registro-marca-botones button,
            .registro-marca-botones a {
                width: 100%;
            }
        }
    </style>
</head>

<body>

<div class="dashboard-container">

    <!-- MENU LATERAL COMPARTIDO -->
    <jsp:include page="/WEB-INF/vistas/menuLateral.jsp">
        <jsp:param name="opcion" value="nuevaMarca"/>
        <jsp:param name="submenu" value="catalogo"/>
    </jsp:include>

    <!-- CONTENIDO PRINCIPAL -->
    <main class="gastos-main catalogo-main">

        <!-- CABECERA -->
        <header class="gastos-header">
            <div>
                <p class="gastos-eyebrow">CONTROL DE INVENTARIO</p>

                <h1 id="tituloPagina">Registrar Marca</h1>

                <p class="gastos-subtitle">
                    Registra una marca para identificar los productos
                    del catálogo del gimnasio.
                </p>
            </div>

            <a class="periodo productos-nuevo"
               href="${pageContext.request.contextPath}/Marcas.jsp">
                <i class="fa-solid fa-list"></i>
                <span>Ver marcas</span>
            </a>
        </header>

        <!-- FORMULARIO -->
        <section class="contenido-card registro-marca-card"
                 id="formulario">

            <div class="card-heading">
                <div>
                    <h2>
                        <i class="fa-solid fa-tag"></i>
                        Datos de la marca
                    </h2>

                    <p>
                        Los campos marcados con * son obligatorios.
                    </p>
                </div>

                <i class="fa-solid fa-copyright heading-icon"></i>
            </div>

            <div id="avisoMarca"
                 class="registro-marca-aviso"
                 role="status"
                 aria-live="polite"></div>

            <form id="formRegistrarMarca"
                  class="registro-marca-form">

                <div class="registro-marca-campos">

                    <!-- NOMBRE -->
                    <div class="registro-marca-campo">
                        <label for="nombreMarca">
                            <i class="fa-solid fa-tag"></i>
                            Nombre de la marca *
                        </label>

                        <input type="text"
                               id="nombreMarca"
                               name="nombre"
                               maxlength="100"
                               required
                               autocomplete="off"
                               placeholder="Ej. Nike">
                        
                        <span class="registro-marca-ayuda">
                            Introduce el nombre con el que se identifica la marca.
                        </span>
                    </div>

                    <!-- PAÍS -->
                    <div class="registro-marca-campo">
                        <label for="paisMarca">
                            <i class="fa-solid fa-globe"></i>
                            País de origen
                        </label>

                        <input type="text"
                               id="paisMarca"
                               name="pais"
                               maxlength="100"
                               autocomplete="off"
                               placeholder="Ej. Perú">

                        <span class="registro-marca-ayuda">
                            Campo opcional. País de origen de la marca.
                        </span>
                    </div>

                    <!-- DESCRIPCIÓN -->
                    <div class="registro-marca-campo registro-marca-campo-completo">
                        <label for="descripcionMarca">
                            <i class="fa-solid fa-align-left"></i>
                            Descripción
                        </label>

                        <textarea id="descripcionMarca"
                                  name="descripcion"
                                  maxlength="500"
                                  rows="4"
                                  placeholder="Describe brevemente la marca y sus productos."></textarea>

                        <span class="registro-marca-ayuda">
                            Campo opcional. Máximo 500 caracteres.
                        </span>
                    </div>

                </div>

                <!-- BOTONES -->
                <div class="registro-marca-botones">

                    <button type="submit"
                            class="btn-registrar-marca"
                            id="btnGuardarMarca">
                        <i class="fa-solid fa-floppy-disk"></i>
                        <span id="textoGuardar">Registrar marca</span>
                    </button>

                    <button type="button"
                            class="btn-limpiar-marca"
                            id="btnLimpiarMarca">
                        <i class="fa-solid fa-eraser"></i>
                        Limpiar
                    </button>

                    <a class="btn-volver-marcas"
                       href="${pageContext.request.contextPath}/Marcas.jsp">
                        <i class="fa-solid fa-arrow-left"></i>
                        Volver a marcas
                    </a>

                </div>

            </form>

        </section>

        <!-- INFORMACIÓN COMPLEMENTARIA -->
        <section class="registro-marca-pasos">

            <article class="registro-marca-paso">
                <i class="fa-solid fa-tag"></i>

                <div>
                    <strong>Nombre identificable</strong>

                    <p>
                        Registra un nombre claro para encontrar
                        fácilmente la marca en el catálogo.
                    </p>
                </div>
            </article>

            <article class="registro-marca-paso">
                <i class="fa-solid fa-globe"></i>

                <div>
                    <strong>País de origen</strong>

                    <p>
                        Puedes indicar el país de procedencia
                        para complementar la información.
                    </p>
                </div>
            </article>

            <article class="registro-marca-paso">
                <i class="fa-solid fa-boxes-stacked"></i>

                <div>
                    <strong>Organización del catálogo</strong>

                    <p>
                        Las marcas ayudan a identificar y organizar
                        los productos del gimnasio.
                    </p>
                </div>
            </article>

        </section>

        <p class="registro-marca-nota">
            <i class="fa-solid fa-circle-info"></i>
            Modo de demostración: las marcas se guardan en el navegador.
            Todavía no se registran en SQL Server.
        </p>

    </main>

</div>

<script src="${pageContext.request.contextPath}/js/menu.js"></script>

<script>
document.addEventListener("DOMContentLoaded", function () {

    const contexto = '<%= request.getContextPath() %>';
    const claveMarcas = "marcasCatalogo";

    const formulario = document.getElementById("formRegistrarMarca");
    const nombre = document.getElementById("nombreMarca");
    const pais = document.getElementById("paisMarca");
    const descripcion = document.getElementById("descripcionMarca");

    const aviso = document.getElementById("avisoMarca");
    const botonGuardar = document.getElementById("btnGuardarMarca");
    const textoGuardar = document.getElementById("textoGuardar");
    const botonLimpiar = document.getElementById("btnLimpiarMarca");
    const tituloPagina = document.getElementById("tituloPagina");

    const parametros = new URLSearchParams(window.location.search);
    const idEditar = parametros.get("id");

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

    function mostrarAviso(texto, esExito) {
        aviso.textContent = texto;
        aviso.classList.add("visible");
        aviso.classList.toggle("exito", Boolean(esExito));
    }

    function ocultarAviso() {
        aviso.textContent = "";
        aviso.classList.remove("visible");
        aviso.classList.remove("exito");
    }

    function limpiarFormulario() {
        formulario.reset();
        ocultarAviso();

        if (marcaExistente) {
            nombre.value = marcaExistente.nombre || "";
            pais.value = marcaExistente.pais || "";
            descripcion.value = marcaExistente.descripcion || "";
        } else {
            nombre.value = "";
            pais.value = "";
            descripcion.value = "";
        }

        nombre.focus();
    }

    let marcaExistente = null;

    // Inicializar datos de demostración y cargar la marca si es edición.
    const marcas = obtenerMarcas();

    if (idEditar !== null) {
        marcaExistente = marcas.find(function (marca) {
            return String(marca.id) === String(idEditar);
        });

        if (marcaExistente) {
            tituloPagina.textContent = "Editar Marca";
            textoGuardar.textContent = "Guardar cambios";

            nombre.value = marcaExistente.nombre || "";
            pais.value = marcaExistente.pais || "";
            descripcion.value = marcaExistente.descripcion || "";
        } else {
            mostrarAviso(
                "No se encontró la marca que deseas editar. " +
                "Regresa al listado e inténtalo nuevamente.",
                false
            );

            botonGuardar.disabled = true;
        }
    }

    // Registrar o actualizar marca.
    formulario.addEventListener("submit", function (evento) {
        evento.preventDefault();
        ocultarAviso();

        if (idEditar !== null && !marcaExistente) {
            mostrarAviso("No se puede editar una marca que no existe.", false);
            return;
        }

        const nombreValor = nombre.value.trim();
        const paisValor = pais.value.trim();
        const descripcionValor = descripcion.value.trim();

        if (!nombreValor) {
            mostrarAviso("Debes ingresar el nombre de la marca.", false);
            nombre.focus();
            return;
        }

        const listaMarcas = obtenerMarcas();

        // Evitar nombres duplicados; al editar se excluye la marca actual.
        const nombreDuplicado = listaMarcas.some(function (marca) {
            return String(marca.nombre || "").trim().toLocaleLowerCase("es")
                    === nombreValor.toLocaleLowerCase("es")
                && String(marca.id) !== String(idEditar);
        });

        if (nombreDuplicado) {
            mostrarAviso(
                "Ya existe una marca registrada con ese nombre.",
                false
            );

            nombre.focus();
            return;
        }

        if (idEditar !== null) {
            const indice = listaMarcas.findIndex(function (marca) {
                return String(marca.id) === String(idEditar);
            });

            if (indice === -1) {
                mostrarAviso("No se encontró la marca que deseas actualizar.", false);
                return;
            }

            listaMarcas[indice] = Object.assign({}, listaMarcas[indice], {
                nombre: nombreValor,
                pais: paisValor,
                descripcion: descripcionValor
            });

            guardarMarcas(listaMarcas);

            window.location.href = contexto + "/Marcas.jsp?actualizado=1";

        } else {
            const nuevaMarca = {
                id: "marca-" + Date.now(),
                nombre: nombreValor,
                pais: paisValor,
                descripcion: descripcionValor,
                activa: true
            };

            listaMarcas.push(nuevaMarca);
            guardarMarcas(listaMarcas);

            window.location.href = contexto + "/Marcas.jsp?guardado=1";
        }
    });

    // Limpiar los campos o restaurar los valores si se está editando.
    botonLimpiar.addEventListener("click", function () {
        limpiarFormulario();
    });

});
</script>

</body>
</html>
