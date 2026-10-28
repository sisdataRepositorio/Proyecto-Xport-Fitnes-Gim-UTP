<%-- 
    Document   : ListaEmpresa
    Created on : Oct 9, 2026, 4:12:23 AM
    Author     : Administrator
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="es">

<head>

    <meta charset="UTF-8">

    <title>Validación de Acceso</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

</head>

<body>

<div class="container mt-5">

    <div class="card shadow">

        <div class="card-header bg-primary text-white">
            <h3>Validación de Acceso</h3>
        </div>

        <div class="card-body">

            <p>
                Usuario:
                <strong>${usuario}</strong>
            </p>

            <p>
                Rol:
                <strong>${rol}</strong>
            </p>

            <hr>

            <c:choose>

                <c:when test="${rol == 'ADMIN'}">

                    <div class="alert alert-success">
                        <strong>Acceso permitido.</strong>
                        Bienvenido, administrador.
                    </div>

                </c:when>

                <c:when test="${rol == 'USER'}">

                    <div class="alert alert-info">
                        <strong>Acceso permitido.</strong>
                        Bienvenido, usuario.
                    </div>

                </c:when>

                <c:otherwise>

                    <div class="alert alert-danger">
                        <strong>Acceso denegado.</strong>
                        No tiene permisos para ingresar.
                    </div>

                </c:otherwise>

            </c:choose>

        </div>

    </div>

</div>

</body>

</html>