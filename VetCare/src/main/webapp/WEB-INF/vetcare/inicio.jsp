<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.List, java.util.ArrayList" %>
<%@ page import="app.modelos.Citas" %>


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
	 <link rel="stylesheet" href="CSS/css.css">
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
					        <a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/logout">
					            <i class="bi bi-box-arrow-right me-2"></i>
					            Cerrar Sesión
					        </a>
					    </li>
					</ul>
						</div>
					</div>
				</div>
			</nav>
    
    <main class="contenido-principal p-2">
    
	    <div class="mb-4">
		    <H1 class="class="display-6 fw-bold text-dark mb-2">Panel de control</H1>
	    	 <p class="mb-0">Bienvenido de nuevo, aquí está el resumen de hoy</p>
	    </div>

        <div class="card border-0 shadow-sm ">
            <div class="card-body ">
            
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h3 class="fw-bold mb-0">Próximas Citas</h3>
                    
                    
                    <div class="d-flexd-flex justify-content-around mb-4">
	                    	<a href="${pageContext.request.contextPath}/vetcare?action=registro"
							   class="btn btn-primary fw-semibold px-4">
							   <i class="bi bi-plus-lg me-2"></i>Nueva Cita
							</a>


								<a href="${pageContext.request.contextPath}/vetcare?action=listarAtencion"
								   class="btn btn-outline-primary fw-semibold px-4">
								   📋 Ver citas
								</a>
                    </div>
                </div>
                
                <div class="d-flex flex-column gap-3">
                
		    <%
		    if (citas == null || citas.isEmpty()) {
			%>
	        <div class="appointment-card card border shadow-sm">
	            <div class="card-body py-3 text-center text-muted">
	                <h5>No hay citas registradas</h5>
	            </div>
	        </div>
			<%
			    } else {
			        for (Citas c : citas) {
			%>
        <div class="appointment-card card border shadow-sm">
            <div class="card-body py-3">

                <div class="d-flex justify-content-between">
                    <strong>
                        <%= c.getMascota().getNombre() %> | 
                        <%= c.getMascota().getTipo() %>
                    </strong>

                    <span class="badge bg-primary">
                        <%= c.getHora() %>
                    </span>
                </div>

                <div class="d-flex justify-content-between text-muted mt-1">
                    <span>
                        <%= c.getMascota().getDueno() %> | 
                        <%= c.getTipoConsulta() %>
                    </span>

                    <small>
                        <%= c.getFecha() %>
                    </small>
                </div>

            </div>
        </div>
		<%} }%>
                </div>
            </div>
        </div>
    	
    </main>
    
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" 
		integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
		
</body>
</html>