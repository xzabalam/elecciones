package com.eleccciones.cliente.data.repositories.candidatos;

import com.eleccciones.cliente.data.entities.candidatos.Voto;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface VotoRepository extends JpaRepository<Voto, Integer> {

    @Query(value = "select distinct v from Voto v " +
            "join fetch v.actaDignidad ad " +
            "join fetch ad.dignidadUbicacion du " +
            "join fetch du.tipoUbicacion tu " +
            "join fetch du.dignidad d " +
            "join fetch d.proceso p " +
            "join fetch d.tipoGrupo tg " +
            "join fetch ad.junta j " +
            "join fetch v.grupoCandidato gc " +
            "join fetch gc.candidatos c " +
            "join fetch gc.movimiento " +
            "where d.id = :idDignidad and j.id = :idJunta")
    List<Voto> findByActaDignidadAndJunta(@Param("idDignidad") Integer idDignidad,
                                          @Param("idJunta") Integer idJunta);

    @Query(value = "select distinct v from Voto v " +
            "join fetch v.actaDignidad ad " +
            "join fetch ad.dignidadUbicacion du " +
            "join fetch du.tipoUbicacion tu " +
            "join fetch du.dignidad d " +
            "join fetch d.proceso p " +
            "join fetch d.tipoGrupo tg " +
            "join fetch ad.junta j " +
            "join fetch v.grupoCandidato gc " +
            "join fetch gc.candidatos c " +
            "join fetch gc.movimiento " +
            "where j.id = :idJunta")
    List<Voto> findByJunta(@Param("idJunta") Integer idJunta);
}
