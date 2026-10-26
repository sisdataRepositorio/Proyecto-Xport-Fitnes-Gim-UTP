
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

    <title>Registrar Categoría | Xport Fitness Gym</title>

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
        .registro-categoria-card {
            margin-bottom: 24px;
        }

        .registro-categoria-form {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .registro-categoria-campos {
            display: grid;
            grid-template-columns: minmax(0, 1fr) minmax(0, 2fr);
            gap: 20px;
        }

        .registro-categoria-campo {
            display: flex;
            flex-direction: column;
            gap: 8px;
            min-width: 0;
            color: #10234D;
            font-size: 12px;
            font-weight: 700;
        }

        .registro-categoria-campo label {
            line-height: 1.5;
        }

        .registro-categoria-campo label i {
            margin-right: 5px;
            color: #2864F0;
        }

        .registro-categoria-campo input,
        .registro-categoria-campo textarea {
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

        .registro-categoria-campo textarea {
            min-height: 110px;
            resize: vertical;
            line-height: 1.6;
        }

        .registro-categoria-campo input:focus,
        .registro-categoria-campo textarea:focus {
            outline: none;
            border-color: #2864F0;
            box-shadow: 0 0 0 3px rgba(40, 100, 240, 0.10);
        }

        .registro-categoria-ayuda {
            color: #75829A;
            font-size: 11px;
            font-weight: 400;
            line-height: 1.5;
        }

        .registro-categoria-botones {
            display: flex;
            flex-wrap: wrap;
            gap: 12px;
            padding-top: 20px;
            border-top: 1px solid #DFE6F0;
        }

        .registro-categoria-botones button,
        .registro-categoria-botones a {
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

        .btn-registrar-categoria {
            background: #18BD70;
            color: #FFFFFF;
        }

        .btn-registrar-categoria:hover {
            background: #11995A;
        }

        .btn-limpiar-categoria {
            background: #2864F0;
            color: #FFFFFF;
        }

        .btn-limpiar-categoria:hover {
            background: #174CC5;
        }

        .btn-volver-categorias {
            background: #EDF1F7;
            color: #34435E;
        }

        .btn-volver-categorias:hover {
            background: #DDE5F0;
        }

        .registro-categoria-aviso {
            display: none;
            padding: 13px 15px;
            border-radius: 8px;
            background: #FFF5E5;
            color: #946200;
            font-size: 12px;
            line-height: 1.6;
        }

        .registro-categoria-aviso.visible {
            display: block;
        }

        .registro-categoria-pasos {
            display: grid;
            grid-template-columns: repeat(3, minmax(0, 1fr));
            gap: 18px;
        }

        .registro-categoria-paso {
            display: flex;
            align-items: flex-start;
            gap: 12px;
            padding: 18px;
            border: 1px solid #DFE6F0;
            border-radius: 12px;
            background: #FFFFFF;
        }

        .registro-categoria-paso > i {
            color: #2864F0;
            font-size: 20px;
        }

        .registro-categoria-paso strong {
            display: block;
            margin-bottom: 6px;
            color: #10234D;
            font-size: 12px;
        }

        .registro-categoria-paso p {
            margin: 0;
            color: #75829A;
            font-size: 11px;
            line-height: 1.6;
        }

        @media (max-width: 900px) {
            .registro-categoria-pasos {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 700px) {
            .registro-categoria-campos {
                grid-template-columns: 1fr;
            }

            .registro-categoria-botones {
                flex-direction: column;
            }

            .registro-categoria-botones button,
            .registro-categoria-botones a {
                width: 100%;
            }
        }
    </style>
</head>

<body>

<div class="dashboard-container">

    <!-- MENU LATERAL COMPARTIDO -->
    <jsp:include page="/WEB-INF/vistas/menuLateral.jsp">
        <jsp:param name="opcion" value="nuevaCategoria"/>
        <jsp:param name="submenu" value="catalogo"/>
    </jsp:include>

    <!-- CONTENIDO PRINCIPAL -->
    <main class="gastos-main catalogo-main">

        <!-- CABECERA -->
        <header class="gastos-header">
            <div>
                <p class="gastos-eyebrow">CONTROL DE INVENTARIO</p>
                <h1>Registrar Categoría</h1>
                <p class="gastos-subtitle">
                    Registra una nueva categoría para organizar los productos del gimnasio.
                </p>
            </div>

            <a class="periodo productos-nuevo"
               href="${pageContext.request.contextPath}/Categorias.jsp">
                <i class="fa-solid fa-list"></i>
                <span>Ver categorías</span>
            </a>
        </header>

       

        <!-- FORMULARIO DE REGISTRO -->
        <section class="contenido-card registro-categoria-card"
                 id="formulario">

            <div class="card-heading">
                <div>
                    <h2>
                        <i class="fa-solid fa-tags"></i>
                        Datos de la categoría
                    </h2>
                    <p>
                        Los campos marcados con * son obligatorios.
                    </p>
                </div>

                <i class="fa-solid fa-folder-plus heading-icon"></i>
            </div>

            <div id="avisoCategoria" class="registro-categoria-aviso"
                 role="status" aria-live="polite"></div>

            <form id="formRegistrarCategoria"
                  class="registro-categoria-form">

                <div class="registro-categoria-campos">

                    <!-- NOMBRE -->
                    <div class="registro-categoria-campo">
                        <label for="nombreCategoria">
                            <i class="fa-solid fa-tag"></i>
                            Nombre de la categoría *
                        </label>

                        <input type="text"
                               id="nombreCategoria"
                               name="nombre"
                               maxlength="60"
                               required
                               autocomplete="off"
                               placeholder="Ej. Suplementos">

                        <span class="registro-categoria-ayuda">
                            Utiliza un nombre breve y fácil de identificar.
                        </span>
                    </div>

                    <!-- DESCRIPCION -->
                    <div class="registro-categoria-campo">
                        <label for="descripcionCategoria">
                            <i class="fa-solid fa-align-left"></i>
                            Descripción
                        </label>

                        <textarea id="descripcionCategoria"
                                  name="descripcion"
                                  maxlength="180"
                                  rows="4"
                                  placeholder="Describe qué tipos de productos pertenecen a esta categoría."></textarea>

                        <span class="registro-categoria-ayuda">
                            Campo opcional. Máximo 180 caracteres.
                        </span>
                    </div>

                </div>

                <!-- BOTONES -->
                <div class="registro-categoria-botones">

                    <button type="submit"
                            class="btn-registrar-categoria">
                        <i class="fa-solid fa-floppy-disk"></i>
                        Registrar categoría
                    </button>

                    <button type="reset"
                            class="btn-limpiar-categoria"
                            id="btnLimpiarCategoria">
                        <i class="fa-solid fa-eraser"></i>
                        Limpiar
                    </button>

                    <a class="btn-volver-categorias"
                       href="${pageContext.request.contextPath}/Categorias.jsp">
                        <i class="fa-solid fa-arrow-left"></i>
                        Volver a categorías
                    </a>

                </div>

            </form>

        </section>

        <!-- INFORMACION COMPLEMENTARIA -->
        <section class="registro-categoria-pasos">

            <article class="registro-categoria-paso">
                <i class="fa-solid fa-tag"></i>
                <div>
                    <strong>Nombre identificable</strong>
                    <p>Usa nombres como Suplementos, Accesorios, Ropa Deportiva o Bebidas.</p>
                </div>
            </article>

            <article class="registro-categoria-paso">
                <i class="fa-solid fa-align-left"></i>
                <div>
                    <strong>Descripción clara</strong>
                    <p>Explica brevemente qué productos estarán agrupados en la categoría.</p>
                </div>
            </article>

            <article class="registro-categoria-paso">
                <i class="fa-solid fa-boxes-stacked"></i>
                <div>
                    <strong>Organización del catálogo</strong>
                    <p>Las categorías permiten ordenar los productos por tipo.</p>
                </div>
            </article>

        </section>

        <p class="nota-demo" style="margin-top:18px;">
            <i class="fa-solid fa-circle-info"></i>
            Interfaz visual: el registro todavía debe conectarse al controlador y a SQL Server.
        </p>

    </main>

</div>

<script src="${pageContext.request.contextPath}/js/menu.js"></script>

<script>
document.addEventListener("DOMContentLoaded", function () {

    const formulario = document.getElementById("formRegistrarCategoria");
    const nombre = document.getElementById("nombreCategoria");
    const descripcion = document.getElementById("descripcionCategoria");
    const aviso = document.getElementById("avisoCategoria");
    const botonLimpiar = document.getElementById("btnLimpiarCategoria");

    // Por ahora la pantalla no está conectada a SQL Server.
    formulario.addEventListener("submit", function (evento) {
        evento.preventDefault();

        if (!nombre.value.trim()) {
            nombre.focus();
            nombre.reportValidity();
            return;
        }

        aviso.textContent =
            "El formulario está listo, pero el registro aún no se ha guardado. " +
            "Falta conectar esta pantalla al controlador y a SQL Server.";

        aviso.classList.add("visible");
    });

    botonLimpiar.addEventListener("click", function () {
        aviso.textContent = "";
        aviso.classList.remove("visible");
    });

});
</script>

</body>
</html>
