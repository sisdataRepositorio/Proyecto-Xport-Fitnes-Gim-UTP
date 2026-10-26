
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String opcion = request.getParameter("opcion");
    if (opcion == null) {
        opcion = "";
    }

    String submenu = request.getParameter("submenu");
    if (submenu == null) {
        submenu = "";
    }

    String contexto = request.getContextPath();
%>

<aside class="sidebar">
    <div class="saludo-admin">
        <h2>Hola, Administrador</h2>
    </div>

    <ul class="sidebar-menu">

        <li class="<%= "inicio".equals(opcion) ? "active" : "" %>">
            <a href="<%= contexto %>/dashboard.jsp">
                <i class="fa-solid fa-house-user"></i>
                <span>Inicio</span>
            </a>
        </li>

        <li class="<%= "asistencia".equals(opcion) ? "active" : "" %>">
            <a href="<%= contexto %>/UsuarioController?accion=asistencia">
                <i class="fa-solid fa-user-check"></i>
                <span>Asistencia</span>
            </a>
        </li>

        <li class="<%= "membresias".equals(opcion) ? "active" : "" %>">
            <a href="<%= contexto %>/membresias.jsp">
                <i class="fa-solid fa-id-card"></i>
                <span>Membresía</span>
            </a>
        </li>

        <!-- SUBMENU SOCIOS -->
        <li class="menu-desplegable <%= "socios".equals(submenu) ? "abierto" : "" %>"
            id="menuSocios">

            <a href="#"
               class="menu-enlace"
               onclick="toggleSubmenu(event, 'submenuSocios')"
               aria-expanded="<%= "socios".equals(submenu) ? "true" : "false" %>">

                <i class="fa-solid fa-users"></i>
                <span>Socios</span>
                <i class="fa-solid fa-chevron-down flecha-submenu"></i>
            </a>

            <ul class="submenu" id="submenuSocios">

                <li class="<%= "listarSocios".equals(opcion) ? "submenu-activo" : "" %>">
                    <a href="<%= contexto %>/ClienteController?accion=listar">
                        <i class="fa-solid fa-list"></i>
                        <span>Ver Socios</span>
                    </a>
                </li>

                <li class="<%= "registrarSocio".equals(opcion) ? "submenu-activo" : "" %>">
                    <a href="<%= contexto %>/socios.jsp">
                        <i class="fa-solid fa-user-plus"></i>
                        <span>Registrar Socio</span>
                    </a>
                </li>

            </ul>
        </li>

        <!-- PERSONAL -->
        
        <jsp:include page="/WEB-INF/vistas/menuPersonal.jsp">
            <jsp:param name="opcion"
                       value="${(param.opcion eq 'listarPersonal' or param.opcion eq 'nuevoPersonal') ? param.opcion : ''}"/>
        </jsp:include>


        <li class="<%= "ventas".equals(opcion) ? "active" : "" %>">
            <a href="<%= contexto %>/UsuarioController?accion=ventas">
                <i class="fa-solid fa-chart-line"></i>
                <span>Ventas</span>
            </a>
        </li>

        <!-- CATALOGO -->
        <jsp:include page="/WEB-INF/vistas/menuCatalogo.jsp">
            <jsp:param name="opcion" value="<%= opcion %>"/>
            <jsp:param name="submenu" value="<%= submenu %>"/>
        </jsp:include>

        <li class="<%= "gastos".equals(opcion) ? "active" : "" %>">
            <a href="<%= contexto %>/gastos.jsp">
                <i class="fa-solid fa-money-bill"></i>
                <span>Gastos</span>
            </a>
        </li>

        <li class="<%= "almacen".equals(opcion) ? "active" : "" %>">
           <a href="<%= contexto %>/Almacen.jsp">
                <i class="fa-solid fa-warehouse"></i>
                <span>Almacén</span>
            </a>
        </li>

    </ul>

    <ul class="sidebar-menu2">
        <li>
            <a href="<%= contexto %>/UsuarioController?accion=configurar">
                <i class="fa-solid fa-gear"></i>
                <span>Configurar</span>
            </a>
        </li>

        <li>
            <a href="<%= contexto %>/UsuarioController?accion=cerrarSesion">
                <i class="fa-solid fa-right-from-bracket"></i>
                <span>Cerrar sesión</span>
            </a>
        </li>
    </ul>
</aside>
