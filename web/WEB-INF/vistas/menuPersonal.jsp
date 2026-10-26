
<%--
    Componente del menú lateral: Personal.
    Disponible únicamente para el rol Administrador.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:if test="${sessionScope.rol == 'Administrador'}">

    <%-- Determinar si debe abrirse el menú Personal --%>
    <li class="menu-desplegable ${param.opcion == 'listar' or param.opcion == 'nuevo' or param.opcion == 'listarPersonal' or param.opcion == 'nuevoPersonal' ? 'abierto' : ''}"
        id="menuPersonal">

        <a href="#"
           class="menu-enlace"
           onclick="toggleSubmenu(event, 'submenuPersonal')"
           aria-expanded="${param.opcion == 'listar' or param.opcion == 'nuevo' or param.opcion == 'listarPersonal' or param.opcion == 'nuevoPersonal'}">

            <i class="fa-solid fa-id-badge"></i>
            <span>Personal</span>
            <i class="fa-solid fa-chevron-down flecha-submenu"></i>
        </a>

        <%-- Opciones del submenú Personal --%>
        <ul class="submenu" id="submenuPersonal">

            <%-- VER PERSONAL --%>
            <li class="${param.opcion == 'listar' or param.opcion == 'listarPersonal' ? 'submenu-activo' : ''}">
                <a href="${pageContext.request.contextPath}/PersonalController?accion=listar">
                    <i class="fa-solid fa-list"></i>
                    <span>Ver Personal</span>
                </a>
            </li>

            <%-- REGISTRAR PERSONAL --%>
            <li class="${param.opcion == 'nuevo' or param.opcion == 'nuevoPersonal' ? 'submenu-activo' : ''}">
                <a href="${pageContext.request.contextPath}/PersonalController?accion=nuevo">
                    <i class="fa-solid fa-user-plus"></i>
                    <span>Registrar Personal</span>
                </a>
            </li>

        </ul>
    </li>

</c:if>
