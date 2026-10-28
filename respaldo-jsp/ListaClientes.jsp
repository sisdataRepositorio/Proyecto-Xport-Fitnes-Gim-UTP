<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

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

    <title>Ver Socios | Xport Fitness Gym</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/diseingreso.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/listaclientes.css">

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">

    <style>
        .link-editar {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            color: #0284c7;
            text-decoration: none;
            font-weight: 600;
            padding: 6px 12px;
            border-radius: 6px;
            background-color: #e0f2fe;
            transition: background-color 0.2s, color 0.2s;
        }
        .link-editar:hover {
            background-color: #0284c7;
            color: #ffffff;
        }
    </style>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/menu.css">
</head>
<body>

<div class="dashboard-container">

    <!-- MENÚ LATERAL -->
    <jsp:include page="/WEB-INF/vistas/menuLateral.jsp">
        <jsp:param name="opcion" value="listarSocios"/>
        <jsp:param name="submenu" value="socios"/>
    </jsp:include>

    <!-- CONTENIDO PRINCIPAL -->
    <main class="dashboard-main">

        <section class="panel panel-listaclientes">

            <header class="clientes-header">
                <div class="clientes-titulo">
                    <div class="clientes-icono">
                        <i class="fa-solid fa-users"></i>
                    </div>

                    <div>
                        <h1>Ver Socios</h1>
                        <p>Listado de clientes registrados en Xport Fitness Gym</p>
                    </div>
                </div>

                <a class="btn-nuevo-socio"
                   href="${pageContext.request.contextPath}/ClienteController?accion=nuevo">
                    <i class="fa-solid fa-user-plus"></i>
                    Registrar Socio
                </a>
            </header>

            <div class="clientes-resumen">
                <div>
                    <i class="fa-solid fa-address-book"></i>
                    <span>Listado de clientes</span>
                </div>

                <span class="clientes-total">
                    Registros:
                    <strong>${empty listaClientesWeb ? 0 : listaClientesWeb.size()}</strong>
                </span>
            </div>

            <div class="clientes-tabla-scroll">
                <table class="tabla-clientes">

                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Razón Social</th>
                            <th>RUC / DNI</th>
                            <th>Dirección</th>
                            <th>Teléfono</th>
                            <th>Correo</th>
                            <th>Contacto</th>
                            <th style="text-align: center;">Opciones</th>
                        </tr>
                    </thead>

                    <tbody>

                        <c:forEach var="cliente" items="${listaClientesWeb}">
                            <tr>
                                <td><c:out value="${cliente.cliente_ID}"/></td>
                                <td class="cliente-razon">
                                    <c:out value="${cliente.razonSocial}"/>
                                </td>
                                <td><c:out value="${cliente.rucDNI}"/></td>
                                <td><c:out value="${cliente.direccion}"/></td>
                                <td><c:out value="${cliente.telefono}"/></td>
                                <td><c:out value="${cliente.correo}"/></td>
                                <td><c:out value="${cliente.contacto}"/></td>
                                <td style="text-align: center;">
                                    <a class="link-editar" 
                                       href="${pageContext.request.contextPath}/ClienteController?accion=editar&id=${cliente.cliente_ID}">
                                        <i class="fa-solid fa-pen-to-square"></i> Editar
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>

                        <c:if test="${empty listaClientesWeb}">
                            <tr>
                                <td colspan="8" class="clientes-sin-datos">
                                    <i class="fa-solid fa-circle-info"></i>
                                    No hay clientes para mostrar.
                                </td>
                            </tr>
                        </c:if>

                    </tbody>
                </table>
            </div>

            <footer class="clientes-footer">
                <i class="fa-solid fa-circle-info"></i>
                Los datos mostrados corresponden a los clientes enviados por el controlador.
            </footer>

        </section>

    </main>

</div>

<script src="${pageContext.request.contextPath}/js/diseingreso.js"></script>

<script src="${pageContext.request.contextPath}/js/menu.js"></script>
</body>
</html>