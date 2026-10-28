package com.registro.controller;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/** Restringe las vistas Facelets a usuarios autenticados. */
@WebFilter(urlPatterns = {"*.xhtml", "/ClienteController", "/PersonalController", "/UsuarioController"})
public class AutenticacionFilter implements Filter {
    @Override public void init(FilterConfig filterConfig) {}
    @Override public void destroy() {}

    @Override
    public void doFilter(jakarta.servlet.ServletRequest request,
                         jakarta.servlet.ServletResponse response,
                         FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        String path = req.getServletPath();
        if ("/login.xhtml".equals(path) || "/index.xhtml".equals(path)) {
            chain.doFilter(request, response);
            return;
        }
        if (req.getSession(false) == null
                || req.getSession(false).getAttribute("usuarioAutenticado") == null) {
            res.sendRedirect(req.getContextPath() + "/login.xhtml");
            return;
        }
        chain.doFilter(request, response);
    }
}
