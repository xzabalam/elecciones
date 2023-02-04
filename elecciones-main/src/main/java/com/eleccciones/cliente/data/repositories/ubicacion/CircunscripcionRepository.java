package com.eleccciones.cliente.data.repositories.ubicacion;

import com.eleccciones.cliente.data.entities.ubicacion.Circunscripcion;
import com.eleccciones.cliente.data.repositories.candidatos.dto.CircunscripcionDto;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface CircunscripcionRepository extends JpaRepository<Circunscripcion, Integer> {
    Optional<Circunscripcion> findBySigla(String sigla);

    @Query("select  " +
            " new com.eleccciones.cliente.data.repositories.candidatos.dto.CircunscripcionDto(cir.id, cir.nombre) " +
            "from GrupoCandidato gc " +
            "inner join gc.contrato c  " +
            "inner join gc.dignidadUbicacion du " +
            "inner join du.dignidad d " +
            "inner join du.circunscripcion cir " +
            "where c.id = :idContrato and d.id = :idDignidad " +
            "   and gc.estado != 'D' and c.estado != 'D' and du.estado != 'D' and d.estado != 'D' " +
            "   and cir.estado != 'D'" +
            "group by cir.id, cir.nombre " +
            "order by cir.id ")
    List<CircunscripcionDto> getCircunscripcionesPorContratoYDignidad(@Param("idContrato") Integer idContrato,
                                                                      @Param("idDignidad") Integer idDignidad);
}
