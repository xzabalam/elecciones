package com.eleccciones.cliente.bussiness.services.candidatos;

import com.eleccciones.cliente.common.exception.CandidatoException;
import com.eleccciones.cliente.data.entities.candidatos.Dignidad;
import com.eleccciones.cliente.data.repositories.candidatos.DignidadRepository;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional(readOnly = true)
public class DignidadServicio {
    private final DignidadRepository dignidadRepository;

    public DignidadServicio(DignidadRepository dignidadRepository) {
        this.dignidadRepository = dignidadRepository;
    }

    @Secured({"ROLE_ADMINISTRADOR", "ROLE_USUARIO"})
    @Cacheable(value = "DIGNIDADES", key = "#idDignidad")
    public Dignidad findById(Integer idDignidad) {
        return dignidadRepository.findById(idDignidad).orElseThrow(() ->
                new CandidatoException("No existe la dignidad con el id " + idDignidad)
        );
    }
}
