package com.eleccciones.cliente.web.controllers.candidatos;

import com.eleccciones.cliente.bussiness.services.candidatos.ActaDignidadServicio;
import com.eleccciones.cliente.bussiness.services.candidatos.MovimientoServicio;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/movimiento")
public class MovimientoControlador {

    private final MovimientoServicio movimientoServicio;
    private final ActaDignidadServicio actaDignidadServicio;

    public MovimientoControlador(MovimientoServicio movimientoServicio, ActaDignidadServicio actaDignidadServicio) {
        this.movimientoServicio = movimientoServicio;
        this.actaDignidadServicio = actaDignidadServicio;
    }
}
