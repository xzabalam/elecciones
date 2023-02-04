package com.eleccciones.cliente.web.controllers.security;

import com.eleccciones.cliente.bussiness.services.security.UsuarioService;
import com.eleccciones.cliente.data.entities.security.Usuario;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.stream.Collectors;

@RestController
public class AuthController {

    private final UsuarioService usuarioService;

    public AuthController(UsuarioService usuarioService) {
        this.usuarioService = usuarioService;
    }

    /**
     * Permite iniciar sesi[on desde el formulario login de angular y devueelve los roles que el usuario tienen asignado
     *
     * @param authentication
     * @return
     */
    @GetMapping("/auth")
    public ResponseEntity<Usuario> validateLogin(Authentication authentication) {
        Usuario usuario = usuarioService.getUserByUsername(authentication.getName());
        usuario.setRoles(authentication.getAuthorities().stream().map(item -> item.getAuthority()).collect(Collectors.toList()));
        return new ResponseEntity<>(usuario, HttpStatus.OK);
    }
}
