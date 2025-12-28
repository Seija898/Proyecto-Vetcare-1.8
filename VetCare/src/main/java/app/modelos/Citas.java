package app.modelos;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;

public class Citas {
    private int idCita;
    private Mascota mascota;
    private Consultas consulta;  
    private LocalDate fecha;
    private String motivo;
    private LocalTime hora;
    private String tipoConsulta;
    private String estado;
    private LocalDateTime fechaCreacion;
    private String observaciones;
    
    public Citas() {
    }
    
    public Citas(int idCita, Mascota mascota, LocalDate fecha, LocalTime hora, 
                 String tipoConsulta, String estado, LocalDateTime fechaCreacion) {
        super();
        this.idCita = idCita;
        this.mascota = mascota;
        this.fecha = fecha;
        this.hora = hora;
        this.tipoConsulta = tipoConsulta;
        this.estado = estado;
        this.fechaCreacion = fechaCreacion;
    }

    
    public int getIdCita() {
        return idCita;
    }
    
    public void setIdCita(int idCita) {
        this.idCita = idCita;
    }
    
    public Mascota getMascota() {
        return mascota;
    }
    
    public void setMascota(Mascota mascota) {
        this.mascota = mascota;
    }
    
    // ← AGREGAR ESTOS MÉTODOS
    public Consultas getConsulta() {
        return consulta;
    }
    
    public void setConsulta(Consultas consulta) {
        this.consulta = consulta;
    }
    
    public LocalDate getFecha() {
        return fecha;
    }
    
    public void setFecha(LocalDate fecha) {
        this.fecha = fecha;
    }
    
    public LocalTime getHora() {
        return hora;
    }
    
    public void setHora(LocalTime hora) {
        this.hora = hora;
    }
    
    public String getTipoConsulta() {
        return tipoConsulta;
    }
    
    public void setTipoConsulta(String tipoConsulta) {
        this.tipoConsulta = tipoConsulta;
    }
    
    public String getEstado() {
        return estado;
    }
    
    public void setEstado(String estado) {
        this.estado = estado;
    }
    
    public LocalDateTime getFechaCreacion() {
        return fechaCreacion;
    }
    
    public void setFechaCreacion(LocalDateTime fechaCreacion) {
        this.fechaCreacion = fechaCreacion;
    }
    
    public String getMotivo() {
        return motivo;
    }
    
    public void setMotivo(String motivo) {
        this.motivo = motivo;
    }
    
    public String getObservaciones() {
        return observaciones;
    }
    
    public void setObservaciones(String observaciones) {
        this.observaciones = observaciones;
    }
    
    @Override
    public String toString() {
        return "Cita{" +
                "idCita=" + idCita +
                ", mascota=" + (mascota != null ? mascota.getIdMascota() : null) +
                ", consulta=" + (consulta != null ? consulta.getIdConsulta() : null) +
                ", fecha=" + fecha +
                ", hora=" + hora +
                ", tipoConsulta='" + tipoConsulta + '\'' +
                ", estado='" + estado + '\'' +
                ", fechaCreacion=" + fechaCreacion +
                '}';
    }
}