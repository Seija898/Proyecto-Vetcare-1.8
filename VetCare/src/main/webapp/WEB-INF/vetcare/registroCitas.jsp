<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sistema Vetcare</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <style>
        body { overflow-x: hidden; }
    </style>
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

<div class="flex-grow-1" style="margin-left: 280px;">
    <main class="p-4">

        <div class="row">
            <div class="col-lg-8">
                <div class="card border-0 shadow-sm">
                    <div class="card-body p-4">

                        <form id="formCita" action="${pageContext.request.contextPath}/vetcare" method="POST">
                            <input type="hidden" name="action" value="guardar">

                            <h5 class="fw-bold mb-3">
                                <i class="bi bi-heart-pulse me-2"></i>Registrar cita del Paciente
                            </h5>

                            <div class="row g-3 mb-4">
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold">Paciente</label>
                                    <input type="text" class="form-control" name="paciente" required>
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label fw-semibold">Propietario</label>
                                    <input type="text" class="form-control" name="propietario" required>
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label fw-semibold">Tipo de mascota</label>
                                    <select class="form-select" name="mascota" required>
                                        <option value="" disabled selected>Seleccione...</option>
                                        <option value="perro">Perro</option>
                                        <option value="gato">Gato</option>
                                        <option value="conejo">Conejo</option>
                                        <option value="hamster">Hámster</option>
                                        <option value="cobayo">Cobayo / Cuy</option>
                                        <option value="loro">Loro / Aves</option>
                                        <option value="tortuga">Tortuga / Reptil</option>
                                        <option value="peces">Peces</option>
                                        <option value="erizo">Erizo</option>
                                        <option value="chinchilla">Chinchilla</option>
                                        <option value="huron">Hurón</option>
                                    </select>
                                </div>
                            </div>

                            <h5 class="fw-bold mb-3">
                                <i class="bi bi-calendar-check text-success me-2"></i>Detalles de la Cita
                            </h5>

                            <div class="row g-3 mb-4">
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold">Fecha</label>
                                    <input type="date" class="form-control" id="fecha" name="fecha" required>
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label fw-semibold">Hora</label>
                                    <input type="time" class="form-control" name="hora" required>
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label fw-semibold">Tipo de consulta</label>
                                    <select class="form-select" name="tipoConsulta" required>
                                        <option value="" disabled selected>Seleccione...</option>
                                        <option value="chequeo">Chequeo General</option>
                                        <option value="vacunacion">Vacunación</option>
                                        <option value="cirugia">Cirugía</option>
                                        <option value="urgencia">Urgencia</option>
                                        <option value="control">Control Post-operatorio</option>
                                        <option value="dermatologia">Dermatología</option>
                                        <option value="odontologia">Odontología</option>
                                        <option value="otro">Otro</option>
                                    </select>
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label fw-semibold">Estado de la cita</label>
                                    <select class="form-select" name="estado" required>
                                        <option value="NORMAL">Normal</option>
                                        <option value="ALTA">Alta</option>
                                        <option value="URGENTE">Urgente</option>
                                    </select>
                                </div>

                                <div class="col-12">
                                    <label class="form-label fw-semibold">Motivo de la consulta</label>
                                    <textarea class="form-control" name="motivo" rows="3" required></textarea>
                                </div>

                                <div class="col-12">
                                    <label class="form-label fw-semibold">Observaciones (opcional)</label>
                                    <textarea class="form-control" name="observaciones" rows="2"></textarea>
                                </div>
                            </div>

                            <div class="d-flex justify-content-end gap-2">
                                <button type="button" class="btn btn-outline-secondary" onclick="confirmarCancelar()">
                                    Cancelar
                                </button>
                                <button type="reset" class="btn btn-outline-warning">
                                    Limpiar
                                </button>
                                <button type="button" class="btn btn-primary" onclick="confirmarGuardar()">
                                    Registrar cita
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <div class="col-lg-4">
                <div class="card border-0 shadow-sm">
                    <div class="card-body">
                        <h6 class="fw-bold mb-3">
                            <i class="bi bi-clock-history me-2 text-primary"></i>Horarios de Atención
                        </h6>
                        <ul class="small text-muted">
                            <li>Lunes a Viernes: 9:00 AM – 7:00 PM</li>
                            <li>Sábados: 9:00 AM – 2:00 PM</li>
                            <li>Domingos: Cerrado</li>
                        </ul>
                        <p class="small mb-0"> <i class="bi bi-info-circle me-1"></i> Las citas urgentes se priorizan automáticamente. </p>
                    </div>
                </div>
            </div>
        </div>
    </main>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
<script>
    const hoy = new Date().toISOString().split("T")[0];
    document.getElementById("fecha").setAttribute("min", hoy);
</script>

<script>
function confirmarCancelar() {
    Swal.fire({
        title: "¿Cancelar registro?",
        text: "Se perderán los datos ingresados",
        icon: "warning",
        showCancelButton: true,
        confirmButtonText: "Sí, cancelar",
        cancelButtonText: "Seguir editando"
    }).then((result) => {
        if (result.isConfirmed) {
            window.location.href = "<%= request.getContextPath() %>/vetcare?action=listar";
        }
    });
}
</script>

<script>
function confirmarGuardar() {
    const form = document.getElementById("formCita");
    const campos = form.querySelectorAll("[required]");

    for (let campo of campos) {
        if (!campo.value.trim()) {
            const label = campo.closest("div").querySelector("label").innerText;
            Swal.fire({
                icon: "error",
                title: "Campo obligatorio",
                text: "Debes completar el campo: " + label
            });
            campo.focus();
            return;
        }
    }

    Swal.fire({
        title: "¿Registrar cita?",
        text: "Verifica que los datos sean correctos",
        icon: "success",
        showCancelButton: true,
        confirmButtonText: "Registrar",
        cancelButtonText: "Cancelar"
    }).then((result) => {
        if (result.isConfirmed) {
            form.submit();
        }
    });
}
</script>

</body>
</html>