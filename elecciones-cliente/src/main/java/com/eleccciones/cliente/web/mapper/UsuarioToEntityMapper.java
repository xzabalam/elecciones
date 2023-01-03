package com.eleccciones.cliente.web.mapper;

import com.eleccciones.cliente.data.entities.security.Usuario;
import com.eleccciones.cliente.web.dto.UsuarioTo;
import com.eleccciones.cliente.bussiness.services.builder.UsuarioBuilder;

public final class UsuarioToEntityMapper {

    private UsuarioToEntityMapper() {

    }

    public static final Usuario convertToUsuario(UsuarioTo usuarioTo, int idUsuarioCrea) {
        return UsuarioBuilder.newBuilder()
                .username(usuarioTo.getUsername())
                .usernameCrea(idUsuarioCrea)
                .build();
    }
}
