document.addEventListener("DOMContentLoaded", function () {
    const salir = document.getElementById("btnSalir");
    if (salir) {
        salir.addEventListener("click", function () {
            window.location.href = document.querySelector('.sidebar-menu a[href*="dashboard.jsp"]').href;
        });
    }

    const buscar = document.getElementById("btnBuscar");
    if (buscar) {
        buscar.addEventListener("click", function () {
            document.getElementById("codigo").focus();
            alert("La búsqueda de socios se conectará cuando implementemos la acción en el controlador.");
        });
    }

    document.addEventListener("keydown", function (event) {
        if (event.key === "F2") {
            event.preventDefault();
            document.getElementById("formMembresia").reset();
        }
        if (event.key === "F3") {
            event.preventDefault();
            alert("El reporte de pagos requiere conectarse al controlador y a la base de datos.");
        }
        if (event.key === "F4") {
            event.preventDefault();
            alert("La actualización se implementará al conectar el formulario con la base de datos.");
        }
        if (event.key === "Escape") {
            window.location.href = document.querySelector('.sidebar-menu a[href*="dashboard.jsp"]').href;
        }
    });

    const actualizar = document.getElementById("btnActualizar");
    if (actualizar) {
        actualizar.addEventListener("click", function () {
            alert("La actualización se implementará al conectar el formulario con la base de datos.");
        });
    }
    const pago = document.getElementById("btnPago");
    if (pago) {
        pago.addEventListener("click", function () {
            alert("El reporte de pagos se implementará al conectar el formulario con la base de datos.");
        });
    }
});
