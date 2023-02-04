package com.eleccciones.cliente.bussiness.services.security;

import java.util.List;
import java.util.Optional;

import com.eleccciones.cliente.data.entities.security.Usuario;
import com.eleccciones.cliente.data.entities.security.Rol;
import com.eleccciones.cliente.data.entities.security.Permiso;
import com.eleccciones.cliente.data.repositories.security.RolRepository;
import com.eleccciones.cliente.data.repositories.security.UsuarioRolRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


/**
 * Servicio que permite obtener la data de los empleados
 *
 * @author xzabalam
 *
 */
@Service
@Transactional(readOnly = true)
public class UsuarioRolService {

	@Autowired
	private UsuarioRolRepository usuarioRolRepository;

	@Autowired
	private RolRepository rolRepository;

	@Transactional
	public Permiso crearUsuarioRol(Usuario usuario, Rol rol, int idUsuarioCrea) {
		final Optional<Permiso> usuarioRol = usuarioRolRepository.findByUsernameAndRol(usuario.getUsername(),
				rol.getNombre());

		if (usuarioRol.isEmpty()) {
			final Permiso permisoNuevo = new Permiso(usuario, rol);
			permisoNuevo.setUsuarioCrea(idUsuarioCrea);
			return usuarioRolRepository.save(permisoNuevo);
		}

		return usuarioRol.get();
	}

	/**
	 * Permite eliminar el usuarioRol buscado por el campo username
	 *
	 * @param usuarioId
	 */
	@Transactional
	public void deleteUserByUsuarioId(Long usuarioId) {
		final List<Permiso> usuarioRoles = usuarioRolRepository.findByUsuarioId(usuarioId);
		usuarioRoles.forEach(permiso -> usuarioRolRepository.delete(permiso));
	}
}
