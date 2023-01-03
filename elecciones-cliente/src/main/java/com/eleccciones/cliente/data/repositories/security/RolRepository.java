package com.eleccciones.cliente.data.repositories.security;

import java.util.Optional;

import com.eleccciones.cliente.data.entities.security.Rol;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;


/**
 * Repositorio para {@link Rol}
 *
 * @author xzabalam
 *
 */
@Repository
public interface RolRepository extends JpaRepository<Rol, Long> {
	Optional<Rol> findByNombre(String nombre);
}
