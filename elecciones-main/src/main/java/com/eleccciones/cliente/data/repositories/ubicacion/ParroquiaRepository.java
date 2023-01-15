package com.eleccciones.cliente.data.repositories.ubicacion;

import com.eleccciones.cliente.data.entities.ubicacion.Canton;
import com.eleccciones.cliente.data.entities.ubicacion.Parroquia;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ParroquiaRepository extends JpaRepository<Parroquia, Integer> {
    Page<Parroquia> findAllByCantonAndEstado(Canton canton, String estado, Pageable pageable);

    List<Parroquia> findByCantonAndEstadoOrderByNombre(Canton canton, String estado);
}
