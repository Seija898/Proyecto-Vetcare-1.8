<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Nosotros | VetCare</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            background: linear-gradient(135deg, #e0f2fe, #f0f9ff);
            margin: 0;
            padding: 0;
        }

        .contenedor {
            max-width: 900px;
            margin: 60px auto;
            background: #ffffff;
            border-radius: 16px;
            padding: 45px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.1);
        }

        .titulo {
            color: #1e3a8a;
            font-weight: 800;
            margin-bottom: 10px;
        }

        .subtitulo {
            color: #475569;
            margin-bottom: 30px;
        }

        .seccion {
            margin-top: 30px;
        }

        .seccion h2 {
            color: #1e40af;
            margin-bottom: 15px;
        }

        .seccion p {
            color: #444;
            line-height: 1.7;
            font-size: 16px;
        }

        .valores {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 15px;
            margin-top: 20px;
        }

        .valor {
            background: #f1f5f9;
            border-radius: 10px;
            padding: 15px;
            font-weight: 500;
        }

        .creadores {
            margin-top: 25px;
        }

        .creador {
            background: #eef2ff;
            border-left: 5px solid #6366f1;
            padding: 12px 15px;
            border-radius: 8px;
            margin-bottom: 10px;
            font-weight: 500;
        }

        .boton-volver {
            margin-top: 35px;
            text-align: center;
        }
    </style>
</head>

<body>

<div class="contenedor">

    <h1 class="titulo">🐾 VetCare</h1>
    <p class="subtitulo">
        Sistema de gestión para clínicas veterinarias 🐶🐱
    </p>

    <div class="seccion">
        <h2>💙 ¿Quiénes somos?</h2>
        <p>
            <strong>VetCare</strong> es un sistema desarrollado con el objetivo de
            mejorar la organización y atención en clínicas veterinarias.
            Está pensado para facilitar la gestión de citas, el control de pacientes
            y el seguimiento del historial clínico de cada mascota.
        </p>

        <p>
            Nuestro enfoque combina tecnología, simplicidad y compromiso con el
            bienestar animal, ayudando a los profesionales veterinarios a brindar
            una atención más rápida, ordenada y eficiente 🐕‍🦺.
        </p>
    </div>

    <div class="seccion">
        <h2>🎯 Nuestra misión</h2>
        <p>
            Brindar una herramienta digital confiable, intuitiva y moderna que
            optimice los procesos administrativos y médicos dentro de una clínica
            veterinaria, priorizando siempre el cuidado y la salud de las mascotas 🐾.
        </p>
    </div>

    <div class="seccion">
        <h2>🌈 Nuestros valores</h2>

        <div class="valores">
            <div class="valor">🐶 Amor y respeto por los animales</div>
            <div class="valor">🤝 Compromiso con el servicio</div>
            <div class="valor">⚕️ Responsabilidad profesional</div>
            <div class="valor">💻 Innovación tecnológica</div>
            <div class="valor">📋 Organización y eficiencia</div>
            <div class="valor">🌱 Mejora continua</div>
        </div>
    </div>

    <div class="seccion creadores">
        <h2>👨‍💻👩‍💻 Creadores del sistema</h2>

        <div class="creador">🐾 Yazury Yazmin De La Cruz Zapata</div>
        <div class="creador">🐾 Yadira Esmit Diaz Torres</div>
        <div class="creador">🐾 Jesus Gabriel Lopez Gonzales</div>
        <div class="creador">🐾 Rony Martin Yenque Sandi</div>
    </div>

    <div class="boton-volver">
        <a href="${pageContext.request.contextPath}/vetcare?action=listar"
           class="btn btn-outline-primary mt-4">
           <i class="bi bi-arrow-left me-2"></i> Volver al inicio
        </a>
    </div>

</div>

</body>
</html>