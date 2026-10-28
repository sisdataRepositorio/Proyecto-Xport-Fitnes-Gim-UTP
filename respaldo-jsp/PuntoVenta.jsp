
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("usuarioAutenticado") == null) {
        response.sendRedirect(
            request.getContextPath() + "/UsuarioController?accion=login"
        );
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Punto de Venta | Xport Fitness Gym</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/diseingreso.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/gastos.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/productos-dashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/catalogo.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/menu.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">

    <style>
        * { box-sizing: border-box; }

        .pv-main {
            padding: 8px !important;
            margin: 0 !important;
            min-width: 0;
            min-height: 0;
            height: 100vh;
            max-width: none;
            display: flex;
            flex-direction: column;
            gap: 8px;
            overflow: hidden;
            background: #eef1f5;
        }

        .pv-topbar {
            flex: 0 0 auto;
            min-height: 42px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 12px;
            padding: 5px 12px;
            color: #fff;
            background: #3e5f5b;
            border-radius: 5px;
        }

        .pv-topbar-left,
        .pv-topbar-right {
            display: flex;
            align-items: center;
            gap: 14px;
            min-width: 0;
        }

        .pv-topbar strong,
        .pv-topbar span {
            font-size: 12px;
        }

        .pv-topbar .pv-store {
            white-space: nowrap;
        }

        .pv-topbar button {
            border: 0;
            cursor: pointer;
            color: #fff;
            font-size: 11px;
            font-weight: 700;
            padding: 10px 14px;
            border-radius: 4px;
            background: transparent;
        }

        .pv-topbar button:hover {
            background: rgba(255,255,255,.12);
        }

        .pv-topbar .pv-logout {
            background: #c84635;
        }

        .pv-workspace {
            flex: 1 1 auto;
            min-height: 0;
            display: grid;
            grid-template-columns: minmax(0, .98fr) minmax(0, 1.02fr);
            border: 1px solid #ccd4df;
            border-radius: 4px;
            overflow: hidden;
            background: #fff;
        }

        .pv-products-pane {
            display: flex;
            flex-direction: column;
            min-width: 0;
            min-height: 0;
            padding: 10px;
            gap: 10px;
            background: #e8e8e8;
            border-right: 2px solid #d5dce6;
        }

        .pv-search-row {
            display: grid;
            grid-template-columns: auto minmax(0, 1fr) 40px;
            gap: 9px;
            align-items: center;
        }

        .pv-pos-label {
            color: #00a6a6;
            font-size: 13px;
            font-weight: 800;
            white-space: nowrap;
        }

        .pv-search-row input {
            width: 100%;
            height: 33px;
            min-width: 0;
            padding: 6px 10px;
            border: 1px solid #00a6a6;
            outline: none;
            background: #fff;
            color: #243042;
            font-size: 13px;
        }

        .pv-search-row input:focus {
            box-shadow: 0 0 0 2px rgba(0,166,166,.16);
        }

        .pv-scan-button {
            height: 33px;
            border: 0;
            color: #fff;
            background: #555;
            cursor: pointer;
        }

        .pv-filter-row {
            display: flex;
            flex-wrap: wrap;
            gap: 2px;
        }

        .pv-filter {
            flex: 1 1 auto;
            min-height: 34px;
            padding: 7px 10px;
            border: 0;
            color: #fff;
            background: #00a6a6;
            font-size: 11px;
            font-weight: 700;
            cursor: pointer;
        }

        .pv-filter:hover,
        .pv-filter.active {
            background: #087e83;
        }

        .pv-product-grid {
            flex: 1 1 auto;
            min-height: 0;
            overflow: auto;
            display: grid;
            grid-template-columns: repeat(3, minmax(0, 1fr));
            align-content: start;
            gap: 10px;
            padding: 0 3px 4px 0;
        }

        .pv-product-card {
            position: relative;
            min-width: 0;
            height: 142px;
            padding: 0;
            border: 0;
            background: #fff;
            text-align: left;
            overflow: hidden;
            cursor: pointer;
            box-shadow: 0 1px 2px rgba(0,0,0,.06);
        }

        .pv-product-card:hover {
            outline: 2px solid #00a6a6;
        }

        .pv-product-image {
            height: 96px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #aaa;
            background: #f6f6f6;
            font-size: 12px;
            font-weight: 800;
        }

        .pv-product-card .pv-stock {
            position: absolute;
            top: 0;
            left: 0;
            z-index: 1;
            padding: 3px 6px;
            color: #fff;
            background: #00a6a6;
            font-size: 9px;
            font-weight: 700;
        }

        .pv-product-card .pv-offer {
            position: absolute;
            top: 0;
            right: 0;
            padding: 3px 6px;
            color: #fff;
            background: #e69614;
            font-size: 9px;
            font-weight: 800;
        }

        .pv-product-footer {
            min-height: 46px;
            height: 46px;
            display: grid;
            grid-template-columns: minmax(0, 1fr) auto;
            gap: 5px;
            align-items: start;
            padding: 6px;
            color: #fff;
            background: #686868;
        }

        .pv-product-name {
            display: -webkit-box;
            overflow: hidden;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow-wrap: anywhere;
            font-size: 10px;
            line-height: 1.25;
            font-weight: 800;
        }

        .pv-product-price {
            white-space: nowrap;
            font-size: 10px;
            font-weight: 800;
        }

        .pv-add-card {
            display: flex;
            justify-content: center;
            align-items: center;
            background: #bdbdbd;
            color: white;
            font-size: 48px;
        }

        .pv-add-card span {
            font-size: 52px;
            font-weight: 300;
            line-height: 1;
        }

        .pv-empty-products {
            grid-column: 1 / -1;
            padding: 35px 12px;
            text-align: center;
            color: #75829a;
            font-size: 12px;
        }

        /* Carrito, cliente y dirección */
        .pv-cart-pane {
            display: flex;
            flex-direction: column;
            min-width: 0;
            min-height: 0;
            background: #fff;
        }

        .pv-tabs {
            flex: 0 0 auto;
            display: flex;
            gap: 3px;
            padding: 0 8px;
            border-bottom: 1px solid #cad3df;
            background: #f5f6f8;
        }

        .pv-tab {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 9px 12px;
            border: 1px solid #c7ced8;
            border-bottom: 0;
            border-radius: 5px 5px 0 0;
            background: #e6e8eb;
            color: #3b4555;
            font-size: 11px;
            font-weight: 700;
            cursor: pointer;
        }

        .pv-tab.active {
            background: #fff;
            color: #172c4b;
        }

        .pv-tab-content {
            flex: 1 1 auto;
            min-height: 0;
            display: none;
            overflow: auto;
        }

        .pv-tab-content.active {
            display: block;
        }

        .pv-cart-list {
            min-height: 100%;
            padding: 6px 10px;
        }

        .pv-cart-empty {
            padding: 28px 12px;
            text-align: center;
            color: #8a94a4;
            font-size: 12px;
        }

        .pv-cart-empty i {
            display: block;
            margin-bottom: 8px;
            font-size: 28px;
            color: #b8c1cc;
        }

        .pv-cart-item {
            display: grid;
            grid-template-columns: 27px minmax(0, 1fr) auto;
            align-items: center;
            gap: 8px;
            padding: 10px 2px;
            border-bottom: 1px solid #e4e7ec;
        }

        .pv-remove-item {
            border: 0;
            background: transparent;
            color: #8a929d;
            cursor: pointer;
        }

        .pv-remove-item:hover {
            color: #c84635;
        }

        .pv-item-info {
            min-width: 0;
        }

        .pv-item-info strong {
            display: block;
            color: #27364a;
            font-size: 11px;
            overflow-wrap: anywhere;
        }

        .pv-item-info small {
            display: block;
            margin-top: 4px;
            color: #788497;
            font-size: 10px;
        }

        .pv-quantity {
            display: flex;
            align-items: center;
            gap: 6px;
            margin-top: 6px;
        }

        .pv-quantity button {
            width: 23px;
            height: 23px;
            border: 1px solid #d5dbe4;
            border-radius: 4px;
            background: #f7f9fb;
            cursor: pointer;
        }

        .pv-quantity span {
            min-width: 18px;
            text-align: center;
            font-size: 11px;
            font-weight: 700;
        }

        .pv-item-price {
            color: #27364a;
            font-size: 11px;
            font-weight: 800;
            white-space: nowrap;
        }

        .pv-form-pane {
            padding: 22px;
        }

        .pv-form-pane h2 {
            margin: 0 0 7px;
            color: #233650;
            font-size: 16px;
        }

        .pv-form-pane p {
            margin: 0 0 18px;
            color: #768398;
            font-size: 11px;
        }

        .pv-form-grid {
            display: grid;
            grid-template-columns: repeat(2, minmax(0,1fr));
            gap: 14px;
        }

        .pv-field {
            display: flex;
            flex-direction: column;
            gap: 7px;
            min-width: 0;
        }

        .pv-field.full {
            grid-column: 1 / -1;
        }

        .pv-field label {
            color: #34435a;
            font-size: 11px;
            font-weight: 700;
        }

        .pv-field input,
        .pv-field textarea,
        .pv-field select {
            width: 100%;
            min-height: 37px;
            padding: 9px 10px;
            border: 1px solid #d3dae4;
            border-radius: 5px;
            background: white;
            color: #25364a;
            font: inherit;
            font-size: 12px;
        }

        .pv-field textarea {
            min-height: 80px;
            resize: vertical;
        }

        .pv-checkout {
            flex: 0 0 auto;
            padding: 8px 10px 10px;
            border-top: 1px solid #e3e7ed;
            background: #fff;
        }

        .pv-subtotal-row,
        .pv-total-row {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 12px;
        }

        .pv-subtotal-row {
            padding: 2px 0 8px;
            color: #3f4753;
            font-size: 9px;
            font-weight: 700;
        }

        .pv-total-row {
            padding: 10px 0;
            border-top: 1px solid #cfd5dd;
        }

        .pv-total-row strong {
            color: #00a6a6;
            font-size: 14px;
        }

        .pv-total-row span {
            color: #00a6a6;
            font-size: 20px;
            font-weight: 800;
        }

        .pv-adjustments {
            display: flex;
            justify-content: flex-end;
            flex-wrap: wrap;
            gap: 7px;
            margin-bottom: 8px;
        }

        .pv-clear-cart {
            border: 0;
            padding: 8px 12px;
            color: #fff;
            background: #c84635;
            font-size: 10px;
            font-weight: 800;
            cursor: pointer;
        }

        .pv-action-grid {
            display: grid;
            grid-template-columns: .7fr 1fr .75fr .7fr 1.15fr 1.8fr;
            gap: 4px;
            min-height: 65px;
        }

        .pv-action {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            gap: 5px;
            min-width: 0;
            padding: 6px 4px;
            border: 0;
            color: #fff;
            font-size: 9px;
            font-weight: 800;
            line-height: 1.25;
            text-align: center;
            cursor: pointer;
        }

        .pv-action i {
            font-size: 14px;
        }

        .pv-action-note {
            background: #555;
        }

        .pv-action-teal {
            background: #00a6a6;
        }

        .pv-action-orange {
            background: #e69614;
        }

        .pv-action-pay {
            background: #9ab014;
            font-size: clamp(16px, 1.7vw, 27px);
            font-weight: 400;
        }

        .pv-action:hover {
            filter: brightness(.92);
        }

        .pv-feedback {
            display: none;
            margin: 0 0 8px;
            padding: 9px 11px;
            border-radius: 5px;
            color: #155e40;
            background: #e6f8ee;
            font-size: 11px;
        }

        .pv-feedback.show {
            display: block;
        }

        /* Ventanas emergentes */
        .pv-modal-backdrop {
            position: fixed;
            inset: 0;
            z-index: 10000;
            display: none;
            align-items: center;
            justify-content: center;
            padding: 18px;
            background: rgba(13,25,43,.48);
        }

        .pv-modal-backdrop.show {
            display: flex;
        }

        .pv-modal {
            width: min(100%, 480px);
            max-height: 90vh;
            overflow: auto;
            padding: 22px;
            border-radius: 12px;
            background: #fff;
            box-shadow: 0 15px 50px rgba(0,0,0,.22);
        }

        .pv-modal h2 {
            margin: 0 0 8px;
            color: #142d53;
            font-size: 18px;
        }

        .pv-modal p {
            margin: 0 0 16px;
            color: #718096;
            font-size: 12px;
        }

        .pv-modal-actions {
            display: flex;
            justify-content: flex-end;
            flex-wrap: wrap;
            gap: 9px;
            margin-top: 18px;
        }

        .pv-modal-actions button,
        .pv-size-button {
            border: 0;
            border-radius: 6px;
            padding: 10px 14px;
            font-size: 12px;
            font-weight: 700;
            cursor: pointer;
        }

        .pv-modal-cancel {
            background: #edf1f7;
            color: #34435e;
        }

        .pv-modal-save {
            background: #00a6a6;
            color: #fff;
        }

        .pv-size-options {
            display: flex;
            flex-wrap: wrap;
            gap: 9px;
        }

        .pv-size-button {
            min-width: 72px;
            color: #0b7d80;
            background: #e6f8f7;
        }

        .pv-size-button:disabled {
            opacity: .4;
            cursor: not-allowed;
        }

        .pv-history-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 11px;
        }

        .pv-history-table th,
        .pv-history-table td {
            padding: 9px 7px;
            border-bottom: 1px solid #e4e8ef;
            text-align: left;
        }

        .pv-history-table th {
            color: #33445d;
            background: #f4f6fa;
        }

        @media (max-width: 1100px) {
            .pv-action-grid {
                grid-template-columns: repeat(3, minmax(0,1fr));
            }

            .pv-action-pay {
                grid-column: span 3;
                min-height: 48px;
            }

            .pv-products-pane {
                padding: 8px;
            }

            .pv-product-grid {
                grid-template-columns: repeat(2, minmax(0,1fr));
            }
        }

        @media (max-width: 780px) {
            .pv-main {
                height: auto;
                min-height: calc(100vh - 20px);
                overflow: visible;
            }

            .pv-topbar {
                align-items: flex-start;
                flex-direction: column;
            }

            .pv-topbar-left,
            .pv-topbar-right {
                flex-wrap: wrap;
                gap: 8px;
            }

            .pv-workspace {
                grid-template-columns: minmax(0,1fr);
                overflow: visible;
            }

            .pv-products-pane {
                min-height: 520px;
                border-right: 0;
                border-bottom: 2px solid #d5dce6;
            }

            .pv-cart-pane {
                min-height: 600px;
            }

            .pv-product-grid {
                grid-template-columns: repeat(3, minmax(0,1fr));
            }

            .pv-product-card {
                height: 135px;
            }

            .pv-product-image {
                height: 89px;
            }

            .pv-action-grid {
                grid-template-columns: repeat(3, minmax(0,1fr));
            }

            .pv-action-pay {
                grid-column: span 3;
            }
        }

        @media (max-width: 500px) {
            .pv-product-grid {
                grid-template-columns: repeat(2, minmax(0,1fr));
            }

            .pv-search-row {
                grid-template-columns: minmax(0,1fr) 38px;
            }

            .pv-pos-label {
                grid-column: 1 / -1;
            }

            .pv-form-grid {
                grid-template-columns: minmax(0,1fr);
            }

            .pv-field.full {
                grid-column: auto;
            }

            .pv-cart-item {
                grid-template-columns: 23px minmax(0,1fr);
            }

            .pv-item-price {
                grid-column: 2;
            }
        }

        /* ==========================================================
           PALETA DEL DASHBOARD: azul, azul marino y fondos claros
           ========================================================== */
        :root {
            --pv-navy: #102653;
            --pv-blue: #2864F0;
            --pv-blue-dark: #174CC5;
            --pv-blue-light: #EAF0FF;
            --pv-page: #EEF2F8;
            --pv-border: #DCE5F1;
            --pv-text: #102653;
            --pv-muted: #75829A;
        }

        .pv-main {
            background: var(--pv-page);
        }

        .pv-topbar {
            background: var(--pv-navy);
            border-radius: 8px;
            box-shadow: 0 3px 10px rgba(16, 38, 83, .12);
        }

        .pv-topbar .pv-logout {
            background: #D94343;
            border-radius: 6px;
        }

        .pv-workspace {
            border: 1px solid var(--pv-border);
            border-radius: 12px;
            box-shadow: 0 5px 18px rgba(16, 38, 83, .07);
        }

        .pv-products-pane {
            background: #F0F4FB;
            border-right: 1px solid var(--pv-border);
        }

        .pv-pos-label {
            color: var(--pv-blue);
        }

        .pv-search-row input {
            border: 1px solid #C9D8F5;
            border-radius: 7px;
        }

        .pv-search-row input:focus {
            border-color: var(--pv-blue);
            box-shadow: 0 0 0 3px rgba(40, 100, 240, .13);
        }

        .pv-scan-button {
            background: var(--pv-navy);
            border-radius: 7px;
        }

        .pv-filter {
            background: var(--pv-blue);
            border-radius: 6px;
        }

        .pv-filter:hover,
        .pv-filter.active {
            background: var(--pv-blue-dark);
        }

        .pv-product-card {
            border: 1px solid #E4EAF4;
            border-radius: 8px;
            box-shadow: 0 2px 7px rgba(16, 38, 83, .06);
        }

        .pv-product-card:hover {
            outline: 2px solid var(--pv-blue);
        }

        .pv-product-image {
            background: #F7F9FD;
            color: #8A9AB4;
        }

        .pv-product-card .pv-stock {
            background: var(--pv-blue);
            border-radius: 0 0 5px 0;
        }

        .pv-product-footer {
            background: var(--pv-navy);
        }

        .pv-add-card {
            background: #DFE9FC;
            color: var(--pv-blue);
            border: 1px dashed #9CB8F5;
            border-radius: 8px;
        }

        .pv-add-card:hover {
            background: #D2E0FC;
        }

        .pv-cart-pane {
            background: #FFFFFF;
        }

        .pv-tabs {
            border-bottom-color: var(--pv-border);
            background: #F2F5FB;
        }

        .pv-tab {
            border-color: var(--pv-border);
            background: #EAF0FA;
            color: #52627D;
        }

        .pv-tab.active {
            background: #FFFFFF;
            color: var(--pv-blue);
            border-top: 2px solid var(--pv-blue);
        }

        .pv-cart-item {
            border-bottom-color: #E7EDF6;
        }

        .pv-item-info strong,
        .pv-item-price,
        .pv-form-pane h2 {
            color: var(--pv-navy);
        }

        .pv-quantity button {
            border-color: #D6E1F2;
            background: #F3F6FC;
            color: var(--pv-navy);
        }

        .pv-quantity button:hover {
            border-color: var(--pv-blue);
            color: var(--pv-blue);
            background: var(--pv-blue-light);
        }

        .pv-field input,
        .pv-field textarea,
        .pv-field select {
            border-color: #D6E1F2;
            border-radius: 7px;
        }

        .pv-field input:focus,
        .pv-field textarea:focus,
        .pv-field select:focus {
            outline: none;
            border-color: var(--pv-blue);
            box-shadow: 0 0 0 3px rgba(40, 100, 240, .12);
        }

        .pv-checkout {
            border-top-color: var(--pv-border);
        }

        .pv-total-row {
            border-top-color: var(--pv-border);
        }

        .pv-total-row strong,
        .pv-total-row span {
            color: var(--pv-blue);
        }

        .pv-action-note {
            background: var(--pv-navy);
        }

        .pv-action-teal {
            background: var(--pv-blue);
        }

        .pv-action-orange {
            background: #1F55D5;
        }

        .pv-action-pay {
            background: linear-gradient(135deg, #438AF8 0%, #2864F0 60%, #2056D8 100%);
            color: #FFFFFF;
            border-radius: 7px;
            box-shadow: 0 3px 8px rgba(40, 100, 240, .2);
            font-weight: 700;
        }

        .pv-action-pay:hover {
            filter: brightness(.96);
        }

        .pv-modal h2 {
            color: var(--pv-navy);
        }

        .pv-modal-save {
            background: var(--pv-blue);
        }

        .pv-modal-save:hover {
            background: var(--pv-blue-dark);
        }

        .pv-size-button {
            color: var(--pv-blue-dark);
            background: var(--pv-blue-light);
            border: 1px solid #D3E0FA;
        }

        .pv-size-button:hover:not(:disabled) {
            color: #FFFFFF;
            background: var(--pv-blue);
        }

        .pv-history-table th {
            color: var(--pv-navy);
            background: #EDF3FF;
        }

        .pv-history-table th,
        .pv-history-table td {
            border-bottom-color: #E2EAF5;
        }
    </style>
</head>
<body>

<div class="dashboard-container">

    <!-- MENÚ LATERAL COMPARTIDO -->
    <jsp:include page="/WEB-INF/vistas/menuLateral.jsp">
        <jsp:param name="opcion" value="puntoVenta"/>
        <jsp:param name="submenu" value=""/>
    </jsp:include>

    <main class="gastos-main pv-main">

        <header class="pv-topbar">
            <div class="pv-topbar-left">
                <span class="pv-store">
                    <i class="fa-solid fa-store"></i>
                    <strong>Tienda:</strong> PLAN BEACH
                </span>

                <span><strong>Caja registradora:</strong> Caja1</span>

                <button type="button" id="btnHistorialVentas">
                    <i class="fa-solid fa-receipt"></i> Ventas
                </button>
            </div>

            <div class="pv-topbar-right">
                <span><i class="fa-solid fa-user"></i> <strong>Administrador</strong></span>

                <button type="button" class="pv-logout" id="btnCerrarVenta">
                    CERRAR SESIÓN
                </button>
            </div>
        </header>

        <section class="pv-workspace" aria-label="Punto de venta">

            <!-- CATÁLOGO DE PRODUCTOS -->
            <section class="pv-products-pane">

                <div class="pv-search-row">
                    <label class="pv-pos-label" for="pvBuscar">POINT OF SALE</label>

                    <input type="search"
                           id="pvBuscar"
                           autocomplete="off"
                           placeholder="Buscar producto o escanear código..."
                           aria-label="Buscar producto o código de barras">

                    <button type="button"
                            class="pv-scan-button"
                            id="pvEscanear"
                            title="Escanear o introducir código">
                        <i class="fa-solid fa-barcode"></i>
                    </button>
                </div>

                <div class="pv-filter-row" role="group" aria-label="Filtros del catálogo">
                    <button type="button" class="pv-filter active" data-filtro="Todo">Todo</button>
                    <button type="button" class="pv-filter" data-filtro="descuento">En descuento</button>
                    <button type="button" class="pv-filter" data-filtro="destacado">Destacado</button>

                    <button type="button" class="pv-filter" id="pvNuevoProducto">
                        <i class="fa-solid fa-plus"></i> Añadir producto
                    </button>

                    <button type="button" class="pv-filter" id="pvEscanearBtn">
                        <i class="fa-solid fa-barcode"></i> Escanear producto
                    </button>
                </div>

                <div class="pv-product-grid" id="pvProductGrid" aria-live="polite"></div>

            </section>

            <!-- CARRITO / CLIENTE / DIRECCIÓN -->
            <section class="pv-cart-pane">

                <div class="pv-tabs" role="tablist" aria-label="Datos de venta">
                    <button type="button"
                            class="pv-tab active"
                            data-tab="carrito"
                            role="tab"
                            aria-selected="true">
                        <i class="fa-solid fa-cart-shopping"></i>
                        Carrito <span id="pvCantidadItems"></span>
                    </button>

                    <button type="button"
                            class="pv-tab"
                            data-tab="cliente"
                            role="tab"
                            aria-selected="false">
                        <i class="fa-solid fa-user"></i> Cliente
                    </button>

                    <button type="button"
                            class="pv-tab"
                            data-tab="direccion"
                            role="tab"
                            aria-selected="false">
                        <i class="fa-solid fa-location-dot"></i> Dirección
                    </button>
                </div>

                <div class="pv-tab-content active" id="pvPanelCarrito" role="tabpanel">
                    <div class="pv-cart-list" id="pvCartList"></div>
                </div>

                <div class="pv-tab-content" id="pvPanelCliente" role="tabpanel">
                    <div class="pv-form-pane">
                        <h2>Datos del cliente</h2>
                        <p>Información opcional para asociar esta venta a un cliente.</p>

                        <div class="pv-form-grid">
                            <div class="pv-field full">
                                <label for="pvClienteNombre">Nombre completo</label>
                                <input id="pvClienteNombre" type="text" maxlength="120"
                                       placeholder="Nombre del cliente">
                            </div>

                            <div class="pv-field">
                                <label for="pvClienteDocumento">Documento</label>
                                <input id="pvClienteDocumento" type="text" maxlength="20"
                                       placeholder="DNI / CE / RUC">
                            </div>

                            <div class="pv-field">
                                <label for="pvClienteTelefono">Teléfono</label>
                                <input id="pvClienteTelefono" type="tel" maxlength="25"
                                       placeholder="999 999 999">
                            </div>

                            <div class="pv-field full">
                                <label for="pvClienteEmail">Correo electrónico</label>
                                <input id="pvClienteEmail" type="email" maxlength="120"
                                       placeholder="cliente@correo.com">
                            </div>
                        </div>
                    </div>
                </div>

                <div class="pv-tab-content" id="pvPanelDireccion" role="tabpanel">
                    <div class="pv-form-pane">
                        <h2>Dirección de entrega</h2>
                        <p>Completa estos datos si la venta requiere envío.</p>

                        <div class="pv-form-grid">
                            <div class="pv-field full">
                                <label for="pvDireccion">Dirección</label>
                                <input id="pvDireccion" type="text" maxlength="180"
                                       placeholder="Av., calle, número, referencia...">
                            </div>

                            <div class="pv-field">
                                <label for="pvCiudad">Ciudad / distrito</label>
                                <input id="pvCiudad" type="text" maxlength="80"
                                       placeholder="Lima, San Miguel...">
                            </div>

                            <div class="pv-field">
                                <label for="pvCodigoPostal">Código postal</label>
                                <input id="pvCodigoPostal" type="text" maxlength="15"
                                       placeholder="15000">
                            </div>

                            <div class="pv-field full">
                                <label for="pvReferencia">Referencia</label>
                                <textarea id="pvReferencia" maxlength="250"
                                          placeholder="Referencia para encontrar la dirección"></textarea>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- TOTALES Y ACCIONES -->
                <footer class="pv-checkout">
                    <div id="pvFeedback" class="pv-feedback" role="status" aria-live="polite"></div>

                    <div class="pv-subtotal-row">
                        <span>SUBTOTAL (INCL. IMPUESTO)</span>
                        <strong id="pvSubtotal">S/ 0.00</strong>
                    </div>

                    <div class="pv-total-row">
                        <strong>TOTAL</strong>
                        <span id="pvTotal">S/ 0.00</span>
                    </div>

                    <div class="pv-adjustments">
                        <button type="button" class="pv-clear-cart" id="pvVaciar">
                            <i class="fa-solid fa-xmark"></i> VACIAR CARRITO
                        </button>
                    </div>

                    <div class="pv-action-grid">
                        <button type="button" class="pv-action pv-action-note" id="pvNota">
                            <i class="fa-solid fa-note-sticky"></i> AÑADIR NOTA
                        </button>

                        <button type="button" class="pv-action pv-action-teal" id="pvDescuento">
                            <i class="fa-solid fa-percent"></i> AÑADIR RECARGO O DESCUENTO
                        </button>

                        <button type="button" class="pv-action pv-action-teal" id="pvCupon">
                            <i class="fa-solid fa-ticket"></i> APLICAR CUPÓN
                        </button>

                        <button type="button" class="pv-action pv-action-teal" id="pvEnvio">
                            <i class="fa-solid fa-truck"></i> ENVÍO
                        </button>

                        <button type="button" class="pv-action pv-action-orange" id="pvSuspender">
                            <i class="fa-solid fa-box-archive"></i> SUSPENDER Y GUARDAR EL CARRITO
                        </button>

                        <button type="button" class="pv-action pv-action-pay" id="pvPagar">
                            PAGAR
                        </button>
                    </div>
                </footer>

            </section>
        </section>
    </main>
</div>

<!-- MODAL DE TALLAS -->
<div class="pv-modal-backdrop"
     id="pvModalTalla"
     role="dialog"
     aria-modal="true"
     aria-labelledby="pvTituloTalla">
    <div class="pv-modal">
        <h2 id="pvTituloTalla">Seleccionar talla</h2>
        <p id="pvTextoTalla">Selecciona una talla disponible.</p>
        <div class="pv-size-options" id="pvTallasOpciones"></div>
        <div class="pv-modal-actions">
            <button type="button" class="pv-modal-cancel" data-cerrar="pvModalTalla">
                Cancelar
            </button>
        </div>
    </div>
</div>

<!-- MODAL DE NUEVO PRODUCTO (DEMO) -->
<div class="pv-modal-backdrop"
     id="pvModalProducto"
     role="dialog"
     aria-modal="true"
     aria-labelledby="pvTituloProducto">
    <div class="pv-modal">
        <h2 id="pvTituloProducto">Añadir producto de demostración</h2>
        <p>El producto se agregará únicamente al catálogo de demostración de este navegador.</p>

        <form id="pvFormProducto">
            <div class="pv-form-grid">
                <div class="pv-field full">
                    <label for="pvNuevoNombre">Nombre *</label>
                    <input id="pvNuevoNombre" required maxlength="100">
                </div>

                <div class="pv-field">
                    <label for="pvNuevoCodigo">Código de barras</label>
                    <input id="pvNuevoCodigo" maxlength="40">
                </div>

                <div class="pv-field">
                    <label for="pvNuevoPrecio">Precio (S/) *</label>
                    <input id="pvNuevoPrecio" type="number" min="0" step="0.01" required>
                </div>

                <div class="pv-field">
                    <label for="pvNuevoStock">Stock total *</label>
                    <input id="pvNuevoStock" type="number" min="0" max="99999" value="40" required>
                </div>

                <div class="pv-field">
                    <label for="pvNuevoCategoria">Categoría</label>
                    <select id="pvNuevoCategoria">
                        <option>Ropa deportiva</option>
                        <option>Suplementos</option>
                        <option>Accesorios</option>
                        <option>Bebidas</option>
                    </select>
                </div>
            </div>

            <div class="pv-modal-actions">
                <button type="button" class="pv-modal-cancel" data-cerrar="pvModalProducto">
                    Cancelar
                </button>
                <button type="submit" class="pv-modal-save">Añadir al catálogo</button>
            </div>
        </form>
    </div>
</div>

<!-- MODAL DE HISTORIAL -->
<div class="pv-modal-backdrop"
     id="pvModalVentas"
     role="dialog"
     aria-modal="true"
     aria-labelledby="pvTituloVentas">
    <div class="pv-modal" style="width:min(100%,800px)">
        <h2 id="pvTituloVentas">Historial de ventas de demostración</h2>
        <p>Las ventas de esta pantalla se almacenan solamente en el navegador.</p>
        <div id="pvHistorialContenido"></div>
        <div class="pv-modal-actions">
            <button type="button" class="pv-modal-cancel" data-cerrar="pvModalVentas">
                Cerrar
            </button>
        </div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js/menu.js"></script>

<script>
document.addEventListener("DOMContentLoaded", function () {
    "use strict";

    const contexto = '<%= request.getContextPath() %>';
    const KEY_PRODUCTS = "pv_productos_demo";
    const KEY_SALES = "pv_ventas_demo";
    const KEY_SUSPENDED = "pv_carritos_suspendidos";

    let filtroActual = "Todo";
    let carrito = [];
    let descuentoManual = 0;
    let descuentoCupon = 0;
    let envio = 0;
    let notaVenta = "";
    let productoSeleccionado = null;

    const inputBuscar = document.getElementById("pvBuscar");
    const grid = document.getElementById("pvProductGrid");
    const listaCarrito = document.getElementById("pvCartList");
    const feedback = document.getElementById("pvFeedback");

    function productosIniciales() {
        const nombres = [
            ["ENDLESS SUM PT J BDSH KVJ7", 50.00, false, true, "7750000000001", "Ropa deportiva"],
            ["FIFTY50 LB", 50.00, true, false, "7750000000002", "Ropa deportiva"],
            ["SUNDAYS STRETCH LB", 55.00, true, false, "7750000000003", "Ropa deportiva"],
            ["EVDAYVL15 M JAMV KVJ0", 30.00, false, true, "7750000000004", "Ropa deportiva"],
            ["EVDAYVL15 M JAMV GPHH", 30.00, false, false, "7750000000005", "Ropa deportiva"],
            ["EVDAYVL15 M JAMV BSMH", 30.00, false, false, "7750000000006", "Ropa deportiva"],
            ["EVDAYVL15 M JAMV CPHH", 30.00, false, false, "7750000000007", "Ropa deportiva"],
            ["ISLANDPVL15 M JAMV BPZ6", 46.00, false, false, "7750000000008", "Ropa deportiva"],
            ["SUNFADVL17 M JAMV KTA6", 46.00, true, false, "7750000000009", "Ropa deportiva"]
        ];

        return nombres.map(function (d, i) {
            return {
                id: "pv-" + (i + 1),
                nombre: d[0],
                precio: d[1],
                destacado: d[2],
                descuento: d[3],
                codigo: d[4],
                categoria: d[5],
                marca: "PLAN BEACH",
                tallas: {"S": 10, "M": 10, "L": 10, "XL": 10}
            };
        });
    }

    function leerJSON(clave, predeterminado) {
        try {
            const valor = localStorage.getItem(clave);
            return valor === null ? predeterminado : JSON.parse(valor);
        } catch (e) {
            return predeterminado;
        }
    }

    function obtenerProductos() {
        let lista = leerJSON(KEY_PRODUCTS, null);

        if (!Array.isArray(lista)) {
            lista = productosIniciales();
            guardarProductos(lista);
        }

        return lista;
    }

    function guardarProductos(lista) {
        localStorage.setItem(KEY_PRODUCTS, JSON.stringify(lista));
    }

    function stockTotal(producto) {
        if (producto.tallas && typeof producto.tallas === "object") {
            return Object.keys(producto.tallas).reduce(function (s, talla) {
                return s + Math.max(0, Number(producto.tallas[talla]) || 0);
            }, 0);
        }

        return Math.max(0, Number(producto.stock) || 0);
    }

    function obtenerEstado(producto) {
        const s = stockTotal(producto);
        return s <= 0 ? "agotado" : (s <= 5 ? "bajo" : "disponible");
    }

    function formatoDinero(valor) {
        return "S/ " + (Number(valor) || 0).toLocaleString("es-PE", {
            minimumFractionDigits: 2,
            maximumFractionDigits: 2
        });
    }

    function escapar(texto) {
        return String(texto == null ? "" : texto).replace(/[&<>"']/g, function (c) {
            return {
                "&": "&amp;",
                "<": "&lt;",
                ">": "&gt;",
                "\"": "&quot;",
                "'": "&#39;"
            }[c];
        });
    }

    function mostrarFeedback(texto) {
        feedback.textContent = texto;
        feedback.classList.add("show");
    }

    function ocultarFeedback() {
        feedback.textContent = "";
        feedback.classList.remove("show");
    }

    function crearBoton(texto, clase, alClick) {
        const b = document.createElement("button");
        b.type = "button";
        b.className = clase || "";
        b.textContent = texto;
        b.addEventListener("click", alClick);
        return b;
    }

    function renderizarProductos() {
        const lista = obtenerProductos();
        const q = inputBuscar.value.trim().toLocaleLowerCase("es");

        grid.replaceChildren();

        const agregar = document.createElement("button");
        agregar.type = "button";
        agregar.className = "pv-product-card pv-add-card";
        agregar.title = "Añadir producto de demostración";

        const plus = document.createElement("span");
        plus.textContent = "+";
        agregar.appendChild(plus);
        agregar.addEventListener("click", abrirNuevoProducto);
        grid.appendChild(agregar);

        const filtrados = lista.filter(function (p) {
            const texto = [p.nombre, p.codigo, p.categoria, p.marca]
                .join(" ")
                .toLocaleLowerCase("es");

            const coincideTexto = texto.includes(q);
            const coincideFiltro = filtroActual === "Todo"
                || (filtroActual === "descuento" && p.descuento)
                || (filtroActual === "destacado" && p.destacado);

            return coincideTexto && coincideFiltro;
        });

        filtrados.forEach(function (p) {
            const card = document.createElement("button");
            card.type = "button";
            card.className = "pv-product-card";
            card.title = "Agregar " + p.nombre + " al carrito";

            const stock = document.createElement("span");
            stock.className = "pv-stock";
            stock.textContent = stockTotal(p) === 0
                ? "AGOTADO"
                : "Stock: " + stockTotal(p);

            if (stockTotal(p) === 0) {
                stock.style.background = "#c84635";
            }

            card.appendChild(stock);

            if (p.descuento) {
                const oferta = document.createElement("span");
                oferta.className = "pv-offer";
                oferta.textContent = "OFERTA";
                card.appendChild(oferta);
            }

            const imagen = document.createElement("div");
            imagen.className = "pv-product-image";
            imagen.textContent = p.imagenData ? "IMAGEN CONFIGURADA" : "SIN IMAGEN";
            card.appendChild(imagen);

            const footer = document.createElement("div");
            footer.className = "pv-product-footer";

            const nombre = document.createElement("span");
            nombre.className = "pv-product-name";
            nombre.textContent = p.nombre;

            const precio = document.createElement("span");
            precio.className = "pv-product-price";
            precio.textContent = formatoDinero(p.precio);

            footer.appendChild(nombre);
            footer.appendChild(precio);
            card.appendChild(footer);

            card.addEventListener("click", function () {
                seleccionarProducto(p.id);
            });

            grid.appendChild(card);
        });

        if (filtrados.length === 0) {
            const vacio = document.createElement("p");
            vacio.className = "pv-empty-products";
            vacio.textContent = "No se encontraron productos con ese filtro.";
            grid.appendChild(vacio);
        }
    }

    function obtenerProductoPorId(id) {
        return obtenerProductos().find(function (p) {
            return String(p.id) === String(id);
        });
    }

    function seleccionarProducto(id) {
        const p = obtenerProductoPorId(id);
        if (!p) return;

        if (stockTotal(p) <= 0) {
            alert("Este producto está agotado.");
            return;
        }

        productoSeleccionado = p;

        const opciones = document.getElementById("pvTallasOpciones");
        opciones.replaceChildren();

        document.getElementById("pvTituloTalla").textContent = p.nombre;

        document.getElementById("pvTextoTalla").textContent =
            p.tallas && Object.keys(p.tallas).length
            ? "Selecciona una talla disponible. El número indica unidades restantes."
            : "Confirma para agregar el producto al carrito.";

        const tallas = p.tallas && Object.keys(p.tallas).length
            ? Object.keys(p.tallas)
            : [""];

        tallas.forEach(function (talla) {
            const stock = talla
                ? Number(p.tallas[talla]) || 0
                : stockTotal(p);

            let enCarrito = 0;

            carrito.forEach(function (it) {
                if (String(it.productoId) === String(p.id) && it.talla === talla) {
                    enCarrito += it.cantidad;
                }
            });

            const libre = Math.max(0, stock - enCarrito);
            const etiqueta = talla ? (talla + " · " + libre) : "Agregar";

            const btn = crearBoton(etiqueta, "pv-size-button", function () {
                if (libre <= 0) return;
                agregarAlCarrito(p.id, talla);
                cerrarModal("pvModalTalla");
            });

            btn.disabled = libre <= 0;
            opciones.appendChild(btn);
        });

        abrirModal("pvModalTalla");
    }

    function agregarAlCarrito(productoId, talla) {
        const p = obtenerProductoPorId(productoId);
        if (!p) return;

        const claveTalla = talla || "";

        const existencia = claveTalla && p.tallas
            ? (Number(p.tallas[claveTalla]) || 0)
            : stockTotal(p);

        const existente = carrito.find(function (it) {
            return String(it.productoId) === String(productoId)
                && it.talla === claveTalla;
        });

        if (existente) {
            if (existente.cantidad + 1 > existencia) {
                alert("No hay más unidades disponibles de este producto/talla.");
                return;
            }

            existente.cantidad++;
        } else {
            carrito.push({
                productoId: p.id,
                talla: claveTalla,
                cantidad: 1
            });
        }

        ocultarFeedback();
        renderizarCarrito();
    }

    function cambiarCantidad(productoId, talla, delta) {
        const item = carrito.find(function (it) {
            return String(it.productoId) === String(productoId)
                && it.talla === talla;
        });

        if (!item) return;

        if (delta < 0 && item.cantidad <= 1) {
            carrito = carrito.filter(function (it) {
                return it !== item;
            });
        } else if (delta > 0) {
            const p = obtenerProductoPorId(productoId);

            const stock = talla && p && p.tallas
                ? Number(p.tallas[talla]) || 0
                : (p ? stockTotal(p) : 0);

            if (item.cantidad + 1 > stock) {
                alert("No hay stock suficiente.");
                return;
            }

            item.cantidad++;
        } else {
            item.cantidad--;
        }

        renderizarCarrito();
    }

    function subtotal() {
        return carrito.reduce(function (s, item) {
            const p = obtenerProductoPorId(item.productoId);
            return s + (p ? Number(p.precio) * item.cantidad : 0);
        }, 0);
    }

    function calcularTotal() {
        return Math.max(0, subtotal() - descuentoManual - descuentoCupon + envio);
    }

    function renderizarCarrito() {
        listaCarrito.replaceChildren();

        let cantidad = 0;

        carrito.forEach(function (item) {
            const p = obtenerProductoPorId(item.productoId);
            if (!p) return;

            cantidad += item.cantidad;

            const fila = document.createElement("div");
            fila.className = "pv-cart-item";

            const quitar = crearBoton("×", "pv-remove-item", function () {
                carrito = carrito.filter(function (it) {
                    return it !== item;
                });
                renderizarCarrito();
            });

            quitar.title = "Quitar del carrito";
            fila.appendChild(quitar);

            const info = document.createElement("div");
            info.className = "pv-item-info";

            const nombre = document.createElement("strong");
            nombre.textContent = p.nombre;
            info.appendChild(nombre);

            const detalle = document.createElement("small");
            detalle.textContent = "Código: " + (p.codigo || "—")
                + (item.talla ? " · Talla: " + item.talla : "");

            info.appendChild(detalle);

            const controles = document.createElement("div");
            controles.className = "pv-quantity";

            controles.appendChild(crearBoton("−", "", function () {
                cambiarCantidad(item.productoId, item.talla, -1);
            }));

            const qty = document.createElement("span");
            qty.textContent = item.cantidad;
            controles.appendChild(qty);

            controles.appendChild(crearBoton("+", "", function () {
                cambiarCantidad(item.productoId, item.talla, 1);
            }));

            info.appendChild(controles);
            fila.appendChild(info);

            const precio = document.createElement("strong");
            precio.className = "pv-item-price";
            precio.textContent = formatoDinero(Number(p.precio) * item.cantidad);
            fila.appendChild(precio);

            listaCarrito.appendChild(fila);
        });

        if (carrito.length === 0) {
            const vacio = document.createElement("div");
            vacio.className = "pv-cart-empty";

            const icono = document.createElement("i");
            icono.className = "fa-solid fa-cart-shopping";

            vacio.appendChild(icono);
            vacio.appendChild(document.createTextNode(
                "El carrito está vacío. Selecciona un producto para comenzar."
            ));

            listaCarrito.appendChild(vacio);
        }

        document.getElementById("pvCantidadItems").textContent =
            cantidad ? "(" + cantidad + ")" : "";

        document.getElementById("pvSubtotal").textContent = formatoDinero(subtotal());
        document.getElementById("pvTotal").textContent = formatoDinero(calcularTotal());
    }

    function cambiarPestana(nombre) {
        document.querySelectorAll(".pv-tab").forEach(function (tab) {
            const activa = tab.getAttribute("data-tab") === nombre;
            tab.classList.toggle("active", activa);
            tab.setAttribute("aria-selected", activa ? "true" : "false");
        });

        document.querySelectorAll(".pv-tab-content").forEach(function (panel) {
            panel.classList.toggle(
                "active",
                panel.id === "pvPanel"
                    + nombre.charAt(0).toUpperCase()
                    + nombre.slice(1)
            );
        });
    }

    function abrirModal(id) {
        document.getElementById(id).classList.add("show");
    }

    function cerrarModal(id) {
        document.getElementById(id).classList.remove("show");
    }

    document.querySelectorAll("[data-cerrar]").forEach(function (b) {
        b.addEventListener("click", function () {
            cerrarModal(b.getAttribute("data-cerrar"));
        });
    });

    document.querySelectorAll(".pv-modal-backdrop").forEach(function (fondo) {
        fondo.addEventListener("click", function (e) {
            if (e.target === fondo) fondo.classList.remove("show");
        });
    });

    document.querySelectorAll(".pv-filter[data-filtro]").forEach(function (btn) {
        btn.addEventListener("click", function () {
            filtroActual = btn.getAttribute("data-filtro");

            document.querySelectorAll(".pv-filter[data-filtro]").forEach(function (otro) {
                otro.classList.toggle("active", otro === btn);
            });

            renderizarProductos();
        });
    });

    document.querySelectorAll(".pv-tab").forEach(function (tab) {
        tab.addEventListener("click", function () {
            cambiarPestana(tab.getAttribute("data-tab"));
        });
    });

    inputBuscar.addEventListener("input", renderizarProductos);

    inputBuscar.addEventListener("keydown", function (e) {
        if (e.key !== "Enter") return;

        e.preventDefault();

        const texto = inputBuscar.value.trim().toLocaleLowerCase("es");
        if (!texto) return;

        const lista = obtenerProductos();

        const p = lista.find(function (x) {
            return String(x.codigo || "").toLocaleLowerCase("es") === texto
                || String(x.nombre || "").toLocaleLowerCase("es") === texto;
        });

        if (p) {
            seleccionarProducto(p.id);
            inputBuscar.value = "";
            renderizarProductos();
        } else {
            renderizarProductos();
            mostrarFeedback("No se encontró un producto con ese código o nombre exacto.");
        }
    });

    function activarEscaneo() {
        inputBuscar.focus();
        inputBuscar.select();
        mostrarFeedback("Escribe o escanea el código de barras y pulsa Enter.");
    }

    document.getElementById("pvEscanear").addEventListener("click", activarEscaneo);
    document.getElementById("pvEscanearBtn").addEventListener("click", activarEscaneo);

    function abrirNuevoProducto() {
        document.getElementById("pvFormProducto").reset();
        document.getElementById("pvNuevoStock").value = "40";
        abrirModal("pvModalProducto");
        document.getElementById("pvNuevoNombre").focus();
    }

    document.getElementById("pvNuevoProducto").addEventListener("click", abrirNuevoProducto);

    document.getElementById("pvFormProducto").addEventListener("submit", function (e) {
        e.preventDefault();

        const nombre = document.getElementById("pvNuevoNombre").value.trim();
        const codigo = document.getElementById("pvNuevoCodigo").value.trim();
        const precio = Number(document.getElementById("pvNuevoPrecio").value);
        const stock = Number(document.getElementById("pvNuevoStock").value);
        const categoria = document.getElementById("pvNuevoCategoria").value;

        if (!nombre || !Number.isFinite(precio) || precio < 0
                || !Number.isInteger(stock) || stock < 0) {
            alert("Revisa el nombre, precio y stock del producto.");
            return;
        }

        const lista = obtenerProductos();

        if (codigo && lista.some(function (p) {
            return String(p.codigo || "").toLowerCase() === codigo.toLowerCase();
        })) {
            alert("Ya existe un producto con ese código de barras.");
            return;
        }

        const tallas = {};
        const base = Math.floor(stock / 4);
        const resto = stock % 4;

        ["S", "M", "L", "XL"].forEach(function (t, i) {
            tallas[t] = base + (i < resto ? 1 : 0);
        });

        lista.push({
            id: "pv-" + Date.now(),
            nombre: nombre.toUpperCase(),
            codigo: codigo,
            precio: precio,
            destacado: false,
            descuento: false,
            categoria: categoria,
            marca: "Sin marca",
            tallas: tallas
        });

        guardarProductos(lista);
        cerrarModal("pvModalProducto");
        renderizarProductos();
        mostrarFeedback("Producto agregado al catálogo de demostración.");
    });

    document.getElementById("pvVaciar").addEventListener("click", function () {
        if (carrito.length === 0) {
            mostrarFeedback("El carrito ya está vacío.");
            return;
        }

        if (!confirm("¿Deseas vaciar todos los productos del carrito?")) return;

        carrito = [];
        descuentoManual = 0;
        descuentoCupon = 0;
        envio = 0;
        notaVenta = "";

        renderizarCarrito();
        mostrarFeedback("Carrito vaciado.");
    });

    document.getElementById("pvNota").addEventListener("click", function () {
        const valor = prompt("Nota del pedido:", notaVenta);

        if (valor !== null) {
            notaVenta = valor.trim();
            mostrarFeedback(notaVenta ? "Nota agregada a la venta." : "Nota eliminada.");
        }
    });

    document.getElementById("pvDescuento").addEventListener("click", function () {
        const valor = prompt(
            "Importe en S/. Usa positivo para descuento y negativo para recargo:",
            String(descuentoManual)
        );

        if (valor === null) return;

        const n = Number(valor.replace(",", "."));

        if (!Number.isFinite(n)) {
            alert("Ingresa un importe numérico válido.");
            return;
        }

        descuentoManual = n;
        renderizarCarrito();

        mostrarFeedback(
            n > 0 ? "Descuento aplicado."
                : (n < 0 ? "Recargo aplicado." : "Descuento/recargo quitado.")
        );
    });

    document.getElementById("pvCupon").addEventListener("click", function () {
        const codigo = prompt("Código del cupón (demo: DESC10):");
        if (codigo === null) return;

        if (codigo.trim().toUpperCase() === "DESC10") {
            descuentoCupon = subtotal() * 0.10;
            renderizarCarrito();
            mostrarFeedback("Cupón DESC10 aplicado: 10% de descuento.");
        } else {
            descuentoCupon = 0;
            renderizarCarrito();
            alert("Cupón no válido. Para esta demostración puedes usar DESC10.");
        }
    });

    document.getElementById("pvEnvio").addEventListener("click", function () {
        const valor = prompt("Costo de envío en S/:", String(envio));
        if (valor === null) return;

        const n = Number(valor.replace(",", "."));

        if (!Number.isFinite(n) || n < 0) {
            alert("El costo de envío debe ser un número mayor o igual a cero.");
            return;
        }

        envio = n;
        renderizarCarrito();
        mostrarFeedback("Costo de envío actualizado.");
    });

    document.getElementById("pvSuspender").addEventListener("click", function () {
        if (carrito.length === 0) {
            alert("No puedes suspender un carrito vacío.");
            return;
        }

        const suspendidos = leerJSON(KEY_SUSPENDED, []);

        suspendidos.push({
            fecha: new Date().toLocaleString("es-PE"),
            items: carrito,
            cliente: document.getElementById("pvClienteNombre").value.trim(),
            direccion: document.getElementById("pvDireccion").value.trim(),
            descuentoManual: descuentoManual,
            descuentoCupon: descuentoCupon,
            envio: envio,
            nota: notaVenta,
            subtotal: subtotal(),
            total: calcularTotal()
        });

        localStorage.setItem(KEY_SUSPENDED, JSON.stringify(suspendidos));

        carrito = [];
        descuentoManual = 0;
        descuentoCupon = 0;
        envio = 0;
        notaVenta = "";

        renderizarCarrito();
        mostrarFeedback("Carrito suspendido y guardado temporalmente en este navegador.");
    });

    document.getElementById("pvPagar").addEventListener("click", function () {
        if (carrito.length === 0) {
            alert("El carrito está vacío.");
            return;
        }

        const metodo = prompt(
            "Total a pagar: " + formatoDinero(calcularTotal())
            + "\nEscribe el método: Efectivo, Tarjeta o Transferencia",
            "Efectivo"
        );

        if (metodo === null) return;

        const metodoLimpio = metodo.trim();
        const metodosValidos = ["efectivo", "tarjeta", "transferencia"];

        if (!metodosValidos.includes(metodoLimpio.toLocaleLowerCase("es"))) {
            alert("Método no válido. Usa Efectivo, Tarjeta o Transferencia.");
            return;
        }

        const lista = obtenerProductos();

        for (let i = 0; i < carrito.length; i++) {
            const item = carrito[i];

            const p = lista.find(function (x) {
                return String(x.id) === String(item.productoId);
            });

            if (!p) {
                alert("No se encontró uno de los productos del carrito.");
                return;
            }

            if (item.talla && p.tallas
                    && (Number(p.tallas[item.talla]) || 0) < item.cantidad) {
                alert("Stock insuficiente para " + p.nombre + " talla " + item.talla + ".");
                return;
            }
        }

        carrito.forEach(function (item) {
            const p = lista.find(function (x) {
                return String(x.id) === String(item.productoId);
            });

            if (p && item.talla && p.tallas) {
                p.tallas[item.talla] = Math.max(
                    0,
                    (Number(p.tallas[item.talla]) || 0) - item.cantidad
                );
            }
        });

        guardarProductos(lista);

        const ventas = leerJSON(KEY_SALES, []);

        ventas.unshift({
            id: "V-" + Date.now(),
            fecha: new Date().toLocaleString("es-PE"),
            cliente: document.getElementById("pvClienteNombre").value.trim()
                || "Público general",
            metodo: metodoLimpio,
            subtotal: subtotal(),
            descuento: descuentoManual + descuentoCupon,
            envio: envio,
            total: calcularTotal(),
            articulos: carrito.reduce(function (s, i) {
                return s + i.cantidad;
            }, 0),
            nota: notaVenta
        });

        localStorage.setItem(KEY_SALES, JSON.stringify(ventas));

        const totalPagado = calcularTotal();

        carrito = [];
        descuentoManual = 0;
        descuentoCupon = 0;
        envio = 0;
        notaVenta = "";

        renderizarCarrito();
        renderizarProductos();

        mostrarFeedback(
            "Venta de demostración registrada: "
            + formatoDinero(totalPagado)
            + " · " + metodoLimpio
            + ". No se guardó en el servidor."
        );

        cambiarPestana("carrito");

        document.getElementById("pvClienteNombre").value = "";
        document.getElementById("pvClienteDocumento").value = "";
        document.getElementById("pvClienteTelefono").value = "";
        document.getElementById("pvClienteEmail").value = "";
        document.getElementById("pvDireccion").value = "";
        document.getElementById("pvCiudad").value = "";
        document.getElementById("pvCodigoPostal").value = "";
        document.getElementById("pvReferencia").value = "";
    });

    function mostrarHistorial() {
        const ventas = leerJSON(KEY_SALES, []);
        const contenedor = document.getElementById("pvHistorialContenido");

        contenedor.replaceChildren();

        if (!ventas.length) {
            const p = document.createElement("p");
            p.textContent = "Todavía no hay ventas registradas en esta demostración.";
            contenedor.appendChild(p);
        } else {
            const table = document.createElement("table");
            table.className = "pv-history-table";

            const thead = document.createElement("thead");
            const trh = document.createElement("tr");

            ["N.º", "Fecha", "Cliente", "Método", "Artículos", "Total"]
                .forEach(function (t) {
                    const th = document.createElement("th");
                    th.textContent = t;
                    trh.appendChild(th);
                });

            thead.appendChild(trh);
            table.appendChild(thead);

            const tbody = document.createElement("tbody");

            ventas.forEach(function (v) {
                const tr = document.createElement("tr");

                [v.id, v.fecha, v.cliente, v.metodo, String(v.articulos),
                    formatoDinero(v.total)].forEach(function (t) {
                    const td = document.createElement("td");
                    td.textContent = t;
                    tr.appendChild(td);
                });

                tbody.appendChild(tr);
            });

            table.appendChild(tbody);
            contenedor.appendChild(table);
        }

        abrirModal("pvModalVentas");
    }

    document.getElementById("btnHistorialVentas")
        .addEventListener("click", mostrarHistorial);

    document.getElementById("btnCerrarVenta")
        .addEventListener("click", function () {
            if (confirm("¿Deseas cerrar la sesión?")) {
                window.location.href =
                    contexto + "/UsuarioController?accion=cerrarSesion";
            }
        });

    // Inicio de la pantalla.
    renderizarProductos();
    renderizarCarrito();
});
</script>

</body>
</html>
