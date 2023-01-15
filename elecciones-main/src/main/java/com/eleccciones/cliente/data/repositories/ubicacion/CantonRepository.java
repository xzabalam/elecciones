package com.eleccciones.cliente.data.repositories.ubicacion;

import com.eleccciones.cliente.data.entities.ubicacion.Canton;
import com.eleccciones.cliente.data.entities.ubicacion.Provincia;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CantonRepository extends JpaRepository<Canton, Integer> {
    Page<Canton> findAllByProvinciaAndEstado(Provincia provincia, String estado, Pageable pageable);

    List<Canton> findByProvinciaAndEstadoOrderByNombre(Provincia provincia, String estado);
}
