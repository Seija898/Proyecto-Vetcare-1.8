<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="app.modelos.Citas" %>
<%@ page import="java.util.ArrayList" %>

<%
		List<Citas> citas = (List<Citas>) request.getAttribute("listacitas");
		if (citas == null) {
		    citas = new ArrayList<>();
		}

%>
    
<!DOCTYPE html>
<html>
<head>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet"
	 integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
<meta charset="UTF-8">

<title>Sistema Vetcare</title>

</head>
<body>
		<jsp:include page="/WEB-INF/includes/navbar.jsp" />

    <div class="flex-grow-1" style="margin-left: 280px;">
        <nav class="navbar navbar-expand-lg navbar-light bg-white border-bottom shadow-sm sticky-top">
            <div class="container-fluid">
 
                <div class="d-flex align-items-center gap-3 ms-auto">
                    <div class="dropdown">
                        <button class="btn btn-light d-flex align-items-center gap-2 dropdown-toggle" type="button" data-bs-toggle="dropdown">
                            <div class="bg-primary text-white rounded-circle d-flex align-items-center justify-content-center fw-bold" style="width: 40px; height: 40px;">
                                ?
                            </div>
                            <div class="text-start d-none d-md-block">
                                <div class="fw-semibold small">Iniciar Sesion</div>
                                <div class="text-muted" style="font-size: 0.8rem;">Veterinario</div>
                            </div>
                        </button>
                       <ul class="dropdown-menu dropdown-menu-end">
					    <li>
					        <a class="dropdown-item text-danger"  href="${pageContext.request.contextPath}/logout">
					            <i class="bi bi-box-arrow-right me-2"></i>
					            Cerrar Sesión
					        </a>
					    </li>
					</ul>
						</div>
					</div>
				</div>
			</nav>
			
    

    <main class="contenido-principal p-4">
   <% if ("true".equals(request.getParameter("successEliminar"))) { %>
    <div class="alert alert-success alert-dismissible fade show" role="alert">
        ✅ Cita eliminada correctamente
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
<% } %>

<% if ("true".equals(request.getParameter("errorEliminar"))) { %>
    <div class="alert alert-danger alert-dismissible fade show" role="alert">
        ❌ No se pudo eliminar la cita
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
<% } %>

    	<div class="mb-4">
		    <h1 class="display-6 fw-bold text-dark mb-2">Atenciones Pendientes</h1>
	    	<p class="mb-0">Gestiona las citas y atenciones programadas</p>
	    </div>
	    
    	<div class="container-fluid">
    		<div class="row g-4">
    		
<%
    if (citas == null || citas.isEmpty()) {
%>
    	<div class="col-12">
    		<div class="card border-0 shadow-sm">
	    		<div class="card-body py-5 text-center">
	    			<i class="bi bi-calendar-x text-muted" style="font-size: 4rem;"></i>
	    			<h4 class="text-muted mt-3">No hay atenciones pendientes</h4>
	    			<p class="text-muted">Las citas programadas aparecerán aquí</p>
	    		</div>
	    	</div>
    	</div>
<%
    } else {
        for (Citas c : citas) {
%>

<div class="col-xl-4 col-lg-6 col-md-6 col-12">
    <div class="card border-0 shadow-sm h-100 hover-card">
        <div class="card-body p-4">

            <div class="d-flex justify-content-between align-items-start mb-3">
	            <div>
		            <h4 class="card-title fw-bold mb-1">
		                <%= c.getMascota().getNombre() %>
		            </h4>
		            <span class="badge bg-info text-white">
		                <%= c.getMascota().getTipo() %>
		            </span>
	            </div>
	            <span class="badge bg-primary fs-6">
	                <%= c.getHora() %>
	            </span>
            </div>

            <p class="text-muted mb-3">
                <i class="bi bi-person me-2"></i><strong>Dueño:</strong> <%= c.getMascota().getDueno() %>
            </p>
            
            <hr>

            <div class="mb-3">
                <p class="mb-2">
                    <i class="bi bi-journal-medical me-2 text-primary"></i>
                    <strong>Tipo de consulta:</strong><br>
                    <span class="ms-4"><%= c.getTipoConsulta() %></span>
                </p>
                
                
                <p class="mb-2">
				    <i class="bi bi-chat-left-text me-2 text-secondary"></i>
				    <strong>Motivo de consulta:</strong><br>
				    <span class="ms-4"><%= c.getMotivo() %></span>
				</p>
                
                
                <p class="mb-0">
                    <i class="bi bi-calendar-event me-2 text-success"></i>
                    <strong>Fecha:</strong> <%= c.getFecha() %>
                </p>
            </div>

            <div class="d-grid gap-2 mt-4">
            <a href="${pageContext.request.contextPath}/vetcare?action=registroAtencion&idCita=<%= c.getIdCita() %>"
			   class="btn btn-success fw-semibold">
			   <i class="bi bi-clipboard-pulse me-2"></i>Abrir Consulta
			</a>
                <div class="d-flex gap-2">
	                <a href="${pageContext.request.contextPath}/vetcare?action=editar&idCita=<%= c.getIdCita() %>"
					   class="btn btn-warning text-white flex-fill fw-semibold">
					   <i class="bi bi-pencil me-1"></i>Modificar	</a>

	               <button type="button" class="btn btn-danger flex-fill fw-semibold" onclick="confirmarCancelar('<%= c.getIdCita() %>')">
					    <i class="bi bi-x-circle me-1"></i>Cancelar
					</button>

                </div>
            </div>

			     </div>
			    </div>
			</div>
			
			<%	} }	%>	
    		</div>
    	</div>
    	
   </main>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" 
		integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
		 <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
		<script>
function confirmarCancelar(idCita) {
    Swal.fire({
        title: "¿Seguro que deseas cancelar esta cita?",
        text: "Esta acción no se puede deshacer",
        icon: "warning",
        showCancelButton: true,
        confirmButtonColor: "#d33",
        confirmButtonText: "Sí, cancelar",
        cancelButtonText: "No"
    }).then((result) => {
        if (result.isConfirmed) {
            window.location.href = "<%= request.getContextPath() %>/vetcare?action=eliminar&idCita=" + idCita;
        }
    });
}
</script>
</body>
</html>