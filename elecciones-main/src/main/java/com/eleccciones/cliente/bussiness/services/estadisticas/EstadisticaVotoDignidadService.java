package com.eleccciones.cliente.bussiness.services.estadisticas;

import com.eleccciones.cliente.bussiness.services.estadisticas.util.ParametroEstadisticaUtil;
import com.eleccciones.cliente.data.entities.estadisticas.dto.EstadisticaDTO;
import com.eleccciones.cliente.data.repositories.estadisticas.EstadisticaVotoDignidadRepository;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional(readOnly = true)
public class EstadisticaVotoDignidadService {
    private final EstadisticaVotoDignidadRepository estadisticaVotoDignidadRepository;

    public EstadisticaVotoDignidadService(EstadisticaVotoDignidadRepository estadisticaVotoDignidadRepository) {
        this.estadisticaVotoDignidadRepository = estadisticaVotoDignidadRepository;
    }

    @Secured(value = {"ROLE_ADMINISTRADOR", "ROLE_USUARIO"})
    public List<EstadisticaDTO> getPrefectosPorProvincia(Integer idProvincia) {
        ParametroEstadisticaUtil.validarProvincia(idProvincia);
        return estadisticaVotoDignidadRepository.getPrefectosPorProvincia(idProvincia);
    }

    @Secured(value = {"ROLE_ADMINISTRADOR", "ROLE_USUARIO"})
    public List<EstadisticaDTO> getAlcaldesPorProvincia(Integer idProvincia) {
        ParametroEstadisticaUtil.validarProvincia(idProvincia);
        return estadisticaVotoDignidadRepository.getAlcaldesPorProvincia(idProvincia);
    }

    @Secured(value = {"ROLE_ADMINISTRADOR", "ROLE_USUARIO"})
    public List<EstadisticaDTO> getAlcaldesPorProvinciaYCanton(Integer idProvincia, Integer idCanton) {
        ParametroEstadisticaUtil.validarProvincia(idProvincia);
        ParametroEstadisticaUtil.validarCanton(idCanton);
        return estadisticaVotoDignidadRepository.getAlcaldesPorProvinciaYCanton(idProvincia, idCanton);
    }

    @Secured(value = {"ROLE_ADMINISTRADOR", "ROLE_USUARIO"})
    public List<EstadisticaDTO> getConcejalesUrbanosPorProvincia(Integer idProvincia) {
        ParametroEstadisticaUtil.validarProvincia(idProvincia);
        return estadisticaVotoDignidadRepository.getConcejalesUrbanosPorProvincia(idProvincia);
    }

    @Secured(value = {"ROLE_ADMINISTRADOR", "ROLE_USUARIO"})
    public List<EstadisticaDTO> getConcejalesUrbanosPorProvinciaYCanton(Integer idProvincia, Integer idCanton) {
        ParametroEstadisticaUtil.validarProvincia(idProvincia);
        ParametroEstadisticaUtil.validarCanton(idCanton);
        return estadisticaVotoDignidadRepository.getConcejalesUrbanosPorProvinciaYCanton(idProvincia, idCanton);
    }

    @Secured(value = {"ROLE_ADMINISTRADOR", "ROLE_USUARIO"})
    public List<EstadisticaDTO> getConcejalesRuralesPorProvincia(Integer idProvincia) {
        ParametroEstadisticaUtil.validarProvincia(idProvincia);
        return estadisticaVotoDignidadRepository.getConcejalesRuralesPorProvincia(idProvincia);
    }

    @Secured(value = {"ROLE_ADMINISTRADOR", "ROLE_USUARIO"})
    public List<EstadisticaDTO> getConcejalesRuralesPorProvinciaYCanton(Integer idProvincia, Integer idCanton) {
        ParametroEstadisticaUtil.validarProvincia(idProvincia);
        ParametroEstadisticaUtil.validarCanton(idCanton);
        return estadisticaVotoDignidadRepository.getConcejalesRuralesPorProvinciaYCanton(idProvincia, idCanton);
    }

    @Secured(value = {"ROLE_ADMINISTRADOR", "ROLE_USUARIO"})
    public List<EstadisticaDTO> getVocalesJuntasParroquialesPorProvincia(Integer idProvincia) {
        ParametroEstadisticaUtil.validarProvincia(idProvincia);
        return estadisticaVotoDignidadRepository.getVocalesJuntasParroquialesPorProvincia(idProvincia);
    }

    @Secured(value = {"ROLE_ADMINISTRADOR", "ROLE_USUARIO"})
    public List<EstadisticaDTO> getVocalesJuntasParroquialesPorProvinciaYCanton(Integer idProvincia, Integer idCanton) {
        ParametroEstadisticaUtil.validarProvincia(idProvincia);
        ParametroEstadisticaUtil.validarCanton(idCanton);
        return estadisticaVotoDignidadRepository.getVocalesJuntasParroquialesPorProvinciaYCanton(idProvincia, idCanton);
    }

    @Secured(value = {"ROLE_ADMINISTRADOR", "ROLE_USUARIO"})
    public List<EstadisticaDTO> getVocalesJuntasParroquialesPorProvinciaYCantonYParroquia(Integer idProvincia, Integer idCanton, Integer idParroquia) {
        ParametroEstadisticaUtil.validarProvincia(idProvincia);
        ParametroEstadisticaUtil.validarCanton(idCanton);
        ParametroEstadisticaUtil.validarParroquia(idParroquia);
        return estadisticaVotoDignidadRepository.getVocalesJuntasParroquialesPorProvinciaYCantonYParroquia(idProvincia, idCanton, idParroquia);
    }


}
