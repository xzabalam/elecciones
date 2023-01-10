package com.eleccciones.cliente.bussiness.services.ubicacion;

import com.eleccciones.cliente.common.exception.UbicacionException;
import com.eleccciones.cliente.common.util.EstadoEnum;
import com.eleccciones.cliente.data.entities.ubicacion.Parroquia;
import com.eleccciones.cliente.data.entities.ubicacion.Zona;
import com.eleccciones.cliente.data.repositories.ubicacion.ZonaRepository;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@Transactional(readOnly = true)
public class ZonaService {
    private final ParroquiaService parroquiaService;
    private final ZonaRepository zonaRepository;

    public ZonaService(ParroquiaService parroquiaService, ZonaRepository zonaRepository) {
        this.parroquiaService = parroquiaService;
        this.zonaRepository = zonaRepository;
    }

    @Secured({"ROLE_ADMINISTRADOR", "ROLE_USUARIO"})
    @Cacheable(value = "ZONA", key = "#idZona")
    public Zona findById(Integer idZona) {
        Optional<Zona> zona = zonaRepository.findById(idZona);

        if (zona.isEmpty()) {
            throw new UbicacionException("No existe la zona con el id " + idZona);
        }
        return zona.get();
    }

    @Secured({"ROLE_ADMINISTRADOR", "ROLE_USUARIO"})
    @Cacheable(value = "ZONA_PAGE", key = "#idParroquia")
    public Page<Zona> findAllByParroquiaAndEstado(Integer idParroquia, int page, int size) {
        Parroquia parroquia = parroquiaService.findById(idParroquia);
        return zonaRepository.findAllByParroquiaAndEstado(parroquia, EstadoEnum.CREADO.getEstado(),
                PageRequest.of(page, size));
    }

    @Secured({"ROLE_ADMINISTRADOR", "ROLE_USUARIO"})
    @Cacheable(value = "ZONA_LIST", key = "#idParroquia")
    public List<Zona> findByParroquiaAndEstado(Integer idParroquia) {
        Parroquia parroquia = parroquiaService.findById(idParroquia);
        return zonaRepository.findByParroquiaAndEstado(parroquia, EstadoEnum.CREADO.getEstado());
    }
}
