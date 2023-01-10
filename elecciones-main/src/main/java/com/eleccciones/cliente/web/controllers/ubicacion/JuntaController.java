package com.eleccciones.cliente.web.controllers.ubicacion;

import com.eleccciones.cliente.bussiness.services.ubicacion.JuntaService;
import com.eleccciones.cliente.data.entities.ubicacion.Junta;
import com.eleccciones.cliente.web.util.RestPreconditions;
import io.swagger.v3.oas.annotations.Operation;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/junta")
public class JuntaController {

    private final JuntaService juntaService;

    public JuntaController(JuntaService juntaService) {
        this.juntaService = juntaService;
    }

    @GetMapping("/{idJunta}")
    @Operation(summary = "Permite obtener una junta buscada por su id.")
    public ResponseEntity<Junta> getById(@PathVariable("idJunta") Integer idJunta) {
        RestPreconditions.checkNull(idJunta);
        Junta junta = juntaService.findById(idJunta);
        return new ResponseEntity<>(junta, HttpStatus.OK);
    }

    @GetMapping("/recinto/{idRecinto}/all")
    @Operation(summary = "Obtiene las juntas de un recinto.")
    public ResponseEntity<List<Junta>> getAllByIdRecinto(@PathVariable("idRecinto") Integer idRecinto) {
        RestPreconditions.checkNull(idRecinto);
        List<Junta> juntas = juntaService.getAll(idRecinto);
        return new ResponseEntity<>(juntas, HttpStatus.OK);
    }
}
