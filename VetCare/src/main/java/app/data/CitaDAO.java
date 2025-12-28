package app.data;
import app.modelos.Citas;
import app.modelos.Mascota;
import app.utils.Database;
import java.sql.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;



public class CitaDAO {
	public void guardar(
	        Mascota mascota,
	        LocalDate fecha,
	        LocalTime hora,
	        String tipoConsulta,
	        String estado,
	        String motivo,
	        String observaciones
	) {
		String sql = "INSERT INTO citas " +
	             "(id_mascota, fecha, hora, tipo_consulta, estado, motivo, observaciones) " +
	             "VALUES (?, ?, ?, ?, ?, ?, ?)";
		try (Connection cn = Database.getConexion();
			     PreparedStatement ps = cn.prepareStatement(sql)) {
			    ps.setInt(1, mascota.getIdMascota());
			    ps.setDate(2, Date.valueOf(fecha));
			    ps.setTime(3, Time.valueOf(hora));
			    ps.setString(4, tipoConsulta);
			    ps.setString(5, estado);
			    ps.setString(6, motivo);
			    ps.setString(7, observaciones);
			    ps.executeUpdate();
			} catch (SQLException e) {
			    e.printStackTrace();
			}
	}
	
	
	
    // ACTUALIZAR
	public boolean actualizar(Citas cita) {
	    String sql = "UPDATE citas SET " +
	                 "fecha = ?, hora = ?, tipo_consulta = ?, estado = ?, motivo = ?, observaciones = ? " +
	                 "WHERE id_cita = ?";

	    try (Connection cn = Database.getConexion();
	         PreparedStatement ps = cn.prepareStatement(sql)) {

	        ps.setDate(1, Date.valueOf(cita.getFecha()));
	        ps.setTime(2, Time.valueOf(cita.getHora()));
	        ps.setString(3, cita.getTipoConsulta());
	        ps.setString(4, cita.getEstado());
	        ps.setString(5, cita.getMotivo());
	        ps.setString(6, cita.getObservaciones());
	        ps.setInt(7, cita.getIdCita());

	        return ps.executeUpdate() > 0;
	    } catch (SQLException e) {
	        e.printStackTrace();
	        return false;
	    }
	}

    // ELIMINAR
    public boolean eliminar(int idCita) {
        String sql = "DELETE FROM citas WHERE id_cita = ?";
        try (Connection cn = Database.getConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setInt(1, idCita);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    
    // LISTAR
    public List<Citas> listarCitas() {
        List<Citas> lista = new ArrayList<>();
        String sql = "SELECT \r\n"
        		+ "    c.id_cita, c.fecha, c.hora, c.tipo_consulta, c.estado, c.motivo,\r\n"
        		+ "    m.id_mascota, m.nombre AS nombre_mascota,\r\n"
        		+ "    m.tipo AS tipo_mascota, m.dueno\r\n"
        		+ "FROM citas c\r\n"
        		+ "JOIN mascotas m ON c.id_mascota = m.id_mascota\r\n"
        		+ "ORDER BY c.fecha, c.hora";
        try (Connection cn = Database.getConexion();
             PreparedStatement ps = cn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                // Mascota
                Mascota mascota = new Mascota();
                mascota.setIdMascota(rs.getInt("id_mascota"));
                mascota.setNombre(rs.getString("nombre_mascota"));
                mascota.setTipo(rs.getString("tipo_mascota"));
                mascota.setDueno(rs.getString("dueno"));
                
                // Cita
                Citas cita = new Citas();
                cita.setIdCita(rs.getInt("id_cita"));
                cita.setFecha(rs.getDate("fecha").toLocalDate());
                cita.setHora(rs.getTime("hora").toLocalTime());
                cita.setTipoConsulta(rs.getString("tipo_consulta"));
                cita.setEstado(rs.getString("estado"));
                cita.setMotivo(rs.getString("motivo"));
                cita.setMascota(mascota);
                lista.add(cita);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lista;
    }
    
    
    public Citas obtenerPorId(int idCita) {
    	String sql = "SELECT c.*, " +
                "       m.id_mascota, m.nombre, m.tipo, m.dueno " +
                "FROM citas c " +
                "JOIN mascotas m ON c.id_mascota = m.id_mascota " +
                "WHERE c.id_cita = ?";
        try (Connection cn = Database.getConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setInt(1, idCita);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Mascota mascota = new Mascota();
                mascota.setIdMascota(rs.getInt("id_mascota"));
                mascota.setNombre(rs.getString("nombre"));
                mascota.setTipo(rs.getString("tipo"));
                mascota.setDueno(rs.getString("dueno"));
                
                Citas c = new Citas();
                c.setIdCita(rs.getInt("id_cita"));
                c.setFecha(rs.getDate("fecha").toLocalDate());
                c.setHora(rs.getTime("hora").toLocalTime());
                c.setTipoConsulta(rs.getString("tipo_consulta"));
                c.setEstado(rs.getString("estado"));
                c.setMotivo(rs.getString("motivo"));
                c.setObservaciones(rs.getString("observaciones"));
                c.setMascota(mascota);

                return c;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    
    public boolean actualizarEstado(int idCita, String nuevoEstado) {
        String sql = "UPDATE citas SET estado = ? WHERE id_cita = ?";
        try (Connection cn = Database.getConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setString(1, nuevoEstado);
            ps.setInt(2, idCita);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    
    
    public List<Citas> listarCitasPendientes() {
        List<Citas> lista = new ArrayList<>();
        String sql = "SELECT c.*, " +
                "m.nombre AS nombre_mascota, " +
                "m.dueno AS dueno_mascota, " +
                "m.tipo AS tipo_mascota " +
                "FROM citas c " +
                "JOIN mascotas m ON c.id_mascota = m.id_mascota " +
                "WHERE c.estado != 'ATENDIDA' " +
                "ORDER BY c.fecha ASC, c.hora ASC";

        try (Connection conn =  Database.getConexion();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Citas c = new Citas();
                c.setIdCita(rs.getInt("id_cita"));
                c.setFecha(rs.getDate("fecha").toLocalDate());
                c.setHora(rs.getTime("hora").toLocalTime());
                c.setTipoConsulta(rs.getString("tipo_consulta"));
                c.setEstado(rs.getString("estado"));
                c.setMotivo(rs.getString("motivo"));
                c.setObservaciones(rs.getString("observaciones"));

                Mascota m = new Mascota();
                m.setIdMascota(rs.getInt("id_mascota"));
                m.setNombre(rs.getString("nombre_mascota"));  // ahora sí
                m.setDueno(rs.getString("dueno_mascota"));    // ahora sí
                m.setTipo(rs.getString("tipo_mascota"));      // tipo de mascota
                c.setMascota(m);

                lista.add(c);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return lista;
    }

    
}