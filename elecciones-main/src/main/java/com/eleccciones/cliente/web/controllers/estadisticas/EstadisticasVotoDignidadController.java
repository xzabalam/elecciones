package com.eleccciones.cliente.web.controllers.estadisticas;

import com.eleccciones.cliente.bussiness.services.estadisticas.EstadisticaVotoDignidadService;
import com.eleccciones.cliente.bussiness.services.estadisticas.util.ParametroEstadisticaUtil;
import com.eleccciones.cliente.data.entities.estadisticas.dto.EstadisticaDTO;
import io.swagger.v3.oas.annotations.Operation;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Positive;
import java.util.List;

@RestController
@RequestMapping("/estadisticas")
public class EstadisticasVotoDignidadController {
    private final EstadisticaVotoDignidadService estadisticaVotoDignidadService;

    public EstadisticasVotoDignidadController(EstadisticaVotoDignidadService estadisticaVotoDignidadService) {
        this.estadisticaVotoDignidadService = estadisticaVotoDignidadService;
    }

    @GetMapping("/prefectos/provincia/{idProvincia}")
    @Operation(summary = "Obtener prefectos por provincia.")
    public ResponseEntity<List<EstadisticaDTO>> getPrefectosPorProvincia(
            @Valid @NotNull @Positive @PathVariable("idProvincia") Integer idProvincia) {
        ParametroEstadisticaUtil.validarProvincia(idProvincia);
        List<EstadisticaDTO> resultado = estadisticaVotoDignidadService.getPrefectosPorProvincia(idProvincia);
        return new ResponseEntity<>(resultado, HttpStatus.OK);
    }

    @GetMapping("/alcaldes/provincia/{idProvincia}")
    @Operation(summary = "Obtener alcaldes por provincia")
    public ResponseEntity<List<EstadisticaDTO>> getAlcaldesPorProvincia(
            @Valid @NotNull @Positive @PathVariable("idProvincia") Integer idProvincia) {
        ParametroEstadisticaUtil.validarProvincia(idProvincia);
        List<EstadisticaDTO> resultado = estadisticaVotoDignidadService.getAlcaldesPorProvincia(idProvincia);
        return new ResponseEntity<>(resultado, HttpStatus.OK);
    }

    @GetMapping("/alcaldes/provincia/{idProvincia}/canton/{idCanton}")
    @Operation(summary = "Obtener prefectos por provincia y canton")
    public ResponseEntity<List<EstadisticaDTO>> getAlcaldesPorProvinciaYCanton(
            @Valid @NotNull @Positive @PathVariable("idProvincia") Integer idProvincia,
            @Valid @NotNull @Positive @PathVariable("idCanton") Integer idCanton) {
        ParametroEstadisticaUtil.validarProvincia(idProvincia);
        ParametroEstadisticaUtil.validarCanton(idCanton);
        List<EstadisticaDTO> resultado = estadisticaVotoDignidadService.getAlcaldesPorProvinciaYCanton(idProvincia, idCanton);
        return new ResponseEntity<>(resultado, HttpStatus.OK);
    }

    @GetMapping("/concejales/urbanos/provincia/{idProvincia}")
    @Operation(summary = "Obtener concejales urbanos por provincia")
    public ResponseEntity<List<EstadisticaDTO>> getConcejalesUrbanosPorProvincia(
            @Valid @NotNull @Positive @PathVariable("idProvincia") Integer idProvincia) {
        ParametroEstadisticaUtil.validarProvincia(idProvincia);
        List<EstadisticaDTO> resultado = estadisticaVotoDignidadService.getConcejalesUrbanosPorProvincia(idProvincia);
        return new ResponseEntity<>(resultado, HttpStatus.OK);
    }

    @GetMapping("/concejales/urbanos/provincia/{idProvincia}/canton/{idCanton}")
    @Operation(summary = "Obtener concejales urbanos por provincia y canton.")
    public ResponseEntity<List<EstadisticaDTO>> getConcejalesUrbanosPorProvinciaYCanton(
            @Valid @NotNull @Positive @PathVariable("idProvincia") Integer idProvincia,
            @Valid @NotNull @Positive @PathVariable("idCanton") Integer idCanton) {
        ParametroEstadisticaUtil.validarProvincia(idProvincia);
        ParametroEstadisticaUtil.validarCanton(idCanton);
        List<EstadisticaDTO> resultado = estadisticaVotoDignidadService.getConcejalesUrbanosPorProvinciaYCanton(idProvincia, idCanton);
        return new ResponseEntity<>(resultado, HttpStatus.OK);
    }

