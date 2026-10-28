<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="theme-color" content="#101513">
    <title>Iniciar sesión | Xport Fitness Gym</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Barlow+Condensed:wght@500;600;700;800&family=DM+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
</head>
<body>
    <main class="login-layout">
        <section class="hero" aria-label="Bienvenido a Xport Fitness Gym">
            <div class="hero-art" aria-hidden="true"></div>
            <div class="hero-top">
                <a class="brand" href="${pageContext.request.contextPath}/UsuarioController?accion=login" aria-label="Xport Fitness Gym, inicio">
                    <span class="brand-mark"><svg viewBox="0 0 48 48" role="img" aria-hidden="true"><path d="M8 17v14M14 12v24M34 12v24M40 17v14M14 24h20"/><path d="M5 17h6M5 31h6M37 17h6M37 31h6"/></svg></span>
                    <span class="brand-name"><strong>XPORT</strong><small>FITNESS GYM</small></span>
                </a>
                <span class="open-badge"><i></i> TU ESPACIO, TU RITMO</span>
            </div>
            <div class="hero-copy">
                <p class="eyebrow"><span></span> MÁS FUERTE CADA DÍA</p>
                <h1>ENTRENA<br>CON <em>PROPÓSITO.</em></h1>
                <p class="hero-description">Tu progreso empieza con una decisión.<br>Nosotros te acompañamos en cada repetición.</p>
                <div class="hero-meta"><span class="meta-icon">✳</span><span>FUERZA <b>•</b> ENERGÍA <b>•</b> CONSTANCIA</span></div>
            </div>
            <div class="hero-bottom"><span class="line"></span><span>SUPERA TU MEJOR VERSIÓN</span><span class="hero-year">XFG&nbsp; / &nbsp;FITNESS CLUB</span></div>
        </section>

        <section class="form-side">
            <div class="mobile-brand"><span class="brand-mark"><svg viewBox="0 0 48 48" aria-hidden="true"><path d="M8 17v14M14 12v24M34 12v24M40 17v14M14 24h20M5 17h6M5 31h6M37 17h6M37 31h6"/></svg></span><span class="brand-name"><strong>XPORT</strong><small>FITNESS GYM</small></span></div>
            <div class="form-wrap">
                <div class="form-heading">
                    <p class="eyebrow form-eyebrow">ÁREA DE MIEMBROS</p>
                    <h2>Qué bueno<br>tenerte de vuelta.</h2>
                    <p>Inicia sesión para continuar con tu entrenamiento.</p>
                </div>

                <form action="${pageContext.request.contextPath}/UsuarioController" method="post">
                    <input type="hidden" name="accion" value="autenticar">
                    <div class="field">
                        <label for="usuario">Usuario</label>
                        <div class="input-wrap"><svg viewBox="0 0 24 24" aria-hidden="true"><circle cx="12" cy="8" r="4"/><path d="M4 21a8 8 0 0 1 16 0"/></svg><input type="text" id="usuario" name="usuario" placeholder="Tu usuario" autocomplete="username" required autofocus></div>
                    </div>
                    <div class="field">
                        <label for="contrasena">Contraseña</label>
                        <div class="input-wrap"><svg viewBox="0 0 24 24" aria-hidden="true"><rect x="4" y="10" width="16" height="11" rx="2"/><path d="M8 10V7a4 4 0 0 1 8 0v3M12 14v3"/></svg><input type="password" id="contrasena" name="contrasena" placeholder="Tu contraseña" autocomplete="current-password" required><button class="toggle-password" type="button" aria-label="Mostrar contraseña" aria-pressed="false"><svg viewBox="0 0 24 24" aria-hidden="true"><path d="M2 12s3.6-7 10-7 10 7 10 7-3.6 7-10 7S2 12 2 12Z"/><circle cx="12" cy="12" r="3"/></svg></button></div>
                    </div>
                    <div class="form-options"><label class="remember"><input type="checkbox" name="recordarme"><span class="checkmark"></span>Recordarme</label><span class="help-text">¿Problemas para ingresar? Consulta en recepción.</span></div>
                    <% if (request.getAttribute("errorLogin") != null) { %>
                        <div class="login-error" role="alert"><span aria-hidden="true">!</span><%= request.getAttribute("errorLogin") %></div>
                    <% } %>
                    <button type="submit" class="submit-button"><span>INGRESAR</span><svg viewBox="0 0 24 24" aria-hidden="true"><path d="M5 12h14M13 6l6 6-6 6"/></svg></button>
                </form>
                <div class="secure-note"><svg viewBox="0 0 24 24" aria-hidden="true"><path d="M12 22s8-4 8-11V5l-8-3-8 3v6c0 7 8 11 8 11Z"/><path d="m9 12 2 2 4-4"/></svg>Acceso seguro para miembros</div>
            </div>
            <footer class="form-footer"><span>© 2026 Xport Fitness Gym</span><span>ENTRENA. CRECE. REPITE.</span></footer>
        </section>
    </main>
    <script>
        (function () {
            var toggle = document.querySelector('.toggle-password');
            var password = document.getElementById('contrasena');
            toggle.addEventListener('click', function () {
                var visible = password.type === 'password';
                password.type = visible ? 'text' : 'password';
                toggle.setAttribute('aria-pressed', visible ? 'true' : 'false');
                toggle.setAttribute('aria-label', visible ? 'Ocultar contraseña' : 'Mostrar contraseña');
            });
        }());
    </script>
</body>
</html>
