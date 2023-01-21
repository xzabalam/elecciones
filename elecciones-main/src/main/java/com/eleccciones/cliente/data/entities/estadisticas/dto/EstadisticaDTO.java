package com.eleccciones.cliente.data.entities.estadisticas.dto;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;

import javax.validation.constraints.NotNull;

@Getter
@Setter
@EqualsAndHashCode
public class EstadisticaDTO {
    @NotNull
    private Integer idMovimiento;

    @NotNull
    private String movimiento;

    @NotNull
    private String numeroMovimiento;

    private Long sumatoria;

    public EstadisticaDTO(Integer idMovimiento, String movimiento, String numeroMovimiento, Long sumatoria) {
        this.idMovimiento = idMovimiento;
        this.movimiento = movimiento;
        this.numeroMovimiento = numeroMovimiento;
        this.sumatoria = sumatoria;
    }
}

