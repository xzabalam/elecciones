package com.eleccciones.cliente.bussiness.services.candidatos;

import com.eleccciones.cliente.data.repositories.candidatos.DignidadRepository;
import org.springframework.stereotype.Service;

@Service
public class DignidadServicio {
    private final DignidadRepository dignidadRepository;

    public DignidadServicio(DignidadRepository dignidadRepository) {
        this.dignidadRepository = dignidadRepository;
    }
}
