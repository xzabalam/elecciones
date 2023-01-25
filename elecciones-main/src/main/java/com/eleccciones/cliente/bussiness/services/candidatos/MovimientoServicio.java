package com.eleccciones.cliente.bussiness.services.candidatos;

import com.eleccciones.cliente.data.repositories.candidatos.MovimientoRepository;
import org.springframework.stereotype.Service;

@Service
public class MovimientoServicio {
    private final MovimientoRepository movimientoRepository;

    public MovimientoServicio(MovimientoRepository movimientoRepository) {
        this.movimientoRepository = movimientoRepository;
    }

}
