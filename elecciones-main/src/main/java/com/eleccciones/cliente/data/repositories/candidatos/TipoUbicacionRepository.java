package com.eleccciones.cliente.data.repositories.candidatos;

import com.eleccciones.cliente.data.entities.candidatos.TipoUbicacion;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TipoUbicacionRepository extends JpaRepository<TipoUbicacion, Integer> {
}
