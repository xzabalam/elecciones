package com.eleccciones.cliente.web.controllers.candidatos;

import com.eleccciones.cliente.bussiness.services.candidatos.VotoServicio;
import com.eleccciones.cliente.data.entities.candidatos.Voto;
import com.eleccciones.cliente.web.util.RestPreconditions;
import io.swagger.v3.oas.annotations.Operation;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/voto")
public class VotoController {

    private final VotoServicio votoServicio;

    public VotoController(VotoServicio votoServicio) {
        this.votoServicio = votoServicio;
    }

    @GetMapping("/dignidad/{idDignidad}/junta/{idJunta}")
    @Operation(summary = "Permite obtener los votos de una junta y acta dignidad.")
    public ResponseEntity<List<Voto>> findByActaDignidadAndJunta(@PathVariable("idDignidad") Integer idDignidad,
                                                                 @PathVariable("idJunta") Integer idJunta) {
        RestPreconditions.checkNull(idDignidad);
        RestPreconditions.checkNull(idJunta);
        List<Voto> votos = votoServicio.findByActaDignidadAndJunta(idDignidad, idJunta);
        return new ResponseEntity<>(votos, HttpStatus.OK);

    }

    @GetMapping("/junta/{idJunta}")
    @Operation(summary = "Permite obtener los votos de una junta.")
    public ResponseEntity<List<Voto>> findByJunta(@PathVariable("idJunta") Integer idJunta) {
        RestPreconditions.checkNull(idJunta);
        List<Voto> votos = votoServicio.findByJunta(idJunta);
        return new ResponseEntity<>(votos, HttpStatus.OK);

    }
}
