document.addEventListener("DOMContentLoaded", function () {
    const form = document.getElementById("formSocios");
    const inputFoto = document.getElementById("fotoSocio");
    const btnSubirFoto = document.getElementById("btnSubirFoto");
    const fotoAvatar = document.getElementById("fotoAvatar");
    const inputAccion = document.getElementById("accion");

    btnSubirFoto.addEventListener("click", function () {
        inputFoto.click();
    });

    inputFoto.addEventListener("change", function () {
        const archivo = inputFoto.files && inputFoto.files[0];
        if (!archivo) return;
        if (!archivo.type.startsWith("image/")) {
            alert("Selecciona un archivo de imagen válido.");
            inputFoto.value = "";
            return;
        }
        const lector = new FileReader();
        lector.onload = function (e) {
            fotoAvatar.innerHTML = "";
            const img = document.createElement("img");
            img.src = e.target.result;
            img.alt = "Vista previa de la foto del socio";
            fotoAvatar.appendChild(img);
        };
        lector.readAsDataURL(archivo);
    });

    function nuevoSocio() {
        // Redirige al controlador para limpiar o pedir nuevo ID autogenerado
        window.location.href = "ClienteController?accion=nuevo";
    }

    function salir() {
        // Redirige al listado de socios
        window.location.href = "ClienteController?accion=listar";
    }

    document.getElementById("btnNuevo").addEventListener("click", nuevoSocio);
    document.getElementById("btnSalir").addEventListener("click", salir);

    document.getElementById("btnGrabar").addEventListener("click", function () {
        inputAccion.value = "grabar";
        form.submit();
    });

    document.getElementById("btnActualizar").addEventListener("click", function () {
        inputAccion.value = "actualizar";
        form.submit();
    });

    // Atajos de teclado
    document.addEventListener("keydown", function (event) {
        if (event.key === "F2") {
            event.preventDefault();
            nuevoSocio();
        } else if (event.key === "F3") {
            event.preventDefault();
            const btnG = document.getElementById("btnGrabar");
            if (btnG && btnG.style.display !== "none") btnG.click();
        } else if (event.key === "F4") {
            event.preventDefault();
            const btnA = document.getElementById("btnActualizar");
            if (btnA && btnA.style.display !== "none") btnA.click();
        } else if (event.key === "Escape") {
            salir();
        }
    });
});