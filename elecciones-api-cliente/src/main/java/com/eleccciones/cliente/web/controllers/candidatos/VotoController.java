package com.eleccciones.cliente.web.controllers.candidatos;

import com.eleccciones.cliente.bussiness.services.candidatos.ActaDignidadServicio;
import com.eleccciones.cliente.bussiness.services.candidatos.VotoServicio;
import com.eleccciones.cliente.data.entities.candidatos.Voto;
import com.eleccciones.cliente.web.dto.VotoTo;
import com.eleccciones.cliente.web.util.RestPreconditions;
import io.swagger.v3.oas.annotations.Operation;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/voto")
public class VotoController {

    private final VotoServicio votoServicio;
    private final ActaDignidadServicio actaDignidadServicio;

    public VotoController(VotoServicio votoServicio, ActaDignidadServicio actaDignidadServicio) {
        this.votoServicio = votoServicio;
        this.actaDignidadServicio = actaDignidadServicio;
    }

    @GetMapping("/junta/{idJunta}")
    @Operation(summary = "Permite obtener los votos de una junta.")
    public ResponseEntity<List<Voto>> findByJunta(@Valid @NotNull @PathVariable("idJunta") Integer idJunta) {
        RestPreconditions.checkNull(idJunta);
        List<Voto> votos = votoServicio.findByJuntaYCandidatoPrincipal(idJunta);
        return new ResponseEntity<>(votos, HttpStatus.OK);
    }

    @PostMapping
    @Operation(summary = "Permite guardar los votos de una acta.")
    public ResponseEntity<Boolean> guardarVotosPorActa(
            @Valid @NotNull @RequestBody List<VotoTo> votoPorActa,
            Authentication authentication) {

        List<Integer> idsActaDignidad = new ArrayList<>();
        votoPorActa.stream().forEach((voto) -> {
            votoServicio.guardarVotosPorActa(voto.getIdVoto(), voto.getCantidadVoto(), authentication.getName());
            if (!idsActaDignidad.contains(voto.getIdActaDignidad())) {
                idsActaDignidad.add(voto.getIdActaDignidad());
            }
        });

        idsActaDignidad.stream().forEach((idActaDignidad) -> {
            actaDignidadServicio.ponerActaComoEscrutada(idActaDignidad, authentication.getName());
        });

        return new ResponseEntity<>(true, HttpStatus.OK);
    }
}
