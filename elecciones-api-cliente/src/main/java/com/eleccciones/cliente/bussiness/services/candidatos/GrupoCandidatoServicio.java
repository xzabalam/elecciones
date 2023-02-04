package com.eleccciones.cliente.bussiness.services.candidatos;

import com.eleccciones.cliente.data.repositories.candidatos.GrupoCandidatoRepository;
import org.springframework.stereotype.Service;

@Service
public class GrupoCandidatoServicio {
    private final GrupoCandidatoRepository grupoCandidatoRepository;

    public GrupoCandidatoServicio(GrupoCandidatoRepository grupoCandidatoRepository) {
        this.grupoCandidatoRepository = grupoCandidatoRepository;
    }
}
