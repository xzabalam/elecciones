package com.eleccciones.cliente.data.repositories.security;

import com.eleccciones.cliente.data.entities.security.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Optional;


/**
 * Repositorio para {@link Usuario}
 *
 * @author xzabalam
 */
@Repository
public interface UsuarioRepository extends JpaRepository<Usuario, Integer> {

    Optional<Usuario> findByUsername(String username);

    @Query("select u " +
            "from Usuario u " +
            "join u.contrato c " +
            "where u.username = :username " +
            "and u.activo = 'S' " +
            "and u.habilitadoMovil = 'S' " +
            "and u.estado != 'D' " +
            "and c.activo = 'S' " +
            "and c.fechaFin >= current_timestamp " +
            "and (c.sesionesActivas+1)< c.sesiones " +
            "and c.estado != 'D' " +
            "")
    Optional<Usuario> getByUsername(@Param("username") String username);
}
