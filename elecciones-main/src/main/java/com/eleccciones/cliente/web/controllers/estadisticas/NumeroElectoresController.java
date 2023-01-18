package com.eleccciones.cliente.web.controllers.estadisticas;

import com.eleccciones.cliente.bussiness.services.estadisticas.NumeroElectoresService;
import com.eleccciones.cliente.bussiness.services.estadisticas.util.ParametroEstadisticaUtil;
import com.eleccciones.cliente.data.entities.estadisticas.dto.NumeroElectoresDTO;
import io.swagger.v3.oas.annotations.Operation;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Positive;

@RestController
@RequestMapping("/numero-electores")
public class NumeroElectoresController {
    private final NumeroElectoresService numeroElectoresService;

    public NumeroElectoresController(NumeroElectoresService numeroElectoresService) {
        this.numeroElectoresService = numeroElectoresService;
    }

    @GetMapping("/provincia/{idProvincia}")
    @Operation(summary = "Obtener numero de electores por provincia.")
    public NumeroElectoresDTO getByProvincia(
            @Valid @NotNull @Positive @PathVariable("idProvincia") Integer idProvincia) {
        ParametroEstadisticaUtil.validarProvincia(idProvincia);
        return numeroElectoresService.getByProvincia(idProvincia);
    }

    @GetMapping("/provincia/{idProvincia}/canton/{idCanton}")
    @Operation(summary = "Obtener numero de electores por provincia, canton.")
    public NumeroElectoresDTO getByProvinciaAndCanton(
            @Valid @NotNull @Positive @PathVariable("idProvincia") Integer idProvincia,
            @Valid @NotNull @Positive @PathVariable("idCanton") Integer idCanton) {
        ParametroEstadisticaUtil.validarProvincia(idProvincia);
        ParametroEstadisticaUtil.validarCanton(idCanton);
        return numeroElectoresService.getByProvinciaAndCanton(idProvincia, idCanton);
    }

    @GetMapping("/provincia/{idProvincia}/canton/{idCanton}/parroquia/{idParroquia}")
    @Operation(summary = "Obtener numero de electores por provincia, canton y parroquia.")
    public NumeroElectoresDTO getByProvinciaAndCantonAndParroquia(
            @Valid @NotNull @Positive @PathVariable("idProvincia") Integer idProvincia,
            @Valid @NotNull @Positive @PathVariable("idCanton") Integer idCanton,
            @Valid @NotNull @Positive @PathVariable("idParroquia") Integer idParroquia) {
        ParametroEstadisticaUtil.validarProvincia(idProvincia);
        ParametroEstadisticaUtil.validarCanton(idCanton);
        ParametroEstadisticaUtil.validarParroquia(idParroquia);
        return numeroElectoresService.getByProvinciaAndCantonAndParroquia(idProvincia, idCanton, idParroquia);
    }
}
