package com.eleccciones.cliente.data.repositories.ubicacion;

import com.eleccciones.cliente.data.entities.ubicacion.Recinto;
import com.eleccciones.cliente.data.entities.ubicacion.Zona;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface RecintoRepository extends JpaRepository<Recinto, Integer> {
    Page<Recinto> findAllByZonaAndEstado(Zona zona, String estado, Pageable pageable);

    List<Recinto> findByZonaAndEstadoOrderByNombre(Zona zona, String estado);
}
