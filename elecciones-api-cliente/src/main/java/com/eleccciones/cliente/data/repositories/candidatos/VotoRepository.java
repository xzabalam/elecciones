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
            "join fetch du.circunscripcion cir " +
            "join fetch du.tipoUbicacion tu " +
            "join fetch du.dignidad d " +
            "join fetch d.proceso p " +
            "join fetch d.tipoGrupo tg " +
            "join fetch v.grupoCandidato gc " +
            "join fetch gc.contrato con " +
            "join fetch gc.movimiento m " +
            "join fetch gc.candidatos c " +
            "join ad.junta j " +
            "where j.id = :idJunta and c.tipo = :tipoCandidato " +
            " and v.estado != 'D' and ad.estado != 'D' and du.estado != 'D' and cir.estado != 'D' " +
            " and tu.estado != 'D' and d.estado != 'D' and p.estado != 'D' and gc.estado != 'D' " +
            " and tg.estado != 'D' and gc.estado != 'D' and j.estado != 'D' " +
            " and con.estado != 'D' and m.estado != 'D' and c.estado != 'D' ")
    List<Voto> findByJunta(@Param("idJunta") Integer idJunta,
                           @Param("tipoCandidato") String tipoCandidato);
}
