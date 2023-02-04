package com.eleccciones.cliente.web.controllers.ubicacion;

import com.eleccciones.cliente.bussiness.services.ubicacion.ParroquiaService;
import com.eleccciones.cliente.data.entities.ubicacion.Parroquia;
import com.eleccciones.cliente.web.util.RestPreconditions;
import io.swagger.v3.oas.annotations.Operation;
import org.springframework.data.domain.Page;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/parroquia")
public class ParroquiaController {

    private final ParroquiaService parroquiaService;

    public ParroquiaController(ParroquiaService parroquiaService) {
        this.parroquiaService = parroquiaService;
    }

    @GetMapping("/{idParroquia}")
    @Operation(summary = "Permite obtener una parroquia buscada por su id.")
    public ResponseEntity<Parroquia> getById(@PathVariable("idParroquia") Integer idParroquia) {
        RestPreconditions.checkNull(idParroquia);
        Parroquia parroquia = parroquiaService.findById(idParroquia);
        return new ResponseEntity<>(parroquia, HttpStatus.OK);
    }

    @GetMapping("/canton/{idCanton}/all")
    @Operation(summary = "Permite obtener el listado de parroquias dada el id del canton.")
    public ResponseEntity<List<Parroquia>> getByIdCanton(@PathVariable("idCanton") Integer idCanton) {
        RestPreconditions.checkNull(idCanton);
        List<Parroquia> parroquias = parroquiaService.findByCantonAndEstado(idCanton);
        return new ResponseEntity<>(parroquias, HttpStatus.OK);
    }

    @GetMapping("/canton/{idCanton}")
    @Operation(summary = "Permite obtener el listado de parroquias dada el id del canton con paginacion.")
    public ResponseEntity<Page<Parroquia>> getByIdCantonWithPagination(
            @PathVariable("idCanton") Integer idCanton,
            @RequestParam(required = false, value = "page", defaultValue = "0") int page,
            @RequestParam(required = false, value = "size", defaultValue = "500") int size) {
        RestPreconditions.checkNull(idCanton);
        Page<Parroquia> parroquias = parroquiaService.findAllByCantonAndEstado(idCanton, page, size);
        return new ResponseEntity<>(parroquias, HttpStatus.OK);
    }
}
