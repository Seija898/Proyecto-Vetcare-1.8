package app.data;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import app.modelos.HistorialClinico;
import app.modelos.Mascota;
import app.modelos.Veterinaio;
import app.utils.Database;

public class HistorialClinicoDAO {

    public List<HistorialClinico> listarTodo() {

        List<HistorialClinico> lista = new ArrayList<>();

        String sql =
            "SELECT h.id_historial, h.diagnostico, h.tratamiento, h.observaciones, h.fecha_registro, " +
            "       m.id_mascota, m.nombre AS mascota_nombre, m.tipo, m.dueno, " +
            "       v.id_veterinario, v.nombre AS veterinario_nombre " +
            "FROM historial_clinico h " +
            "JOIN mascotas m ON h.id_mascota = m.id_mascota " +
            "LEFT JOIN veterinarios v ON h.id_veterinario = v.id_veterinario " +
            "ORDER BY h.fecha_registro DESC";

        try (
            Connection cn = Database.getConexion();
            PreparedStatement ps = cn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
        ) {
            while (rs.next()) {

                HistorialClinico h = new HistorialClinico();
                h.setIdHistorial(rs.getInt("id_historial"));
                h.setDiagnostico(rs.getString("diagnostico"));
                h.setTratamiento(rs.getString("tratamiento"));
                h.setObservaciones(rs.getString("observaciones"));

                Timestamp ts = rs.getTimestamp("fecha_registro");
                if (ts != null) {
                    h.setFechaRegistro(ts.toLocalDateTime());
                }

                Mascota m = new Mascota();
                m.setIdMascota(rs.getInt("id_mascota"));
                m.setNombre(rs.getString("mascota_nombre"));
                m.setTipo(rs.getString("tipo"));
                m.setDueno(rs.getString("dueno"));
                h.setMascota(m);

                if (rs.getInt("id_veterinario") > 0) {
                    Veterinaio v = new Veterinaio();
                    v.setIdVeterinario(rs.getInt("id_veterinario"));
                    v.setNombre(rs.getString("veterinario_nombre"));
                    h.setVeterinario(v);
                }

                lista.add(h);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return lista;
    }

    public boolean registrar(HistorialClinico h) {

        String sql =
            "INSERT INTO historial_clinico " +
            "(id_mascota, id_cita, id_veterinario, diagnostico, tratamiento, observaciones) " +
            "VALUES (?, ?, ?, ?, ?, ?)";

        try (
            Connection cn = Database.getConexion();
            PreparedStatement ps = cn.prepareStatement(sql);
        ) {
            // DEBUG
            System.out.println("=== DEBUG DAO ===");
            System.out.println("ID Mascota: " + h.getMascota().getIdMascota());
            System.out.println("ID Cita: " + h.getIdCita()); // ← NUEVO
            System.out.println("ID Veterinario: " + (h.getVeterinario() != null ? h.getVeterinario().getIdVeterinario() : "NULL"));
            System.out.println("Diagnóstico: " + h.getDiagnostico());
            
            ps.setInt(1, h.getMascota().getIdMascota());
            ps.setInt(2, h.getIdCita()); // ← NUEVO
            ps.setInt(3, h.getVeterinario() != null ? h.getVeterinario().getIdVeterinario() : 1);
            ps.setString(4, h.getDiagnostico());
            ps.setString(5, h.getTratamiento());
            ps.setString(6, h.getObservaciones());

            int filasAfectadas = ps.executeUpdate();
            System.out.println("Filas insertadas: " + filasAfectadas);
            
            return filasAfectadas > 0;

        } catch (Exception e) {
            System.out.println("ERROR EN DAO: " + e.getMessage());
            e.printStackTrace();
        }

        return false;
    }

    public HistorialClinico buscarPorId(int idHistorial) {

        String sql =
            "SELECT id_historial, id_mascota, id_veterinario, diagnostico, tratamiento, observaciones, fecha_registro " +
            "FROM historial_clinico WHERE id_historial = ?";

        try (
            Connection cn = Database.getConexion();
            PreparedStatement ps = cn.prepareStatement(sql);
        ) {
            ps.setInt(1, idHistorial);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                HistorialClinico h = new HistorialClinico();
                h.setIdHistorial(rs.getInt("id_historial"));
                h.setDiagnostico(rs.getString("diagnostico"));
                h.setTratamiento(rs.getString("tratamiento"));
                h.setObservaciones(rs.getString("observaciones"));

                Timestamp ts = rs.getTimestamp("fecha_registro");
                if (ts != null) {
                    h.setFechaRegistro(ts.toLocalDateTime());
                }

                Mascota m = new Mascota();
                m.setIdMascota(rs.getInt("id_mascota"));
                h.setMascota(m);

                Veterinaio v = new Veterinaio();
                v.setIdVeterinario(rs.getInt("id_veterinario"));
                h.setVeterinario(v);

                return h;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }
    
    public List<HistorialClinico> buscarPorPaciente(String busqueda) {
        List<HistorialClinico> lista = new ArrayList<>();

        String sql =
            "SELECT h.id_historial, h.diagnostico, h.tratamiento, h.observaciones, h.fecha_registro, " +
            "       m.id_mascota, m.nombre AS mascota_nombre, m.tipo, m.dueno, " +
            "       v.id_veterinario, v.nombre AS veterinario_nombre " +
            "FROM historial_clinico h " +
            "JOIN mascotas m ON h.id_mascota = m.id_mascota " +
            "LEFT JOIN veterinarios v ON h.id_veterinario = v.id_veterinario " +
            "WHERE m.nombre LIKE ? OR m.dueno LIKE ? " +
            "ORDER BY h.fecha_registro DESC";

        try (
            Connection cn = Database.getConexion();
            PreparedStatement ps = cn.prepareStatement(sql);
        ) {
            String parametroBusqueda = "%" + busqueda + "%";
            ps.setString(1, parametroBusqueda);
            ps.setString(2, parametroBusqueda);
            
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                HistorialClinico h = new HistorialClinico();
                h.setIdHistorial(rs.getInt("id_historial"));
                h.setDiagnostico(rs.getString("diagnostico"));
                h.setTratamiento(rs.getString("tratamiento"));
                h.setObservaciones(rs.getString("observaciones"));

                Timestamp ts = rs.getTimestamp("fecha_registro");
                if (ts != null) {
                    h.setFechaRegistro(ts.toLocalDateTime());
                }

                Mascota m = new Mascota();
                m.setIdMascota(rs.getInt("id_mascota"));
                m.setNombre(rs.getString("mascota_nombre"));
                m.setTipo(rs.getString("tipo"));
                m.setDueno(rs.getString("dueno"));
                h.setMascota(m);

                if (rs.getInt("id_veterinario") > 0) {
                    Veterinaio v = new Veterinaio();
                    v.setIdVeterinario(rs.getInt("id_veterinario"));
                    v.setNombre(rs.getString("veterinario_nombre"));
                    h.setVeterinario(v);
                }

                lista.add(h);
            }

        } catch (Exception e) {
            System.out.println("Error en búsqueda: " + e.getMessage());
            e.printStackTrace();
        }

        return lista;
    }
}
