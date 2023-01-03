package com.eleccciones.cliente.bussiness.services.candidatos;

import com.eleccciones.cliente.data.repositories.candidatos.VotoRepository;
import org.springframework.stereotype.Service;

@Service
public class VotoServicio {
    private final VotoRepository votoRepository;

    public VotoServicio(VotoRepository votoRepository) {
        this.votoRepository = votoRepository;
    }
}
