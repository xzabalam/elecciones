package com.eleccciones.cliente.data.entities.estadisticas.dto;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@EqualsAndHashCode
public class NumeroElectoresDTO {
    private Integer idUbicacion;
    private String nombreUbicacion;
    private Long cantidadElectores;

    public NumeroElectoresDTO(Integer idUbicacion, String nombreUbicacion, Long cantidadElectores) {
        this.idUbicacion = idUbicacion;
        this.nombreUbicacion = nombreUbicacion;
        this.cantidadElectores = cantidadElectores;
    }
}