    @GetMapping("/concejales/urbanos/circunscripcion/provincia/{idProvincia}/canton/{idCanton}")
    @Operation(summary = "Obtener concejales urbanos por provincia y canton.")
    public ResponseEntity<List<EstadisticaDTO>> getConcejalesUrbanosCircunscripcionPorProvinciaYCanton(
            @Valid @NotNull @Positive @PathVariable("idProvincia") Integer idProvincia,
            @Valid @NotNull @Positive @PathVariable("idCanton") Integer idCanton) {
        ParametroEstadisticaUtil.validarProvincia(idProvincia);
        ParametroEstadisticaUtil.validarCanton(idCanton);
        List<EstadisticaDTO> resultado = estadisticaVotoDignidadService.getConcejalesUrbanosCircunscripcionPorProvinciaYCanton(idProvincia, idCanton);
        return new ResponseEntity<>(resultado, HttpStatus.OK);
    }

    @GetMapping("/concejales/rurales/provincia/{idProvincia}")
    @Operation(summary = "Obtener concejales rurales por provincia")
    public ResponseEntity<List<EstadisticaDTO>> getConcejalesRuralesPorProvincia(@Valid @NotNull @Positive @PathVariable(
            "idProvincia") Integer idProvincia) {
        ParametroEstadisticaUtil.validarProvincia(idProvincia);
        List<EstadisticaDTO> resultado = estadisticaVotoDignidadService.getConcejalesRuralesPorProvincia(idProvincia);
        return new ResponseEntity<>(resultado, HttpStatus.OK);
    }

    @GetMapping("/concejales/rurales/provincia/{idProvincia}/canton/{idCanton}")
    @Operation(summary = "Obtener concejales rurales por provincia y canton")
    public ResponseEntity<List<EstadisticaDTO>> getConcejalesRuralesPorProvinciaYCanton(
            @Valid @NotNull @Positive @PathVariable("idProvincia") Integer idProvincia,
            @Valid @NotNull @Positive @PathVariable("idCanton") Integer idCanton) {
        ParametroEstadisticaUtil.validarProvincia(idProvincia);
        ParametroEstadisticaUtil.validarCanton(idCanton);
        List<EstadisticaDTO> resultado = estadisticaVotoDignidadService.getConcejalesRuralesPorProvinciaYCanton(idProvincia, idCanton);
        return new ResponseEntity<>(resultado, HttpStatus.OK);
    }

    @GetMapping("/vocales/juntas/provincia/{idProvincia}")
    @Operation(summary = "Obtener vocales de juntas parroquiales por provincia")
    public ResponseEntity<List<EstadisticaDTO>> getVocalesJuntasParroquialesPorProvincia(
            @Valid @NotNull @Positive @PathVariable("idProvincia") Integer idProvincia) {
        ParametroEstadisticaUtil.validarProvincia(idProvincia);
        List<EstadisticaDTO> resultado = estadisticaVotoDignidadService.getVocalesJuntasParroquialesPorProvincia(idProvincia);
        return new ResponseEntity<>(resultado, HttpStatus.OK);
    }

    @GetMapping("/vocales/juntas/provincia/{idProvincia}/canton/{idCanton}")
    @Operation(summary = "Obtener vocales de juntas parroquiales por provincia, canton")
    public ResponseEntity<List<EstadisticaDTO>> getVocalesJuntasParroquialesPorProvinciaYCanton(
            @Valid @NotNull @Positive @PathVariable("idProvincia") Integer idProvincia,
            @Valid @NotNull @Positive @PathVariable("idCanton") Integer idCanton) {
        ParametroEstadisticaUtil.validarProvincia(idProvincia);
        ParametroEstadisticaUtil.validarCanton(idCanton);
        List<EstadisticaDTO> resultado = estadisticaVotoDignidadService.getVocalesJuntasParroquialesPorProvinciaYCanton(idProvincia, idCanton);
        return new ResponseEntity<>(resultado, HttpStatus.OK);
    }

    @GetMapping("/vocales/juntas/provincia/{idProvincia}/canton/{idCanton}/parroquia/{idParroquia}")
    @Operation(summary = "Obtener vocales de juntas parroquiales por provincia, canton y parroquia")
    public ResponseEntity<List<EstadisticaDTO>> getVocalesJuntasParroquialesPorProvinciaYCantonYParroquia(
            @Valid @NotNull @Positive @PathVariable("idProvincia") Integer idProvincia,
            @Valid @NotNull @Positive @PathVariable("idCanton") Integer idCanton,
            @Valid @NotNull @Positive @PathVariable("idParroquia") Integer idParroquia) {
        ParametroEstadisticaUtil.validarProvincia(idProvincia);
        ParametroEstadisticaUtil.validarCanton(idCanton);
        ParametroEstadisticaUtil.validarParroquia(idParroquia);
        List<EstadisticaDTO> resultado = estadisticaVotoDignidadService.getVocalesJuntasParroquialesPorProvinciaYCantonYParroquia(idProvincia, idCanton, idParroquia);
        return new ResponseEntity<>(resultado, HttpStatus.OK);
    }
}
