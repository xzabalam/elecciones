package com.eleccciones.cliente.bussiness.services.candidatos;

import com.eleccciones.cliente.data.repositories.candidatos.TipoIdentificacionRepository;
import org.springframework.stereotype.Service;

@Service
public class TipoIdentificacion {
    private final TipoIdentificacionRepository tipoIdentificacionRepository;

    public TipoIdentificacion(TipoIdentificacionRepository tipoIdentificacionRepository) {
        this.tipoIdentificacionRepository = tipoIdentificacionRepository;
    }
}
