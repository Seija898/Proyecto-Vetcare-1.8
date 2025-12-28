package app.modelos;

import java.math.BigDecimal;
import java.time.LocalDateTime;

public class Mascota {
	 private int idMascota;
	    private String nombre;
	    private String tipo;
	    private String dueño;
	    private BigDecimal peso;
	    private LocalDateTime fechaRegistro;

	   
	    public Mascota() {
	    }

	    
	    public Mascota(String nombre, String tipo,
	                   String dueño, BigDecimal peso,
	                   LocalDateTime fechaRegistro) {

	        this.idMascota = idMascota;
	        this.nombre = nombre;
	        this.tipo = tipo;
	        this.dueño = dueño;
	        this.peso = peso;
	        this.fechaRegistro = fechaRegistro;
	    }

	   
	    public int getIdMascota() {
	        return idMascota;
	    }

	    public void setIdMascota(int idMascota) {
	        this.idMascota = idMascota;
	    }

	    public String getNombre() {
	        return nombre;
	    }

	    public void setNombre(String nombre) {
	        this.nombre = nombre;
	    }

	    public String getTipo() {
	        return tipo;
	    }

	    public void setTipo(String tipo) {
	        this.tipo = tipo;
	    }

	    public String getDueno() {
	        return dueño;
	    }

	    public void setDueno(String dueno) {
	        this.dueño = dueno;
	    }

	    public BigDecimal getPeso() {
	        return peso;
	    }

	    public void setPeso(BigDecimal peso) {
	        this.peso = peso;
	    }

	    public LocalDateTime getFechaRegistro() {
	        return fechaRegistro;
	    }

	    public void setFechaRegistro(LocalDateTime fechaRegistro) {
	        this.fechaRegistro = fechaRegistro;
	    }

	    @Override
	    public String toString() {
	    	return "Mascota{" +
	                "idMascota=" + idMascota +
	                ", nombre='" + nombre + '\'' +
	                ", tipo='" + tipo + '\'' +
	                ", dueno='" + dueño + '\'' +
	                ", peso=" + peso +
	                ", fechaRegistro=" + fechaRegistro +
	                '}';
	    }
}
