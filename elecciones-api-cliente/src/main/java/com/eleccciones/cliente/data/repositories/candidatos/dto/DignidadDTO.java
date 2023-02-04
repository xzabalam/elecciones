package com.eleccciones.cliente.data.repositories.candidatos.dto;

import lombok.Data;

import javax.validation.constraints.NotNull;

@Data
public class DignidadDTO {
    @NotNull
    private Integer id;
    @NotNull
    private String nombre;

    public DignidadDTO(Integer id, String nombre) {
        this.id = id;
        this.nombre = nombre;
    }


}
