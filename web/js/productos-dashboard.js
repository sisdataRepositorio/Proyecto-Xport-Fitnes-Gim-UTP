

document.addEventListener("DOMContentLoaded", function () {
    const search = document.getElementById("product-search");
    const category = document.getElementById("category-filter");
    const stockFilter = document.getElementById("stock-filter");
    const rowsContainer = document.getElementById("product-rows");
    const emptyState = document.getElementById("empty-state");
    const resultCount = document.getElementById("result-count");

    if (!search || !category || !stockFilter || !rowsContainer) {
        return;
    }

    const rows = Array.from(rowsContainer.querySelectorAll("tr"));

    function getStockStatus(stock) {
        if (stock === 0) return "agotado";
        if (stock <= 5) return "bajo";
        return "disponible";
    }

    function filterProducts() {
        const query = search.value.trim().toLocaleLowerCase("es");
        const selectedCategory = category.value;
        const selectedStock = stockFilter.value;

        let visibleCount = 0;

        rows.forEach(function (row) {
            const name = (row.dataset.name || "").toLocaleLowerCase("es");
            const code = (row.dataset.code || "").toLocaleLowerCase("es");
            const rowCategory = row.dataset.category || "";
            const stock = Number(row.dataset.stock || 0);
            const status = getStockStatus(stock);

            const matchesText = name.includes(query) || code.includes(query);
            const matchesCategory =
                !selectedCategory || rowCategory === selectedCategory;
            const matchesStock = !selectedStock || status === selectedStock;

            const visible =
                matchesText && matchesCategory && matchesStock;

            row.hidden = !visible;

            if (visible) {
                visibleCount++;
            }
        });

        resultCount.textContent =
            visibleCount + (visibleCount === 1 ? " producto" : " productos");

        emptyState.hidden = visibleCount !== 0;
    }

    search.addEventListener("input", filterProducts);
    category.addEventListener("change", filterProducts);
    stockFilter.addEventListener("change", filterProducts);

    // Los botones son demostrativos: no modifican la base de datos.
    rowsContainer.addEventListener("click", function (event) {
        const button = event.target.closest("button");

        if (!button) return;

        const row = button.closest("tr");
        if (!row) return;

        const name =
            row.querySelector(".mov-info strong")?.textContent ||
            "este producto";

        if (button.classList.contains("editar-btn")) {
            alert("La edición de «" + name + "» aún no está conectada.");
        } else if (button.classList.contains("reponer-btn")) {
            alert("La reposición de «" + name + "» aún no está conectada.");
        } else if (button.classList.contains("eliminar-btn")) {
            alert("La eliminación de «" + name + "» aún no está conectada.");
        }
    });

    filterProducts();
});
