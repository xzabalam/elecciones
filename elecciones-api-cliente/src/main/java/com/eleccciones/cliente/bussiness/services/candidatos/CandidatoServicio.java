package com.eleccciones.cliente.bussiness.services.candidatos;

import com.eleccciones.cliente.data.repositories.candidatos.CandidatoRepository;
import org.springframework.stereotype.Service;

@Service
public class CandidatoServicio {
    private final CandidatoRepository candidatoRepository;

    public CandidatoServicio(CandidatoRepository candidatoRepository) {
        this.candidatoRepository = candidatoRepository;
    }
}
