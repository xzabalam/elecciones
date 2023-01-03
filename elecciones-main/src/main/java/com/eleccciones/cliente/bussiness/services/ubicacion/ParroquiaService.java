package com.eleccciones.cliente.bussiness.services.ubicacion;

import com.eleccciones.cliente.common.exception.UbicacionException;
import com.eleccciones.cliente.common.util.EstadoEnum;
import com.eleccciones.cliente.data.entities.ubicacion.Canton;
import com.eleccciones.cliente.data.entities.ubicacion.Parroquia;
import com.eleccciones.cliente.data.repositories.ubicacion.ParroquiaRepository;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ParroquiaService {
    private final CantonService cantonService;
    private final ParroquiaRepository parroquiaRepository;

    public ParroquiaService(CantonService cantonService, ParroquiaRepository parroquiaRepository) {
        this.cantonService = cantonService;
        this.parroquiaRepository = parroquiaRepository;
    }

    @Secured({"ROLE_ADMINISTRADOR", "ROLE_USUARIO"})
    @Cacheable(value = "PARROQUIA", key = "#idParroquia")
    public Parroquia findById(Integer idParroquia) {
        Optional<Parroquia> parroquia = parroquiaRepository.findById(idParroquia);

        if (parroquia.isEmpty()) {
            throw new UbicacionException("No existe la parroquia con el id " + idParroquia);
        }
        return parroquia.get();
    }

    @Secured({"ROLE_ADMINISTRADOR", "ROLE_USUARIO"})
    @Cacheable(value = "PARROQUIA_PAGE", key = "#idCanton")
    public Page<Parroquia> findAllByCantonAndEstado(Integer idCanton, int page, int size) {
        Canton canton = cantonService.findById(idCanton);
        return parroquiaRepository.findAllByCantonAndEstado(canton, EstadoEnum.CREADO.getEstado(),
                PageRequest.of(page, size));
    }

    @Secured({"ROLE_ADMINISTRADOR", "ROLE_USUARIO"})
    @Cacheable(value = "PARROQUIA_LIST", key = "#idCanton")
    public List<Parroquia> findByCantonAndEstado(Integer idCanton) {
        Canton canton = cantonService.findById(idCanton);
        return parroquiaRepository.findByCantonAndEstado(canton, EstadoEnum.CREADO.getEstado());
    }
}
