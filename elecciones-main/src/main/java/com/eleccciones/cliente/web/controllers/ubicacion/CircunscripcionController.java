package com.eleccciones.cliente.web.controllers.ubicacion;

import com.eleccciones.cliente.bussiness.services.ubicacion.CircunscripcionService;
import com.eleccciones.cliente.data.entities.ubicacion.Circunscripcion;
import com.eleccciones.cliente.data.repositories.candidatos.dto.CircunscripcionDto;
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
@RequestMapping("/circunscripcion")
public class CircunscripcionController {

    private final CircunscripcionService circunscripcionService;

    public CircunscripcionController(CircunscripcionService circunscripcionService) {
        this.circunscripcionService = circunscripcionService;
    }

    @GetMapping("/{idCircunscripcion}")
    @Operation(summary = "Permite obtener la circunscripcion por el id.")
    public ResponseEntity<Circunscripcion> getById(@PathVariable("idCircunscripcion") Integer idCircunscripcion) {
        RestPreconditions.checkNull(idCircunscripcion);
        Circunscripcion circunscripcion = circunscripcionService.findById(idCircunscripcion);
        return new ResponseEntity<>(circunscripcion, HttpStatus.OK);
    }

    @GetMapping("/sigla/{sigla}")
    @Operation(summary = "Permite obtener la circunscripcion por la sigla.")
    public ResponseEntity<Circunscripcion> getById(@PathVariable("sigla") String sigla) {
        RestPreconditions.checkEmptyString(sigla);
        Circunscripcion circunscripcion = circunscripcionService.findBySigla(sigla);
        return new ResponseEntity<>(circunscripcion, HttpStatus.OK);
    }

    @GetMapping("/contrato/{idContrato}/dignidad/{idDignidad}")
    @Operation(summary = "Permite obtener las circunscripciones por el contrato y por la dignidad.")
    public ResponseEntity<List<CircunscripcionDto>> getByContratoAndDignidad(
            @PathVariable("idContrato") Integer idContrato,
            @PathVariable("idDignidad") Integer idDignidad) {
        RestPreconditions.checkEmptyString(idContrato);
        RestPreconditions.checkEmptyString(idDignidad);

        List<CircunscripcionDto> circunscripciones =
                circunscripcionService.getCircunscripcionesPorContratoYDignidad(idContrato, idDignidad);

        return new ResponseEntity<>(circunscripciones, HttpStatus.OK);
    }
}
