package com.eleccciones.cliente.data.repositories.candidatos.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

@Getter
@Setter
@AllArgsConstructor
public class DignidadDTO implements Serializable {
    private static final long serialVersionUID = -412218241272244619L;

    private Integer id;
    private String nombre;
}
