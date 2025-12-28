package app.modelos;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class Usuario {
	private int id;
	private String nombre;
	private String clave;
	private String correo;
	private LocalDateTime fechaCreacion;
	private List<Rol> roles;
	
	public Usuario() {
		id = 0;
		nombre = "";
		clave = "";
		correo = "";
		fechaCreacion = null;
		roles = new ArrayList<Rol>();
	}
	
	public Usuario(int id, String nombre, String clave, String correo) {
		this.id = id;
		this.nombre = nombre;
		this.clave = clave;
		this.correo = correo;
		this.fechaCreacion = null;
		this.roles = new ArrayList<Rol>();
	}
	
	public Usuario(String nombre, String clave, String correo) {
		this.id = 0;
		this.nombre = nombre;
		this.clave = clave;
		this.correo = correo;
		this.fechaCreacion = null;
		this.roles = new ArrayList<Rol>();
	}

	public Usuario(int id, String nombre, String clave, String correo, LocalDateTime fechaCreacion, List<Rol> roles) {
		this.id = id;
		this.nombre = nombre;
		this.clave = clave;
		this.correo = correo;
		this.fechaCreacion = fechaCreacion;
		this.roles = roles;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public String getClave() {
		return clave;
	}

	public void setClave(String clave) {
		this.clave = clave;
	}

	public String getCorreo() {
		return correo;
	}

	public void setCorreo(String correo) {
		this.correo = correo;
	}

	public LocalDateTime getFechaCreacion() {
		return fechaCreacion;
	}

	public void setFechaCreacion(LocalDateTime fechaCreacion) {
		this.fechaCreacion = fechaCreacion;
	}

	public List<Rol> getRoles() {
		return roles;
	}

	public void setRoles(List<Rol> roles) {
		this.roles = roles;
	}

	@Override
	public String toString() {
		return "Usuario [id=" + id + ", nombre=" + nombre + ", clave=" + clave + ", correo=" + correo
				+ ", fechaCreacion=" + fechaCreacion + ", roles=" + roles + "]";
	}
}
