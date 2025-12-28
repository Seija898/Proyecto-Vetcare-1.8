package app.modelos;

import java.time.LocalDateTime;

public class Veterinaio {
	  private int idVeterinario;
	    private String nombre;
	    private String especialidad;
	    private String telefono;
	    private String correo;
	    private LocalDateTime fechaRegistro;

	    
	    public Veterinaio() {
	    }

	    
	    public Veterinaio(int idVeterinario, String nombre, String especialidad,
	                       String telefono, String correo, LocalDateTime fechaRegistro) {
	        this.idVeterinario = idVeterinario;
	        this.nombre = nombre;
	        this.especialidad = especialidad;
	        this.telefono = telefono;
	        this.correo = correo;
	        this.fechaRegistro = fechaRegistro;
	    }

	    
	    public int getIdVeterinario() {
	        return idVeterinario;
	    }

	    public void setIdVeterinario(int idVeterinario) {
	        this.idVeterinario = idVeterinario;
	    }

	    public String getNombre() {
	        return nombre;
	    }

	    public void setNombre(String nombre) {
	        this.nombre = nombre;
	    }

	    public String getEspecialidad() {
	        return especialidad;
	    }

	    public void setEspecialidad(String especialidad) {
	        this.especialidad = especialidad;
	    }

	    public String getTelefono() {
	        return telefono;
	    }

	    public void setTelefono(String telefono) {
	        this.telefono = telefono;
	    }

	    public String getCorreo() {
	        return correo;
	    }

	    public void setCorreo(String correo) {
	        this.correo = correo;
	    }

	    public LocalDateTime getFechaRegistro() {
	        return fechaRegistro;
	    }

	    public void setFechaRegistro(LocalDateTime fechaRegistro) {
	        this.fechaRegistro = fechaRegistro;
	    }

	    @Override
	    public String toString() {
	        return "Veterinario{" +
	                "idVeterinario=" + idVeterinario +
	                ", nombre='" + nombre + '\'' +
	                ", especialidad='" + especialidad + '\'' +
	                ", telefono='" + telefono + '\'' +
	                ", correo='" + correo + '\'' +
	                ", fechaRegistro=" + fechaRegistro +
	                '}';
	    }
}
