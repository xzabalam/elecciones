package com.eleccciones.cliente.bussiness.services.ubicacion;

import com.eleccciones.cliente.common.exception.UbicacionException;
import com.eleccciones.cliente.common.util.EstadoEnum;
import com.eleccciones.cliente.data.entities.ubicacion.Junta;
import com.eleccciones.cliente.data.entities.ubicacion.Recinto;
import com.eleccciones.cliente.data.repositories.ubicacion.JuntaRepository;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class JuntaService {
    private final RecintoService recintoService;
    private final JuntaRepository juntaRepository;

    public JuntaService(RecintoService recintoService, JuntaRepository juntaRepository) {
        this.recintoService = recintoService;
        this.juntaRepository = juntaRepository;
    }

    @Secured({"ROLE_ADMINISTRADOR", "ROLE_USUARIO"})
    @Cacheable(value = "JUNTA", key = "#idJunta")
    public Junta getById(Integer idJunta) {
        Optional<Junta> junta = juntaRepository.findById(idJunta);

        if (junta.isEmpty()) {
            throw new UbicacionException("No existe la junta con el id " + idJunta);
        }

        return junta.get();
    }

    @Secured({"ROLE_ADMINISTRADOR", "ROLE_USUARIO"})
    @Cacheable(value = "JUNTA_LIST", key = "#idRecinto")
    public List<Junta> getAll(Integer idRecinto) {
        Recinto recinto = recintoService.findById(idRecinto);
        return juntaRepository.getAllByRecintoAndEstado(recinto.getId(), EstadoEnum.CREADO.getEstado());
    }
}
