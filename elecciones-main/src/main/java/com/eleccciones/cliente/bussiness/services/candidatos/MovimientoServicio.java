package com.eleccciones.cliente.bussiness.services.candidatos;

import com.eleccciones.cliente.common.util.EstadoEnum;
import com.eleccciones.cliente.common.util.TipoCandidatoEnum;
import com.eleccciones.cliente.data.entities.candidatos.Movimiento;
import com.eleccciones.cliente.data.repositories.candidatos.MovimientoRepository;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MovimientoServicio {
    private final MovimientoRepository movimientoRepository;

    public MovimientoServicio(MovimientoRepository movimientoRepository) {
        this.movimientoRepository = movimientoRepository;
    }

}
