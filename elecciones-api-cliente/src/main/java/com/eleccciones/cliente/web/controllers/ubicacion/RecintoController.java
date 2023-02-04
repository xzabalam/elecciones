package com.eleccciones.cliente.web.controllers.ubicacion;

import com.eleccciones.cliente.bussiness.services.ubicacion.RecintoService;
import com.eleccciones.cliente.data.entities.ubicacion.Recinto;
import com.eleccciones.cliente.web.util.RestPreconditions;
import io.swagger.v3.oas.annotations.Operation;
import org.springframework.data.domain.Page;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/recinto")
public class RecintoController {
    private final RecintoService recintoService;

    public RecintoController(RecintoService recintoService) {
        this.recintoService = recintoService;
    }

    @GetMapping("/{idRecinto}")
    @Operation(summary = "Permite obtener un recinto con base en su id.")
    public ResponseEntity<Recinto> getById(@PathVariable("idRecinto") Integer idRecinto) {
        RestPreconditions.checkNull(idRecinto);
        Recinto recinto = recintoService.findById(idRecinto);
        return new ResponseEntity<>(recinto, HttpStatus.OK);
    }

    @GetMapping("/zona/{idZona}/all")
    @Operation(summary = "Permite obtener el listado de recinto con base en una zona.")
    public ResponseEntity<List<Recinto>> getAllByZona(@PathVariable("idZona") Integer idZona) {
        RestPreconditions.checkNull(idZona);
        List<Recinto> recintos = recintoService.findByZonaAndEstado(idZona);
        return new ResponseEntity<>(recintos, HttpStatus.OK);
    }

    @GetMapping("/zona/{idZona}")
    @Operation(summary = "Permite obtener el listado de recintos con base en la zona. con paginacion.")
    public ResponseEntity<Page<Recinto>> getAllByZonaWithPagination(
            @PathVariable("idZona") Integer idZona,
            @RequestParam(required = false, value = "page", defaultValue = "0") int page,
            @RequestParam(required = false, value = "size", defaultValue = "500") int size) {
        RestPreconditions.checkNull(idZona);
        Page<Recinto> recintos = recintoService.findAllByZonaAndEstado(idZona, page, size);
        return new ResponseEntity<>(recintos, HttpStatus.OK);
    }
}
