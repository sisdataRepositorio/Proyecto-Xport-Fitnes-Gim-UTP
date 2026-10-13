document.addEventListener("DOMContentLoaded", function () {
    const form = document.getElementById("formSocios");
    const inputFoto = document.getElementById("fotoSocio");
    const btnSubirFoto = document.getElementById("btnSubirFoto");
    const fotoAvatar = document.getElementById("fotoAvatar");

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
        form.reset();
        inputFoto.value = "";
        fotoAvatar.innerHTML = '<i class="fa-solid fa-circle-user"></i>';
        document.getElementById("codigo").focus();
    }

    function salir() {
        window.location.href = document.querySelector('.sidebar-menu a[href*="dashboard.jsp"]').href;
    }

    document.getElementById("btnNuevo").addEventListener("click", nuevoSocio);
    document.getElementById("btnSalir").addEventListener("click", salir);

    document.getElementById("btnGrabar").addEventListener("click", function () {
        alert("El formulario todavía no está conectado al controlador ni a la base de datos.");
    });
    document.getElementById("btnActualizar").addEventListener("click", function () {
        alert("La actualización se habilitará cuando conectemos el formulario a la base de datos.");
    });

    document.addEventListener("keydown", function (event) {
        if (event.key === "F2") {
            event.preventDefault();
            nuevoSocio();
        } else if (event.key === "F3") {
            event.preventDefault();
            document.getElementById("btnGrabar").click();
        } else if (event.key === "F4") {
            event.preventDefault();
            document.getElementById("btnActualizar").click();
        } else if (event.key === "Escape") {
            salir();
        }
    });
});
