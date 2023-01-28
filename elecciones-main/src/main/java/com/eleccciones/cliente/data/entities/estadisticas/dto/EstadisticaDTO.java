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

    @NotNull
    private String colorMovimiento;

    @NotNull
    private String nombreCandidato;

    private Long sumatoria;

    public EstadisticaDTO(Integer idMovimiento, String movimiento, String numeroMovimiento,
                          String colorMovimiento, String nombreCandidato, Long sumatoria) {
        this.idMovimiento = idMovimiento;
        this.movimiento = movimiento;
        this.numeroMovimiento = numeroMovimiento;
        this.colorMovimiento = colorMovimiento;
        this.nombreCandidato = nombreCandidato;
        this.sumatoria = sumatoria;
    }
}

