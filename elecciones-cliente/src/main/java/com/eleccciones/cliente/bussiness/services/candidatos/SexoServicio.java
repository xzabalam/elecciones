package com.eleccciones.cliente.bussiness.services.candidatos;

import com.eleccciones.cliente.data.repositories.candidatos.SexoRepository;
import org.springframework.stereotype.Service;

@Service
public class SexoServicio {
    private final SexoRepository sexoRepository;

    public SexoServicio(SexoRepository sexoRepository) {
        this.sexoRepository = sexoRepository;
    }
}
