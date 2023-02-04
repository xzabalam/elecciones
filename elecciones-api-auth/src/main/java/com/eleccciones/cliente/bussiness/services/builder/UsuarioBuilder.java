package com.eleccciones.cliente.bussiness.services.builder;

import com.eleccciones.cliente.data.entities.security.Usuario;
import com.eleccciones.cliente.data.enums.EntityStateEnum;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import java.util.Date;


/**
 * Permite generar una nueva instancia de un usuario.
 *
 * @author xzabalam
 */
public class UsuarioBuilder {

    private static Usuario usuario;

    private static final String getEncode(String password) {
        return new BCryptPasswordEncoder().encode(password);
    }

    public static final UsuarioBuilder newBuilder() {
        usuario = new Usuario();
        return new UsuarioBuilder();
    }

    public UsuarioBuilder username(String username) {
        this.usuario.setUsername(username);
        final String password = getEncode(username);
        this.usuario.setPassword(password);
        return this;
    }

    /**
     * Se genera un usuario cuyo username y password se generan con base en los
     * nombres y apelllidos del empleado, el password será el mismo username
     * codificado.
     *
     * @return
     */
    public Usuario build() {
        usuario.setFechaCrea(new Date());
        usuario.setEstado(EntityStateEnum.ACTIVO.getEstado());
        return usuario;
    }

    public UsuarioBuilder usernameCrea(int idUsuarioCrea) {
        this.usuario.setUsuarioCrea(idUsuarioCrea);
        return this;
    }
}
