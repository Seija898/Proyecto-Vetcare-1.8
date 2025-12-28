package app.modelos;

import java.time.LocalDateTime;

public class HistorialClinico {

    private int idHistorial;
    private Mascota mascota;
    private int idCita;
    private Veterinaio veterinario;
    private String diagnostico;
    private String tratamiento;
    private String observaciones;
    private LocalDateTime fechaRegistro;


    public HistorialClinico() {
    }


    public HistorialClinico(int idHistorial,
           Mascota mascota,                
           Veterinaio veterinario,
           String diagnostico,
           String tratamiento,
           String observaciones,
           LocalDateTime fechaRegistro) {

        this.idHistorial = idHistorial;
        this.mascota = mascota;
      
        this.veterinario = veterinario;
        this.diagnostico = diagnostico;
        this.tratamiento = tratamiento;
        this.observaciones = observaciones;
        this.fechaRegistro = fechaRegistro;
    }

    public int getIdHistorial() {
        return idHistorial;
    }

    public void setIdHistorial(int idHistorial) {
        this.idHistorial = idHistorial;
    }

    public Mascota getMascota() {
        return mascota;
    }

    public void setMascota(Mascota mascota) {
        this.mascota = mascota;
    }

   

    public Veterinaio getVeterinario() {
        return veterinario;
    }

    public void setVeterinario(Veterinaio veterinario) {
        this.veterinario = veterinario;
    }

    public String getDiagnostico() {
        return diagnostico;
    }

    public void setDiagnostico(String diagnostico) {
        this.diagnostico = diagnostico;
    }

    public String getTratamiento() {
        return tratamiento;
    }

    public void setTratamiento(String tratamiento) {
        this.tratamiento = tratamiento;
    }

    public String getObservaciones() {
        return observaciones;
    }

    public void setObservaciones(String observaciones) {
        this.observaciones = observaciones;
    }

    public LocalDateTime getFechaRegistro() {
        return fechaRegistro;
    }

    public void setFechaRegistro(LocalDateTime fechaRegistro) {
        this.fechaRegistro = fechaRegistro;
    }

    public int getIdCita() {
        return idCita;
    }

    public void setIdCita(int idCita) {
        this.idCita = idCita;
    }
    
    
    
    @Override
    public String toString() {
        return "HistorialClinico{" +
                "idHistorial=" + idHistorial +
                ", mascota=" + (mascota != null ? mascota.getIdMascota() : null) +
             
                ", veterinario=" + (veterinario != null ? veterinario.getIdVeterinario() : null) +
                ", diagnostico='" + diagnostico + '\'' +
                ", tratamiento='" + tratamiento + '\'' +
                ", observaciones='" + observaciones + '\'' +
                ", fechaRegistro=" + fechaRegistro +
                '}';
    }
}
