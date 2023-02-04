package com.eleccciones.cliente.web.controllers.ubicacion;

import com.eleccciones.cliente.bussiness.services.ubicacion.CantonService;
import com.eleccciones.cliente.data.entities.ubicacion.Canton;
import com.eleccciones.cliente.web.util.RestPreconditions;
import io.swagger.v3.oas.annotations.Operation;
import org.springframework.data.domain.Page;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/canton")
public class CantonController {

    private final CantonService cantonService;

    public CantonController(CantonService cantonService) {
        this.cantonService = cantonService;
    }

    @GetMapping("/{idCanton}")
    @Operation(summary = "Permite obtener el canton filtrandolo por el id, Roles permitidos Administrador y Usuario")
    public ResponseEntity<Canton> getById(@PathVariable("idCanton") Integer idCanton) {
        RestPreconditions.checkNull(idCanton);

        final Canton canton = cantonService.findById(idCanton);
        return new ResponseEntity<>(canton, HttpStatus.OK);
    }

    @GetMapping("/provincia/{idProvincia}")
    @Operation(summary = "Permite obtener un listado de cantones paginados de acuerdo al idProvincia , Roles " +
            "permitidos Administrador y Usuario")
    public ResponseEntity<Page<Canton>> getByIdProvinciaConPaginacion(
            @PathVariable("idProvincia") Integer idProvincia,
            @RequestParam(required = false, value = "page", defaultValue = "0") int page,
            @RequestParam(required = false, value = "size", defaultValue = "500") int size) {
        RestPreconditions.checkNull(idProvincia);

        final Page<Canton> cantones = cantonService.findByProvinciaPage(idProvincia, page, size);
        return new ResponseEntity<>(cantones, HttpStatus.OK);
    }

    @GetMapping("/provincia/{idProvincia}/all")
    @Operation(summary = "Permite obtener un listado de cantones de acuerdo al idProvincia , Roles " +
            "permitidos Administrador y Usuario")
    public ResponseEntity<List<Canton>> getByIdProvincia(@PathVariable("idProvincia") Integer idProvincia) {
        RestPreconditions.checkNull(idProvincia);

        final List<Canton> cantones = cantonService.findByProvincia(idProvincia);
        return new ResponseEntity<>(cantones, HttpStatus.OK);
    }
}
