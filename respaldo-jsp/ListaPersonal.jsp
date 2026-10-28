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
<html lang="es">listar
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Personal | Xport Fitness Gym</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/diseingreso.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/listaclientes.css">

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">

    <style>
        .acciones-personal {
            display: inline-flex;
            gap: 6px;
        }
        .acciones-personal form {
            margin: 0;
        }
        .link-editar,
        .btn-eliminar {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            font-weight: 600;
            font-size: 13px;
            padding: 6px 12px;
            border-radius: 6px;
            border: 0;
            text-decoration: none;
            cursor: pointer;
            transition: background-color 0.2s, color 0.2s;
        }
        .link-editar {
            color: #0284c7;
            background-color: #e0f2fe;
        }
        .link-editar:hover {
            background-color: #0284c7;
            color: #ffffff;
        }
        .btn-eliminar {
            color: #dc2626;
            background-color: #fee2e2;
            font-family: inherit;
        }
        .btn-eliminar:hover {
            background-color: #dc2626;
            color: #ffffff;
        }
        .estado-badge {
            display: inline-block;
            padding: 3px 10px;
            border-radius: 999px;
            font-size: 12px;
            font-weight: 700;
        }
        .estado-activo {
            background: #dcfce7;
            color: #15803d;
        }
        .estado-inactivo {
            background: #f1f5f9;
            color: #64748b;
        }
        .sin-acceso {
            color: #94a3b8;
            font-style: italic;
        }
        .mensaje {
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 11px 14px;
            border-radius: 8px;
            margin-bottom: 16px;
            font-size: 14px;
            font-weight: 600;
        }
        .mensaje-ok {
            background: #dcfce7;
            color: #166534;
        }
        .mensaje-error {
            background: #fee2e2;
            color: #991b1b;
        }
    </style>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/menu.css">
</head>
<body>

<div class="dashboard-container">

    <!-- MENÚ LATERAL -->
    <jsp:include page="/WEB-INF/vistas/menuLateral.jsp">
        <jsp:param name="opcion" value="listarPersonal"/>
        <jsp:param name="submenu" value=""/>
    </jsp:include>

    <!-- CONTENIDO PRINCIPAL -->
    <main class="dashboard-main">

        <section class="panel panel-listaclientes">

            <header class="clientes-header">
                <div class="clientes-titulo">
                    <div class="clientes-icono">
                        <i class="fa-solid fa-id-badge"></i>
                    </div>

                    <div>
                        <h1>Personal</h1>
                        <p>Trabajadores del gimnasio y sus usuarios de acceso al sistema</p>
                    </div>
                </div>

                <a class="btn-nuevo-socio"
                   href="${pageContext.request.contextPath}/PersonalController?accion=nuevo">
                    <i class="fa-solid fa-user-plus"></i>
                    Registrar Personal
                </a>
            </header>

            <c:if test="${not empty mensaje}">
                <div class="mensaje ${tipoMensaje == 'ok' ? 'mensaje-ok' : 'mensaje-error'}">
                    <i class="fa-solid ${tipoMensaje == 'ok' ? 'fa-circle-check' : 'fa-triangle-exclamation'}"></i>
                    <c:out value="${mensaje}"/>
                </div>
            </c:if>

            <div class="clientes-resumen">
                <div>
                    <i class="fa-solid fa-address-book"></i>
                    <span>Listado de personal</span>
                </div>

                <span class="clientes-total">
                    Registros:
                    <strong>${empty listaPersonal ? 0 : listaPersonal.size()}</strong>
                </span>
            </div>

            <div class="clientes-tabla-scroll">
                <table class="tabla-clientes">

                    <thead>
                        <tr>
                            <th>Código</th>
                            <th>Apellidos y Nombres</th>
                            <th>DNI / RUC</th>
                            <th>Área</th>
                            <th>Teléfono</th>
                            <th>Usuario</th>
                            <th>Rol</th>
                            <th>Estado</th>
                            <th style="text-align: center;">Opciones</th>
                        </tr>
                    </thead>

                    <tbody>

                        <c:forEach var="p" items="${listaPersonal}">
                            <tr>
                                <td><c:out value="${p.personal_ID}"/></td>
                                <td class="cliente-razon">
                                    <c:out value="${p.apellidoPaterno} ${p.apellidoMaterno}, ${p.nombres}"/>
                                </td>
                                <td><c:out value="${p.rucDNI}"/></td>
                                <td><c:out value="${p.area}"/></td>
                                <td><c:out value="${p.telefono1}"/></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty p.usuario}"><c:out value="${p.usuario}"/></c:when>
                                        <c:otherwise><span class="sin-acceso">Sin acceso</span></c:otherwise>
                                    </c:choose>
                                </td>
                                <td><c:out value="${p.rol}"/></td>
                                <td>
                                    <span class="estado-badge ${p.estadoGene == 'Activo' ? 'estado-activo' : 'estado-inactivo'}">
                                        <c:out value="${p.estadoGene}"/>
                                    </span>
                                </td>
                                <td style="text-align: center;">
                                    <div class="acciones-personal">
                                        <a class="link-editar"
                                           href="${pageContext.request.contextPath}/PersonalController?accion=editar&id=${p.personal_ID}">
                                            <i class="fa-solid fa-pen-to-square"></i> Editar
                                        </a>

                                        <c:if test="${p.personal_ID != sessionScope.usuarioAutenticado.personal_ID}">
                                            <form method="post"
                                                  action="${pageContext.request.contextPath}/PersonalController"
                                                  data-confirmar="¿Eliminar a <c:out value="${p.nombres} ${p.apellidoPaterno}"/>? Si tiene movimientos registrados solo se marcará como Inactivo."
                                                  onsubmit="return confirm(this.dataset.confirmar);">
                                                <input type="hidden" name="accion" value="eliminar">
                                                <input type="hidden" name="id" value="${p.personal_ID}">
                                                <button type="submit" class="btn-eliminar">
                                                    <i class="fa-solid fa-trash"></i> Eliminar
                                                </button>
                                            </form>
                                        </c:if>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>

                        <c:if test="${empty listaPersonal}">
                            <tr>
                                <td colspan="9" class="clientes-sin-datos">
                                    <i class="fa-solid fa-circle-info"></i>
                                    No hay personal para mostrar.
                                </td>
                            </tr>
                        </c:if>

                    </tbody>
                </table>
            </div>

        </section>

    </main>

</div>

<script src="${pageContext.request.contextPath}/js/diseingreso.js"></script>

<script src="${pageContext.request.contextPath}/js/menu.js"></script>
</body>
</html>
