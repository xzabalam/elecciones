package com.eleccciones.cliente.data.repositories.ubicacion;

import com.eleccciones.cliente.data.entities.ubicacion.Pais;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PaisRepository extends JpaRepository<Pais, Integer> {
    Page<Pais> findAll(Pageable pageable);
    List<Pais> findAllBy();
}
