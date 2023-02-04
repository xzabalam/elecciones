package com.eleccciones.cliente.data.repositories.security;

import java.util.List;
import java.util.Optional;

import com.eleccciones.cliente.data.entities.security.Usuario;
import com.eleccciones.cliente.data.entities.security.Permiso;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

/**
 * Repositorio para {@link Permiso}
 *
 * @author xzabalam
 *
 */
@Repository
public interface UsuarioRolRepository extends JpaRepository<Permiso, Long> {

	@Query("select ur from Permiso ur where ur.usuario.username = ?1")
	List<Permiso> findByUsername(String username);

	@Query("select ur from Permiso ur where ur.usuario.username = ?1 and ur.rol.nombre = ?2")
	Optional<Permiso> findByUsernameAndRol(String username, String rol);

	List<Permiso> findByUsuarioId(Long usuarioId);

	@Query("select ur.usuario from Permiso ur where ur.rol.nombre = ?1")
	List<Usuario> findUsersByRol(String rol);
}
