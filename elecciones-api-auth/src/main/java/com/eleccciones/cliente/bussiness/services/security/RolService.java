package com.eleccciones.cliente.bussiness.services.security;

import java.util.Optional;

import com.eleccciones.cliente.data.entities.security.Rol;
import com.eleccciones.cliente.data.repositories.security.RolRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.server.ResponseStatusException;

/**
 * Servicio que permite obtener la data de los rol
 *
 * @author xzabalam
 *
 */
@Service
@Transactional(readOnly = true)
public class RolService {

	@Autowired
	private RolRepository rolRepository;

	/**
	 * Permite crear un rol en la base de datos
	 *
	 * @param rol
	 *
	 * @return
	 */
	@Transactional
	public Rol createRol(Rol rol) {
		final Optional<Rol> result = rolRepository.findByNombre(rol.getNombre());

		if (result.isPresent()) {
			return result.get();
		}

		return rolRepository.save(rol);
	}

	/**
	 * Elimina un rol almacenado en la base de datos
	 *
	 * @param rolId
	 */
	public void deleteRol(Long rolId) {
		final Optional<Rol> result = rolRepository.findById(rolId);

		if (result.isPresent()) {
			rolRepository.delete(result.get());
		}

		throw new ResponseStatusException(HttpStatus.NOT_FOUND, String.format("{service.rol.no.existe}", rolId));
	}

	/**
	 * Obtiene todos los roles almacenados en la base de datos
	 *
	 * @return
	 */
	public Page<Rol> getRoles(int page, int size) {
		return rolRepository.findAll(PageRequest.of(page, size));
	}

	/**
	 * Permite actualizar un rol
	 *
	 * @param rolId id del rol que se debe actualizar
	 * @param rol   Los datos del rol que se deben actualizar
	 *
	 * @return
	 */
	public Rol updateRol(Long rolId, Rol rol) {
		final Optional<Rol> result = rolRepository.findById(rolId);

		if (result.isPresent()) {
			return rolRepository.save(rol);
		}

		throw new ResponseStatusException(HttpStatus.NOT_FOUND, String.format("{service.rol.no.existe}", rolId));
	}
}
