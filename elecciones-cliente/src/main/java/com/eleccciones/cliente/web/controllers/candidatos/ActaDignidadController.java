package com.eleccciones.cliente.web.controllers.candidatos;

import com.eleccciones.cliente.bussiness.services.candidatos.ActaDignidadServicio;
import com.eleccciones.cliente.data.entities.candidatos.ActaDignidad;
import com.eleccciones.cliente.web.util.RestPreconditions;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/acta-dignidad")
public class ActaDignidadController {

    private final ActaDignidadServicio actaDignidadServicio;

    public ActaDignidadController(ActaDignidadServicio actaDignidadServicio) {
        this.actaDignidadServicio = actaDignidadServicio;
    }

    @GetMapping("/junta/{idJunta}")
    public ResponseEntity<List<ActaDignidad>> findByJunta(@PathVariable("idJunta") Integer idJunta) {
        RestPreconditions.checkNull(idJunta);
        List<ActaDignidad> actaDignidades = actaDignidadServicio.findAllByJunta(idJunta);
        return new ResponseEntity<>(actaDignidades, HttpStatus.OK);
    }
}
