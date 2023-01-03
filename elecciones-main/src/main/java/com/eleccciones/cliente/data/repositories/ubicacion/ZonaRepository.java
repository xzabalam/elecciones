package com.eleccciones.cliente.data.repositories.ubicacion;

import com.eleccciones.cliente.data.entities.ubicacion.Parroquia;
import com.eleccciones.cliente.data.entities.ubicacion.Zona;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ZonaRepository extends JpaRepository<Zona, Integer> {
    Page<Zona> findAllByParroquiaAndEstado(Parroquia parroquia, String estado, Pageable pageable);
    List<Zona> findByParroquiaAndEstado(Parroquia parroquia, String estado);
}
