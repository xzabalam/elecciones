package com.eleccciones.cliente.data.repositories.candidatos.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CircunscripcionDto {
    Integer id;
    String nombre;

    public CircunscripcionDto(Integer id, String nombre) {
        this.id = id;
        this.nombre = nombre;
    }
}
