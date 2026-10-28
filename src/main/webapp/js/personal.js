document.addEventListener("DOMContentLoaded", function () {
    const ctx = window.PERSONAL_CTX || "";
    const form = document.getElementById("formPersonal");
    const chkAcceso = document.getElementById("accesoSistema");
    const datosAcceso = document.getElementById("datosAcceso");
    const usuario = document.getElementById("usuario");
    const contrasena = document.getElementById("contrasena");
    const rol = document.getElementById("rol");

    // Muestra u oculta los datos de usuario según el check de acceso
    function actualizarAcceso() {
        const activo = chkAcceso.checked;
        datosAcceso.hidden = !activo;
        usuario.required = activo;
        rol.required = activo;
        contrasena.required = activo && window.PERSONAL_REQUIERE_CLAVE === true;
    }

    chkAcceso.addEventListener("change", actualizarAcceso);
    actualizarAcceso();

    function nuevoPersonal() {
        window.location.href = ctx + "/PersonalController?accion=nuevo";
    }

    function salir() {
        window.location.href = ctx + "/PersonalController?accion=listar";
    }

    function guardar() {
        if (form.reportValidity()) {
            form.submit();
        }
    }

    document.getElementById("btnNuevo").addEventListener("click", nuevoPersonal);
    document.getElementById("btnSalir").addEventListener("click", salir);

    // Atajos de teclado (mismos que el formulario de socios)
    document.addEventListener("keydown", function (event) {
        const esEdicion = document.getElementById("accion").value === "actualizar";

        if (event.key === "F2") {
            event.preventDefault();
            nuevoPersonal();
        } else if ((event.key === "F3" && !esEdicion) || (event.key === "F4" && esEdicion)) {
            event.preventDefault();
            guardar();
        } else if (event.key === "Escape") {
            salir();
        }
    });
});
