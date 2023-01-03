package com.eleccciones.cliente.bussiness.services.candidatos;

import com.eleccciones.cliente.data.repositories.candidatos.ProcesoRepository;
import org.springframework.stereotype.Service;

@Service
public class ProcesoServicio {
    private final ProcesoRepository procesoRepository;

    public ProcesoServicio(ProcesoRepository procesoRepository) {
        this.procesoRepository = procesoRepository;
    }
}
