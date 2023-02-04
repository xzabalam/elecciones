package com.eleccciones.cliente.web.dto;

import lombok.Data;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

@Data
public class UsuarioTo {

    @NotNull
    @NotEmpty
    @Size(min = 5, max = 20, message = "{entity.auditoria.username}")
    private String username;
}
