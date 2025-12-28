package app.data;

import app.modelos.Mascota;
import app.utils.Database;

import java.math.BigDecimal;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class MascotaDAO {

    //CREATE
	public int guardar(String nombre, String tipo, String dueno, BigDecimal peso) {
	    int idGenerado = -1;

	    String sql = "INSERT INTO mascotas (nombre, tipo, dueno, peso) " +
	                 "VALUES (?, ?, ?, ?)";

	    try (Connection cn = Database.getConexion();
	         PreparedStatement ps = cn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

	        ps.setString(1, nombre);
	        ps.setString(2, tipo);
	        ps.setString(3, dueno);
	        ps.setBigDecimal(4, peso);

	        ps.executeUpdate();

	        ResultSet rs = ps.getGeneratedKeys();
	        if (rs.next()) {
	            idGenerado = rs.getInt(1);
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return idGenerado;
	}



    //READ - por ID
    public Mascota buscarPorId(int idMascota) {

        Mascota mascota = null;

        String sql = "SELECT * FROM mascotas " +
                     "WHERE id_mascota = ?";

        try (Connection cn = Database.getConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setInt(1, idMascota);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                mascota = mapearMascota(rs);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return mascota;
    }

    //READ - listar todas
    public List<Mascota> listar() {

        List<Mascota> lista = new ArrayList<>();

        String sql = "SELECT * FROM mascotas";

        try (Connection cn = Database.getConexion();
             PreparedStatement ps = cn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                lista.add(mapearMascota(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return lista;
    }

    //UPDATE
    public boolean actualizar(Mascota mascota) {

        String sql = "UPDATE mascotas " +
                     "SET nombre = ?, tipo = ?, dueno = ? " +
                     "WHERE id_mascota = ?";

        try (Connection cn = Database.getConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setString(1, mascota.getNombre());
            ps.setString(2, mascota.getTipo());
            ps.setString(3, mascota.getDueno());
            ps.setInt(4, mascota.getIdMascota());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    //DELETE
    public boolean eliminar(int idMascota) {

        String sql = "DELETE FROM mascotas WHERE id_mascota = ?";

        try (Connection cn = Database.getConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setInt(1, idMascota);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }


    private Mascota mapearMascota(ResultSet rs) throws SQLException {

        Mascota mascota = new Mascota();
        mascota.setIdMascota(rs.getInt("id_mascota"));
        mascota.setNombre(rs.getString("nombre"));
        mascota.setTipo(rs.getString("tipo"));
        mascota.setDueno(rs.getString("dueno"));

        Timestamp ts = rs.getTimestamp("fecha_registro");
        if (ts != null) {
            mascota.setFechaRegistro(ts.toLocalDateTime());
        }

        return mascota;
    }
}