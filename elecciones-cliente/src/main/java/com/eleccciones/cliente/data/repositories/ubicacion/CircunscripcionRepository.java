package com.eleccciones.cliente.data.repositories.ubicacion;

import com.eleccciones.cliente.data.entities.ubicacion.Circunscripcion;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface CircunscripcionRepository extends JpaRepository<Circunscripcion, Integer> {
    Optional<Circunscripcion> findBySigla(String sigla);
}
