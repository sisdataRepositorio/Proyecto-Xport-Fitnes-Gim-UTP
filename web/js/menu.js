
document.addEventListener("DOMContentLoaded", function () {

    // Inicializar todos los menus, incluidos los niveles internos.
    document.querySelectorAll(".menu-desplegable").forEach(function (menu) {

        // Si contiene una opcion activa, abrir el menu que la contiene.
        const tieneOpcionActiva =
            menu.querySelector(".submenu-activo") !== null;

        menu.classList.toggle("abierto", tieneOpcionActiva);

        const enlace = menu.querySelector(":scope > .menu-enlace");

        if (enlace) {
            enlace.setAttribute(
                "aria-expanded",
                tieneOpcionActiva ? "true" : "false"
            );
        }
    });

});

function toggleSubmenu(event, submenuId) {
    event.preventDefault();

    const submenu = document.getElementById(submenuId);

    if (!submenu) {
        return;
    }

    // Identificar exactamente el menu que contiene el submenu pulsado.
    const menu = submenu.closest(".menu-desplegable");

    if (!menu) {
        return;
    }

    // Abrir o cerrar solo el menu seleccionado.
    const abierto = menu.classList.toggle("abierto");

    const enlace = menu.querySelector(":scope > .menu-enlace");

    if (enlace) {
        enlace.setAttribute(
            "aria-expanded",
            abierto ? "true" : "false"
        );
    }

    // Si se cierra un menu padre, cerrar tambien los menus internos.
    if (!abierto) {
        menu.querySelectorAll(".menu-desplegable.abierto")
            .forEach(function (menuInterno) {

                menuInterno.classList.remove("abierto");

                const enlaceInterno =
                    menuInterno.querySelector(":scope > .menu-enlace");

                if (enlaceInterno) {
                    enlaceInterno.setAttribute(
                        "aria-expanded",
                        "false"
                    );
                }
            });
    }
}
