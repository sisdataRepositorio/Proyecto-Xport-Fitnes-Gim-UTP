
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
    <title>Registro de Productos | Xport Fitness Gym</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/diseingreso.css">
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/socios.css">
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/menu.css">
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
    
    
    <style>
        /* Espaciado general del formulario de productos */
        #formProductos {
            display: flex;
            flex-direction: column;
            gap: 16px;
        }

        /* Separación entre columnas del mismo renglón */
        #formProductos .fila {
            display: grid;
            gap: 18px;
            margin: 0;
        }

        #formProductos .fila:not(.fila-tres) {
            grid-template-columns: repeat(2, minmax(0, 1fr));
        }

        #formProductos .fila-tres {
            grid-template-columns: repeat(3, minmax(0, 1fr));
        }

        /* Separación entre etiqueta y campo */
        #formProductos .campo {
            display: flex;
            flex-direction: column;
            gap: 7px;
            min-width: 0;
            margin: 0;
        }

        #formProductos .campo label {
            display: block;
            line-height: 1.4;
            margin: 0;
        }

        /* Altura y comodidad de los controles */
        #formProductos input,
        #formProductos select {
            width: 100%;
            min-height: 39px;
            padding: 9px 12px;
            border-radius: 8px;
        }

        /* Evitar que los campos completos se reduzcan */
        #formProductos .campo-full {
            width: 100%;
        }

        /* Adaptación para pantallas pequeñas */
        @media (max-width: 700px) {
            #formProductos .fila,
            #formProductos .fila-tres {
                grid-template-columns: 1fr;
            }
        }
        
         .seccion-titulo {
            display: flex;
            align-items: center;
            gap: 8px;
            margin-top: 24px;
            margin-bottom: 12px;
            font-size: 16px;
            font-weight: 700;
            color: #10234D;
        }

        .botones-productos {
            margin-bottom: 20px;
        }
    </style>


</head>
<body>

