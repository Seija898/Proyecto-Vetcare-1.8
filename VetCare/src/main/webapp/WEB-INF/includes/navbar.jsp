<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
.hover-effect {
    transition: all 0.3s ease;
}

.hover-effect:hover {
    background-color: rgba(255, 255, 255, 0.15) !important;
    transform: translateX(5px);
}

.hover-effect:active {
    background-color: rgba(255, 255, 255, 0.25) !important;
}
</style>



<div class="d-flex" style="min-height: 100vh;">
    <div class="text-light d-flex flex-column position-fixed top-0 start-0 bottom-0 " 
     style="width: 280px; z-index: 1000; background: linear-gradient(180deg, #0f2027 0%, #203a43 50%, #2c5364 100%);">
        <div class="p-4 border-bottom border-secondary">
            <div class="d-flex align-items-center gap-2">
                <span class="fs-2"><i class="bi bi-shop"></i></span>
                <div>
                    <h5 class="mb-0 fw-bold">VetCare</h5>
                    <p class="mb-0 small">Clinica Veterinaria</p>
                </div>
            </div>
        </div>

        <nav class="nav flex-column p-3 flex-grow-1">
            <a href="${pageContext.request.contextPath}/vetcare?action=listar"
               class="nav-link text-white rounded mb-2 py-3 px-3 text-decoration-none hover-effect">
               <i class="bi bi-house-door me-2"></i> Inicio
            </a>

            <a href="${pageContext.request.contextPath}/vetcare?action=registro"
               class="nav-link text-white rounded mb-2 py-3 px-3 text-decoration-none hover-effect">
               <i class="bi bi-calendar-plus me-2"></i> Nueva Cita
            </a>

            <a href="${pageContext.request.contextPath}/historial?action=listar"
               class="nav-link text-white rounded mb-2 py-3 px-3 text-decoration-none hover-effect">
               <i class="bi bi-journal-medical me-2"></i> Historial Clínico
            </a>

            <a href="${pageContext.request.contextPath}/vetcare?action=listarAtencion"
               class="nav-link text-white rounded mb-2 py-3 px-3 text-decoration-none hover-effect">
               <i class="bi bi-clock-history me-2"></i> Citas Programadas
            </a>

            <a href="${pageContext.request.contextPath}/nosotros"
			   class="nav-link text-white-50 rounded mb-2 py-3 px-3 text-decoration-none">
			   <i class="bi bi-people me-2"></i>
			   <span class="fw-semibold">Nosotros</span>
			</a>
        </nav>
    </div>