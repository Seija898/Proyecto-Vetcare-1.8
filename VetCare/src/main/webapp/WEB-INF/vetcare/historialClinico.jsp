<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="app.modelos.HistorialClinico" %>
<%@ page import="java.time.format.DateTimeFormatter" %>

<%
    List<HistorialClinico> historiales = (List<HistorialClinico>) request.getAttribute("historiales");
    String mensaje = (String) request.getAttribute("mensaje");
    String error = (String) request.getAttribute("error");
    
    // Debug
    System.out.println("JSP - Historiales recibidos: " + (historiales != null ? historiales.size() : "null"));
%>
    
<!DOCTYPE html>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet"
     integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <meta charset="UTF-8">
    <link rel="stylesheet" href="../CSS/css.css">
    <title>Sistema Vetcare - Historial Clínico</title>
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
        
        
        <main class="contenido-principal p-2">
            <!-- Mensajes -->
            <% if (mensaje != null) { %>
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="bi bi-check-circle me-2"></i><%= mensaje %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            <% } %>
            
            <% if (error != null) { %>
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="bi bi-exclamation-triangle me-2"></i><%= error %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            <% } %>
            <div class="mb-4">
                <h1 class="display-6 fw-bold text-dark mb-2">📋 Historial Clínico</h1>
                <p class="mb-0">Consulte el historial médico completo de los pacientes</p>
            </div>
           <%
    String busqueda = (String) request.getAttribute("busqueda");
%>

<div class="card border-0 shadow-sm mb-4">
    <div class="card-body p-4">
        <h5 class="fw-bold mb-3">
            <i class="bi bi-search text-primary me-2"></i>Buscar Paciente
        </h5>
        <form action="${pageContext.request.contextPath}/historial" method="get">
            <input type="hidden" name="action" value="listar">
            <div class="row g-3">
                <div class="col-md-8">
                    <input type="text" class="form-control" id="busqueda" name="busqueda" 
                           placeholder="Ingrese el nombre del paciente o dueño"
                           value="<%= busqueda != null ? busqueda : "" %>">
                </div>
                <div class="col-md-2">
                    <button type="submit" class="btn btn-primary btn-lg w-100">
                        <i class="bi bi-search me-2"></i>Buscar
                    </button>
                </div>
                <% if (busqueda != null && !busqueda.isEmpty()) { %>
                <div class="col-md-2">
                    <a href="${pageContext.request.contextPath}/historial?action=listar" 
                       class="btn btn-outline-secondary btn-lg w-100">
                        <i class="bi bi-x-circle me-2"></i>Limpiar
                    </a>
                </div>
                <% } %>
            </div>
        </form>
    </div>
