package com.eleccciones.cliente.web.dto;

import lombok.Getter;
import lombok.Setter;

import javax.validation.constraints.NotNull;

@Getter
@Setter
public class VotoTo {

    @NotNull
    private Integer idVoto;

    @NotNull
    private Integer idActaDignidad;

    @NotNull
    private Integer cantidadVoto;
}
