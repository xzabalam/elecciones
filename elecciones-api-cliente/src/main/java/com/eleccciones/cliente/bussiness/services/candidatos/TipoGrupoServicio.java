package com.eleccciones.cliente.bussiness.services.candidatos;

import com.eleccciones.cliente.data.repositories.candidatos.TipoGrupoRepository;
import org.springframework.stereotype.Service;

@Service
public class TipoGrupoServicio {
    private final TipoGrupoRepository tipoGrupoRepository;

    public TipoGrupoServicio(TipoGrupoRepository tipoGrupoRepository) {
        this.tipoGrupoRepository = tipoGrupoRepository;
    }
}
