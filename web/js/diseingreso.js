document.addEventListener("DOMContentLoaded", function () {

    // FECHA ACTUAL DEL DASHBOARD
    const fecha = document.getElementById("fechaActual");

    if (fecha) {
        const hoy = new Date();

        fecha.textContent =
            `${hoy.getFullYear()}-${String(hoy.getMonth() + 1).padStart(2, "0")}-${String(hoy.getDate()).padStart(2, "0")}`;
    }

    // CAMBIAR ESTADO DE ASISTENCIA
    const estado = document.getElementById("estadoEntrada");
    const punto = document.getElementById("puntoEstado");

    if (estado && punto) {
        estado.addEventListener("change", function () {
            punto.classList.toggle("verde", estado.value === "verde");
            punto.classList.toggle("rojo", estado.value === "rojo");
        });
    }

    // INICIAR EL SUBMENU DE SOCIOS CERRADO
    const menuSocios = document.getElementById("menuSocios");

    if (menuSocios) {
        menuSocios.classList.remove("abierto");

        const enlace = menuSocios.querySelector(".menu-enlace");

        if (enlace) {
            enlace.setAttribute("aria-expanded", "false");
        }
    }

});

// ABRIR Y CERRAR EL SUBMENU DE SOCIOS
function toggleSubmenu(event, submenuId) {
    event.preventDefault();

    const menu = document.getElementById("menuSocios");

    if (!menu) {
        return;
    }

    const submenu = document.getElementById(submenuId);
    const enlace = menu.querySelector(".menu-enlace");

    if (!submenu || !enlace) {
        return;
    }

    const abierto = menu.classList.toggle("abierto");

    enlace.setAttribute("aria-expanded", abierto ? "true" : "false");
}