<div class="dashboard-container">

    <!-- MENU LATERAL COMPARTIDO -->
    <jsp:include page="/WEB-INF/vistas/menuLateral.jsp">
        <jsp:param name="opcion" value="nuevoProducto"/>
        <jsp:param name="submenu" value="catalogo"/>
    </jsp:include>

    <!-- CONTENIDO PRINCIPAL -->
    <main class="main-content">
        <section class="panel">

            <div class="titulo-modulo">
                <i class="fa-solid fa-box-open"></i>
                <h1>Registro de Productos</h1>
            </div>

            <!-- FORMULARIO Y FOTO -->
            <div class="contenido-form">

                <form class="form-socios" id="formProductos"
                      onsubmit="return false;">

                    <!-- CODIGO Y CATEGORIA -->
                    <div class="fila">
                        <div class="campo">
                            <label for="codigoProducto">
                                <i class="fa-solid fa-barcode"></i>
                                Código / Barras
                            </label>
                            <input type="text"
                                   id="codigoProducto"
                                   name="codigoProducto"
                                   placeholder="PROD-001">
                        </div>

                        <div class="campo">
                            <label for="categoriaProducto">
                                <i class="fa-solid fa-tags"></i>
                                Categoría
                            </label>
                            <select id="categoriaProducto"
                                    name="categoriaProducto">
                                <option value="Suplementos">Suplementos</option>
                                <option value="Ropa Deportiva">Ropa Deportiva</option>
                                <option value="Accesorios">Accesorios</option>
                                <option value="Bebidas">Bebidas</option>
                            </select>
                        </div>
                    </div>

                    <!-- NOMBRE -->
                    <div class="campo campo-full">
                        <label for="nombreProducto">
                            <i class="fa-solid fa-box"></i>
                            Nombre del Producto
                        </label>
                        <input type="text"
                               id="nombreProducto"
                               name="nombreProducto"
                               placeholder="Ej. Proteína Whey 2lb Chocolate">
                    </div>

                    <!-- DESCRIPCION -->
                    <div class="campo campo-full">
                        <label for="descripcionProducto">
                            <i class="fa-solid fa-align-left"></i>
                            Descripción corta
                        </label>
                        <input type="text"
                               id="descripcionProducto"
                               name="descripcionProducto"
                               placeholder="Ej. 24g de proteína por porción...">
                    </div>

                    <!-- PRECIOS Y STOCK -->
                    <div class="fila fila-tres">
                        <div class="campo">
                            <label for="precioCompra">
                                <i class="fa-solid fa-cart-shopping"></i>
                                Precio Compra
                            </label>
                            <input type="number"
                                   id="precioCompra"
                                   name="precioCompra"
                                   min="0"
                                   step="0.01"
                                   placeholder="0.00">
                        </div>

                        <div class="campo">
                            <label for="precioVenta">
                                <i class="fa-solid fa-money-bill-wave"></i>
                                Precio Venta
                            </label>
                            <input type="number"
                                   id="precioVenta"
                                   name="precioVenta"
                                   min="0"
                                   step="0.01"
                                   placeholder="0.00">
                        </div>

                        <div class="campo">
                            <label for="stockActual">
                                <i class="fa-solid fa-cubes"></i>
                                Stock Actual
                            </label>
                            <input type="number"
                                   id="stockActual"
                                   name="stockActual"
                                   min="0"
                                   step="1"
                                   placeholder="0">
                        </div>
                    </div>

                    <!-- PROVEEDOR Y ESTADO -->
                    <div class="fila">
                        <div class="campo">
                            <label for="proveedorProducto">
                                <i class="fa-solid fa-truck"></i>
                                Proveedor
                            </label>
                            <input type="text"
                                   id="proveedorProducto"
                                   name="proveedorProducto"
                                   placeholder="Ej. Distribuidora Fit">
                        </div>

                        <div class="campo">
                            <label for="estadoProducto">
                                <i class="fa-solid fa-circle-check"></i>
                                Estado
                            </label>
                            <select id="estadoProducto" name="estadoProducto">
                                <option value="ACTIVO">ACTIVO (En venta)</option>
                                <option value="INACTIVO">INACTIVO (Agotado)</option>
                            </select>
                        </div>
                    </div>

                </form>

                <!-- FOTO DEL PRODUCTO -->
                <aside class="foto-card">
                    <div class="foto-titulo">FOTO DEL PRODUCTO</div>

                    <div class="foto-avatar foto-producto-avatar"
                         id="fotoProductoAvatar">
                        <i class="fa-solid fa-image"></i>
                    </div>

                    <input type="file"
                           id="imagenProducto"
                           name="imagenProducto"
                           accept="image/*"
                           hidden>

                    <button type="button"
                            class="btn-subir"
                            id="btnSubirImagen">
                        <i class="fa-solid fa-cloud-arrow-up"></i>
                        Subir Imagen
                    </button>

                    <p class="foto-ayuda">
                        Selecciona una imagen del producto.
                    </p>
                </aside>

            </div>

            <!-- BOTONES -->
            <div class="botones-form botones-productos">
                <button type="button" class="btn-form btn-nuevo"
                        id="btnNuevoProducto">
                    <i class="fa-solid fa-plus"></i>
                    Nuevo (F2)
                </button>

                <button type="button" class="btn-form btn-grabar"
                        id="btnGrabarProducto">
                    <i class="fa-solid fa-floppy-disk"></i>
                    Grabar (F3)
                </button>

                <button type="button" class="btn-form btn-actualizar"
                        id="btnActualizarProducto">
                    <i class="fa-solid fa-rotate"></i>
                    Actualizar (F4)
                </button>

                <button type="button" class="btn-form btn-salir"
                        id="btnSalirProducto">
                    <i class="fa-solid fa-right-from-bracket"></i>
                    Salir (Esc)
                </button>
            </div>

            <!-- LISTADO DE EJEMPLO -->
            <div class="seccion-titulo">
                <i class="fa-solid fa-list"></i>
                Lista de Productos
            </div>

            <div class="tabla-contenedor tabla-productos-registro">
                <table class="tabla">
                    <thead>
                        <tr>
                            <th>Código</th>
                            <th>Producto</th>
                            <th>Categoría</th>
                            <th>P. Venta</th>
                            <th>Stock</th>
                            <th>Estado</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>

                    <tbody>
                        <tr>
                            <td>PROD-001</td>
                            <td>Proteína Whey 2lb</td>
                            <td>Suplementos</td>
                            <td>S/ 120.00</td>
                            <td>15</td>
                            <td><span class="punto verde"></span> Activo</td>
                            <td>
                                <button type="button" class="btn-accion btn-oscuro"
                                        title="Editar">
                                    <i class="fa-solid fa-pen"></i>
                                </button>
                                <button type="button" class="btn-accion btn-verde"
                                        title="Reponer">
                                    <i class="fa-solid fa-cart-plus"></i>
                                </button>
                                <button type="button" class="btn-accion btn-rojo"
                                        title="Eliminar">
                                    <i class="fa-solid fa-trash"></i>
                                </button>
                            </td>
                        </tr>

                        <tr>
                            <td>PROD-002</td>
                            <td>Shaker Xport</td>
                            <td>Accesorios</td>
                            <td>S/ 25.00</td>
                            <td>40</td>
                            <td><span class="punto verde"></span> Activo</td>
                            <td>
                                <button type="button" class="btn-accion btn-oscuro"
                                        title="Editar">
                                    <i class="fa-solid fa-pen"></i>
                                </button>
                                <button type="button" class="btn-accion btn-verde"
                                        title="Reponer">
                                    <i class="fa-solid fa-cart-plus"></i>
                                </button>
                                <button type="button" class="btn-accion btn-rojo"
                                        title="Eliminar">
                                    <i class="fa-solid fa-trash"></i>
                                </button>
                            </td>
                        </tr>

                        <tr>
                            <td>PROD-003</td>
                            <td>Polera Oversize Negra</td>
                            <td>Ropa Deportiva</td>
                            <td>S/ 65.00</td>
                            <td>0</td>
                            <td><span class="punto rojo"></span> Agotado</td>
                            <td>
                                <button type="button" class="btn-accion btn-oscuro"
                                        title="Editar">
                                    <i class="fa-solid fa-pen"></i>
                                </button>
                                <button type="button" class="btn-accion btn-verde"
                                        title="Reponer">
                                    <i class="fa-solid fa-cart-plus"></i>
                                </button>
                                <button type="button" class="btn-accion btn-rojo"
                                        title="Eliminar">
                                    <i class="fa-solid fa-trash"></i>
                                </button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <p class="nota-demo nota-productos">
                <i class="fa-solid fa-circle-info"></i>
                Los productos de esta tabla son datos de muestra.
            </p>

        </section>
    </main>

