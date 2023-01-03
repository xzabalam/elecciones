package com.eleccciones.cliente.bussiness.services.ubicacion;

import com.eleccciones.cliente.common.exception.UbicacionException;
import com.eleccciones.cliente.data.entities.ubicacion.Pais;
import com.eleccciones.cliente.data.repositories.ubicacion.PaisRepository;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class PaisService {
    private final PaisRepository paisRepository;

    public PaisService(PaisRepository paisRepository) {
        this.paisRepository = paisRepository;
    }

    @Secured({"ROLE_ADMINISTRADOR", "ROLE_USUARIO"})
    @Cacheable(value = "PAIS", key="#idPais")
    public Pais findById(Integer idPais) {
        Optional<Pais> pais = paisRepository.findById(idPais);

        if (pais.isEmpty()) {
            throw new UbicacionException("No existe el país con el id " + idPais);
        }

        return pais.get();
    }

    @Secured({"ROLE_ADMINISTRADOR", "ROLE_USUARIO"})
    @Cacheable(value = "PAIS_PAGE")
    public Page<Pais> getAll(int page, int size) {
        return paisRepository.findAll(PageRequest.of(page, size));
    }

    @Secured({"ROLE_ADMINISTRADOR", "ROLE_USUARIO"})
    @Cacheable(value = "PAIS_LIST")
    public List<Pais> getAll() {
        return paisRepository.findAll();
    }
}
