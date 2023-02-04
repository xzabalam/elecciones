package com.eleccciones.cliente.bussiness.services.candidatos;

import com.eleccciones.cliente.bussiness.services.security.UsuarioService;
import com.eleccciones.cliente.bussiness.services.ubicacion.JuntaService;
import com.eleccciones.cliente.common.exception.CandidatoException;
import com.eleccciones.cliente.data.entities.candidatos.Voto;
import com.eleccciones.cliente.data.entities.security.Usuario;
import com.eleccciones.cliente.data.entities.ubicacion.Junta;
import com.eleccciones.cliente.data.repositories.candidatos.VotoRepository;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

@Service
@Transactional(readOnly = true)
public class VotoServicio {
    private final DignidadServicio dignidadServicio;
    private final JuntaService juntaService;
    private final UsuarioService usuarioService;
    private final VotoRepository votoRepository;

    public VotoServicio(DignidadServicio dignidadServicio, JuntaService juntaService, UsuarioService usuarioService, VotoRepository votoRepository) {
        this.dignidadServicio = dignidadServicio;
        this.juntaService = juntaService;
        this.usuarioService = usuarioService;
        this.votoRepository = votoRepository;
    }

    @Secured(value = {"ROLE_ADMINISTRADOR", "ROLE_USUARIO"})
    public List<Voto> findByJuntaYCandidatoPrincipal(Integer idJunta) {
        Junta junta = juntaService.findById(idJunta);
        return votoRepository.findByJunta(junta.getId(), "PRINCIPAL");
    }

    @Secured(value = {"ROLE_ADMINISTRADOR", "ROLE_USUARIO"})
    @Transactional
    public Boolean guardarVotosPorActa(Integer idVoto, Integer cantidad, String username) {
        Usuario usuario = usuarioService.getUserByUsername(username);
        Voto voto = votoRepository.findById(idVoto).orElseThrow(() ->
                new CandidatoException("No existe la entidad voto con el id" + idVoto)
        );

        long stamp = voto.getLock().writeLock();

        try {
            voto.setCantidad(cantidad);
            voto.setFechaModifica(new Date());
            voto.setUsuarioModifica(usuario.getId());

            votoRepository.save(voto);
            return true;
        } catch (Exception e) {
            throw new CandidatoException("Se produjo un error al guardar los votos con el id " + idVoto);
        } finally {
            voto.getLock().unlockWrite(stamp);
        }
    }
}