</div>

<script src="${pageContext.request.contextPath}/js/menu.js"></script>

<script>
document.addEventListener("DOMContentLoaded", function () {
    const inputImagen = document.getElementById("imagenProducto");
    const botonImagen = document.getElementById("btnSubirImagen");
    const avatar = document.getElementById("fotoProductoAvatar");
    const form = document.getElementById("formProductos");

    // Vista previa de la imagen seleccionada
    botonImagen.addEventListener("click", function () {
        inputImagen.click();
    });

    inputImagen.addEventListener("change", function () {
        const archivo = inputImagen.files[0];

        if (!archivo) return;

        if (!archivo.type.startsWith("image/")) {
            alert("Selecciona un archivo de imagen válido.");
            inputImagen.value = "";
            return;
        }

        const lector = new FileReader();

        lector.onload = function (evento) {
            avatar.innerHTML = "";
            avatar.style.backgroundImage = `url("${evento.target.result}")`;
            avatar.style.backgroundSize = "contain";
            avatar.style.backgroundPosition = "center";
            avatar.style.backgroundRepeat = "no-repeat";
        };

        lector.readAsDataURL(archivo);
    });

    // Limpiar formulario
    document.getElementById("btnNuevoProducto")
        .addEventListener("click", function () {
            form.reset();
            inputImagen.value = "";
            avatar.innerHTML = '<i class="fa-solid fa-image"></i>';
            avatar.style.backgroundImage = "none";
        });

    // Volver al listado
    document.getElementById("btnSalirProducto")
        .addEventListener("click", function () {
            window.location.href =
                "${pageContext.request.contextPath}/Productos.jsp";
        });

    // Atajos de teclado
    document.addEventListener("keydown", function (evento) {
        const etiqueta = evento.target.tagName;

        if (etiqueta === "INPUT" || etiqueta === "SELECT"
                || etiqueta === "TEXTAREA") {
            if (evento.key === "Escape") {
                document.getElementById("btnSalirProducto").click();
            }
            return;
        }

        if (evento.key === "F2") {
            evento.preventDefault();
            document.getElementById("btnNuevoProducto").click();
        }

        if (evento.key === "Escape") {
            document.getElementById("btnSalirProducto").click();
        }
    });

    // Estos botones todavía requieren conexión al controlador y a la base de datos.
    document.getElementById("btnGrabarProducto")
        .addEventListener("click", function () {
            alert("El guardado de productos todavía no está conectado a la base de datos.");
        });

    document.getElementById("btnActualizarProducto")
        .addEventListener("click", function () {
            alert("La actualización de productos todavía no está conectada a la base de datos.");
        });
});
</script>

</body>
</html>
