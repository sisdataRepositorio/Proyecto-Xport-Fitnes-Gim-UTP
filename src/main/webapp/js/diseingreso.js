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

});
