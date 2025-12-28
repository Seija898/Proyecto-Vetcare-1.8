package app.controladores;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import app.data.CitaDAO;
import app.data.MascotaDAO;
import app.modelos.Citas;
import app.modelos.Mascota;


/**
 * Servlet implementation class citaServlet
 */
@WebServlet("/vetcare")
public class CitasServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
			String action = request.getParameter("action");
		
		if("guardar".equals(action)) {
			guardarCitas(request, response);
		}
		if ("actualizar".equals(action)) {
		    actualizarCita(request, response);
		}

			
	}
	

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
	        mostrarCitas(request, response);
	        break;

	    case "registro":
	        FormularioRegistro(request, response);
	        break;

	    case "registroAtencion":
	        mostrarRegistroAtencion(request, response);
	        break;

	    case "eliminar":
	        eliminarCita(request, response);
	        break;

	    case "editar":
	        editarCita(request, response);
	        break;

	    case "listarAtencion":
	        mostrarAtenciones(request, response);
	        break;
	}

	}
	
	private void mostrarRegistroAtencion(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {

	    int idCita = Integer.parseInt(request.getParameter("idCita"));

	    CitaDAO dao = new CitaDAO();
	    Citas cita = dao.obtenerPorId(idCita);

	    request.setAttribute("cita", cita);

	    request.getRequestDispatcher("/WEB-INF/vetcare/registroAtencion.jsp")
	           .forward(request, response);
	}

	
	
	private void FormularioRegistro(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {

	    request.getRequestDispatcher("/WEB-INF/vetcare/registroCitas.jsp")
	           .forward(request, response);
	}


	
	private void actualizarCita(HttpServletRequest request, HttpServletResponse response)
	        throws IOException {

	    Citas c = new Citas();
	    c.setIdCita(Integer.parseInt(request.getParameter("idCita")));
	    c.setFecha(LocalDate.parse(request.getParameter("fecha")));
	    c.setHora(LocalTime.parse(request.getParameter("hora")));
	    c.setTipoConsulta(request.getParameter("tipoConsulta"));
	    c.setEstado(request.getParameter("estado"));
	    c.setMotivo(request.getParameter("motivo"));
	    c.setObservaciones(request.getParameter("observaciones"));


	    CitaDAO dao = new CitaDAO();
	    dao.actualizar(c);
	    
	    response.sendRedirect(request.getContextPath() + "/vetcare?action=listarAtencion&success=true");


	}

	private void editarCita(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {

	    int idCita = Integer.parseInt(request.getParameter("idCita"));

	    CitaDAO dao = new CitaDAO();
	    Citas cita = dao.obtenerPorId(idCita);

	    request.setAttribute("cita", cita);
	    request.getRequestDispatcher("/WEB-INF/vetcare/ModificarCitas.jsp")
	       .forward(request, response);

	}


	private void mostrarAtenciones(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {

	    CitaDAO dao = new CitaDAO();
	    List<Citas> citas = dao.listarCitasPendientes();

	    request.setAttribute("listacitas", citas);
	    request.getRequestDispatcher("/WEB-INF/vetcare/historialAtencion.jsp")
	           .forward(request, response);
	}

	

	private void mostrarCitas(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {

		CitaDAO dao = new CitaDAO();
	    List<Citas> citas = dao.listarCitasPendientes();
	    request.setAttribute("listacitas", citas);
	    request.getRequestDispatcher("/WEB-INF/vetcare/inicio.jsp").forward(request, response);
	}


	private void eliminarCita(HttpServletRequest request, HttpServletResponse response)
	        throws IOException {

	    int idCita = Integer.parseInt(request.getParameter("idCita"));

	    CitaDAO dao = new CitaDAO();
	    boolean eliminado = dao.eliminar(idCita);

	    if (eliminado) {
	        response.sendRedirect(request.getContextPath() + "/vetcare?action=listarAtencion&successEliminar=true");
	    } else {
	        response.sendRedirect(request.getContextPath() + "/vetcare?action=listarAtencion&errorEliminar=true");
	    }
	}


	
	public void guardarCitas(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {
	    // ===== Datos del Paciente =====
	    String paciente     = request.getParameter("paciente");
	    String propietario  = request.getParameter("propietario");
	    String tipoMascota  = request.getParameter("mascota");
	    
	    // ===== Datos de la Cita =====
	    LocalDate fecha     = LocalDate.parse(request.getParameter("fecha"));
	    LocalTime hora      = LocalTime.parse(request.getParameter("hora"));
	    String tipoConsulta = request.getParameter("tipoConsulta");
	    String estado = "PROGRAMADA"; 
	    
	    String motivo        = request.getParameter("motivo");
	    String observaciones = request.getParameter("observaciones");

	    MascotaDAO mascotaDao = new MascotaDAO();
	    int idMascota = mascotaDao.guardar(
	            paciente,
	            tipoMascota,
	            propietario,
	            null 
	    );

	    Mascota mascota = new Mascota();
	    mascota.setIdMascota(idMascota);

	    CitaDAO citaDao = new CitaDAO();
	    citaDao.guardar(
	            mascota,
	            fecha,
	            hora,
	            tipoConsulta,
	            estado,
	            motivo,
	            observaciones
	    );
	    
	    response.sendRedirect(request.getContextPath() + "/vetcare?action=listar");


	}

}
