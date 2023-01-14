package com.eleccciones.cliente.bussiness.services.candidatos;

import com.eleccciones.cliente.bussiness.services.ubicacion.JuntaService;
import com.eleccciones.cliente.data.entities.candidatos.Voto;
import com.eleccciones.cliente.data.entities.ubicacion.Junta;
import com.eleccciones.cliente.data.repositories.candidatos.VotoRepository;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional(readOnly = true)
public class VotoServicio {
    private final DignidadServicio dignidadServicio;
    private final JuntaService juntaService;
    private final VotoRepository votoRepository;

    public VotoServicio(DignidadServicio dignidadServicio, JuntaService juntaService, VotoRepository votoRepository) {
        this.dignidadServicio = dignidadServicio;
        this.juntaService = juntaService;
        this.votoRepository = votoRepository;
    }

    @Secured(value = {"ROLE_ADMINISTRADOR", "ROLE_USUARIO"})
    @Cacheable(value = "VOTO")
    public List<Voto> findByJuntaYCandidatoPrincipal(Integer idJunta) {
        Junta junta = juntaService.findById(idJunta);
        return votoRepository.findByJunta(junta.getId(), "PRINCIPAL");
    }
}
