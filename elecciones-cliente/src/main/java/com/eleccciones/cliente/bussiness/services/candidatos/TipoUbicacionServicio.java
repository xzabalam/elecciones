package com.eleccciones.cliente.bussiness.services.candidatos;

import com.eleccciones.cliente.data.repositories.candidatos.TipoUbicacionRepository;
import org.springframework.stereotype.Service;

@Service
public class TipoUbicacionServicio {
    private final TipoUbicacionRepository tipoUbicacionRepository;

    public TipoUbicacionServicio(TipoUbicacionRepository tipoUbicacionRepository) {
        this.tipoUbicacionRepository = tipoUbicacionRepository;
    }
}
