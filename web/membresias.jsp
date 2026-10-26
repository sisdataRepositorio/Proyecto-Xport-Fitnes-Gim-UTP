<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("usuarioAutenticado") == null) {
        response.sendRedirect(request.getContextPath() + "/UsuarioController?accion=login");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro Membresía | Xport Fitness Gym</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/membresias.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/menu.css">
</head>
<body>
<div class="dashboard-container">
    <jsp:include page="/WEB-INF/vistas/menuLateral.jsp">
        <jsp:param name="opcion" value="membresias"/>
        <jsp:param name="submenu" value=""/>
    </jsp:include>

    <main class="main-content">
        <section class="panel">
            <div class="titulo-modulo">
                <i class="fa-solid fa-id-card"></i>
                <h1>Registro Membresía</h1>
            </div>

            <% if (request.getAttribute("mensaje") != null) { %>
                <div class="alerta-exito"><i class="fa-solid fa-circle-check"></i>
                    <span><%= request.getAttribute("mensaje") %></span>
                </div>
            <% } %>

            <div class="contenido-form">
                <form class="form-membresia" action="#" method="post" id="formMembresia">
                    <div class="fila">
                        <div class="campo">
                            <label for="nroRegistro"><i class="fa-solid fa-hashtag"></i> Nro. Registro</label>
                            <input type="text" id="nroRegistro" name="nroRegistro" value="00000116" readonly>
                        </div>
                        <div class="campo">
                            <label for="condicion"><i class="fa-solid fa-circle-check"></i> Condición</label>
                            <select id="condicion" name="condicion">
                                <option value="ACTIVA">🟢 ACTIVA</option>
                                <option value="INACTIVA">🔴 INACTIVA</option>
                            </select>
                        </div>
                    </div>

                    <div class="seccion-titulo"><i class="fa-solid fa-user"></i> Datos del alumno</div>

                    <div class="fila fila-codigo">
                        <div class="campo">
                            <label for="codigo"><i class="fa-solid fa-barcode"></i> Código</label>
                            <input type="text" id="codigo" name="codigo" placeholder="70012717">
                        </div>
                        <button type="button" class="btn-buscar" id="btnBuscar"><i class="fa-solid fa-magnifying-glass"></i> Buscar F6</button>
                        <div class="campo">
                            <label for="telefono"><i class="fa-solid fa-phone"></i> Teléfono</label>
                            <input type="tel" id="telefono" name="telefono" placeholder="987654321">
                        </div>
                    </div>

                    <div class="campo campo-full">
                        <label for="nombre"><i class="fa-solid fa-user"></i> Nombre</label>
                        <input type="text" id="nombre" name="nombre" placeholder="Nombre completo del alumno">
                    </div>
                    <div class="campo campo-full">
                        <label for="direccion"><i class="fa-solid fa-location-dot"></i> Dirección</label>
                        <input type="text" id="direccion" name="direccion" placeholder="Dirección del alumno">
                    </div>

                    <div class="fila">
                        <div class="campo">
                            <label for="fechaNacimiento"><i class="fa-solid fa-calendar"></i> Fecha nacimiento</label>
                            <input type="date" id="fechaNacimiento" name="fechaNacimiento">
                        </div>
                        <div class="campo">
                            <label for="fechaVencimiento"><i class="fa-solid fa-calendar-check"></i> Fecha vencimiento</label>
                            <input type="date" id="fechaVencimiento" name="fechaVencimiento">
                        </div>
                    </div>

                    <div class="campo campo-full">
                        <label for="responsable"><i class="fa-solid fa-user-tie"></i> Responsable</label>
                        <select id="responsable" name="responsable">
                            <option value="1 - ADMIN">1 - ADMIN</option>
                            <option value="2 - RECEPCION">2 - RECEPCIÓN</option>
                        </select>
                    </div>

                    <div class="fila fila-tres">
                        <div class="campo">
                            <label for="periodos"><i class="fa-solid fa-clock"></i> Periodos</label>
                            <select id="periodos" name="periodos">
                                <option value="MENSUAL">MENSUAL</option>
                                <option value="TRIMESTRAL">TRIMESTRAL</option>
                                <option value="ANUAL">ANUAL</option>
                            </select>
                        </div>
                        <div class="campo">
                            <label for="diasLimite"><i class="fa-solid fa-calendar-days"></i> Días límite</label>
                            <input type="number" id="diasLimite" name="diasLimite" value="30" min="0">
                        </div>
                        <div class="campo">
                            <label for="tarifa"><i class="fa-solid fa-dollar-sign"></i> Tarifa</label>
                            <input type="number" id="tarifa" name="tarifa" value="100.00" min="0" step="0.01">
                        </div>
                    </div>

                    <div class="fila">
                        <div class="campo">
                            <label for="duracion"><i class="fa-solid fa-hourglass"></i> Duración</label>
                            <input type="text" id="duracion" name="duracion" value="0 días, 0 semanas, 1 mes, 0 años">
                        </div>
                        <div class="campo">
                            <label for="frecuencia"><i class="fa-solid fa-repeat"></i> Frecuencia</label>
                            <select id="frecuencia" name="frecuencia">
                                <option value="DIARIO">DIARIO</option>
                                <option value="SEMANAL">SEMANAL</option>
                                <option value="MENSUAL">MENSUAL</option>
                            </select>
                        </div>
                    </div>

                    <div class="campo campo-full">
                        <label for="observacion"><i class="fa-solid fa-comment"></i> Observación</label>
                        <textarea id="observacion" name="observacion" rows="3" placeholder="Membresía mensual - Plan estándar"></textarea>
                    </div>
                    <div class="campo campo-full">
                        <label for="condicionDeuda"><i class="fa-solid fa-money-bill"></i> Condición deuda</label>
                        <input type="text" id="condicionDeuda" name="condicionDeuda" value="PAGADO">
                    </div>

                    <div class="botones-form">
                        <button type="reset" class="btn-form btn-nuevo"><i class="fa-solid fa-plus"></i> Nuevo (F2)</button>
                        <button type="button" class="btn-form btn-pago" id="btnPago"><i class="fa-solid fa-money-bill-transfer"></i> Reportar pago (F3)</button>
                        <button type="button" class="btn-form btn-actualizar" id="btnActualizar"><i class="fa-solid fa-rotate"></i> Actualizar (F4)</button>
                        <button type="button" class="btn-form btn-salir" id="btnSalir"><i class="fa-solid fa-right-from-bracket"></i> Salir (Esc)</button>
                    </div>
                    <p class="nota-funcionalidad">Vista de plantilla: guardar, buscar y reportar pagos requieren conectarse al controlador y a la base de datos.</p>
                </form>

                <aside class="asistencias-card">
                    <div class="asistencias-titulo"><i class="fa-solid fa-calendar-check"></i><span>ASISTENCIAS</span></div>
                    <div class="tabla-asistencias-scroll">
                        <table class="tabla-asistencias">
                            <thead><tr><th>Día</th><th>Horario ingreso</th><th>Fecha ingreso</th></tr></thead>
                            <tbody>
                                <tr><td>1</td><td>08:10:00</td><td>01/08/2026</td></tr>
                                <tr><td>2</td><td>08:00:00</td><td>03/09/2026</td></tr>
                                <tr><td>3</td><td>08:10:00</td><td>05/09/2026</td></tr>
                                <tr><td>4</td><td>08:10:00</td><td>08/09/2026</td></tr>
                                <tr><td>5</td><td>08:14:00</td><td>10/09/2026</td></tr>
                                <tr><td>6</td><td>08:10:00</td><td>12/09/2026</td></tr>
                                <tr><td>7</td><td>08:10:00</td><td>15/09/2026</td></tr>
                                <tr><td>8</td><td>08:12:00</td><td>18/09/2026</td></tr>
                            </tbody>
                        </table>
                    </div>
                </aside>
            </div>
        </section>
    </main>
</div>
<script src="${pageContext.request.contextPath}/js/membresias.js"></script>
<script src="${pageContext.request.contextPath}/js/menu.js"></script>
</body>
</html>
