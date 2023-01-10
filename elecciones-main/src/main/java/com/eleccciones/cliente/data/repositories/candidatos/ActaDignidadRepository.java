package com.eleccciones.cliente.data.repositories.candidatos;

import com.eleccciones.cliente.data.entities.candidatos.ActaDignidad;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ActaDignidadRepository extends JpaRepository<ActaDignidad, Integer> {

    @Query("select distinct ad from ActaDignidad ad " +
            "join fetch ad.junta j " +
            "join fetch ad.dignidadUbicacion du " +
            "join fetch du.tipoUbicacion tu " +
            "join fetch du.dignidad d " +
            "join fetch d.tipoGrupo tg " +
            "join fetch d.proceso p " +
            "where j.id = :idJunta and ad.estado = :estado")
    List<ActaDignidad> findAllByJuntaAndEstado(@Param("idJunta") Integer idJunta, @Param("estado") String estado);
}
