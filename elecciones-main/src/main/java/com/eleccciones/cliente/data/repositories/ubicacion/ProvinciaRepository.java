package com.eleccciones.cliente.data.repositories.ubicacion;

import com.eleccciones.cliente.data.entities.ubicacion.Pais;
import com.eleccciones.cliente.data.entities.ubicacion.Provincia;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProvinciaRepository extends JpaRepository<Provincia, Integer> {
    Page<Provincia> findAllByPaisAndEstado(Pais pais, String estado, Pageable pageable);

    List<Provincia> findByPaisAndEstado(Pais pais, String estado);
}
