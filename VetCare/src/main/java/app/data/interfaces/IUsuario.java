package app.data.interfaces;

import app.modelos.Usuario;

public interface IUsuario extends ICRUD<Usuario, Integer>{
	Usuario validar(String nombre, String clave);
}
