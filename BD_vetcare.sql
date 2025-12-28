/* =========================================================
   BD: Clinica Veterinaria (SIN tabla consultas)
   Motor: MySQL 8+
   ========================================================= */

DROP DATABASE IF EXISTS bd_vetcare;
CREATE DATABASE bd_vetcare
  DEFAULT CHARACTER SET utf8mb4
  DEFAULT COLLATE utf8mb4_0900_ai_ci;

USE bd_vetcare;

/* =========================
   TABLA: veterinarios
   ========================= */
DROP TABLE IF EXISTS veterinarios;
CREATE TABLE veterinarios (
    id_veterinario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    especialidad VARCHAR(150),
    telefono VARCHAR(20),
    correo VARCHAR(100),
    fecha_registro TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    UNIQUE KEY uq_veterinarios_correo (correo)
) ENGINE=InnoDB;

/* =========================
   TABLA: mascotas
   ========================= */
DROP TABLE IF EXISTS mascotas;
CREATE TABLE mascotas (
    id_mascota INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    dueno VARCHAR(100) NOT NULL,
    peso DECIMAL(5,2),
    fecha_registro TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    KEY idx_mascotas_dueno (dueno),
    KEY idx_mascotas_tipo (tipo)
) ENGINE=InnoDB;

/* =========================
   TABLA: citas
   ========================= */
DROP TABLE IF EXISTS citas;
CREATE TABLE citas (
    id_cita INT AUTO_INCREMENT PRIMARY KEY,
    id_mascota INT NOT NULL,
    fecha DATE NOT NULL,
    hora TIME NOT NULL,
    tipo_consulta VARCHAR(150),
    estado ENUM('PROGRAMADA','CONFIRMADA','EN_ATENCION','ATENDIDA','CANCELADA')
           NOT NULL DEFAULT 'PROGRAMADA',
    motivo TEXT NOT NULL,
    observaciones TEXT,
    fecha_creacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_citas_mascotas
      FOREIGN KEY (id_mascota) REFERENCES mascotas(id_mascota)
      ON UPDATE CASCADE
      ON DELETE RESTRICT
) ENGINE=InnoDB;

/* =========================
   TABLA: historial_clinico
   ========================= */
DROP TABLE IF EXISTS historial_clinico;
CREATE TABLE historial_clinico (
    id_historial INT AUTO_INCREMENT PRIMARY KEY,
    id_mascota INT NOT NULL,
    id_cita INT NOT NULL,
    id_veterinario INT NOT NULL,

    diagnostico TEXT NOT NULL,
    tratamiento TEXT NOT NULL,
    observaciones TEXT,
    fecha_registro TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_historial_mascotas
      FOREIGN KEY (id_mascota) REFERENCES mascotas(id_mascota)
      ON UPDATE CASCADE
      ON DELETE RESTRICT,

    CONSTRAINT fk_historial_citas
      FOREIGN KEY (id_cita) REFERENCES citas(id_cita)
      ON UPDATE CASCADE
      ON DELETE RESTRICT,

    CONSTRAINT fk_historial_veterinarios
      FOREIGN KEY (id_veterinario) REFERENCES veterinarios(id_veterinario)
      ON UPDATE CASCADE
      ON DELETE RESTRICT
) ENGINE=InnoDB;

/* =========================
   DATOS BASE
   ========================= */
INSERT INTO veterinarios (nombre, especialidad, telefono, correo)
VALUES ('Veterinario Sistema', 'General', '000000000', 'sistema@vetcare.local');

INSERT INTO mascotas (nombre, tipo, dueno, peso) VALUES
('Max', 'Perro', 'Juan Pérez', 18.50),
('Michi', 'Gato', 'Lucía Gómez', 4.20),
('Rocky', 'Perro', 'Carlos Rojas', 22.30);

/* =========================
   5 CITAS
   ========================= */
INSERT INTO citas (
    id_mascota, fecha, hora, tipo_consulta, estado, motivo, observaciones
) VALUES
(1, '2025-12-26', '09:30:00', 'Consulta General', 'PROGRAMADA',
 'Vacunación anual', 'Mascota nerviosa'),

(2, '2025-12-26', '11:00:00', 'Revisión', 'CONFIRMADA',
 'Pérdida de apetito', 'Ayuno previo'),

(3, '2025-12-27', '15:30:00', 'Control', 'PROGRAMADA',
 'Dolor en pata trasera', 'Posible esguince'),

(1, '2025-12-28', '10:00:00', 'Control', 'PROGRAMADA',
 'Revisión post vacuna', 'Buen estado general'),

(2, '2025-12-29', '16:00:00', 'Seguimiento', 'PROGRAMADA',
 'Control digestivo', 'Evaluar evolución');

/* =========================
   2 HISTORIALES CLÍNICOS
   ========================= */
INSERT INTO historial_clinico (
    id_mascota,
    id_cita,
    id_veterinario,
    diagnostico,
    tratamiento,
    observaciones
) VALUES
(
    1,
    1,
    1,
    'Paciente clínicamente sano.',
    'Aplicación de vacuna antirrábica.',
    'Control anual recomendado.'
),
(
    2,
    2,
    1,
    'Gastritis leve.',
    'Dieta blanda y medicación por 5 días.',
    'Mejoría esperada en 72 horas.'
);

/* =========================
   CONSULTA DE PRUEBA
   ========================= */
SELECT
    hc.id_historial,
    m.nombre AS mascota,
    c.fecha,
    hc.diagnostico,
    v.nombre AS veterinario
FROM historial_clinico hc
JOIN mascotas m ON m.id_mascota = hc.id_mascota
JOIN citas c ON c.id_cita = hc.id_cita
JOIN veterinarios v ON v.id_veterinario = hc.id_veterinario;

select * from historial_clinico;
select * from citas;
select * from mascotas;