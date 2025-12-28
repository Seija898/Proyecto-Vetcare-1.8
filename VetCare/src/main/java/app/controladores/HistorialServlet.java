package app.controladores;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import app.data.HistorialClinicoDAO;
import app.data.CitaDAO;
import app.modelos.HistorialClinico;
import app.modelos.Mascota;
import app.modelos.Veterinaio;
import app.modelos.Citas;

@WebServlet("/historial")
public class HistorialServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private HistorialClinicoDAO historialDAO = new HistorialClinicoDAO();
    private CitaDAO citaDAO = new CitaDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	
    	request.setCharacterEncoding("UTF-8");
    	response.setContentType("text/html; charset=UTF-8");
    	
    	
    	
        String action = request.getParameter("action");
        if (action == null || action.isEmpty()) {
            action = "listar";
        }

        switch (action) {
            case "listar":
                listarHistoriales(request, response);
                break;

            case "registro":
                mostrarFormularioRegistro(request, response);
                break;

            default:
                listarHistoriales(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    	request.setCharacterEncoding("UTF-8");
    	response.setContentType("text/html; charset=UTF-8");
    	
    	
        String action = request.getParameter("action");

        if ("guardar".equals(action)) {
            registrarHistorial(request, response);
        }
    }


    // LISTAR TODOS LOS HISTORIALES
 private void listarHistoriales(HttpServletRequest request, HttpServletResponse response)
         throws ServletException, IOException {

     String busqueda = request.getParameter("busqueda");
     List<HistorialClinico> historiales;
     
     if (busqueda != null && !busqueda.trim().isEmpty()) {
         historiales = historialDAO.buscarPorPaciente(busqueda.trim());
         request.setAttribute("mensaje", "Resultados para: " + busqueda);
         request.setAttribute("busqueda", busqueda); 
     } else {
         historiales = historialDAO.listarTodo();
     }
     
     request.setAttribute("historiales", historiales);

     request.getRequestDispatcher("/WEB-INF/vetcare/historialClinico.jsp")
            .forward(request, response);
 }

    // MOSTRAR FORMULARIO REGISTRO
    private void mostrarFormularioRegistro(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("/WEB-INF/vetcare/registroAtencion.jsp")
               .forward(request, response);
    }

    // REGISTRAR HISTORIAL
    private void registrarHistorial(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        int idCita = 0;

        try {
            idCita = Integer.parseInt(request.getParameter("idCita"));
            int idMascota = Integer.parseInt(request.getParameter("idMascota"));
            String diagnostico = request.getParameter("diagnostico");
            String tratamiento = request.getParameter("tratamiento");
            String observaciones = request.getParameter("observaciones");

            System.out.println("=== DEBUG HISTORIAL ===");
            System.out.println("idCita: " + idCita);
            System.out.println("idMascota: " + idMascota);
            System.out.println("diagnostico: " + diagnostico);
            System.out.println("tratamiento: " + tratamiento);

            if (diagnostico == null || diagnostico.trim().isEmpty()) {
                request.setAttribute("error", "El diagnóstico es obligatorio");
                volverFormulario(request, response, idCita, null);
                return;
            }

            if (tratamiento == null || tratamiento.trim().isEmpty()) {
                request.setAttribute("error", "El tratamiento es obligatorio");
                volverFormulario(request, response, idCita, null);
                return;
            }

            HttpSession session = request.getSession();
            Integer idVeterinario = (Integer) session.getAttribute("idVeterinario");
            if (idVeterinario == null) {
                idVeterinario = 1;
            }

            HistorialClinico historial = new HistorialClinico();
            historial.setIdCita(idCita); // ← LÍNEA NUEVA
            historial.setDiagnostico(diagnostico.trim());
            historial.setTratamiento(tratamiento.trim());
            historial.setObservaciones(observaciones != null ? observaciones.trim() : "");

            Mascota mascota = new Mascota();
            mascota.setIdMascota(idMascota);
            historial.setMascota(mascota);

            Veterinaio veterinario = new Veterinaio();
            veterinario.setIdVeterinario(idVeterinario);
            historial.setVeterinario(veterinario);

            boolean guardado = historialDAO.registrar(historial);

            System.out.println("Resultado guardado: " + guardado);

            if (guardado) {
                try {
                    citaDAO.actualizarEstado(idCita, "Atendida");
                } catch (Exception e) {
                    System.out.println("Advertencia: No se pudo actualizar el estado de la cita");
                    e.printStackTrace();
                }

                response.sendRedirect(request.getContextPath() + "/historial?action=listar&success=true");
            } else {
                request.setAttribute("error", "No se pudo guardar el historial en la base de datos");
                volverFormulario(request, response, idCita, historial);
            }

        } catch (NumberFormatException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error: Los IDs deben ser números válidos");
            volverFormulario(request, response, idCita, null);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error al registrar historial: " + e.getMessage());
            volverFormulario(request, response, idCita, null);
        }
    }
    

    // VOLVER AL FORMULARIO EN CASO DE ERROR
    private void volverFormulario(HttpServletRequest request, HttpServletResponse response, int idCita, HistorialClinico h)
            throws ServletException, IOException {

        if (idCita > 0) {
            try {
                Citas cita = citaDAO.obtenerPorId(idCita);
                request.setAttribute("cita", cita);
                System.out.println("Cita recargada en volverFormulario: " + (cita != null));
            } catch (Exception e) {
                System.out.println("Error al recargar cita: " + e.getMessage());
                e.printStackTrace();
            }
        }

        if (h != null) {
            request.setAttribute("historial", h);
        }

        request.getRequestDispatcher("/WEB-INF/vetcare/registroAtencion.jsp")
               .forward(request, response);
    }
}