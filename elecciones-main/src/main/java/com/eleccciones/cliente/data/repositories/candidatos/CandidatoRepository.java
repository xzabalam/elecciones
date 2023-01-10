package com.eleccciones.cliente.data.repositories.candidatos;

import com.eleccciones.cliente.data.entities.candidatos.Candidato;
import com.eleccciones.cliente.data.entities.candidatos.Voto;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CandidatoRepository extends JpaRepository<Candidato, Integer> {
    
}
