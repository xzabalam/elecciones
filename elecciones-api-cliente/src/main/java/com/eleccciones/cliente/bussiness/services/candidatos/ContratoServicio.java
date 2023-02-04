package com.eleccciones.cliente.bussiness.services.candidatos;

import com.eleccciones.cliente.data.repositories.candidatos.ContratoRepository;
import org.springframework.stereotype.Service;

@Service
public class ContratoServicio {
    private final ContratoRepository contratoRepository;

    public ContratoServicio(ContratoRepository contratoRepository) {
        this.contratoRepository = contratoRepository;
    }
}
