<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="app.modelos.Citas" %>
<%
    Citas cita = (Citas) request.getAttribute("cita");
   
    Integer idVeterinario = (Integer) session.getAttribute("idVeterinario");
%>

<!DOCTYPE html>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet"
     integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
    <meta charset="UTF-8">
    <link rel="stylesheet" href="../CSS/css.css">
    <title>Sistema Vetcare</title>
</head>
<body>

<jsp:include page="/WEB-INF/includes/navbar.jsp" />

    <div class="flex-grow-1" style="margin-left: 280px;">

        <nav class="navbar navbar-expand-lg navbar-light bg-white border-bottom shadow-sm sticky-top">
    <div class="container-fluid">
        <div class="d-flex align-items-center ms-auto">
            <div class="dropdown">
                <button class="btn btn-light d-flex align-items-center gap-2 dropdown-toggle" 
                        type="button" id="dropdownUsuario" data-bs-toggle="dropdown" aria-expanded="false">
                    <div class="bg-primary text-white rounded-circle d-flex align-items-center justify-content-center fw-bold" 
                         style="width: 40px; height: 40px;">
                        ?
                    </div>
                    <div class="text-start d-none d-md-block">
                        <div class="fw-semibold small">Iniciar Sesión</div>
                        <div class="text-muted" style="font-size: 0.8rem;">Veterinario</div>
                    </div>
                </button>
                <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="dropdownUsuario">
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
               
        <div class="container mt-4">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="card shadow-sm">
                        <div class="card-header bg-primary text-white">
                            <h4 class="mb-0">📋 Registro de Historial Clínico</h4>
                        </div>
                        <div class="card-body p-4">
                            
                          
								<% if ("true".equals(request.getParameter("success"))) { %>
								    <div class="alert alert-success alert-dismissible fade show" role="alert">
								        ✅ <strong>Historial guardado correctamente</strong>.
								        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
								    </div>
								<% } %>

							
								<% if (cita == null) { %>
								    <div class="alert alert-warning">
								        ⚠️ No hay una cita cargada. Accede desde la lista de citas.
								    </div>
								<% } else { %>
							
                            
                           
                          <form id="formHistorial"action="${pageContext.request.contextPath}/historial" method="post">
								<input type="hidden" name="action" value="guardar">
                              <input type="hidden" name="idCita" value="<%= cita.getIdCita() %>">
							<input type="hidden" name="idMascota" value="<%= cita.getMascota().getIdMascota() %>">

                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <label class="form-label fw-semibold">Paciente (Mascota)</label>
                                        <input type="text" class="form-control"
                                               value="<%= cita.getMascota() != null ? cita.getMascota().getNombre() : "" %>" readonly>
                                    </div>
                            
                                    <div class="col-md-6">
                                        <label class="form-label fw-semibold">Especie</label>
                                        <input type="text" class="form-control"
                                               value="<%= cita.getMascota() != null ? cita.getMascota().getTipo() : "" %>" readonly>
                                    </div>
                                </div>

                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <label class="form-label fw-semibold">Dueño</label>
                                        <input type="text" class="form-control"
                                               value="<%= cita.getMascota() != null ? cita.getMascota().getDueno() : "" %>" readonly>
                                    </div>
                            
                                    
                                </div>

                                <div class="row mb-3">
                                    <div class="col-md-12">
                                        <label class="form-label fw-semibold">Fecha de Atención</label>
                                        <input type="date" class="form-control"
                                               value="<%= cita.getFecha() %>" readonly>
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label fw-semibold">Diagnóstico <span class="text-danger">*</span></label>
                                    <textarea class="form-control"
                                              name="diagnostico"
                                              rows="3"
                                              placeholder="Descripción detallada del diagnóstico..."
                                              required></textarea>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label fw-semibold">Tratamiento <span class="text-danger">*</span></label>
                                    <textarea class="form-control"
                                              name="tratamiento"
                                              rows="4"
                                              placeholder="Medicamentos, dosis, indicaciones..."
                                              required></textarea>
                                </div>

                                <div class="mb-4">
                                    <label class="form-label fw-semibold">Observaciones (opcional)</label>
                                    <textarea class="form-control"
                                              name="observaciones"
                                              rows="3"
                                              placeholder="Información adicional relevante..."></textarea>
                                </div>
                            
                                <div class="d-flex gap-2 justify-content-end">
                                  <button type="button" id="btnCancelar" class="btn btn-outline-secondary px-4">
									    Cancelar
									</button>

                                    <button type="reset" class="btn btn-outline-secondary px-4">
                                        Limpiar
                                    </button>
                                    <button type="button" id="btnGuardarHistorial" class="btn btn-primary px-4">
							            💾 Guardar Historial
							        </button>
                                </div>
                             </form>
                            <% } %>
                            
                        </div>
                    </div>
                </div>
            </div>
        </div>
              
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" 
    integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script>
// BOTÓN CANCELAR
document.getElementById("btnCancelar").addEventListener("click", function () {
    Swal.fire({
        title: "¿Seguro que deseas cancelar?",
        text: "Los cambios no se guardarán",
        icon: "warning",
        showCancelButton: true,
        confirmButtonText: "Sí, cancelar",
        cancelButtonText: "Seguir editando"
    }).then((result) => {
        if (result.isConfirmed) {
            window.location.href =
                "${pageContext.request.contextPath}/vetcare?action=listarAtencion";
        }
    });
});

document.getElementById("btnGuardarHistorial").addEventListener("click", function () {

    const diagnostico = document.querySelector('textarea[name="diagnostico"]').value.trim();
    const tratamiento = document.querySelector('textarea[name="tratamiento"]').value.trim();

    if (diagnostico === "" || tratamiento === "") {
        Swal.fire({
            icon: "error",
            title: "Campos obligatorios incompletos",
            text: "Por favor completa el diagnóstico y el tratamiento antes de guardar"
        });
        return; 
    }

    Swal.fire({
        title: "¿Guardar historial clínico?",
        text: "Se guardarán los datos ingresados",
        icon: "question",
        showCancelButton: true,
        confirmButtonText: "Guardar",
        cancelButtonText: "Cancelar"
    }).then((result) => {
        if (result.isConfirmed) {
            document.getElementById("formHistorial").submit();
        }
    });
});
</script>
</body>
</html>