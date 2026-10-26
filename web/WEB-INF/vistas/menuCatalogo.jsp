<%-- 
    Document   : menuCatalogo
    Created on : 25 oct. 2026, 17:17:33
    Author     : Ing
--%>

 <%-- Uso:  <jsp:include page="/WEB-INF/vistas/menuProductos.jsp">
            <jsp:param name="opcion" value="listar"/>   (listar | nuevo | vacío)
        </jsp:include>
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:if test="${sessionScope.rol == 'Administrador'}">
    <!-- MENÚ PRINCIPAL: CATÁLOGO -->
    <li class="menu-desplegable ${param.opcion == 'listarProductos' or param.opcion == 'nuevoProducto' or param.opcion == 'listarCategorias' or param.opcion == 'nuevaCategoria' or param.opcion == 'listarMarcas' or param.opcion == 'nuevaMarca' ? 'abierto' : ''}" id="menuCatalogo">
        <a href="#" class="menu-enlace"
           onclick="toggleSubmenu(event, 'submenuCatalogo')"
           aria-expanded="${not empty param.opcion}">
            <i class="fa-solid fa-folder-open"></i>
            <span>Catálogo</span>
            <i class="fa-solid fa-chevron-down flecha-submenu"></i>
        </a>
        
        <!-- Primer nivel de Submenú (Contiene Productos, Categorías y Marcas) -->
        <ul class="submenu" id="submenuCatalogo">
            
            <!-- SUBMENÚ: PRODUCTOS -->
            <li class="menu-desplegable ${param.opcion == 'listarProductos' or param.opcion == 'nuevoProducto' ? 'abierto' : ''}" id="menuProductos">
                <a href="#" class="menu-enlace" onclick="toggleSubmenu(event, 'submenuItemsProductos')">
                    <i class="fa-solid fa-box"></i>
                    <span>Productos</span>
                    <i class="fa-solid fa-chevron-down flecha-submenu"></i>
                </a>
                <!-- Opciones de Productos -->
                <ul class="submenu-interno" id="submenuItemsProductos">
                    <li class="${param.opcion == 'listarProductos' ? 'submenu-activo' : ''}">
                        <a href="${pageContext.request.contextPath}/Productos.jsp">
                            <i class="fa-solid fa-list"></i>
                            <span>Ver Productos</span>
                        </a>
                    </li>
                    <li class="${param.opcion == 'nuevoProducto' ? 'submenu-activo' : ''}">
                        <a href="${pageContext.request.contextPath}/RegistrarProducto.jsp">
                            <i class="fa-solid fa-plus"></i>
                            <span>Registrar Productos</span>
                        </a>
                    </li>
                </ul>
            </li>
            
            <!-- SUBMENÚ: CATEGORÍAS -->
            <li class="menu-desplegable ${param.opcion == 'listarCategorias' or param.opcion == 'nuevaCategoria' ? 'abierto' : ''}" id="menuCategorias">
                <a href="#" class="menu-enlace" onclick="toggleSubmenu(event, 'submenuItemsCategorias')">
                    <i class="fa-solid fa-tags"></i>
                    <span>Categorías</span>
                    <i class="fa-solid fa-chevron-down flecha-submenu"></i>
                </a>
                <!-- Opciones de Categorías -->
                <ul class="submenu-interno" id="submenuItemsCategorias">
                    <li class="${param.opcion == 'listarCategorias' ? 'submenu-activo' : ''}">
                        <a href="${pageContext.request.contextPath}/Categorias.jsp">
                            <i class="fa-solid fa-list"></i>
                            <span>Ver Categorías</span>
                        </a>
                    </li>
                    <li class="${param.opcion == 'nuevaCategoria' ? 'submenu-activo' : ''}">
                        <a href="${pageContext.request.contextPath}/RegistrarCategoria.jsp">
                            <i class="fa-solid fa-plus"></i>
                            <span>Registrar Categorías</span>
                        </a>
                    </li>
                </ul>
            </li>
            
            <!-- SUBMENÚ: MARCAS -->
            <li class="menu-desplegable ${param.opcion == 'listarMarcas' or param.opcion == 'nuevaMarca' ? 'abierto' : ''}" id="menuMarcas">
                <a href="#" class="menu-enlace" onclick="toggleSubmenu(event, 'submenuItemsMarcas')">
                    <i class="fa-solid fa-copyright"></i>
                    <span>Marca de Productos</span>
                    <i class="fa-solid fa-chevron-down flecha-submenu"></i>
                </a>
                <!-- Opciones de Marcas -->
                <ul class="submenu-interno" id="submenuItemsMarcas">
                    <li class="${param.opcion == 'listarMarcas' ? 'submenu-activo' : ''}">
                        <a href="${pageContext.request.contextPath}/Marcas.jsp">
                            <i class="fa-solid fa-list"></i>
                            <span>Ver Marcas</span>
                        </a>
                    </li>
                    <li class="${param.opcion == 'nuevaMarca' ? 'submenu-activo' : ''}">
                        <a href="${pageContext.request.contextPath}/RegistrarMarca.jsp">
                            <i class="fa-solid fa-plus"></i>
                            <span>Registrar Marcas</span>
                        </a>
                    </li>
                </ul>
            </li>
            
        </ul>
    </li>
</c:if>
