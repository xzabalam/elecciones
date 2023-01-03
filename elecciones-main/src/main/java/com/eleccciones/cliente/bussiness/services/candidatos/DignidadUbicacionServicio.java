package com.eleccciones.cliente.bussiness.services.candidatos;

import com.eleccciones.cliente.data.repositories.candidatos.DignidadUbicacionRepository;
import org.springframework.stereotype.Service;

@Service
public class DignidadUbicacionServicio {
    private final DignidadUbicacionRepository dignidadUbicacionRepository;

    public DignidadUbicacionServicio(DignidadUbicacionRepository dignidadUbicacionRepository) {
        this.dignidadUbicacionRepository = dignidadUbicacionRepository;
    }
}
