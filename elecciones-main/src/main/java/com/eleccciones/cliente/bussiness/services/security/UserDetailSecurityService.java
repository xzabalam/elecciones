package com.eleccciones.cliente.bussiness.services.security;

import com.eleccciones.cliente.data.entities.security.Permiso;
import com.eleccciones.cliente.data.entities.security.Usuario;
import com.eleccciones.cliente.data.repositories.security.UsuarioRepository;
import com.eleccciones.cliente.data.repositories.security.UsuarioRolRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

/**
 * Esta clase permite validar y autenticar a los usuarios registrados en mi base
 * de datos.
 *
 * @author xzabalam
 */
@Service
@Transactional(readOnly = true)
public class UserDetailSecurityService implements UserDetailsService {

    @Autowired
    private UsuarioRepository usuarioRepository;

    @Autowired
    private UsuarioRolRepository userInRoleRepository;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        final Optional<Usuario> optionalUser = usuarioRepository.getByUsername(username);

        if (optionalUser.isPresent()) {
            final Usuario usuario = optionalUser.get();
            final List<Permiso> listaPermiso = userInRoleRepository.findByUsername(usuario.getUsername());
            final String[] roles = listaPermiso.stream().map(permiso -> permiso.getRol().getNombre())
                    .toArray(String[]::new);
            return User.withUsername(usuario.getUsername()).password(usuario.getPassword()).roles(roles).build();
        }

        throw new UsernameNotFoundException(String.format("{security.usuario.no.encontrado}", username));
    }
}
