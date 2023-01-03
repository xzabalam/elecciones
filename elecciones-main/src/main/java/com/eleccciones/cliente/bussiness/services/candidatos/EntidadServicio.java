package com.eleccciones.cliente.bussiness.services.candidatos;

import com.eleccciones.cliente.data.repositories.candidatos.EntidadRepository;
import org.springframework.stereotype.Service;

@Service
public class EntidadServicio {
    private final EntidadRepository entidadRepository;

    public EntidadServicio(EntidadRepository entidadRepository) {
        this.entidadRepository = entidadRepository;
    }
}
