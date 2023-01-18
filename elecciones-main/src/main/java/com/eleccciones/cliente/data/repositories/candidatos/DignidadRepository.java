package com.eleccciones.cliente.data.repositories.candidatos;

import com.eleccciones.cliente.data.entities.candidatos.Dignidad;
import com.eleccciones.cliente.data.repositories.candidatos.dto.DignidadDTO;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface DignidadRepository extends JpaRepository<Dignidad, Integer> {
    @Query("select new com.eleccciones.cliente.data.repositories.candidatos.dto.DignidadDTO(d.id, d.nombre) " +
            "from Dignidad d where d.estado != 'D'")
    List<DignidadDTO> obtenerTodas();
}
