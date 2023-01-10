package com.eleccciones.cliente.bussiness.services.candidatos;

import com.eleccciones.cliente.bussiness.services.ubicacion.JuntaService;
import com.eleccciones.cliente.common.exception.CandidatoException;
import com.eleccciones.cliente.common.util.EstadoEnum;
import com.eleccciones.cliente.data.entities.candidatos.ActaDignidad;
import com.eleccciones.cliente.data.entities.ubicacion.Junta;
import com.eleccciones.cliente.data.repositories.candidatos.ActaDignidadRepository;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional(readOnly = true)
public class ActaDignidadServicio {
    private final JuntaService juntaService;
    private final DignidadServicio dignidadServicio;
    private final ActaDignidadRepository actaDignidadRepository;

    public ActaDignidadServicio(JuntaService juntaService, DignidadServicio dignidadServicio, ActaDignidadRepository actaDignidadRepository) {
        this.juntaService = juntaService;
        this.dignidadServicio = dignidadServicio;
        this.actaDignidadRepository = actaDignidadRepository;
    }

    @Secured({"ROLE_ADMINISTRADOR", "ROLE_USUARIO"})
    @Cacheable(value = "ACTA_DIGNIDAD", key = "#idJunta")
    public List<ActaDignidad> findAllByJunta(Integer idJunta) {
        Junta junta = juntaService.findById(idJunta);
        return actaDignidadRepository.findAllByJuntaAndEstado(junta.getId(), EstadoEnum.CREADO.getEstado());
    }

    @Secured({"ROLE_ADMINISTRADOR", "ROLE_USUARIO"})
    @Cacheable(value = "ACTA_DIGNIDAD", key = "#idActaDignidad")
    public ActaDignidad findById(Integer idActaDignidad) {
        return actaDignidadRepository.findById(idActaDignidad).orElseThrow(() -> new CandidatoException("No existe " +
                "el acta dignidad con el id " + idActaDignidad));
    }
}
