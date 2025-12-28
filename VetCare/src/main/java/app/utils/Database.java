package app.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Database {
	private static String URL = "jdbc:mysql://127.0.0.1:3306/bd_vetcare";
	private static String USUARIO = "root";
	private static String CLAVE = "1234";

	
	static {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		}
		catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	public static Connection getConexion() {
		Connection conexion = null;
		try {
			conexion = DriverManager.getConnection(URL, USUARIO, CLAVE);
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		return conexion;
	}
}