</div>
            <div class="container-fluid">
                <div class="card shadow-sm">
                    <div class="card-header bg-primary text-white">
                        <h5 class="mb-0">
                            <i class="bi bi-clipboard-data me-2"></i>
                            Registros de Historial Clínico
                            <span class="badge bg-light text-primary ms-2">
                                <%= historiales != null ? historiales.size() : 0 %>
                            </span>
                        </h5>
                    </div>
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <table class="table table-hover table-borderless align-middle mb-0">
                                <thead class="table-light">
                                    <tr>
                                        <th class="ps-4">Paciente</th>
                                        <th>Dueño</th>
                                        <th>Diagnóstico</th>
                                        <th>Tratamiento</th>
                                        <th>Fecha</th>
                                        <th class="text-center">Acciones</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <% if (historiales == null || historiales.isEmpty()) { %>
                                    <tr>
                                        <td colspan="6" class="text-center text-muted py-5">
                                            <i class="bi bi-inbox fs-1 d-block mb-3"></i>
                                            <p class="mb-0">No hay historiales clínicos registrados</p>
                                            <small>Los historiales aparecerán aquí una vez que registres consultas</small>
                                        </td>
                                    </tr>
                                <% } else {
                                    for (HistorialClinico h : historiales) {
                                %>
                                    <tr>
                                        <td class="ps-4">
                                            <div class="d-flex align-items-center">
                                                <div class="bg-primary bg-opacity-10 rounded-circle p-2 me-3">
                                                    <i class="bi bi-heart-pulse text-primary fs-5"></i>
                                                </div>
                                                <div>
                                                    <div class="fw-bold">
                                                        <%= h.getMascota() != null ? h.getMascota().getNombre() : "Sin nombre" %>
                                                    </div>
                                                    <small class="text-muted">
                                                        <%= h.getMascota() != null ? h.getMascota().getTipo() : "" %>
                                                    </small>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="fw-semibold">
                                                <%= h.getMascota() != null ? h.getMascota().getDueno() : "Sin dueño" %>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="text-truncate" style="max-width: 200px;" 
                                                 title="<%= h.getDiagnostico() != null ? h.getDiagnostico() : "" %>">
                                                <%= h.getDiagnostico() != null ? h.getDiagnostico() : "Sin diagnóstico" %>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="text-truncate" style="max-width: 200px;"
                                                 title="<%= h.getTratamiento() != null ? h.getTratamiento() : "" %>">
                                                <%= h.getTratamiento() != null ? h.getTratamiento() : "Sin tratamiento" %>
                                            </div>
                                        </td>
                                        <td>
                                            <span class="badge bg-primary">
                                                <%= h.getFechaRegistro() != null ? 
                                                    h.getFechaRegistro().format(DateTimeFormatter.ofPattern("dd/MM/yyyy")) : 
                                                    "" %>
                                            </span>
                                        </td>
                                        <td class="text-center">
                                            <button class="btn btn-sm btn-outline-primary"
										        title="Ver detalles"
										        data-bs-toggle="modal"
										        data-bs-target="#modalHistorial"
										        data-paciente="<%= h.getMascota() != null ? h.getMascota().getNombre() : "" %>"
										        data-dueno="<%= h.getMascota() != null ? h.getMascota().getDueno() : "" %>"
										        data-diagnostico="<%= h.getDiagnostico() != null ? h.getDiagnostico() : "" %>"
										        data-tratamiento="<%= h.getTratamiento() != null ? h.getTratamiento() : "" %>"
										        data-fecha="<%= h.getFechaRegistro() != null ? h.getFechaRegistro().format(DateTimeFormatter.ofPattern("dd/MM/yyyy")) : "" %>">
										    <i class="bi bi-eye"></i>
										</button>
                                        </td>
                                    </tr>
                                <% }} %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
<div class="modal fade" id="modalHistorial" tabindex="-1">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title">
                    <i class="bi bi-clipboard-heart me-2"></i>
                    Detalle del Historial Clínico
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>

            <div class="modal-body">
                <p><strong>🐾 Paciente:</strong> <span id="mPaciente"></span></p>
                <p><strong>👤 Dueño:</strong> <span id="mDueno"></span></p>
                <p><strong>🩺 Diagnóstico:</strong></p>
                <p id="mDiagnostico" class="border rounded p-2"></p>
                <p><strong>💊 Tratamiento:</strong></p>
                <p id="mTratamiento" class="border rounded p-2"></p>
                <p><strong>📅 Fecha:</strong> <span id="mFecha"></span></p>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                    Cerrar
                </button>
            </div>
        </div>
    </div>
</div>
<script>
document.getElementById('modalHistorial').addEventListener('show.bs.modal', function (event) {
    const button = event.relatedTarget;

    document.getElementById('mPaciente').textContent = button.getAttribute('data-paciente');
    document.getElementById('mDueno').textContent = button.getAttribute('data-dueno');
    document.getElementById('mDiagnostico').textContent = button.getAttribute('data-diagnostico');
    document.getElementById('mTratamiento').textContent = button.getAttribute('data-tratamiento');
    document.getElementById('mFecha').textContent = button.getAttribute('data-fecha');
});
</script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" 
    integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
</body>
</html>