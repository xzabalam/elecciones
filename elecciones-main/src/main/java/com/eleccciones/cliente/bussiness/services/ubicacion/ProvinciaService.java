package com.eleccciones.cliente.bussiness.services.ubicacion;

import com.eleccciones.cliente.common.exception.UbicacionException;
import com.eleccciones.cliente.common.util.EstadoEnum;
import com.eleccciones.cliente.data.entities.ubicacion.Pais;
import com.eleccciones.cliente.data.entities.ubicacion.Provincia;
import com.eleccciones.cliente.data.repositories.ubicacion.ProvinciaRepository;
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
public class ProvinciaService {

    private final PaisService paisService;
    private final ProvinciaRepository provinciaRepository;

    public ProvinciaService(PaisService paisService, ProvinciaRepository provinciaRepository) {
        this.paisService = paisService;
        this.provinciaRepository = provinciaRepository;
    }

    @Secured({"ROLE_ADMINISTRADOR", "ROLE_USUARIO"})
    @Cacheable(value = "PROVINCIA", key = "#idProvincia")
    public Provincia findById(Integer idProvincia) {
        Optional<Provincia> provincia = provinciaRepository.findById(idProvincia);

        if (provincia.isEmpty()) {
            throw new UbicacionException("No existe la provincia con el id " + idProvincia);
        }
        return provincia.get();
    }

    @Secured({"ROLE_ADMINISTRADOR", "ROLE_USUARIO"})
    @Cacheable(value = "PROVINCIA_PAGE", key = "#idPais")
    public Page<Provincia> findAllByPaisAndEstado(Integer idPais, int page, int size) {
        Pais pais = paisService.findById(idPais);
        return provinciaRepository.findAllByPaisAndEstado(pais, EstadoEnum.CREADO.getEstado(),
                PageRequest.of(page, size));
    }

    @Secured({"ROLE_ADMINISTRADOR", "ROLE_USUARIO"})
    @Cacheable(value = "PROVINCIA_LIST", key = "#idPais")
    public List<Provincia> findByPaisAndEstado(Integer idPais) {
        Pais pais = paisService.findById(idPais);
        return provinciaRepository.findByPaisAndEstadoOrderByNombre(pais, EstadoEnum.CREADO.getEstado());
    }
}
