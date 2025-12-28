package app.data.interfaces;

import java.util.List;

public interface ICRUD<T, ID> {
	ID registrar(T t);			// C - Create
	T buscarPorId(ID id);		// R - Read
	boolean actualizar(T t);	// U - Update
	boolean eliminar(ID id);	// D - Delete
	List<T> obtenerTodo();		// getAll();
	//boolean existe(ID id);
}
