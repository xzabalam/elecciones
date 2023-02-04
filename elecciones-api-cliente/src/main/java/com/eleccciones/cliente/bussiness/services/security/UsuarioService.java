package com.eleccciones.cliente.bussiness.services.security;

import com.eleccciones.cliente.data.entities.security.Usuario;
import com.eleccciones.cliente.data.enums.EntityStateEnum;
import com.eleccciones.cliente.data.repositories.security.UsuarioRepository;
import com.eleccciones.cliente.data.repositories.security.UsuarioRolRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpStatus;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.server.ResponseStatusException;

import java.util.Date;
import java.util.List;
import java.util.Optional;

/**
 * Servicio que permite obtener la data de los empleados
 *
 * @author xzabalam
 */
@Slf4j
@Service
@Transactional(readOnly = true)
public class UsuarioService {

    private final UsuarioRepository usuarioRepository;
    private final UsuarioRolRepository usuarioRolRepository;
    private final MessageSource messageSource;

    public UsuarioService(UsuarioRepository usuarioRepository, UsuarioRolRepository usuarioRolRepository, MessageSource messageSource) {
        this.usuarioRepository = usuarioRepository;
        this.usuarioRolRepository = usuarioRolRepository;
        this.messageSource = messageSource;
    }

    /**
     * Permite crear un usuario en la base de datos
     *
     * @param usuario TO que contiene toda la informaci[on de un uusario.
     * @return el usuario creado.
     */
    @Transactional
    @Secured("ROLE_ADMINISTRADOR")
    public Usuario createUser(Usuario usuario) {
        final Optional<Usuario> result = usuarioRepository.findByUsername(usuario.getUsername());

        if (result.isEmpty()) {
            return usuarioRepository.save(usuario);
        }

        return result.get();
    }

    /**
     * Permite eliminar el usuario buscado por el campo username
     *
     * @param userId
     */
    @Transactional
    @Secured({"ROLE_ADMINISTRADOR"})
    public void deleteUsuario(int userId, int idUsuarioElimina) {
        Usuario usuario = getUserById(userId);
        usuario.setEstado(EntityStateEnum.INACTIVO.getEstado());
        usuario.setFechaModifica(new Date());
        usuario.setUsuarioModifica(idUsuarioElimina);
        usuarioRepository.save(usuario);
    }

    @Transactional
    @Secured({"ROLE_ADMINISTRADOR"})
    public void activarUsuario(int userId, int idUsuarioElimina) {
        Usuario usuario = getUserById(userId);
        usuario.setEstado(EntityStateEnum.ACTIVO.getEstado());
        usuario.setFechaModifica(new Date());
        usuario.setUsuarioModifica(idUsuarioElimina);
        usuarioRepository.save(usuario);
    }

    /**
     * Permite obtener un usuario buscado por el id, si no existe se generara una
     * excepcion.
     *
     * @param userId
     * @return
     */
    @Secured("ROLE_ADMINISTRADOR")
    public Usuario getUserById(int userId) {
        return usuarioRepository.findById(userId).orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND,
                String.format(messageSource.getMessage(
                        "{service.usuario.no.existe}", null, null,
                        LocaleContextHolder.getLocale().stripExtensions()), userId)));
    }

    /**
     * Permite obtener un usuario buscado por el username, si no existe se generara
     * una excepcion.
     *
     * @param username
     * @return
     */
    @Secured({"ROLE_ADMINISTRADOR", "ROLE_USUARIO"})
    public Usuario getUserByUsername(String username) {
        return usuarioRepository.findByUsername(username)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND,
                        String.format(messageSource.getMessage("service.usuario.no.existe", null, null,
                                LocaleContextHolder.getLocale().stripExtensions()), username)));
    }

    /**
     * Permite obtener una lista de usuarios almacenados en la base de datos. Los
     * resultados se devuelven con paginacion y ordenados ascendentemente
     *
     * @param page
     * @param size
     * @return
     */
    @Secured({"ROLE_ADMINISTRADOR"})
    public Page<Usuario> getUsuarios(int page, int size) {
        return usuarioRepository.findAll(PageRequest.of(page, size, Sort.by(Sort.Direction.ASC, "username")));
    }

    /**
     * Obtiene los usuarios que tienen un rol en espec[ifico
     *
     * @param rol
     * @return
     */
    @Secured({"ROLE_ADMINISTRADOR"})
    public List<Usuario> getUsuariosByRol(String rol) {
        return usuarioRolRepository.findUsersByRol(rol);
    }
}
