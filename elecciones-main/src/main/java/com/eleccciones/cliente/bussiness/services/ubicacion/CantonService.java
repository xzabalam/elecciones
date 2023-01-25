package com.eleccciones.cliente.bussiness.services.ubicacion;

import com.eleccciones.cliente.common.enumeration.EstadoEnum;
import com.eleccciones.cliente.common.exception.UbicacionException;
import com.eleccciones.cliente.data.entities.ubicacion.Canton;
import com.eleccciones.cliente.data.entities.ubicacion.Provincia;
import com.eleccciones.cliente.data.repositories.ubicacion.CantonRepository;
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
public class CantonService {

    private final ProvinciaService provinciaService;
    private final CantonRepository cantonRepository;

    public CantonService(ProvinciaService provinciaService, CantonRepository cantonRepository) {
        this.provinciaService = provinciaService;
        this.cantonRepository = cantonRepository;
    }

    @Secured({"ROLE_ADMINISTRADOR", "ROLE_USUARIO"})
    @Cacheable(value = "CANTON", key = "#idCanton")
    public Canton findById(Integer idCanton) {
        Optional<Canton> canton = cantonRepository.findById(idCanton);

        if (canton.isEmpty()) {
            throw new UbicacionException("No existe el cantón con el id " + idCanton);
        }
        return canton.get();
    }

    @Secured({"ROLE_ADMINISTRADOR", "ROLE_USUARIO"})
    @Cacheable(value = "CANTON_LIST", key = "#idProvincia")
    public List<Canton> findByProvincia(Integer idProvincia) {
        Provincia provincia = provinciaService.findById(idProvincia);
        return cantonRepository.findByProvinciaAndEstadoOrderByNombre(provincia, EstadoEnum.CREADO.getEstado());
    }

    @Secured({"ROLE_ADMINISTRADOR", "ROLE_USUARIO"})
    @Cacheable(value = "CANTON_PAGE", key = "#idProvincia")
    public Page<Canton> findByProvinciaPage(Integer idProvincia, int page, int size) {
        Provincia provincia = provinciaService.findById(idProvincia);
        return cantonRepository.findAllByProvinciaAndEstado(provincia, EstadoEnum.CREADO.getEstado(), PageRequest.of(page, size));
    }
}
