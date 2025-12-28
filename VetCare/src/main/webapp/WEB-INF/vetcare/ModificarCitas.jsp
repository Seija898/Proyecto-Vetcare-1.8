<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
 <%@ page import="app.modelos.Citas" %>
<%
    Citas c = (Citas) request.getAttribute("cita");
%>

    
<!DOCTYPE html>
<html>
<head>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet"
	 integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
	<meta charset="UTF-8">
	<title>Modificar Cita - Sistema Vetcare</title>
	<style>
		body {
			overflow-x: hidden;
		}
	</style>
</head>
<body>
	<jsp:include page="/WEB-INF/includes/navbar.jsp" />

    <div class="flex-grow-1" style="margin-left: 280px;">
        <nav class="navbar navbar-expand-lg navbar-light bg-white border-bottom shadow-sm sticky-top">
            <div class="container-fluid">

                <div class="d-flex align-items-center gap-3 ms-auto">
                    <!-- Perfil de usuario -->
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
			

			<main class="p-4">
				<div class="row">
					<div class="col-lg-8">
						<div class="card border-0 shadow-sm border-start border-warning border-4">
							<div class="card-body p-4">
								<%
									String success = request.getParameter("success");
									if ("true".equals(success)) {
								%>
									<div class="alert alert-success alert-dismissible fade show" role="alert">
										✅ <strong>¡Éxito!</strong> La cita fue modificada correctamente.
										<button type="button" class="btn-close" data-bs-dismiss="alert"></button>
									</div>
								<%
									}
								%>
								
								<form id="formCita" action="${pageContext.request.contextPath}/vetcare" method="POST">
									<input type="hidden" name="action" value="actualizar">
									<input type="hidden" name="idCita" value="<%= c.getIdCita() %>">
									
									<div class="mb-4">
										<h5 class="fw-bold text-dark mb-3 pb-2 border-bottom">
											<i class="bi bi-pencil-square text-warning me-2"></i>Modificar cita del Paciente
										</h5>
										<p class="fs-6 fw-light text-warning mb-3">Actualice la información de la cita</p>
										
										<div class="row g-3">
											<div class="col-md-6">
												<label for="paciente" class="form-label fw-semibold">Nombre del Paciente</label>
												<input type="text" class="form-control" id="paciente" name="paciente"
      											 value="<%= c.getMascota().getNombre() %>" readonly>

											</div>
										   
											<div class="col-md-6">
												<label for="propietario" class="form-label fw-semibold">Dueño</label>
												<input type="text" class="form-control" id="propietario" name="propietario"
     												  value="<%= c.getMascota().getDueno() %>" readonly>
											</div>
											
									<select class="form-select" id="mascota" name="mascota" disabled>
									    <option value="" disabled>Seleccione el tipo...</option>
									    <option value="perro"  ${cita.mascota.tipo == 'perro' ? 'selected' : ''}>Perro</option>
									    <option value="gato"   ${cita.mascota.tipo == 'gato' ? 'selected' : ''}>Gato</option>
									    <option value="conejo" ${cita.mascota.tipo == 'conejo' ? 'selected' : ''}>Conejo</option>
									    <option value="hamster" ${cita.mascota.tipo == 'hamster' ? 'selected' : ''}>Hámster</option>
									    <option value="cobayo"  ${cita.mascota.tipo == 'cobayo' ? 'selected' : ''}>Cobayo / Cuy</option>
									    <option value="loro"    ${cita.mascota.tipo == 'loro' ? 'selected' : ''}>Loro / Aves pequeñas</option>
									    <option value="tortuga" ${cita.mascota.tipo == 'tortuga' ? 'selected' : ''}>Tortuga / Reptiles pequeños</option>
									    <option value="peces"   ${cita.mascota.tipo == 'peces' ? 'selected' : ''}>Peces ornamentales</option>
									    <option value="erizo"   ${cita.mascota.tipo == 'erizo' ? 'selected' : ''}>Erizo africano</option>
									    <option value="chinchilla" ${cita.mascota.tipo == 'chinchilla' ? 'selected' : ''}>Chinchilla</option>
									    <option value="huron" ${cita.mascota.tipo == 'huron' ? 'selected' : ''}>Hurón</option>
									</select>
									</div>
									</div>

									<div class="mb-4">
										<h5 class="fw-bold text-dark mb-3 pb-2 border-bottom">
											<i class="bi bi-calendar-check text-warning me-2"></i>Detalles de la Cita
										</h5>
										
										<div class="row g-3">
											<div class="col-md-6">
												<label for="fecha" class="form-label fw-semibold">Fecha de la Cita</label>
												<input type="date" class="form-control" id="fecha" name="fecha"
     													  value="<%= c.getFecha() %>" required>
		
											</div>
											
											<div class="col-md-6">
												<label for="hora" class="form-label fw-semibold">Hora</label>
												<input type="time" class="form-control" id="hora" name="hora"
      													 value="<%= c.getHora() %>" required>

											</div>
											
											<div class="col-md-6">
											    <label for="tipoConsulta" class="form-label fw-semibold">Tipo de Consulta</label>
											    <select class="form-select" id="tipoConsulta" name="tipoConsulta" required>
											        <option value="" disabled <%= c.getTipoConsulta() == null ? "selected" : "" %>>Seleccione el tipo...</option>
											        <option value="chequeo" <%= "chequeo".equals(c.getTipoConsulta()) ? "selected" : "" %>>Chequeo General</option>
											        <option value="vacunacion" <%= "vacunacion".equals(c.getTipoConsulta()) ? "selected" : "" %>>Vacunación</option>
											        <option value="cirugia" <%= "cirugia".equals(c.getTipoConsulta()) ? "selected" : "" %>>Cirugía</option>
											        <option value="urgencia" <%= "urgencia".equals(c.getTipoConsulta()) ? "selected" : "" %>>Urgencia</option>
											        <option value="control" <%= "control".equals(c.getTipoConsulta()) ? "selected" : "" %>>Control Post-operatorio</option>
											        <option value="dermatologia" <%= "dermatologia".equals(c.getTipoConsulta()) ? "selected" : "" %>>Dermatología</option>
											        <option value="odontologia" <%= "odontologia".equals(c.getTipoConsulta()) ? "selected" : "" %>>Odontología</option>
											        <option value="otro" <%= "otro".equals(c.getTipoConsulta()) ? "selected" : "" %>>Otro</option>
											    </select>
											</div>
											
											<div class="col-md-6">
												<label for="estado" class="form-label fw-semibold">Estado de la Cita</label>
												<select class="form-select" id="estado" name="estado" required>
													<option value="PROGRAMADA" <%= "PROGRAMADA".equals(c.getEstado()) ? "selected" : "" %>>Programada</option>
													<option value="CONFIRMADA" <%= "CONFIRMADA".equals(c.getEstado()) ? "selected" : "" %>>Confirmada</option>
													<option value="CANCELADA" <%= "CANCELADA".equals(c.getEstado()) ? "selected" : "" %>>Cancelada</option>
													<option value="COMPLETADA" <%= "COMPLETADA".equals(c.getEstado()) ? "selected" : "" %>>Completada</option>
												</select>

											</div>
											
											<div class="col-12">
												<label for="motivo" class="form-label fw-semibold">Motivo de Consulta</label>
												<textarea class="form-control" id="motivo" name="motivo" rows="3" required><%= c.getMotivo() %></textarea>

											</div>
											
											<div class="col-12">
												<label for="observaciones" class="form-label fw-semibold">Observaciones Adicionales</label>
												<textarea class="form-control" id="observaciones" name="observaciones" rows="2"><%= c.getObservaciones() %></textarea>

											</div>
										</div>
									</div>

									<div class="d-flex gap-2 justify-content-end">
								    <button type="button" class="btn btn-outline-secondary px-4" onclick="confirmarCancelar()">
								        <i class="bi bi-x-lg me-2"></i>Cancelar
								    </button>
								
								    <button type="button" class="btn btn-warning" onclick="confirmarGuardar()">
									    Guardar Modificación
									</button>
									
								</div>
								</form>
							</div>
						</div>
					</div>

					<div class="col-lg-4">
						<div class="card border-0 shadow-sm border-start border-warning border-4">
							<div class="card-body">
								<h6 class="fw-bold text-dark mb-3">
									<i class="bi bi-exclamation-triangle text-warning me-2"></i>Importante
								</h6>
								<div class="small text-muted">
									<p class="mb-2"><strong>Al modificar una cita:</strong></p>
									<ul class="mb-3">
										<li>Los datos del paciente no pueden modificarse</li>
										<li>Puede cambiar fecha, hora y tipo de consulta</li>
										<li>Puede actualizar el estado de la cita</li>
									</ul>
									<p class="mb-0"><i class="bi bi-info-circle me-1"></i>Los cambios se aplicarán inmediatamente.</p>
								</div>
							</div>
						</div>
					</div>
				</div>
			</main>
		</div>
	</div>

	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" 
	integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script>
function confirmarCancelar() {
    Swal.fire({
        title: "¿Cancelar modificación?",
        text: "Los cambios no se guardarán",
        icon: "warning",
        showCancelButton: true,
        confirmButtonText: "Sí, cancelar",
        cancelButtonText: "Seguir editando"
    }).then((result) => {
        if (result.isConfirmed) {
            window.location.href =  "<%= request.getContextPath() %>/vetcare?action=listarAtencion";
        }
    });
}
</script>

<script>
function confirmarGuardar() {
    Swal.fire({
        title: "¿Guardar cambios?",
        text: "La cita será actualizada",
        icon: "question",
        showCancelButton: true,
        confirmButtonText: "Guardar",
        cancelButtonText: "Cancelar"
    }).then((result) => {
        if(result.isConfirmed){
            document.getElementById("formCita").submit();
        }
    });
}
</script>
</body>
</html>
