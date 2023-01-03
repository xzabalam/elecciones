package com.eleccciones.cliente.data.repositories.candidatos;

import com.eleccciones.cliente.data.entities.candidatos.ActaDignidad;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ActaDignidadRepository extends JpaRepository<ActaDignidad, Integer> {

    @Query("select d from ActaDignidad d " +
            "join fetch d.dignidadUbicacion du " +
            "join fetch du.tipoUbicacion tu " +
            "join fetch du.dignidad dignidad " +
            "join fetch dignidad.proceso " +
            "join fetch  dignidad.tipoGrupo " +
            "where d.junta.id = :idJunta and d.estado = :estado")
    List<ActaDignidad> findAllByJuntaAndEstado(@Param("idJunta") Integer idJunta, @Param("estado") String estado);
}
