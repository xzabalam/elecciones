package com.eleccciones.cliente.bussiness.services.estadisticas;

import com.eleccciones.cliente.data.entities.estadisticas.dto.NumeroElectoresDTO;
import com.eleccciones.cliente.data.repositories.estadisticas.NumeroElectoresRepository;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional(readOnly = true)
public class NumeroElectoresService {
    private final NumeroElectoresRepository numeroElectoresRepository;

    public NumeroElectoresService(NumeroElectoresRepository numeroElectoresRepository) {
        this.numeroElectoresRepository = numeroElectoresRepository;
    }

    @Secured(value = {"ROLE_ADMINISTRADOR", "ROLE_USUARIO"})
    @Cacheable(value = "NUMERO_ELECTORES_PROVINCIA")
    public NumeroElectoresDTO getByProvincia(Integer idProvincia) {
        return numeroElectoresRepository.getByProvincia(idProvincia);
    }

    @Secured(value = {"ROLE_ADMINISTRADOR", "ROLE_USUARIO"})
    @Cacheable(value = "NUMERO_ELECTORES_CANTON")
    public NumeroElectoresDTO getByProvinciaAndCanton(Integer idProvincia,
                                                      Integer idCanton) {
        return numeroElectoresRepository.getByProvinciaAndCanton(idProvincia, idCanton);
    }

    @Secured(value = {"ROLE_ADMINISTRADOR", "ROLE_USUARIO"})
    @Cacheable(value = "NUMERO_ELECTORES_PARROQUIA")
    public NumeroElectoresDTO getByProvinciaAndCantonAndParroquia(Integer idProvincia,
                                                                  Integer idCanton,
                                                                  Integer idParroquia) {
        return numeroElectoresRepository.getByProvinciaAndCantonAndParroquia(idProvincia, idCanton, idParroquia);
    }
}
