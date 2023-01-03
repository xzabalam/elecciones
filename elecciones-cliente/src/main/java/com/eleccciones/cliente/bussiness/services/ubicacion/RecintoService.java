package com.eleccciones.cliente.bussiness.services.ubicacion;

import com.eleccciones.cliente.common.exception.UbicacionException;
import com.eleccciones.cliente.common.util.EstadoEnum;
import com.eleccciones.cliente.data.entities.ubicacion.Canton;
import com.eleccciones.cliente.data.entities.ubicacion.Parroquia;
import com.eleccciones.cliente.data.entities.ubicacion.Recinto;
import com.eleccciones.cliente.data.entities.ubicacion.Zona;
import com.eleccciones.cliente.data.repositories.ubicacion.RecintoRepository;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class RecintoService {

    private final ZonaService zonaService;
    private final RecintoRepository recintoRepository;

    public RecintoService(ZonaService zonaService, RecintoRepository recintoRepository) {
        this.zonaService = zonaService;
        this.recintoRepository = recintoRepository;
    }

    @Secured({"ROLE_ADMINISTRADOR", "ROLE_USUARIO"})
    @Cacheable(value = "RECINTO", key = "#idRecinto")
    public Recinto findById(Integer idRecinto) {
        Optional<Recinto> recinto = recintoRepository.findById(idRecinto);

        if (recinto.isEmpty()) {
            throw new UbicacionException("No existe la recinto con el id " + idRecinto);
        }

        return recinto.get();
    }

    @Secured({"ROLE_ADMINISTRADOR", "ROLE_USUARIO"})
    @Cacheable(value = "RECINTO_PAGE", key = "#idZona")
    public Page<Recinto> findAllByZonaAndEstado(Integer idZona, int page, int size) {
        Zona zona = zonaService.findById(idZona);
        return recintoRepository.findAllByZonaAndEstado(zona, EstadoEnum.CREADO.getEstado(),
                PageRequest.of(page, size));
    }

    @Secured({"ROLE_ADMINISTRADOR", "ROLE_USUARIO"})
    @Cacheable(value = "RECINTO_LIST", key = "#idZona")
    public List<Recinto> findByZonaAndEstado(Integer idZona) {
        Zona zona = zonaService.findById(idZona);
        return recintoRepository.findByZonaAndEstado(zona, EstadoEnum.CREADO.getEstado());
    }
}
