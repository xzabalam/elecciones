package com.eleccciones.cliente.data.repositories.candidatos;

import com.eleccciones.cliente.data.entities.candidatos.Dignidad;
import com.eleccciones.cliente.data.repositories.candidatos.dto.DignidadDTO;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface DignidadRepository extends JpaRepository<Dignidad, Integer> {
    @Query("select new com.eleccciones.cliente.data.repositories.candidatos.dto.DignidadDTO(d.id, d.nombre) " +
            "from Dignidad d where d.estado != 'D'")
    List<DignidadDTO> obtenerTodas();

    /**
     * select distinct d.id, d.nombre
     * from contrato c
     * inner join grupo_candidato gc on c.id = gc.id_contrato and gc.estado !='D'
     * inner join dignidad_ubicacion du on gc.id_dignidad_ubicacion = du.id and gc.estado !='D'
     * inner join dignidad d on du.id_dignidad =d.id and d.estado !='D'
     * inner join circunscripcion cc on du.id_circunscripcion =cc.id and cc.estado !='D'
     * where c.id = 2
     * and c.estado != 'D'
     * and c.activo ='S'
     * order by 1;
     *
     * @param idContrato
     * @return
     */
    @Query("select " +
            "   new com.eleccciones.cliente.data.repositories.candidatos.dto.DignidadDTO(d.id, d.nombre) " +
            " from GrupoCandidato gc " +
            " inner join gc.contrato c " +
            " inner join gc.dignidadUbicacion du " +
            " inner join du.dignidad d " +
            " inner join du.circunscripcion cir " +
            " where " +
            "   c.id = :idContrato " +
            "   and c.estado != 'D' " +
            "   and c.activo = 'S' " +
            "   and d.estado != 'D' " +
            "   and gc.estado != 'D' " +
            "   and du.estado != 'D' " +
            "   and cir.estado != 'D' " +
            " group by d.id, d.nombre " +
            " order by d.id ")
    List<DignidadDTO> obtenerPorContrato(@Param("idContrato") Integer idContrato);
}
