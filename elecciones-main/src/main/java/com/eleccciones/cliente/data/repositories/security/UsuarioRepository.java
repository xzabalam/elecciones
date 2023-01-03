package com.eleccciones.cliente.data.repositories.security;

import java.util.Optional;

import com.eleccciones.cliente.data.entities.security.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;


/**
 * Repositorio para {@link Usuario}
 *
 * @author xzabalam
 *
 */
@Repository
public interface UsuarioRepository extends JpaRepository<Usuario, Integer> {

	Optional<Usuario> findByUsername(String username);
}
