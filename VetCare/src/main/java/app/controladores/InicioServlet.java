package app.controladores;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/InicioServlet")
public class InicioServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        //VALIDAR SESIÓN 
        HttpSession sesion = request.getSession(false);
        if (sesion == null || sesion.getAttribute("usuario") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        //CONTROLADOR CENTRAL 
        String accion = request.getParameter("accion");

        if (accion == null) {
            request.getRequestDispatcher("inicio.jsp").forward(request, response);
            return;
        }

        switch (accion) {

            case "mascotas":
                response.sendRedirect("MascotaServlet?accion=listar");
                break;

            default:
                request.getRequestDispatcher("inicio.jsp").forward(request, response);
                break;
        }
    }
}
