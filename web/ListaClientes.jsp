<%-- 
    Document   : ListaClientes
    Created on : 22 oct. 2026, 06:16:59
    Author     : Ing
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Listado de Clientes Activos</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 30px; background-color: #f4f7f6; }
        h2 { color: #333; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; background-color: #fff; }
        th, td { border: 1px solid #ddd; padding: 12px; text-align: left; }
        th { background-color: #2c3e50; color: white; }
        tr:nth-child(even) { background-color: #f2f2f2; }
        tr:hover { background-color: #ddd; }
        .no-data { color: red; font-style: italic; }
    </style>
</head>
<body>

    <h2>📊 Listado de Clientes Activos</h2>

    <%-- Verificamos si la lista enviada desde el Servlet está vacía o es nula --%>

            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Razón Social</th>
                        <th>RUC / DNI</th>
                        <th>Dirección</th>
                        <th>Teléfono</th>
                        <th>Correo</th>
                        <th>Contacto</th>
                    </tr>
                </thead>
                <tbody>
                    <%-- Recorremos la lista asignada en 'request.setAttribute("listaClientesWeb", listaClientes)' --%>
                    <c:forEach var="cliente" items="${listaClientesWeb}">
                        <tr>
                            <td><c:out value="${cliente.cliente_ID}"/></td>
                            <td><c:out value="${cliente.razonSocial}"/></td>
                            <td><c:out value="${cliente.rucDNI}"/></td>
                            <td><c:out value="${cliente.direccion}"/></td>
                            <td><c:out value="${cliente.telefono}"/></td>
                            <td><c:out value="${cliente.correo}"/></td>
                            <td><c:out value="${cliente.contacto}"/></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

</body>
</html>
