package com.eleccciones.cliente.data.repositories.ubicacion;

import com.eleccciones.cliente.data.entities.ubicacion.Junta;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface JuntaRepository extends JpaRepository<Junta, Integer> {

    @Query("select junta from Junta junta " +
            "join fetch junta.sexo s " +
            "where junta.id = :idJunta and junta.estado != 'D'")
    Optional<Junta> findById(Integer idJunta);

    @Query("select junta from Junta junta " +
            "join fetch junta.sexo s " +
            "where junta.recinto.id = :idRecinto and junta.estado = :estado order by junta.numero asc")
    List<Junta> getAllByRecintoAndEstado(@Param("idRecinto") Integer idRecinto, @Param("estado") String estado);
}
