package com.eleccciones.cliente.bussiness.services.ubicacion;

import com.eleccciones.cliente.common.exception.UbicacionException;
import com.eleccciones.cliente.data.entities.ubicacion.Circunscripcion;
import com.eleccciones.cliente.data.repositories.ubicacion.CircunscripcionRepository;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;

@Service
@Transactional(readOnly = true)
public class CircunscripcionService {

    private final CircunscripcionRepository circunscripcionRepository;

    public CircunscripcionService(CircunscripcionRepository circunscripcionRepository) {
        this.circunscripcionRepository = circunscripcionRepository;
    }

    @Secured({"ROLE_ADMINISTRACION", "ROLE_USUARIO"})
    @Cacheable(value = "CIRCUNSCRIPCION", key = "#idCircunscripcion")
    public Circunscripcion findById(Integer idCircunscripcion) {
        Optional<Circunscripcion> circunscripcion = circunscripcionRepository.findById(idCircunscripcion);

        if(circunscripcion.isEmpty()) {
            throw  new UbicacionException("No existe la circunscripción con el id " +idCircunscripcion);
        }

        return circunscripcion.get();
    }

    @Secured({"ROLE_ADMINISTRACION", "ROLE_USUARIO"})
    @Cacheable(value = "CIRCUNSCRIPCION", key = "#sigla")
    public Circunscripcion findBySigla(String sigla) {
        Optional<Circunscripcion> circunscripcion = circunscripcionRepository.findBySigla(sigla);

        if(circunscripcion.isEmpty()) {
            throw  new UbicacionException("No existe la circunscripción con la sigla " + sigla);
        }

        return circunscripcion.get();
    }
}
