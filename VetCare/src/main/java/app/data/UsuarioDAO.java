package app.data;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.List;

import app.data.interfaces.IUsuario;
import app.modelos.Rol;
import app.modelos.Usuario;
import app.utils.Database;

public class UsuarioDAO implements IUsuario {

	@Override
	public Integer registrar(Usuario t) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Usuario buscarPorId(Integer id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean actualizar(Usuario t) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean eliminar(Integer id) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public List<Usuario> obtenerTodo() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Usuario validar(String nombre, String clave) {
		Usuario usuario = null;
		String sql = "{ CALL SP_ValidarUsuario(?, ?) }";
		try {
			Connection cnx = Database.getConexion();
			CallableStatement cs = cnx.prepareCall(sql);
			cs.setString(1, nombre);
			cs.setString(2, sql);
			ResultSet rs = cs.executeQuery();
			while (rs.next()) {
				if (usuario == null) {
					usuario = new Usuario(
						rs.getInt("ID"),
						rs.getString("Nombre"),
						"---privado---",
						rs.getString("Email")
					);
				}
				Rol rol = new Rol(rs.getInt("RolID"), rs.getString("RolNombre"));
				usuario.getRoles().add(rol);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return usuario;
	}

}
